import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../models/cultivation.dart';
import '../../models/enums.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';
import 'cultivation_calculator.dart';

const _uuid = Uuid();

/// 当前角色的修炼会话
final currentCultivationSessionProvider =
    StreamProvider.autoDispose<CultivationSession?>((ref) {
  final db = ref.watch(databaseProvider);
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return Stream.value(null);

  return db
      .select(db.cultivationSessions)
      .watch()
      .map((rows) {
        if (rows.isEmpty) return null;
        final row = rows.first;
        return CultivationSession(
          id: row.id,
          characterId: row.characterId,
          type: CultivationType.values[row.typeIndex],
          status: CultivationStatus.values[row.statusIndex],
          skillId: row.skillId,
          locationId: row.locationId,
          startTime: row.startTime,
          durationMinutes: row.durationMinutes,
          completedTime: row.completedTime,
          rewardExp: row.rewardExp,
          rewardSilver: row.rewardSilver,
          rewardItems: row.rewardItemsJson.isEmpty
              ? {}
              : Map<String, int>.from(jsonDecode(row.rewardItemsJson)),
          rewardSkillId: row.rewardSkillId,
        );
      })
      .asyncMap((session) async {
        if (session == null) return null;
        // 自动检查是否完成
        if (session.canCollect && session.status == CultivationStatus.cultivating) {
          await ref.read(cultivationNotifierProvider.notifier)._autoComplete(session);
        }
        return session;
      });
});

/// 修炼管理器
final cultivationNotifierProvider =
    NotifierProvider<CultivationNotifier, void>(CultivationNotifier.new);

class CultivationNotifier extends Notifier<void> {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);

  /// 开始修炼
  Future<String?> startCultivation({
    required String characterId,
    required CultivationType type,
    required int durationMinutes,
    String? skillId,
    String? locationId,
  }) async {
    // 检查是否已有进行中的修炼
    final existing = await (_db.select(_db.cultivationSessions)
          ..where((t) => t.characterId.equals(characterId))
          ..where((t) => t.statusIndex.equals(CultivationStatus.cultivating.index)))
        .getSingleOrNull();

    if (existing != null) {
      return '已有修炼正在进行中';
    }

    // 创建修炼会话
    final session = CultivationSessionsCompanion.insert(
      id: _uuid.v4(),
      characterId: characterId,
      typeIndex: type.index,
      statusIndex: CultivationStatus.cultivating.index,
      skillId: Value(skillId),
      locationId: Value(locationId),
      startTime: DateTime.now(),
      durationMinutes: durationMinutes,
    );

    await _db.into(_db.cultivationSessions).insert(session);
    return null;
  }

  /// 自动完成修炼（内部使用）
  Future<void> _autoComplete(CultivationSession session) async {
    if (session.status != CultivationStatus.cultivating) return;
    if (!session.canCollect) return;

    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    // 计算奖励
    final rewards = CultivationCalculator.calculateReward(
      type: session.type,
      comprehension: character.baseComprehension,
      luck: character.baseLuck,
      realmTier: character.realmTier,
      durationMinutes: session.durationMinutes,
      skillId: session.skillId,
      locationId: session.locationId,
    );

    // 更新修炼会话状态
    await (_db.update(_db.cultivationSessions)
          ..where((t) => t.id.equals(session.id)))
        .write(
      CultivationSessionsCompanion(
        statusIndex: Value(CultivationStatus.completed.index),
        completedTime: Value(DateTime.now()),
        rewardExp: Value(rewards['exp'] ?? 0),
        rewardSilver: Value(rewards['silver'] ?? 0),
        rewardItemsJson: Value(jsonEncode(rewards['items'] ?? {})),
        rewardSkillId: Value(rewards['skillId']),
      ),
    );
  }

  /// 收取修炼奖励
  Future<String?> collectReward(String sessionId) async {
    final session = await (_db.select(_db.cultivationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) return '修炼会话不存在';
    if (session.statusIndex != CultivationStatus.completed.index) {
      return '修炼尚未完成';
    }

    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return '角色不存在';

    // 发放奖励
    if (session.rewardExp > 0) {
      await ref
          .read(characterNotifierProvider.notifier)
          .gainExp(character.id, session.rewardExp);
    }

    if (session.rewardSilver > 0) {
      await ref
          .read(characterNotifierProvider.notifier)
          .gainSilver(character.id, session.rewardSilver);
    }

    if (session.rewardItemsJson.isNotEmpty) {
      final items = Map<String, int>.from(jsonDecode(session.rewardItemsJson));
      for (final entry in items.entries) {
        await ref
            .read(inventoryNotifierProvider.notifier)
            .addItem(character.id, entry.key, entry.value);
      }
    }

    // 删除修炼会话
    await (_db.delete(_db.cultivationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .go();

    return null;
  }

  /// 取消修炼
  Future<String?> cancelCultivation(String sessionId) async {
    final session = await (_db.select(_db.cultivationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .getSingleOrNull();

    if (session == null) return '修炼会话不存在';
    if (session.statusIndex != CultivationStatus.cultivating.index) {
      return '只能取消进行中的修炼';
    }

    // 删除修炼会话（取消不给奖励）
    await (_db.delete(_db.cultivationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .go();

    return null;
  }
}

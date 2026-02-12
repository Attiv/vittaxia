import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/quest_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/quest.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../skill/skill_provider.dart';

/// 监听当前角色的任务进度
final questProgressProvider = StreamProvider<List<QuestProgressData>>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return db.watchQuestProgress(id);
});

/// 进行中的任务
final activeQuestsProvider = Provider<List<QuestProgressData>>((ref) {
  final progress = ref.watch(questProgressProvider).valueOrNull ?? [];
  return progress.where((p) => p.status == 1).toList();
});

/// 可接取的任务（未接受且满足前置条件）
final availableQuestsProvider = Provider<List<Quest>>((ref) {
  final progress = ref.watch(questProgressProvider).valueOrNull ?? [];
  final completedIds = progress
      .where((p) => p.status == 2)
      .map((p) => p.questId)
      .toSet();
  final activeIds = progress.map((p) => p.questId).toSet();

  return quests.values.where((q) {
    if (activeIds.contains(q.id)) return false;
    if (q.prerequisiteQuestId != null &&
        !completedIds.contains(q.prerequisiteQuestId)) {
      return false;
    }
    return true;
  }).toList();
});

class QuestNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  QuestNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  /// 接取任务
  Future<void> acceptQuest(String characterId, String questId) async {
    final quest = quests[questId];
    if (quest == null) return;

    final objectivesMap = <String, int>{};
    for (final obj in quest.objectives) {
      objectivesMap[obj.id] = 0;
    }

    await _db.upsertQuestProgress(QuestProgressCompanion.insert(
      id: const Uuid().v4(),
      characterId: characterId,
      questId: questId,
      status: const Value(1),
      objectivesJson: Value(jsonEncode(objectivesMap)),
    ));

    _ref.read(gameLogProvider.notifier).addLog(
          '接取任务: ${quest.name}',
          type: LogType.quest,
        );
  }

  /// 统一检查并更新与 [type]+[targetId] 匹配的所有进行中任务目标
  Future<void> checkAndUpdateObjectives(
    String characterId,
    QuestObjectiveType type,
    String targetId,
  ) async {
    // 查所有进行中的任务
    final progressList = await (_db.select(_db.questProgress)
          ..where((t) => t.characterId.equals(characterId) & t.status.equals(1)))
        .get();

    for (final progress in progressList) {
      final quest = quests[progress.questId];
      if (quest == null) continue;

      for (final obj in quest.objectives) {
        if (obj.type != type) continue;
        if (obj.targetId != targetId) continue;

        await updateObjective(characterId, quest.id, obj.id, 1);
        await tryCompleteQuest(characterId, quest.id);
      }
    }
  }

  /// 更新任务目标进度
  Future<void> updateObjective(
      String characterId, String questId, String objectiveId, int delta) async {
    final progressList = await (_db.select(_db.questProgress)
          ..where((t) =>
              t.characterId.equals(characterId) & t.questId.equals(questId)))
        .get();
    if (progressList.isEmpty) return;
    final progress = progressList.first;

    final objectives =
        Map<String, int>.from(jsonDecode(progress.objectivesJson));
    objectives[objectiveId] = (objectives[objectiveId] ?? 0) + delta;

    await (_db.update(_db.questProgress)
          ..where((t) => t.id.equals(progress.id)))
        .write(QuestProgressCompanion(
      objectivesJson: Value(jsonEncode(objectives)),
    ));
  }

  /// 检查并完成任务
  Future<bool> tryCompleteQuest(String characterId, String questId) async {
    final quest = quests[questId];
    if (quest == null) return false;

    final progressList = await (_db.select(_db.questProgress)
          ..where((t) =>
              t.characterId.equals(characterId) & t.questId.equals(questId)))
        .get();
    if (progressList.isEmpty) return false;
    final progress = progressList.first;

    final objectives =
        Map<String, int>.from(jsonDecode(progress.objectivesJson));

    // 检查所有目标是否完成
    for (final obj in quest.objectives) {
      final current = objectives[obj.id] ?? 0;
      if (current < obj.requiredCount) return false;
    }

    // 标记完成
    await (_db.update(_db.questProgress)
          ..where((t) => t.id.equals(progress.id)))
        .write(const QuestProgressCompanion(status: Value(2)));

    // 发放奖励
    final charNotifier = _ref.read(characterNotifierProvider.notifier);
    final logNotifier = _ref.read(gameLogProvider.notifier);
    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return true;

    // 经验走 addExp 以触发境界突破
    if (quest.rewardExp > 0) {
      final newRealm = await charNotifier.addExp(characterId, quest.rewardExp);
      if (newRealm != null) {
        logNotifier.addLog('突破！境界提升至$newRealm', type: LogType.system);
      }
    }

    if (quest.rewardSilver > 0 || quest.rewardReputation > 0) {
      await charNotifier.updateStats(
        characterId: characterId,
        silver: character.silver + quest.rewardSilver,
        reputation: character.reputation + quest.rewardReputation,
      );
    }

    if (quest.rewardItemId != null) {
      await _ref
          .read(inventoryNotifierProvider.notifier)
          .addItem(characterId, quest.rewardItemId!);
    }
    if (quest.rewardSkillId != null) {
      await _ref
          .read(skillNotifierProvider.notifier)
          .learnSkill(characterId, quest.rewardSkillId!);
    }

    logNotifier.addLog(
      '完成任务: ${quest.name}！获得${quest.rewardExp}经验、${quest.rewardSilver}银两',
      type: LogType.quest,
    );

    // 完成任务后尝试自动接取下一个主线
    await autoAcceptMainQuests(characterId);

    return true;
  }

  /// 自动接取所有满足前置条件的主线任务
  Future<void> autoAcceptMainQuests(String characterId) async {
    final progressList = await (_db.select(_db.questProgress)
          ..where((t) => t.characterId.equals(characterId)))
        .get();

    final completedIds =
        progressList.where((p) => p.status == 2).map((p) => p.questId).toSet();
    final allIds = progressList.map((p) => p.questId).toSet();

    for (final quest in quests.values) {
      if (quest.type != QuestType.main) continue;
      if (allIds.contains(quest.id)) continue;
      if (quest.prerequisiteQuestId != null &&
          !completedIds.contains(quest.prerequisiteQuestId)) {
        continue;
      }
      await acceptQuest(characterId, quest.id);
      _ref.read(gameLogProvider.notifier).addLog(
            '自动接取主线任务: ${quest.name}',
            type: LogType.quest,
          );
    }
  }
}

final questNotifierProvider =
    StateNotifierProvider<QuestNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return QuestNotifier(db, ref);
});

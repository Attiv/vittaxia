import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../character/character_provider.dart';

/// NPC好感度等级
enum AffectionLevel {
  stranger('陌生', 0, 0),
  acquaintance('相识', 1, 100),
  friend('友好', 2, 300),
  close('亲密', 3, 600),
  confidant('知己', 4, 1000);

  final String label;
  final int level;
  final int requiredAffection;

  const AffectionLevel(this.label, this.level, this.requiredAffection);

  static AffectionLevel fromAffection(int affection) {
    if (affection >= confidant.requiredAffection) return confidant;
    if (affection >= close.requiredAffection) return close;
    if (affection >= friend.requiredAffection) return friend;
    if (affection >= acquaintance.requiredAffection) return acquaintance;
    return stranger;
  }
}

/// NPC关系数据
class NpcRelation {
  final String npcId;
  final int affection;
  final AffectionLevel level;

  NpcRelation({
    required this.npcId,
    required this.affection,
  }) : level = AffectionLevel.fromAffection(affection);

  /// 到下一等级还需要的好感度
  int get affectionToNextLevel {
    final nextLevel = AffectionLevel.values
        .where((l) => l.level > level.level)
        .firstOrNull;
    if (nextLevel == null) return 0;
    return nextLevel.requiredAffection - affection;
  }

  /// 当前等级进度百分比
  double get levelProgress {
    final nextLevel = AffectionLevel.values
        .where((l) => l.level > level.level)
        .firstOrNull;
    if (nextLevel == null) return 1.0;

    final currentLevelMin = level.requiredAffection;
    final nextLevelMin = nextLevel.requiredAffection;
    final range = nextLevelMin - currentLevelMin;
    final current = affection - currentLevelMin;

    return current / range;
  }
}

/// 当前角色的所有NPC关系
final npcRelationsProvider = StreamProvider.autoDispose<Map<String, NpcRelation>>((ref) {
  final db = ref.watch(databaseProvider);
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return Stream.value({});

  return (db.select(db.npcRelations)
        ..where((t) => t.characterId.equals(character.id)))
      .watch()
      .map((rows) {
    return {
      for (final row in rows)
        row.npcId: NpcRelation(
          npcId: row.npcId,
          affection: row.affection,
        ),
    };
  });
});

/// 获取指定NPC的关系
final npcRelationProvider = StreamProvider.autoDispose.family<NpcRelation?, String>((ref, npcId) {
  final relations = ref.watch(npcRelationsProvider).valueOrNull ?? {};
  return Stream.value(relations[npcId]);
});

/// NPC关系管理器
final npcRelationNotifierProvider =
    NotifierProvider<NpcRelationNotifier, void>(NpcRelationNotifier.new);

class NpcRelationNotifier extends Notifier<void> {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);

  /// 增加好感度
  Future<void> increaseAffection(String characterId, String npcId, int amount) async {
    final existing = await (_db.select(_db.npcRelations)
          ..where((t) => t.characterId.equals(characterId))
          ..where((t) => t.npcId.equals(npcId)))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.npcRelations).insert(
            NpcRelationsCompanion.insert(
              characterId: characterId,
              npcId: npcId,
              affection: Value(amount),
            ),
          );
    } else {
      await (_db.update(_db.npcRelations)
            ..where((t) => t.characterId.equals(characterId))
            ..where((t) => t.npcId.equals(npcId)))
          .write(
        NpcRelationsCompanion(
          affection: Value(existing.affection + amount),
        ),
      );
    }
  }

  /// 减少好感度
  Future<void> decreaseAffection(String characterId, String npcId, int amount) async {
    final existing = await (_db.select(_db.npcRelations)
          ..where((t) => t.characterId.equals(characterId))
          ..where((t) => t.npcId.equals(npcId)))
        .getSingleOrNull();

    if (existing == null) return;

    final newAffection = (existing.affection - amount).clamp(0, 9999);
    await (_db.update(_db.npcRelations)
          ..where((t) => t.characterId.equals(characterId))
          ..where((t) => t.npcId.equals(npcId)))
        .write(
      NpcRelationsCompanion(
        affection: Value(newAffection),
      ),
    );
  }

  /// 获取好感度
  Future<int> getAffection(String characterId, String npcId) async {
    final relation = await (_db.select(_db.npcRelations)
          ..where((t) => t.characterId.equals(characterId))
          ..where((t) => t.npcId.equals(npcId)))
        .getSingleOrNull();

    return relation?.affection ?? 0;
  }
}

/// NPC互动类型
enum NpcInteractionType {
  chat('闲聊', 5, 10),
  gift('送礼', 20, 50),
  help('帮助', 30, 80),
  quest('完成任务', 50, 100);

  final String label;
  final int minAffection;
  final int maxAffection;

  const NpcInteractionType(this.label, this.minAffection, this.maxAffection);
}

/// NPC互动奖励
class NpcInteractionReward {
  final int affection;
  final int? exp;
  final int? silver;
  final String? itemId;
  final String? skillId;
  final String? message;

  NpcInteractionReward({
    required this.affection,
    this.exp,
    this.silver,
    this.itemId,
    this.skillId,
    this.message,
  });
}

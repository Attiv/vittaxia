import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/sect_data.dart';
import '../../models/game_event.dart';
import '../../models/sect.dart';
import '../../models/enums.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../skill/skill_provider.dart';

/// 当前角色的师门信息
final currentSectMemberProvider = StreamProvider<SectMember?>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value(null);
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.sectMembers,
  )..where((t) => t.characterId.equals(id))).watchSingleOrNull();
});

/// 当前角色的师门
final currentSectProvider = Provider<Sect?>((ref) {
  final member = ref.watch(currentSectMemberProvider).valueOrNull;
  if (member == null) return null;
  return sects[member.sectId];
});

/// 可加入的师门列表
final availableSectsProvider = Provider<List<Sect>>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  final member = ref.watch(currentSectMemberProvider).valueOrNull;

  if (character == null || member != null) return [];

  return sects.values.where((sect) {
    // 检查境界要求
    if (character.realmTierIndex < sect.requiredRealm.rank - 1) return false;

    // 检查声望要求
    if (character.reputation < sect.requiredReputation) return false;

    // 检查前置任务（如果有）
    // TODO: 需要查询任务完成状态

    return true;
  }).toList();
});

/// 师门任务进度
final sectQuestProgressProvider = StreamProvider<List<SectQuestProgressData>>((
  ref,
) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.sectQuestProgress,
  )..where((t) => t.characterId.equals(id))).watch();
});

/// 当前师门的可用任务
final availableSectQuestsProvider = Provider<List<SectQuest>>((ref) {
  final sect = ref.watch(currentSectProvider);
  if (sect == null) return [];

  final progressList = ref.watch(sectQuestProgressProvider).valueOrNull ?? [];
  final activeIds = progressList.map((p) => p.questId).toSet();

  return sectQuests.values.where((q) {
    if (q.sectId != sect.id) return false;
    if (activeIds.contains(q.id)) return false;
    return true;
  }).toList();
});

class SectNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  SectNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  Future<int> _getInventoryCount(String characterId, String itemId) async {
    final row =
        await (_db.select(_db.inventoryItems)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.itemId.equals(itemId),
            ))
            .getSingleOrNull();
    return row?.quantity ?? 0;
  }

  /// 加入师门
  Future<bool> joinSect(String characterId, String sectId) async {
    final sect = sects[sectId];
    if (sect == null) return false;

    // 检查是否已加入师门
    final existing = await (_db.select(
      _db.sectMembers,
    )..where((t) => t.characterId.equals(characterId))).getSingleOrNull();
    if (existing != null) return false;

    await _db
        .into(_db.sectMembers)
        .insert(
          SectMembersCompanion.insert(
            characterId: characterId,
            sectId: sectId,
            contribution: const Value(0),
          ),
        );

    _ref
        .read(gameLogProvider.notifier)
        .addLog('加入了${sect.name}', type: LogType.system);

    return true;
  }

  /// 接取师门任务
  Future<void> acceptSectQuest(String characterId, String questId) async {
    final quest = sectQuests[questId];
    if (quest == null) return;

    final objectivesMap = <String, int>{};
    for (final obj in quest.objectives) {
      if (obj.type == QuestObjectiveType.collect) {
        final targetId = obj.targetId;
        if (targetId == null || targetId.isEmpty) {
          objectivesMap[obj.id] = 0;
        } else {
          final owned = await _getInventoryCount(characterId, targetId);
          objectivesMap[obj.id] = owned.clamp(0, obj.requiredCount);
        }
      } else {
        objectivesMap[obj.id] = 0;
      }
    }

    await _db
        .into(_db.sectQuestProgress)
        .insert(
          SectQuestProgressCompanion.insert(
            id: const Uuid().v4(),
            characterId: characterId,
            questId: questId,
            status: const Value(1),
            objectivesJson: Value(jsonEncode(objectivesMap)),
          ),
        );

    _ref
        .read(gameLogProvider.notifier)
        .addLog('接取师门任务: ${quest.name}', type: LogType.quest);
  }

  /// 更新师门任务目标
  Future<void> updateSectQuestObjective(
    String characterId,
    String questId,
    String objectiveId,
    int delta,
  ) async {
    final progressList =
        await (_db.select(_db.sectQuestProgress)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.questId.equals(questId),
            ))
            .get();
    if (progressList.isEmpty) return;
    final progress = progressList.first;

    final objectives = Map<String, int>.from(
      jsonDecode(progress.objectivesJson),
    );
    objectives[objectiveId] = (objectives[objectiveId] ?? 0) + delta;

    await (_db.update(
      _db.sectQuestProgress,
    )..where((t) => t.id.equals(progress.id))).write(
      SectQuestProgressCompanion(objectivesJson: Value(jsonEncode(objectives))),
    );
  }

  /// 统一检查并更新与 [type]+[targetId] 匹配的所有进行中师门任务目标
  Future<void> checkAndUpdateSectObjectives(
    String characterId,
    QuestObjectiveType type,
    String targetId, {
    int delta = 1,
  }) async {
    if (delta <= 0) return;

    // 查所有进行中的师门任务
    final progressList =
        await (_db.select(_db.sectQuestProgress)..where(
              (t) => t.characterId.equals(characterId) & t.status.equals(1),
            ))
            .get();

    for (final progress in progressList) {
      final quest = sectQuests[progress.questId];
      if (quest == null) continue;

      for (final obj in quest.objectives) {
        if (obj.type != type) continue;
        if (obj.targetId != targetId) continue;

        await updateSectQuestObjective(characterId, quest.id, obj.id, delta);
      }
    }
  }

  /// 完成师门任务
  Future<bool> completeSectQuest(String characterId, String questId) async {
    final quest = sectQuests[questId];
    if (quest == null) return false;

    final progressList =
        await (_db.select(_db.sectQuestProgress)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.questId.equals(questId),
            ))
            .get();
    if (progressList.isEmpty) return false;
    final progress = progressList.first;

    final objectives = Map<String, int>.from(
      jsonDecode(progress.objectivesJson),
    );
    var objectivesSynced = false;

    // 检查所有目标是否完成
    for (final obj in quest.objectives) {
      var current = objectives[obj.id] ?? 0;
      if (obj.type == QuestObjectiveType.collect) {
        final targetId = obj.targetId;
        if (targetId != null && targetId.isNotEmpty) {
          final owned = await _getInventoryCount(characterId, targetId);
          if (owned > current) {
            current = owned;
            objectives[obj.id] = owned;
            objectivesSynced = true;
          }
        }
      }
      if (current < obj.requiredCount) return false;
    }

    if (objectivesSynced) {
      await (_db.update(
        _db.sectQuestProgress,
      )..where((t) => t.id.equals(progress.id))).write(
        SectQuestProgressCompanion(
          objectivesJson: Value(jsonEncode(objectives)),
        ),
      );
    }

    // 标记完成
    await (_db.update(
      _db.sectQuestProgress,
    )..where((t) => t.id.equals(progress.id))).write(
      SectQuestProgressCompanion(
        status: const Value(2),
        lastCompletedTime: Value(DateTime.now()),
      ),
    );

    // 发放奖励
    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return true;

    final charNotifier = _ref.read(characterNotifierProvider.notifier);
    final logNotifier = _ref.read(gameLogProvider.notifier);

    // 增加贡献度
    if (quest.rewardContribution > 0) {
      final member = await (_db.select(
        _db.sectMembers,
      )..where((t) => t.characterId.equals(characterId))).getSingleOrNull();
      if (member != null) {
        await (_db.update(
          _db.sectMembers,
        )..where((t) => t.characterId.equals(characterId))).write(
          SectMembersCompanion(
            contribution: Value(member.contribution + quest.rewardContribution),
          ),
        );
      }
    }

    // 经验和银两
    if (quest.rewardExp > 0) {
      await charNotifier.addExp(characterId, quest.rewardExp);
    }
    if (quest.rewardSilver > 0) {
      await charNotifier.updateStats(
        characterId: characterId,
        silver: character.silver + quest.rewardSilver,
      );
    }

    // 物品和技能奖励
    if (quest.rewardItemId != null) {
      await _ref
          .read(inventoryNotifierProvider.notifier)
          .addItem(characterId, quest.rewardItemId!);
      logNotifier.addLog('获得物品奖励', type: LogType.item);
    }
    if (quest.rewardSkillId != null) {
      await _ref
          .read(skillNotifierProvider.notifier)
          .learnSkill(characterId, quest.rewardSkillId!);
      logNotifier.addLog(
        '习得师门技能: ${quest.rewardSkillId}',
        type: LogType.system,
      );
    }

    // 构建奖励信息
    final rewardParts = <String>[];
    if (quest.rewardContribution > 0) {
      rewardParts.add('贡献度+${quest.rewardContribution}');
    }
    if (quest.rewardExp > 0) {
      rewardParts.add('经验+${quest.rewardExp}');
    }
    if (quest.rewardSilver > 0) {
      rewardParts.add('银两+${quest.rewardSilver}');
    }

    logNotifier.addLog(
      '完成师门任务: ${quest.name}！${rewardParts.isNotEmpty ? "获得${rewardParts.join("、")}" : ""}',
      type: LogType.quest,
    );

    return true;
  }
}

final sectNotifierProvider =
    StateNotifierProvider<SectNotifier, AsyncValue<void>>((ref) {
      final db = ref.watch(databaseProvider);
      return SectNotifier(db, ref);
    });

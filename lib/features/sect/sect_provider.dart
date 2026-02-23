import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/item_data.dart';
import '../../data/sect_data.dart';
import '../../data/skill_data.dart';
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

enum SectQuestBoardState {
  active,
  available,
  cooldown,
  lockedContribution,
  lockedRealm,
  completed,
}

class SectQuestBoardEntry {
  final SectQuest quest;
  final SectQuestBoardState state;
  final Duration? cooldownRemaining;
  final int missingContribution;

  const SectQuestBoardEntry({
    required this.quest,
    required this.state,
    this.cooldownRemaining,
    this.missingContribution = 0,
  });
}

/// 当前师门任务看板（进行中/可接取/冷却/未解锁/已完成）
final sectQuestBoardProvider = Provider<List<SectQuestBoardEntry>>((ref) {
  final sect = ref.watch(currentSectProvider);
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  final member = ref.watch(currentSectMemberProvider).valueOrNull;
  if (sect == null || character == null || member == null) return [];

  final progressList = ref.watch(sectQuestProgressProvider).valueOrNull ?? [];
  final now = DateTime.now();

  final activeByQuestId = <String, SectQuestProgressData>{};
  final completedByQuestId = <String, List<SectQuestProgressData>>{};
  for (final progress in progressList) {
    if (progress.status == 1) {
      activeByQuestId[progress.questId] = progress;
    } else if (progress.status == 2) {
      completedByQuestId.putIfAbsent(progress.questId, () => []).add(progress);
    }
  }

  final entries = <SectQuestBoardEntry>[];
  for (final quest in sectQuests.values) {
    if (quest.sectId != sect.id) continue;

    if (activeByQuestId.containsKey(quest.id)) {
      entries.add(
        SectQuestBoardEntry(quest: quest, state: SectQuestBoardState.active),
      );
      continue;
    }

    if (character.realmTierIndex < quest.requiredRealm.rank - 1) {
      entries.add(
        SectQuestBoardEntry(
          quest: quest,
          state: SectQuestBoardState.lockedRealm,
        ),
      );
      continue;
    }

    if (member.contribution < quest.requiredContribution) {
      entries.add(
        SectQuestBoardEntry(
          quest: quest,
          state: SectQuestBoardState.lockedContribution,
          missingContribution: quest.requiredContribution - member.contribution,
        ),
      );
      continue;
    }

    final completedList = completedByQuestId[quest.id] ?? const [];
    if (!quest.repeatable) {
      entries.add(
        SectQuestBoardEntry(
          quest: quest,
          state: completedList.isNotEmpty
              ? SectQuestBoardState.completed
              : SectQuestBoardState.available,
        ),
      );
      continue;
    }

    DateTime? latestCompleted;
    for (final row in completedList) {
      final time = row.lastCompletedTime;
      if (time == null) continue;
      if (latestCompleted == null || latestCompleted.isBefore(time)) {
        latestCompleted = time;
      }
    }
    if (latestCompleted != null && quest.cooldownHours > 0) {
      final availableAt = latestCompleted.add(
        Duration(hours: quest.cooldownHours),
      );
      final remain = availableAt.difference(now);
      if (remain > Duration.zero) {
        entries.add(
          SectQuestBoardEntry(
            quest: quest,
            state: SectQuestBoardState.cooldown,
            cooldownRemaining: remain,
          ),
        );
        continue;
      }
    }

    entries.add(
      SectQuestBoardEntry(quest: quest, state: SectQuestBoardState.available),
    );
  }

  const stateOrder = <SectQuestBoardState, int>{
    SectQuestBoardState.active: 0,
    SectQuestBoardState.available: 1,
    SectQuestBoardState.cooldown: 2,
    SectQuestBoardState.lockedContribution: 3,
    SectQuestBoardState.lockedRealm: 4,
    SectQuestBoardState.completed: 5,
  };
  entries.sort((a, b) {
    final stateCmp = (stateOrder[a.state] ?? 99).compareTo(
      stateOrder[b.state] ?? 99,
    );
    if (stateCmp != 0) return stateCmp;
    if (a.state == SectQuestBoardState.lockedContribution) {
      return a.missingContribution.compareTo(b.missingContribution);
    }
    return a.quest.requiredContribution.compareTo(b.quest.requiredContribution);
  });
  return entries;
});

/// 当前师门的可用任务
final availableSectQuestsProvider = Provider<List<SectQuest>>((ref) {
  final board = ref.watch(sectQuestBoardProvider);
  return board
      .where((entry) => entry.state == SectQuestBoardState.available)
      .map((entry) => entry.quest)
      .toList();
});

/// 当前师门的贡献兑换列表
final sectExchangeOffersProvider = Provider<List<SectExchangeOffer>>((ref) {
  final sect = ref.watch(currentSectProvider);
  if (sect == null) return const [];

  final offers = sectExchangeOffers.values
      .where((offer) => offer.sectId == sect.id)
      .toList();
  offers.sort((a, b) => a.contributionCost.compareTo(b.contributionCost));
  return offers;
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
  Future<bool> acceptSectQuest(String characterId, String questId) async {
    final quest = sectQuests[questId];
    if (quest == null) return false;

    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return false;
    final member = await (_db.select(
      _db.sectMembers,
    )..where((t) => t.characterId.equals(characterId))).getSingleOrNull();
    if (member == null) return false;
    if (member.sectId != quest.sectId) return false;
    if (character.realmTierIndex < quest.requiredRealm.rank - 1) return false;
    if (member.contribution < quest.requiredContribution) return false;

    final existingRows =
        await (_db.select(_db.sectQuestProgress)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.questId.equals(questId),
            ))
            .get();
    final hasActiveRow = existingRows.any((row) => row.status == 1);
    if (hasActiveRow) return false;

    final completedRows = existingRows.where((row) => row.status == 2).toList();
    if (!quest.repeatable && completedRows.isNotEmpty) return false;
    if (quest.repeatable &&
        completedRows.isNotEmpty &&
        quest.cooldownHours > 0) {
      DateTime? latestCompleted;
      for (final row in completedRows) {
        final time = row.lastCompletedTime;
        if (time == null) continue;
        if (latestCompleted == null || latestCompleted.isBefore(time)) {
          latestCompleted = time;
        }
      }
      if (latestCompleted != null) {
        final nextTime = latestCompleted.add(
          Duration(hours: quest.cooldownHours),
        );
        if (DateTime.now().isBefore(nextTime)) return false;
      }
    }

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

    if (quest.repeatable && completedRows.isNotEmpty) {
      final latestCompletedRow = completedRows.reduce((a, b) {
        final aTime =
            a.lastCompletedTime ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime =
            b.lastCompletedTime ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aTime.isAfter(bTime) ? a : b;
      });
      await (_db.update(
        _db.sectQuestProgress,
      )..where((t) => t.id.equals(latestCompletedRow.id))).write(
        SectQuestProgressCompanion(
          status: const Value(1),
          objectivesJson: Value(jsonEncode(objectivesMap)),
          lastCompletedTime: const Value(null),
        ),
      );
    } else {
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
    }

    _ref
        .read(gameLogProvider.notifier)
        .addLog('接取师门任务: ${quest.name}', type: LogType.quest);
    return true;
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

  /// 师门贡献兑换，返回 null 表示成功，否则返回失败原因
  Future<String?> exchangeSectOffer(String characterId, String offerId) async {
    final offer = sectExchangeOffers[offerId];
    if (offer == null) return '兑换项目不存在';

    final member = await (_db.select(
      _db.sectMembers,
    )..where((t) => t.characterId.equals(characterId))).getSingleOrNull();
    if (member == null) return '尚未加入师门';
    if (member.sectId != offer.sectId) return '只能兑换本门奖励';
    if (member.contribution < offer.requiredContribution) return '贡献度不足以解锁该项目';
    if (member.contribution < offer.contributionCost) return '贡献度不足';

    if (offer.unique) {
      final skillId = offer.rewardSkillId;
      if (skillId != null && skillId.isNotEmpty) {
        final learned =
            await (_db.select(_db.learnedSkills)..where(
                  (t) =>
                      t.characterId.equals(characterId) &
                      t.skillId.equals(skillId),
                ))
                .getSingleOrNull();
        if (learned != null) return '该技能已兑换';
      }
      final itemId = offer.rewardItemId;
      if (itemId != null && itemId.isNotEmpty) {
        final owned = await _getInventoryCount(characterId, itemId);
        if (owned > 0) return '该物品已兑换';
      }
    }

    await _db.transaction(() async {
      await (_db.update(
        _db.sectMembers,
      )..where((t) => t.characterId.equals(characterId))).write(
        SectMembersCompanion(
          contribution: Value(member.contribution - offer.contributionCost),
        ),
      );

      final rewardItemId = offer.rewardItemId;
      if (rewardItemId != null && rewardItemId.isNotEmpty) {
        final existing =
            await (_db.select(_db.inventoryItems)..where(
                  (t) =>
                      t.characterId.equals(characterId) &
                      t.itemId.equals(rewardItemId),
                ))
                .getSingleOrNull();
        if (existing != null) {
          await (_db.update(
            _db.inventoryItems,
          )..where((t) => t.id.equals(existing.id))).write(
            InventoryItemsCompanion(
              quantity: Value(existing.quantity + offer.rewardItemCount),
            ),
          );
        } else {
          await _db
              .into(_db.inventoryItems)
              .insert(
                InventoryItemsCompanion.insert(
                  id: const Uuid().v4(),
                  characterId: characterId,
                  itemId: rewardItemId,
                  quantity: Value(offer.rewardItemCount),
                ),
              );
        }
      }

      final rewardSkillId = offer.rewardSkillId;
      if (rewardSkillId != null && rewardSkillId.isNotEmpty) {
        final learned =
            await (_db.select(_db.learnedSkills)..where(
                  (t) =>
                      t.characterId.equals(characterId) &
                      t.skillId.equals(rewardSkillId),
                ))
                .getSingleOrNull();
        if (learned == null) {
          await _db
              .into(_db.learnedSkills)
              .insert(
                LearnedSkillsCompanion.insert(
                  id: const Uuid().v4(),
                  characterId: characterId,
                  skillId: rewardSkillId,
                ),
              );
        }
      }
    });

    final rewardText = offer.rewardSkillId != null
        ? (skills[offer.rewardSkillId]?.name ?? offer.rewardSkillId!)
        : '${items[offer.rewardItemId]?.name ?? offer.rewardItemId} x${offer.rewardItemCount}';
    _ref
        .read(gameLogProvider.notifier)
        .addLog(
          '消耗贡献${offer.contributionCost}兑换：$rewardText',
          type: LogType.item,
        );
    return null;
  }
}

final sectNotifierProvider =
    StateNotifierProvider<SectNotifier, AsyncValue<void>>((ref) {
      final db = ref.watch(databaseProvider);
      return SectNotifier(db, ref);
    });

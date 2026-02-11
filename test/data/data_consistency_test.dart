import 'package:flutter_test/flutter_test.dart';
import 'package:vittaxia/data/dialogue_data.dart';
import 'package:vittaxia/data/enemy_data.dart';
import 'package:vittaxia/data/event_data.dart';
import 'package:vittaxia/data/item_data.dart';
import 'package:vittaxia/data/map_data.dart';
import 'package:vittaxia/data/npc_data.dart';
import 'package:vittaxia/data/quest_data.dart';
import 'package:vittaxia/data/skill_data.dart';
import 'package:vittaxia/models/enums.dart';

void _expectNoErrors(List<String> errors) {
  expect(errors, isEmpty, reason: errors.join('\n'));
}

void main() {
  group('Data consistency', () {
    test('map data references should be valid', () {
      final errors = <String>[];
      final locationIds = mapLocations.keys.toSet();

      for (final entry in mapLocations.entries) {
        final locationId = entry.key;
        final location = entry.value;

        if (location.id != locationId) {
          errors.add(
            'mapLocations key "$locationId" 与 location.id "${location.id}" 不一致',
          );
        }

        for (final adjacentId in location.adjacentIds) {
          if (!locationIds.contains(adjacentId)) {
            errors.add('地点 "$locationId" 的 adjacentId "$adjacentId" 不存在');
          }
        }

        for (final npcId in location.npcIds) {
          if (!npcs.containsKey(npcId)) {
            errors.add('地点 "$locationId" 引用了不存在的 npcId "$npcId"');
          }
        }

        for (final eventId in location.eventIds) {
          if (!gameEvents.containsKey(eventId)) {
            errors.add('地点 "$locationId" 引用了不存在的 eventId "$eventId"');
          }
        }

        final requiredQuestId = location.requiredQuestId;
        if (requiredQuestId != null && !quests.containsKey(requiredQuestId)) {
          errors.add(
            '地点 "$locationId" 的 requiredQuestId "$requiredQuestId" 不存在',
          );
        }
      }

      _expectNoErrors(errors);
    });

    test('npc data references should be valid', () {
      final errors = <String>[];

      for (final entry in npcs.entries) {
        final npcId = entry.key;
        final npc = entry.value;

        if (npc.id != npcId) {
          errors.add('npcs key "$npcId" 与 npc.id "${npc.id}" 不一致');
        }

        if (!mapLocations.containsKey(npc.locationId)) {
          errors.add('NPC "$npcId" 的 locationId "${npc.locationId}" 不存在');
        }

        for (final dialogueId in npc.dialogueIds) {
          if (!dialogues.containsKey(dialogueId)) {
            errors.add('NPC "$npcId" 引用了不存在的 dialogueId "$dialogueId"');
          }
        }

        for (final skillId in npc.teachableSkillIds) {
          if (!skills.containsKey(skillId)) {
            errors.add('NPC "$npcId" 引用了不存在的 teachableSkillId "$skillId"');
          }
        }

        for (final itemId in npc.shopItemIds) {
          if (!items.containsKey(itemId)) {
            errors.add('NPC "$npcId" 引用了不存在的 shopItemId "$itemId"');
          }
        }
      }

      _expectNoErrors(errors);
    });

    test('dialogue data references should be valid', () {
      final errors = <String>[];

      for (final entry in dialogues.entries) {
        final dialogueId = entry.key;
        final node = entry.value;

        if (node.id != dialogueId) {
          errors.add('dialogues key "$dialogueId" 与 node.id "${node.id}" 不一致');
        }

        if (node.nextId != null && !dialogues.containsKey(node.nextId)) {
          errors.add('对话 "$dialogueId" 的 nextId "${node.nextId}" 不存在');
        }

        for (final choice in node.choices) {
          if (!dialogues.containsKey(choice.nextId)) {
            errors.add(
              '对话 "$dialogueId" 的 choice.nextId "${choice.nextId}" 不存在',
            );
          }
        }

        if (node.rewardItemId != null &&
            !items.containsKey(node.rewardItemId)) {
          errors.add(
            '对话 "$dialogueId" 的 rewardItemId "${node.rewardItemId}" 不存在',
          );
        }

        if (node.teachSkillId != null &&
            !skills.containsKey(node.teachSkillId)) {
          errors.add(
            '对话 "$dialogueId" 的 teachSkillId "${node.teachSkillId}" 不存在',
          );
        }

        if (node.requiredQuestId != null &&
            !quests.containsKey(node.requiredQuestId)) {
          errors.add(
            '对话 "$dialogueId" 的 requiredQuestId "${node.requiredQuestId}" 不存在',
          );
        }
      }

      _expectNoErrors(errors);
    });

    test('quest data references should be valid', () {
      final errors = <String>[];

      for (final entry in quests.entries) {
        final questId = entry.key;
        final quest = entry.value;

        if (quest.id != questId) {
          errors.add('quests key "$questId" 与 quest.id "${quest.id}" 不一致');
        }

        final prerequisiteQuestId = quest.prerequisiteQuestId;
        if (prerequisiteQuestId != null &&
            !quests.containsKey(prerequisiteQuestId)) {
          errors.add(
            '任务 "$questId" 的 prerequisiteQuestId "$prerequisiteQuestId" 不存在',
          );
        }

        final questGiverNpcId = quest.questGiverNpcId;
        if (questGiverNpcId != null && !npcs.containsKey(questGiverNpcId)) {
          errors.add('任务 "$questId" 的 questGiverNpcId "$questGiverNpcId" 不存在');
        }

        final questLocationId = quest.questLocationId;
        if (questLocationId != null &&
            !mapLocations.containsKey(questLocationId)) {
          errors.add('任务 "$questId" 的 questLocationId "$questLocationId" 不存在');
        }

        final rewardItemId = quest.rewardItemId;
        if (rewardItemId != null && !items.containsKey(rewardItemId)) {
          errors.add('任务 "$questId" 的 rewardItemId "$rewardItemId" 不存在');
        }

        final rewardSkillId = quest.rewardSkillId;
        if (rewardSkillId != null && !skills.containsKey(rewardSkillId)) {
          errors.add('任务 "$questId" 的 rewardSkillId "$rewardSkillId" 不存在');
        }

        final objectiveIds = <String>{};
        for (final objective in quest.objectives) {
          if (!objectiveIds.add(objective.id)) {
            errors.add('任务 "$questId" 存在重复的 objective.id "${objective.id}"');
          }

          final targetId = objective.targetId;
          if (targetId == null || targetId.isEmpty) {
            errors.add('任务 "$questId" 的目标 "${objective.id}" 缺少 targetId');
            continue;
          }

          if (objective.requiredCount <= 0) {
            errors.add(
              '任务 "$questId" 的目标 "${objective.id}" requiredCount 必须大于 0',
            );
          }

          switch (objective.type) {
            case QuestObjectiveType.kill:
              if (!enemies.containsKey(targetId)) {
                errors.add('任务 "$questId" 的 kill 目标 "$targetId" 不存在于 enemies');
              }
              break;
            case QuestObjectiveType.collect:
              if (!items.containsKey(targetId)) {
                errors.add('任务 "$questId" 的 collect 目标 "$targetId" 不存在于 items');
              }
              break;
            case QuestObjectiveType.talk:
              if (!npcs.containsKey(targetId)) {
                errors.add('任务 "$questId" 的 talk 目标 "$targetId" 不存在于 npcs');
              }
              break;
            case QuestObjectiveType.explore:
              if (!mapLocations.containsKey(targetId)) {
                errors.add(
                  '任务 "$questId" 的 explore 目标 "$targetId" 不存在于 mapLocations',
                );
              }
              break;
          }
        }
      }

      _expectNoErrors(errors);
    });

    test('event data references should be valid', () {
      final errors = <String>[];

      for (final entry in gameEvents.entries) {
        final eventId = entry.key;
        final event = entry.value;

        if (event.id != eventId) {
          errors.add('gameEvents key "$eventId" 与 event.id "${event.id}" 不一致');
        }

        if (event.weight <= 0) {
          errors.add('事件 "$eventId" 的 weight 必须大于 0');
        }

        final enemyId = event.enemyId;
        if (enemyId != null && !enemies.containsKey(enemyId)) {
          errors.add('事件 "$eventId" 的 enemyId "$enemyId" 不存在');
        }

        final rewardItemId = event.rewardItemId;
        if (rewardItemId != null && !items.containsKey(rewardItemId)) {
          errors.add('事件 "$eventId" 的 rewardItemId "$rewardItemId" 不存在');
        }

        for (final choice in event.choices) {
          final choiceEnemyId = choice.enemyId;
          if (choiceEnemyId != null && !enemies.containsKey(choiceEnemyId)) {
            errors.add('事件 "$eventId" 的选项 enemyId "$choiceEnemyId" 不存在');
          }

          final choiceRewardItemId = choice.rewardItemId;
          if (choiceRewardItemId != null &&
              !items.containsKey(choiceRewardItemId)) {
            errors.add(
              '事件 "$eventId" 的选项 rewardItemId "$choiceRewardItemId" 不存在',
            );
          }

          if (choice.triggerBattle && choiceEnemyId == null) {
            errors.add('事件 "$eventId" 的战斗选项缺少 enemyId');
          }

          if (!choice.triggerBattle && choiceEnemyId != null) {
            errors.add('事件 "$eventId" 的非战斗选项不应设置 enemyId');
          }
        }
      }

      _expectNoErrors(errors);
    });
  });
}

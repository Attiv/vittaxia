import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/dialogue_data.dart';
import '../../data/quest_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/npc.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../quest/quest_provider.dart';
import '../sect/sect_provider.dart';
import '../skill/skill_provider.dart';
import 'npc_provider.dart';

class DialoguePage extends ConsumerStatefulWidget {
  final String npcId;
  final Npc npc;

  const DialoguePage({super.key, required this.npcId, required this.npc});

  @override
  ConsumerState<DialoguePage> createState() => _DialoguePageState();
}

class _DialoguePageState extends ConsumerState<DialoguePage> {
  DialogueNode? _currentNode;
  final List<_DialogueEntry> _history = [];
  bool _talkObjectiveUpdated = false;

  @override
  void initState() {
    super.initState();
    // 从第一个对话开始
    if (widget.npc.dialogueIds.isNotEmpty) {
      _setNode(widget.npc.dialogueIds.first);
    }
  }

  void _setNode(String nodeId) {
    final node = dialogues[nodeId];
    if (node == null) return;

    // 首次进入对话时更新 talk 类任务目标
    if (!_talkObjectiveUpdated) {
      _talkObjectiveUpdated = true;
      final character = ref.read(currentCharacterProvider).valueOrNull;
      if (character != null) {
        ref
            .read(questNotifierProvider.notifier)
            .checkAndUpdateObjectives(
              character.id,
              QuestObjectiveType.talk,
              widget.npcId,
            );
        ref
            .read(sectNotifierProvider.notifier)
            .checkAndUpdateSectObjectives(
              character.id,
              QuestObjectiveType.talk,
              widget.npcId,
            );
      }
    }

    setState(() {
      _currentNode = node;
      _history.add(_DialogueEntry(speaker: node.speaker, text: node.text));
    });

    _applyNodeEffects(node);
  }

  void _applyNodeEffects(DialogueNode node) {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final logNotifier = ref.read(gameLogProvider.notifier);
    final charNotifier = ref.read(characterNotifierProvider.notifier);

    // 好感度
    if (node.affectionChange != 0) {
      ref
          .read(npcNotifierProvider.notifier)
          .changeAffection(character.id, widget.npcId, node.affectionChange);
    }

    // 经验
    if (node.expReward > 0) {
      charNotifier.updateStats(
        characterId: character.id,
        exp: character.exp + node.expReward,
      );
      logNotifier.addLog('获得 ${node.expReward} 经验', type: LogType.dialogue);
    }

    // 银两
    if (node.silverReward != 0) {
      charNotifier.updateStats(
        characterId: character.id,
        silver: (character.silver + node.silverReward).clamp(0, 999999),
      );
    }

    // 教技能
    if (node.teachSkillId != null) {
      ref
          .read(skillNotifierProvider.notifier)
          .learnSkill(character.id, node.teachSkillId!);
      logNotifier.addLog('学会了新技能', type: LogType.dialogue);
    }

    // 奖励物品
    if (node.rewardItemId != null) {
      ref
          .read(inventoryNotifierProvider.notifier)
          .addItem(character.id, node.rewardItemId!);
      ref
          .read(questNotifierProvider.notifier)
          .checkAndUpdateObjectives(
            character.id,
            QuestObjectiveType.collect,
            node.rewardItemId!,
          );
      ref
          .read(sectNotifierProvider.notifier)
          .checkAndUpdateSectObjectives(
            character.id,
            QuestObjectiveType.collect,
            node.rewardItemId!,
          );
    }
  }

  void _selectChoice(DialogueChoice choice) {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    _history.add(
      _DialogueEntry(
        speaker: character.name,
        text: choice.text,
        isPlayer: true,
      ),
    );

    if (choice.affectionChange != 0) {
      ref
          .read(npcNotifierProvider.notifier)
          .changeAffection(character.id, widget.npcId, choice.affectionChange);
    }

    _setNode(choice.nextId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final node = _currentNode;

    // 读取已完成任务集合，用于过滤受剧情门控的选项
    final progress = ref.watch(questProgressProvider).valueOrNull ?? [];
    final completedQuestIds = progress
        .where((p) => p.status == 2)
        .map((p) => p.questId)
        .toSet();

    return Scaffold(
      appBar: AppBar(title: Text(widget.npc.name)),
      body: Column(
        children: [
          // 对话历史
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (_, i) {
                final entry = _history[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.speaker}：',
                        style: TextStyle(
                          color: entry.isPlayer
                              ? AppColors.accent
                              : AppColors.mp,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          entry.text,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // 选项区
          if (node != null)
            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (node.choices.isNotEmpty)
                    ...node.choices
                        .where((c) => _isChoiceVisible(c, completedQuestIds))
                        .map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ElevatedButton(
                              onPressed: () => _selectChoice(c),
                              child: Text(c.text),
                            ),
                          ),
                        ),
                  if (node.choices.isEmpty && node.nextId != null)
                    ElevatedButton(
                      onPressed: () => _setNode(node.nextId!),
                      child: const Text('继续'),
                    ),
                  if (node.choices.isEmpty && node.nextId == null)
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('告辞'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// 检查对话选项是否可见（前置任务是否已完成）
  bool _isChoiceVisible(DialogueChoice choice, Set<String> completedQuestIds) {
    final gateQuestId = dialogueQuestGates[choice.nextId];
    if (gateQuestId == null) return true;

    final quest = quests[gateQuestId];
    if (quest == null) return true;

    // 没有前置任务的直接放行
    if (quest.prerequisiteQuestId == null) return true;
    return completedQuestIds.contains(quest.prerequisiteQuestId);
  }
}

class _DialogueEntry {
  final String speaker;
  final String text;
  final bool isPlayer;

  _DialogueEntry({
    required this.speaker,
    required this.text,
    this.isPlayer = false,
  });
}

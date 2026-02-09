import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/quest_data.dart';
import '../../models/enums.dart';
import '../../models/quest.dart';
import '../character/character_provider.dart';
import 'quest_provider.dart';

class QuestPage extends ConsumerWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(questProgressProvider);
    final available = ref.watch(availableQuestsProvider);
    final active = ref.watch(activeQuestsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('任务'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '进行中'),
              Tab(text: '可接取'),
              Tab(text: '已完成'),
            ],
          ),
        ),
        body: progressAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (allProgress) {
            final completed =
                allProgress.where((p) => p.status == 2).toList();

            return TabBarView(
              children: [
                // 进行中
                _buildQuestList(
                  context,
                  ref,
                  active,
                  isActive: true,
                ),
                // 可接取
                _buildAvailableList(context, ref, available),
                // 已完成
                _buildCompletedList(context, completed),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestList(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> progressList, {
    required bool isActive,
  }) {
    if (progressList.isEmpty) {
      return const Center(
        child: Text('暂无任务', style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(12),
      children: progressList.map((progress) {
        final quest = quests[progress.questId];
        if (quest == null) return const SizedBox.shrink();

        final objectives =
            Map<String, int>.from(jsonDecode(progress.objectivesJson));

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _questTypeBadge(quest.type),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        quest.name,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(quest.description,
                    style: const TextStyle(fontSize: 13, height: 1.5)),
                const SizedBox(height: 8),
                ...quest.objectives.map((obj) {
                  final current = objectives[obj.id] ?? 0;
                  final done = current >= obj.requiredCount;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          done ? Icons.check_circle : Icons.circle_outlined,
                          color: done ? AppColors.success : AppColors.textSecondary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${obj.description} ($current/${obj.requiredCount})',
                          style: TextStyle(
                            color: done ? AppColors.success : AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                // 完成按钮
                if (isActive) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final character =
                            ref.read(currentCharacterProvider).valueOrNull;
                        if (character == null) return;
                        await ref
                            .read(questNotifierProvider.notifier)
                            .tryCompleteQuest(character.id, quest.id);
                      },
                      child: const Text('交付'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAvailableList(
      BuildContext context, WidgetRef ref, List<Quest> available) {
    if (available.isEmpty) {
      return const Center(
        child: Text('暂无可接取任务',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(12),
      children: available.map((quest) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _questTypeBadge(quest.type),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        quest.name,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(quest.description,
                    style: const TextStyle(fontSize: 13, height: 1.5)),
                const SizedBox(height: 8),
                _rewardRow(quest),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final character =
                          ref.read(currentCharacterProvider).valueOrNull;
                      if (character == null) return;
                      ref
                          .read(questNotifierProvider.notifier)
                          .acceptQuest(character.id, quest.id);
                    },
                    child: const Text('接取'),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompletedList(BuildContext context, List<dynamic> completed) {
    if (completed.isEmpty) {
      return const Center(
        child: Text('尚未完成任何任务',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(12),
      children: completed.map((progress) {
        final quest = quests[progress.questId];
        if (quest == null) return const SizedBox.shrink();
        return Card(
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: AppColors.success),
            title: Text(quest.name),
            subtitle: Text(quest.description,
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        );
      }).toList(),
    );
  }

  Widget _questTypeBadge(QuestType type) {
    final color = switch (type) {
      QuestType.main => AppColors.accent,
      QuestType.side => AppColors.mp,
      QuestType.hidden => const Color(0xFFAB47BC),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        type.label,
        style: TextStyle(color: color, fontSize: 10),
      ),
    );
  }

  Widget _rewardRow(Quest quest) {
    final parts = <String>[];
    if (quest.rewardExp > 0) parts.add('经验+${quest.rewardExp}');
    if (quest.rewardSilver > 0) parts.add('银两+${quest.rewardSilver}');
    if (quest.rewardReputation > 0) parts.add('声望+${quest.rewardReputation}');
    if (quest.rewardItemId != null) parts.add('物品奖励');
    if (quest.rewardSkillId != null) parts.add('技能奖励');

    return Text(
      '奖励: ${parts.join("、")}',
      style: const TextStyle(color: AppColors.exp, fontSize: 12),
    );
  }
}

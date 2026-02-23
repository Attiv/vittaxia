import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/game_audio.dart';
import '../../data/quest_data.dart';
import '../../models/enums.dart';
import '../../models/quest.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';
import 'quest_dialogs.dart';
import 'quest_provider.dart';

class QuestPage extends ConsumerStatefulWidget {
  final int initialTabIndex;

  const QuestPage({super.key, this.initialTabIndex = 0});

  @override
  ConsumerState<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends ConsumerState<QuestPage>
    with SingleTickerProviderStateMixin {
  static const _tabCount = 3;

  late final TabController _tabController;
  late int _activeTab;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTabIndex.clamp(0, _tabCount - 1).toInt();
    _activeTab = initial;
    _tabController = TabController(
      length: _tabCount,
      vsync: this,
      initialIndex: initial,
    );
    _tabController.addListener(_handleTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChanged() {
    if (_activeTab == _tabController.index) return;
    setState(() {
      _activeTab = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressAsync = ref.watch(questProgressProvider);
    final available = ref.watch(availableQuestsProvider);
    final active = ref.watch(activeQuestsProvider);
    final inventory = ref.watch(inventoryProvider).valueOrNull ?? const [];
    final inventoryCountById = _buildInventoryCountMap(inventory);

    return Scaffold(
      appBar: AppBar(
        title: const Text('任务'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            if (_activeTab == index) return;
            setState(() {
              _activeTab = index;
            });
          },
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
          final completed = allProgress.where((p) => p.status == 2).toList();
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: KeyedSubtree(
              key: ValueKey(_activeTab),
              child: switch (_activeTab) {
                0 => KeyedSubtree(
                  key: const PageStorageKey('quest_tab_active'),
                  child: _buildQuestList(
                    context,
                    ref,
                    active,
                    inventoryCountById: inventoryCountById,
                  ),
                ),
                1 => KeyedSubtree(
                  key: const PageStorageKey('quest_tab_available'),
                  child: _buildAvailableList(context, ref, available),
                ),
                _ => KeyedSubtree(
                  key: const PageStorageKey('quest_tab_completed'),
                  child: _buildCompletedList(context, completed),
                ),
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestList(
    BuildContext context,
    WidgetRef ref,
    List<QuestProgressData> progressList, {
    required Map<String, int> inventoryCountById,
  }) {
    if (progressList.isEmpty) {
      return Center(
        child: Text('暂无任务', style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: progressList.length,
      itemBuilder: (_, index) {
        final progress = progressList[index];
        final quest = quests[progress.questId];
        if (quest == null) return const SizedBox.shrink();

        final objectives = _decodeObjectives(progress.objectivesJson);
        final objectiveCurrent = <String, int>{
          for (final obj in quest.objectives)
            obj.id: _objectiveCurrent(obj, objectives, inventoryCountById),
        };
        final allDone = quest.objectives.every(
          (obj) => (objectiveCurrent[obj.id] ?? 0) >= obj.requiredCount,
        );

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
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  quest.description,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 8),
                ...quest.objectives.map((obj) {
                  final current = objectiveCurrent[obj.id] ?? 0;
                  final done = current >= obj.requiredCount;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          done ? Icons.check_circle : Icons.circle_outlined,
                          color: done
                              ? AppColors.success
                              : AppColors.textSecondary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${obj.description} ($current/${obj.requiredCount})',
                            style: TextStyle(
                              color: done
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: allDone
                        ? () async {
                            final character = ref
                                .read(currentCharacterProvider)
                                .valueOrNull;
                            if (character == null) return;

                            final completed = await ref
                                .read(questNotifierProvider.notifier)
                                .tryCompleteQuest(character.id, quest.id);

                            if (completed && context.mounted) {
                              GameAudio.success();
                              await showQuestCompleteDialog(context, quest);
                            }
                          }
                        : null,
                    child: const Text('交付'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvailableList(
    BuildContext context,
    WidgetRef ref,
    List<Quest> available,
  ) {
    if (available.isEmpty) {
      return Center(
        child: Text(
          '暂无可接取任务',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: available.length,
      itemBuilder: (_, index) {
        final quest = available[index];
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
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  quest.description,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 8),
                _rewardRow(quest),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final character = ref
                          .read(currentCharacterProvider)
                          .valueOrNull;
                      if (character == null) return;

                      final confirmed = await showQuestAcceptDialog(
                        context,
                        quest,
                      );
                      if (confirmed == true) {
                        ref
                            .read(questNotifierProvider.notifier)
                            .acceptQuest(character.id, quest.id);
                      }
                    },
                    child: const Text('接取'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompletedList(
    BuildContext context,
    List<QuestProgressData> completed,
  ) {
    if (completed.isEmpty) {
      return Center(
        child: Text(
          '尚未完成任何任务',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: completed.length,
      itemBuilder: (_, index) {
        final progress = completed[index];
        final quest = quests[progress.questId];
        if (quest == null) return const SizedBox.shrink();

        return Card(
          child: ListTile(
            leading: Icon(Icons.check_circle, color: AppColors.success),
            title: Text(quest.name),
            subtitle: Text(
              quest.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
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
      child: Text(type.label, style: TextStyle(color: color, fontSize: 10)),
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
      style: TextStyle(color: AppColors.exp, fontSize: 12),
    );
  }

  Map<String, int> _decodeObjectives(String objectivesJson) {
    try {
      final decoded = jsonDecode(objectivesJson);
      if (decoded is! Map) return <String, int>{};
      final result = <String, int>{};
      for (final entry in decoded.entries) {
        final key = entry.key.toString();
        final value = entry.value;
        result[key] = value is int ? value : int.tryParse('$value') ?? 0;
      }
      return result;
    } catch (_) {
      return <String, int>{};
    }
  }

  Map<String, int> _buildInventoryCountMap(List<dynamic> inventory) {
    final counts = <String, int>{};
    for (final inv in inventory) {
      final itemId = inv.itemId as String?;
      final quantity = inv.quantity as int?;
      if (itemId == null) continue;
      counts[itemId] = (counts[itemId] ?? 0) + (quantity ?? 0);
    }
    return counts;
  }

  int _objectiveCurrent(
    QuestObjective obj,
    Map<String, int> objectives,
    Map<String, int> inventoryCountById,
  ) {
    final recorded = objectives[obj.id] ?? 0;
    if (obj.type != QuestObjectiveType.collect) return recorded;

    final targetId = obj.targetId;
    if (targetId == null || targetId.isEmpty) return recorded;

    final owned = inventoryCountById[targetId] ?? 0;
    return owned > recorded ? owned : recorded;
  }
}

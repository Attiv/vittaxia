import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/game_audio.dart';
import '../../data/item_data.dart';
import '../../data/sect_data.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/sect.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';
import '../skill/skill_provider.dart';
import 'sect_provider.dart';

class SectPage extends ConsumerWidget {
  const SectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(currentSectMemberProvider).valueOrNull;
    final currentSect = ref.watch(currentSectProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('师门')),
      body: member == null
          ? _buildJoinSectView(context, ref)
          : _buildSectMemberView(context, ref, currentSect, member),
    );
  }

  // 未加入师门 - 显示可加入的师门列表
  Widget _buildJoinSectView(BuildContext context, WidgetRef ref) {
    final availableSects = ref.watch(availableSectsProvider);
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    if (character == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (availableSects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                '暂无可加入的师门',
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Text(
                '提升境界和声望后可解锁更多师门',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            '选择师门',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...availableSects.map(
          (sect) => _buildSectCard(context, ref, sect, character),
        ),
      ],
    );
  }

  Widget _buildSectCard(
    BuildContext context,
    WidgetRef ref,
    Sect sect,
    dynamic character,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    sect.type.label,
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    sect.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(sect.description, style: TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 12),
            _buildSectInfo(sect),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('加入${sect.name}'),
                      content: Text('确定要加入${sect.name}吗？\n\n加入后将无法更换师门。'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('取消'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('确定'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    await ref
                        .read(sectNotifierProvider.notifier)
                        .joinSect(character.id, sect.id);
                  }
                },
                icon: Icon(Icons.check_circle_outline),
                label: const Text('加入师门'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectInfo(Sect sect) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '师门特色',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          if (sect.atkBonus > 0)
            _buildBonusRow(
              Icons.flash_on,
              '攻击',
              '+${sect.atkBonus}',
              AppColors.danger,
            ),
          if (sect.defBonus > 0)
            _buildBonusRow(
              Icons.shield,
              '防御',
              '+${sect.defBonus}',
              AppColors.mp,
            ),
          if (sect.speedBonus > 0)
            _buildBonusRow(
              Icons.speed,
              '速度',
              '+${sect.speedBonus}',
              AppColors.exp,
            ),
          const SizedBox(height: 4),
          Text(
            '特色技能: ${sect.specialtySkills.length}个',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildBonusRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13)),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // 已加入师门 - 显示师门信息和任务
  Widget _buildSectMemberView(
    BuildContext context,
    WidgetRef ref,
    Sect? sect,
    dynamic member,
  ) {
    if (sect == null) {
      return const Center(child: Text('师门信息加载失败'));
    }

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        sect.type.label,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        sect.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.warning, size: 20),
                    const SizedBox(width: 6),
                    const Text('贡献度:', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 4),
                    Text(
                      '${member.contribution}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const TabBar(
            tabs: [
              Tab(text: '师门任务'),
              Tab(text: '贡献兑换'),
              Tab(text: '师门信息'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildQuestTab(context, ref),
                _buildExchangeTab(context, ref),
                _buildInfoTab(context, sect),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestTab(BuildContext context, WidgetRef ref) {
    final board = ref.watch(sectQuestBoardProvider);
    final progressList = ref.watch(sectQuestProgressProvider).valueOrNull ?? [];
    final inventory = ref.watch(inventoryProvider).valueOrNull ?? [];
    final activeProgressByQuestId = <String, dynamic>{
      for (final p in progressList)
        if (p.status == 1) p.questId: p,
    };
    final activeEntries = board
        .where((entry) => entry.state == SectQuestBoardState.active)
        .toList();
    final availableEntries = board
        .where((entry) => entry.state == SectQuestBoardState.available)
        .toList();
    final pendingEntries = board
        .where(
          (entry) =>
              entry.state == SectQuestBoardState.cooldown ||
              entry.state == SectQuestBoardState.lockedContribution ||
              entry.state == SectQuestBoardState.lockedRealm ||
              entry.state == SectQuestBoardState.completed,
        )
        .toList();

    if (board.isEmpty) {
      return Center(
        child: Text(
          '当前师门暂无任务配置',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (activeEntries.isNotEmpty) ...[
          Text(
            '进行中',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          ...activeEntries.map((entry) {
            final progress = activeProgressByQuestId[entry.quest.id];
            if (progress == null) return const SizedBox.shrink();
            return _buildQuestCard(
              context,
              ref,
              entry.quest,
              progress,
              inventory,
            );
          }),
          const SizedBox(height: 16),
        ],
        if (availableEntries.isNotEmpty) ...[
          Text(
            '可接取',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          ...availableEntries.map(
            (entry) => _buildAvailableQuestCard(context, ref, entry.quest),
          ),
          const SizedBox(height: 16),
        ],
        if (pendingEntries.isNotEmpty) ...[
          Text(
            '未就绪',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          ...pendingEntries.map((entry) => _buildQuestBoardStateCard(entry)),
        ],
      ],
    );
  }

  Widget _buildQuestBoardStateCard(SectQuestBoardEntry entry) {
    final quest = entry.quest;
    String badgeText;
    Color badgeColor;
    String hint;

    if (entry.state == SectQuestBoardState.cooldown) {
      badgeText = '冷却中';
      badgeColor = AppColors.warning;
      hint = '剩余 ${_formatDuration(entry.cooldownRemaining)} 后可再次接取';
    } else if (entry.state == SectQuestBoardState.lockedContribution) {
      badgeText = '贡献不足';
      badgeColor = AppColors.mp;
      hint = '还差 ${entry.missingContribution} 点贡献度';
    } else if (entry.state == SectQuestBoardState.lockedRealm) {
      badgeText = '境界不足';
      badgeColor = AppColors.danger;
      hint = '需要达到 ${quest.requiredRealm.label}';
    } else {
      badgeText = '已完成';
      badgeColor = AppColors.success;
      hint = '该任务为一次性任务，已完成';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: badgeColor.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      color: badgeColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    quest.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              quest.description,
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hint,
              style: TextStyle(
                fontSize: 12,
                color: badgeColor.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null || duration <= Duration.zero) return '0分钟';
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours <= 0) return '$minutes分钟';
    if (minutes == 0) return '$hours小时';
    return '$hours小时$minutes分钟';
  }

  Widget _buildQuestCard(
    BuildContext context,
    WidgetRef ref,
    SectQuest quest,
    dynamic progress,
    List<dynamic> inventory,
  ) {
    final objectives = Map<String, int>.from(
      jsonDecode(progress.objectivesJson),
    );

    // 检查所有目标是否完成
    final allDone = quest.objectives.every((obj) {
      final current = _objectiveCurrent(obj, objectives, inventory);
      return current >= obj.requiredCount;
    });

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quest.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              quest.description,
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 8),
            // 显示任务目标进度
            ...quest.objectives.map((obj) {
              final current = _objectiveCurrent(obj, objectives, inventory);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '奖励: 贡献度+${quest.rewardContribution}',
                  style: TextStyle(fontSize: 12, color: AppColors.warning),
                ),
                ElevatedButton(
                  onPressed: allDone
                      ? () async {
                          final character = ref
                              .read(currentCharacterProvider)
                              .valueOrNull;
                          if (character == null) return;

                          final completed = await ref
                              .read(sectNotifierProvider.notifier)
                              .completeSectQuest(character.id, quest.id);

                          if (completed && context.mounted) {
                            GameAudio.success();
                            // 显示奖励对话框
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColors.success,
                                    ),
                                    SizedBox(width: 8),
                                    Text('任务完成'),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quest.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '获得奖励:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (quest.rewardContribution > 0)
                                      _buildRewardRow(
                                        Icons.star,
                                        '贡献度',
                                        '+${quest.rewardContribution}',
                                        AppColors.warning,
                                      ),
                                    if (quest.rewardExp > 0)
                                      _buildRewardRow(
                                        Icons.trending_up,
                                        '经验',
                                        '+${quest.rewardExp}',
                                        AppColors.exp,
                                      ),
                                    if (quest.rewardSilver > 0)
                                      _buildRewardRow(
                                        Icons.monetization_on,
                                        '银两',
                                        '+${quest.rewardSilver}',
                                        AppColors.warning,
                                      ),
                                    if (quest.rewardSkillId != null)
                                      _buildRewardRow(
                                        Icons.auto_awesome,
                                        '技能',
                                        skills[quest.rewardSkillId]?.name ??
                                            quest.rewardSkillId!,
                                        AppColors.accent,
                                      ),
                                    if (quest.rewardItemId != null)
                                      _buildRewardRow(
                                        Icons.inventory_2,
                                        '物品',
                                        items[quest.rewardItemId]?.name ??
                                            quest.rewardItemId!,
                                        AppColors.mp,
                                      ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('确定'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      : null,
                  child: const Text('交付'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableQuestCard(
    BuildContext context,
    WidgetRef ref,
    SectQuest quest,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (quest.repeatable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mp.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.mp.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      '日常',
                      style: TextStyle(color: AppColors.mp, fontSize: 10),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    quest.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              quest.description,
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
            if (quest.requiredContribution > 0 ||
                quest.requiredRealm != RealmTier.houTian) ...[
              const SizedBox(height: 6),
              Text(
                '接取条件: ${quest.requiredRealm.label}'
                '${quest.requiredContribution > 0 ? ' · 贡献度${quest.requiredContribution}' : ''}',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              '奖励: 贡献度+${quest.rewardContribution}、经验+${quest.rewardExp}',
              style: TextStyle(fontSize: 12, color: AppColors.warning),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  final character = ref
                      .read(currentCharacterProvider)
                      .valueOrNull;
                  if (character == null) return;
                  final ok = await ref
                      .read(sectNotifierProvider.notifier)
                      .acceptSectQuest(character.id, quest.id);
                  if (!context.mounted) return;
                  if (ok) {
                    GameAudio.tap();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('已接取师门任务')));
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('当前无法接取该任务')));
                  }
                },
                child: const Text('接取'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeTab(BuildContext context, WidgetRef ref) {
    final member = ref.watch(currentSectMemberProvider).valueOrNull;
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    final offers = ref.watch(sectExchangeOffersProvider);
    final learnedSkills = ref.watch(learnedSkillsProvider).valueOrNull ?? [];
    final learnedSkillIds = learnedSkills.map((s) => s.skillId).toSet();
    final inventory = ref.watch(inventoryProvider).valueOrNull ?? [];
    final inventoryCountById = <String, int>{};
    for (final inv in inventory) {
      final itemId = inv.itemId as String?;
      final quantity = inv.quantity as int?;
      if (itemId == null || itemId.isEmpty) continue;
      inventoryCountById[itemId] =
          (inventoryCountById[itemId] ?? 0) + (quantity ?? 0);
    }

    if (member == null || character == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (offers.isEmpty) {
      return Center(
        child: Text(
          '当前师门暂无兑换项目',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          '贡献兑换',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '当前贡献度：${member.contribution}',
          style: TextStyle(
            color: AppColors.warning,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...offers.map(
          (offer) => _buildExchangeOfferCard(
            context,
            ref,
            character.id,
            member.contribution,
            offer,
            learnedSkillIds,
            inventoryCountById,
          ),
        ),
      ],
    );
  }

  Widget _buildExchangeOfferCard(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    int contribution,
    SectExchangeOffer offer,
    Set<String> learnedSkillIds,
    Map<String, int> inventoryCountById,
  ) {
    final rewardText = _offerRewardText(offer);
    final unlocked = contribution >= offer.requiredContribution;
    final enoughCost = contribution >= offer.contributionCost;
    final uniqueSkillLearned =
        offer.unique &&
        offer.rewardSkillId != null &&
        learnedSkillIds.contains(offer.rewardSkillId);
    final uniqueItemOwned =
        offer.unique &&
        offer.rewardItemId != null &&
        (inventoryCountById[offer.rewardItemId!] ?? 0) > 0;
    final uniqueDone = uniqueSkillLearned || uniqueItemOwned;
    final canExchange = unlocked && enoughCost && !uniqueDone;

    String stateText;
    Color stateColor;
    if (!unlocked) {
      stateText = '需贡献度 ${offer.requiredContribution} 解锁';
      stateColor = AppColors.mp;
    } else if (!enoughCost) {
      stateText = '贡献不足';
      stateColor = AppColors.danger;
    } else if (uniqueDone) {
      stateText = '已兑换';
      stateColor = AppColors.success;
    } else {
      stateText = '可兑换';
      stateColor = AppColors.accent;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    offer.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: stateColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: stateColor.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    stateText,
                    style: TextStyle(
                      color: stateColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              offer.description,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '兑换内容：$rewardText',
              style: TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: AppColors.warning),
                const SizedBox(width: 4),
                Text(
                  '消耗贡献: ${offer.contributionCost}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: !canExchange
                    ? null
                    : () async {
                        final error = await ref
                            .read(sectNotifierProvider.notifier)
                            .exchangeSectOffer(characterId, offer.id);
                        if (!context.mounted) return;
                        if (error == null) {
                          GameAudio.success();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('兑换成功：$rewardText')),
                          );
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(error)));
                        }
                      },
                child: const Text('兑换'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _offerRewardText(SectExchangeOffer offer) {
    final skillId = offer.rewardSkillId;
    if (skillId != null && skillId.isNotEmpty) {
      return skills[skillId]?.name ?? skillId;
    }
    final itemId = offer.rewardItemId;
    if (itemId != null && itemId.isNotEmpty) {
      final name = items[itemId]?.name ?? itemId;
      return '$name x${offer.rewardItemCount}';
    }
    return '未知奖励';
  }

  Widget _buildInfoTab(BuildContext context, Sect sect) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '师门介绍',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Text(sect.description, style: TextStyle(fontSize: 14, height: 1.6)),
        const SizedBox(height: 16),
        _buildSectInfo(sect),
      ],
    );
  }

  int _objectiveCurrent(
    SectQuestObjective obj,
    Map<String, int> objectives,
    List<dynamic> inventory,
  ) {
    final recorded = objectives[obj.id] ?? 0;
    if (obj.type != QuestObjectiveType.collect) return recorded;
    final targetId = obj.targetId;
    if (targetId == null || targetId.isEmpty) return recorded;

    final owned = inventory
        .where((inv) => inv.itemId == targetId)
        .fold<int>(0, (sum, inv) => sum + (inv.quantity as int));
    return owned > recorded ? owned : recorded;
  }

  Widget _buildRewardRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text('$label: ', style: TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/faction_data.dart';
import '../../models/faction.dart';
import 'faction_provider.dart';

class FactionPage extends ConsumerWidget {
  const FactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reputationsAsync = ref.watch(factionReputationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('江湖势力')),
      body: reputationsAsync.when(
        data: (reputations) => _buildContent(context, ref, reputations),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('加载失败: $e')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Map<String, FactionReputation> reputations,
  ) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: AppColors.surface,
            child: const TabBar(
              tabs: [
                Tab(text: '正派'),
                Tab(text: '中立'),
                Tab(text: '邪派'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildFactionList(
                  context,
                  ref,
                  FactionType.righteous,
                  reputations,
                ),
                _buildFactionList(
                  context,
                  ref,
                  FactionType.neutral,
                  reputations,
                ),
                _buildFactionList(
                  context,
                  ref,
                  FactionType.evil,
                  reputations,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactionList(
    BuildContext context,
    WidgetRef ref,
    FactionType type,
    Map<String, FactionReputation> reputations,
  ) {
    final factionsOfType =
        factions.values.where((f) => f.type == type).toList();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: factionsOfType.map((faction) {
        final reputation = reputations[faction.id];
        return _buildFactionCard(context, ref, faction, reputation);
      }).toList(),
    );
  }

  Widget _buildFactionCard(
    BuildContext context,
    WidgetRef ref,
    Faction faction,
    FactionReputation? reputation,
  ) {
    final rep = reputation?.reputation ?? 0;
    final level = reputation?.level ?? ReputationLevel.neutral;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showFactionDetail(context, ref, faction, reputation),
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
                      color: _getFactionTypeColor(faction.type)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _getFactionTypeColor(faction.type)
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      faction.type.label,
                      style: TextStyle(
                        color: _getFactionTypeColor(faction.type),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      faction.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                faction.description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    _getReputationIcon(level),
                    size: 16,
                    color: _getReputationColor(level),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    level.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getReputationColor(level),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '($rep)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: reputation?.levelProgress ?? 0,
                backgroundColor: AppColors.surface,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getReputationColor(level),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFactionDetail(
    BuildContext context,
    WidgetRef ref,
    Faction faction,
    FactionReputation? reputation,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                faction.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                faction.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              _buildReputationInfo(reputation),
              const SizedBox(height: 16),
              _buildRewards(faction, reputation),
              const SizedBox(height: 16),
              _buildSpecialties(faction),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReputationInfo(FactionReputation? reputation) {
    if (reputation == null) return const SizedBox.shrink();

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
            '当前声望',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                reputation.level.label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getReputationColor(reputation.level),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${reputation.reputation})',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (reputation.reputationToNextLevel > 0)
            Text(
              '距离下一等级还需: ${reputation.reputationToNextLevel}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRewards(Faction faction, FactionReputation? reputation) {
    final rewards = factionRewards[faction.id] ?? [];
    if (rewards.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '声望奖励',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        ...rewards.map((reward) {
          final unlocked = reputation != null &&
              reputation.level.level >= reward.requiredLevel.level;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: unlocked
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: unlocked
                    ? AppColors.success.withValues(alpha: 0.3)
                    : AppColors.primaryLight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  unlocked ? Icons.check_circle : Icons.lock,
                  color: unlocked ? AppColors.success : AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.requiredLevel.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        reward.description,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSpecialties(Faction faction) {
    if (faction.specialties.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '势力特色',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: faction.specialties.map((specialty) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                specialty,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.accent,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getFactionTypeColor(FactionType type) {
    switch (type) {
      case FactionType.righteous:
        return AppColors.success;
      case FactionType.evil:
        return AppColors.danger;
      case FactionType.neutral:
        return AppColors.warning;
    }
  }

  IconData _getReputationIcon(ReputationLevel level) {
    if (level.level >= ReputationLevel.honored.level) {
      return Icons.favorite;
    } else if (level.level >= ReputationLevel.friendly.level) {
      return Icons.thumb_up;
    } else if (level.level >= ReputationLevel.neutral.level) {
      return Icons.remove;
    } else {
      return Icons.thumb_down;
    }
  }

  Color _getReputationColor(ReputationLevel level) {
    if (level.level >= ReputationLevel.honored.level) {
      return AppColors.success;
    } else if (level.level >= ReputationLevel.friendly.level) {
      return AppColors.mp;
    } else if (level.level >= ReputationLevel.neutral.level) {
      return AppColors.textSecondary;
    } else {
      return AppColors.danger;
    }
  }
}

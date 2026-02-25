import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/arena_data.dart';
import '../../models/arena.dart';
import '../character/character_provider.dart';

class ArenaPage extends ConsumerStatefulWidget {
  const ArenaPage({super.key});

  @override
  ConsumerState<ArenaPage> createState() => _ArenaPageState();
}

class _ArenaPageState extends ConsumerState<ArenaPage> {
  @override
  Widget build(BuildContext context) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    if (character == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('论剑台')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('论剑台')),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: AppColors.surface,
              child: const TabBar(
                tabs: [
                  Tab(text: '每日挑战'),
                  Tab(text: '排位赛'),
                  Tab(text: '排行榜'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDailyChallengeTab(context, character),
                  _buildRankedTab(context, character),
                  _buildLeaderboardTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyChallengeTab(BuildContext context, dynamic character) {
    final opponents = arenaOpponents.values.toList()
      ..sort((a, b) => a.level.compareTo(b.level));

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.accent, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '每日挑战',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '挑战不同等级的对手，获得经验、银两和排名积分。每天可以挑战无限次。',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...opponents.map((opponent) => _buildOpponentCard(context, opponent)),
      ],
    );
  }

  Widget _buildOpponentCard(BuildContext context, ArenaOpponent opponent) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _challengeOpponent(context, opponent),
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
                      color: _getLevelColor(opponent.level)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _getLevelColor(opponent.level)
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      'Lv.${opponent.level}',
                      style: TextStyle(
                        color: _getLevelColor(opponent.level),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opponent.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                        Text(
                          opponent.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatChip(Icons.favorite, '${opponent.hp}', AppColors.hp),
                  const SizedBox(width: 8),
                  _buildStatChip(
                      Icons.flash_on, '${opponent.atk}', AppColors.danger),
                  const SizedBox(width: 8),
                  _buildStatChip(
                      Icons.shield, '${opponent.def}', AppColors.mp),
                  const SizedBox(width: 8),
                  _buildStatChip(
                      Icons.speed, '${opponent.speed}', AppColors.exp),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRewardText(
                        Icons.trending_up, '经验 +${opponent.rewardExp}'),
                    _buildRewardText(
                        Icons.monetization_on, '银两 +${opponent.rewardSilver}'),
                    _buildRewardText(
                        Icons.star, '排名 +${opponent.rewardRanking}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  void _challengeOpponent(BuildContext context, ArenaOpponent opponent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('挑战 ${opponent.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${opponent.title}'),
            const SizedBox(height: 8),
            Text('等级: ${opponent.level}'),
            Text('生命: ${opponent.hp}'),
            Text('攻击: ${opponent.atk}'),
            Text('防御: ${opponent.def}'),
            Text('速度: ${opponent.speed}'),
            const SizedBox(height: 12),
            Text(
              '确定要挑战吗？',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 启动战斗
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('战斗系统开发中...')),
              );
            },
            child: const Text('挑战'),
          ),
        ],
      ),
    );
  }

  Widget _buildRankedTab(BuildContext context, dynamic character) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: 80,
              color: AppColors.warning,
            ),
            const SizedBox(height: 24),
            Text(
              '排位赛',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '排位赛系统开发中...',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '敬请期待！',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildLeaderboardTypeCard(
          context,
          LeaderboardType.power,
          Icons.flash_on,
          AppColors.danger,
        ),
        _buildLeaderboardTypeCard(
          context,
          LeaderboardType.wealth,
          Icons.monetization_on,
          AppColors.warning,
        ),
        _buildLeaderboardTypeCard(
          context,
          LeaderboardType.reputation,
          Icons.star,
          AppColors.exp,
        ),
        _buildLeaderboardTypeCard(
          context,
          LeaderboardType.arena,
          Icons.emoji_events,
          AppColors.accent,
        ),
        _buildLeaderboardTypeCard(
          context,
          LeaderboardType.sect,
          Icons.groups,
          AppColors.mp,
        ),
      ],
    );
  }

  Widget _buildLeaderboardTypeCard(
    BuildContext context,
    LeaderboardType type,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showLeaderboard(context, type),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  type.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaderboard(BuildContext context, LeaderboardType type) {
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
          child: Column(
            children: [
              Text(
                type.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: Text(
                    '排行榜数据开发中...',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    if (level >= 15) return AppColors.danger;
    if (level >= 10) return AppColors.warning;
    if (level >= 5) return AppColors.mp;
    return AppColors.success;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/game_audio.dart';
import '../../data/map_data.dart';
import '../../data/skill_data.dart';
import '../../models/cultivation.dart';
import '../character/character_provider.dart';
import '../skill/skill_provider.dart';
import 'cultivation_calculator.dart';
import 'cultivation_provider.dart';

class CultivationPage extends ConsumerStatefulWidget {
  const CultivationPage({super.key});

  @override
  ConsumerState<CultivationPage> createState() => _CultivationPageState();
}

class _CultivationPageState extends ConsumerState<CultivationPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 每秒刷新一次进度
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(currentCultivationSessionProvider);
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    if (character == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('修炼')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('修炼')),
      body: sessionAsync.when(
        data: (session) {
          if (session == null || session.status == CultivationStatus.idle) {
            return _buildStartView(context, character);
          } else if (session.status == CultivationStatus.cultivating) {
            return _buildProgressView(context, session);
          } else {
            return _buildRewardView(context, session);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('加载失败: $e')),
      ),
    );
  }

  Widget _buildStartView(BuildContext context, dynamic character) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: AppColors.surface,
            child: const TabBar(
              tabs: [
                Tab(text: '打坐修炼'),
                Tab(text: '武技修炼'),
                Tab(text: '历练探索'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildMeditationTab(context, character),
                _buildPracticeTab(context, character),
                _buildAdventureTab(context, character),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationTab(BuildContext context, dynamic character) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '打坐修炼',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '静心打坐，感悟天地灵气，提升修为境界。',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        _buildDurationOptions(
          context,
          character,
          CultivationType.meditation,
        ),
      ],
    );
  }

  Widget _buildPracticeTab(BuildContext context, dynamic character) {
    final learnedSkills = ref.watch(learnedSkillsProvider).valueOrNull ?? [];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '武技修炼',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '反复演练武技，提升技能熟练度。',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        if (learnedSkills.isEmpty)
          Center(
            child: Text(
              '你还没有学会任何技能',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          )
        else
          ...learnedSkills.map((ls) {
            final skill = skills[ls.skillId];
            if (skill == null) return const SizedBox.shrink();
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      skill.description,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    _buildDurationOptions(
                      context,
                      character,
                      CultivationType.practice,
                      skillId: skill.id,
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildAdventureTab(BuildContext context, dynamic character) {
    final locations = mapLocations.values.where((loc) => loc.unlocked).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '历练探索',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '前往各地历练，获得经验、银两和材料。收益最丰富但也最随机。',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        ...locations.map((loc) {
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
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          loc.type.label,
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        loc.name,
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
                    loc.description,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  _buildDurationOptions(
                    context,
                    character,
                    CultivationType.adventure,
                    locationId: loc.id,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDurationOptions(
    BuildContext context,
    dynamic character,
    CultivationType type, {
    String? skillId,
    String? locationId,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: CultivationCalculator.recommendedDurations.map((minutes) {
        return ElevatedButton(
          onPressed: () async {
            final error = await ref
                .read(cultivationNotifierProvider.notifier)
                .startCultivation(
                  characterId: character.id,
                  type: type,
                  durationMinutes: minutes,
                  skillId: skillId,
                  locationId: locationId,
                );

            if (!context.mounted) return;

            if (error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            } else {
              GameAudio.tap();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '开始${type.label}，预计${CultivationCalculator.formatDuration(minutes)}后完成',
                  ),
                ),
              );
            }
          },
          child: Text(CultivationCalculator.formatDuration(minutes)),
        );
      }).toList(),
    );
  }

  Widget _buildProgressView(BuildContext context, CultivationSession session) {
    final progress = session.progress;
    final remaining = session.remainingMinutes;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.self_improvement,
              size: 80,
              color: AppColors.accent,
            ),
            const SizedBox(height: 24),
            Text(
              '${session.type.label}中...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.surface,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '剩余时间: ${CultivationCalculator.formatDuration(remaining)}',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('取消修炼'),
                    content: const Text('确定要取消修炼吗？已消耗的时间将不会获得任何奖励。'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('继续修炼'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('取消修炼'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true && context.mounted) {
                  final error = await ref
                      .read(cultivationNotifierProvider.notifier)
                      .cancelCultivation(session.id);

                  if (error != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
              ),
              child: const Text('取消修炼'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardView(BuildContext context, CultivationSession session) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.success,
            ),
            const SizedBox(height: 24),
            Text(
              '修炼完成！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '获得奖励:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (session.rewardExp > 0)
                    _buildRewardRow(
                      Icons.trending_up,
                      '经验',
                      '+${session.rewardExp}',
                      AppColors.exp,
                    ),
                  if (session.rewardSilver > 0)
                    _buildRewardRow(
                      Icons.monetization_on,
                      '银两',
                      '+${session.rewardSilver}',
                      AppColors.warning,
                    ),
                  if (session.rewardItems.isNotEmpty)
                    ...session.rewardItems.entries.map((e) {
                      return _buildRewardRow(
                        Icons.inventory_2,
                        '${e.key}',
                        'x${e.value}',
                        AppColors.mp,
                      );
                    }),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final error = await ref
                    .read(cultivationNotifierProvider.notifier)
                    .collectReward(session.id);

                if (!context.mounted) return;

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  GameAudio.success();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已收取修炼奖励')),
                  );
                }
              },
              child: const Text('收取奖励'),
            ),
          ],
        ),
      ),
    );
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
          Text('$label: ', style: const TextStyle(fontSize: 14)),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/game_constants.dart';
import '../../core/utils/character_growth.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';
import '../inventory/inventory_provider.dart';

class CharacterDetailPage extends ConsumerWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final c = character;
    final tier = RealmTier.values[c.realmTierIndex];
    final stage = RealmStage.values[c.realmStageIndex];
    final hpMax = totalMaxHp(c);
    final mpMax = totalMaxMp(c);
    final staminaMax = totalMaxStamina(c);

    return Scaffold(
      appBar: AppBar(title: Text(c.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 境界信息
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    c.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${tier.label}${stage.label}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.textAccent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '等级: Lv.${c.level}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Builder(
                    builder: (_) {
                      final isMaxRealm =
                          tier == RealmTier.huaJing && stage == RealmStage.peak;
                      if (isMaxRealm) {
                        return Text(
                          '经验: ${c.exp}（已达最高境界）',
                          style: theme.textTheme.bodyMedium,
                        );
                      }
                      final required =
                          tier.rank * stage.rank * GameConstants.realmExpBase;
                      return Text(
                        '经验: ${c.exp} / $required',
                        style: theme.textTheme.bodyMedium,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 属性面板
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('属性', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  _buildStatBar('气血', c.currentHp, hpMax, AppColors.hp),
                  const SizedBox(height: 8),
                  _buildStatBar('内力', c.currentMp, mpMax, AppColors.mp),
                  const SizedBox(height: 8),
                  _buildStatBar('体力', c.stamina, staminaMax, AppColors.warning),
                  const Divider(height: 24),
                  _buildStatRow('攻击', c.baseAtk),
                  _buildStatRow('防御', c.baseDef),
                  _buildStatRow('速度', c.baseSpeed),
                  _buildStatRow('运气', c.baseLuck),
                  _buildStatRow('悟性', c.baseComprehension),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 资源
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('资源', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  _buildStatRow('银两', c.silver),
                  _buildStatRow('声望', c.reputation),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int current, int max, Color color) {
    final ratio = max > 0 ? current / max : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary)),
            Text(
              '$current/$max',
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            backgroundColor: AppColors.surfaceLight,
            color: color,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(
            '$value',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

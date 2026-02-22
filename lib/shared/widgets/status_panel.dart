import 'package:flutter/material.dart';

import '../../core/utils/character_growth.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';
import '../../features/inventory/inventory_provider.dart';

/// 顶部角色状态条
class StatusPanel extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const StatusPanel({super.key, required this.character, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = character;
    final tier = RealmTier.values[c.realmTierIndex];
    final stage = RealmStage.values[c.realmStageIndex];
    final hpMax = totalMaxHp(c);
    final mpMax = totalMaxMp(c);
    final staminaMax = totalMaxStamina(c);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryLight.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            // 角色名和境界
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        c.name,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${tier.label}${stage.label} · Lv.${c.level}',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // HP/MP/体力 条
                  Row(
                    children: [
                      _MiniBar(
                        label: '气血',
                        current: c.currentHp,
                        max: hpMax,
                        color: AppColors.hp,
                      ),
                      const SizedBox(width: 12),
                      _MiniBar(
                        label: '内力',
                        current: c.currentMp,
                        max: mpMax,
                        color: AppColors.mp,
                      ),
                      const SizedBox(width: 12),
                      _MiniBar(
                        label: '体力',
                        current: c.stamina,
                        max: staminaMax,
                        color: AppColors.warning,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 银两
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${c.silver} 两',
                  style: TextStyle(color: AppColors.accent, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  '声望 ${c.reputation}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final String label;
  final int current;
  final int max;
  final Color color;

  const _MiniBar({
    required this.label,
    required this.current,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = max > 0 ? current / max : 0.0;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$current/$max',
                style: TextStyle(color: color, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: AppColors.progressTrack,
              color: color,
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

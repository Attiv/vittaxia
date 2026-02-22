import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import 'idle_calculator.dart';

/// 离线收益弹窗
class IdleRewardDialog extends StatelessWidget {
  final IdleReward reward;

  const IdleRewardDialog({super.key, required this.reward});

  static Future<void> show(BuildContext context, IdleReward reward) {
    if (!reward.hasAny) return Future.value();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => IdleRewardDialog(reward: reward),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        '离线收益',
        style: TextStyle(color: AppColors.accent),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '你离开了 ${IdleCalculator.formatDuration(reward.minutesIdle)}',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          if (reward.wasCapped)
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '(已达离线上限12小时)',
                style: TextStyle(color: AppColors.warning, fontSize: 12),
              ),
            ),
          const SizedBox(height: 14),
          if (reward.exp > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('修炼经验 ', style: TextStyle(color: AppColors.textPrimary)),
                Text(
                  '+${reward.exp}',
                  style: TextStyle(
                    color: AppColors.exp,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (reward.silver > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '银两 +${reward.silver}',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (reward.items.isNotEmpty) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '补给收获',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            ...reward.items.entries.map((entry) {
              final itemName = items[entry.key]?.name ?? entry.key;
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '• $itemName x${entry.value}',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
                ),
              );
            }),
          ],
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('收取'),
          ),
        ),
      ],
    );
  }
}

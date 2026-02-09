import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'idle_calculator.dart';

/// 离线收益弹窗
class IdleRewardDialog extends StatelessWidget {
  final IdleReward reward;

  const IdleRewardDialog({super.key, required this.reward});

  static Future<void> show(BuildContext context, IdleReward reward) {
    if (reward.exp <= 0) return Future.value();
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
      title: const Text(
        '离线收益',
        style: TextStyle(color: AppColors.accent),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '你离开了 ${IdleCalculator.formatDuration(reward.minutesIdle)}',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          if (reward.wasCapped)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '(已达离线上限12小时)',
                style: TextStyle(color: AppColors.warning, fontSize: 12),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('修炼经验 ', style: TextStyle(color: AppColors.textPrimary)),
              Text(
                '+${reward.exp}',
                style: const TextStyle(
                  color: AppColors.exp,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class HpBarWidget extends StatelessWidget {
  final int currentHp;
  final int maxHp;
  final int currentMp;
  final int maxMp;
  final bool isPlayer;

  const HpBarWidget({
    super.key,
    required this.currentHp,
    required this.maxHp,
    required this.currentMp,
    required this.maxMp,
    this.isPlayer = true,
  });

  @override
  Widget build(BuildContext context) {
    final double hpRatio = maxHp > 0 ? (currentHp / maxHp).clamp(0.0, 1.0) : 0.0;
    final double mpRatio = maxMp > 0 ? (currentMp / maxMp).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: isPlayer ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        _buildBar(
          context: context,
          ratio: hpRatio,
          color: AppColors.hp,
          backgroundColor: AppColors.progressTrack,
          height: 10.0,
        ),
        const SizedBox(height: 4),
        _buildBar(
          context: context,
          ratio: mpRatio,
          color: AppColors.mp,
          backgroundColor: AppColors.progressTrack,
          height: 6.0,
        ),
      ],
    );
  }

  Widget _buildBar({
    required BuildContext context,
    required double ratio,
    required Color color,
    required Color backgroundColor,
    required double height,
  }) {
    return Container(
      width: 120, // 固定宽度或使用 Expanded
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
        border: Border.all(color: Colors.black38, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: ratio, end: ratio),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return FractionallySizedBox(
              alignment: isPlayer ? Alignment.centerLeft : Alignment.centerRight,
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

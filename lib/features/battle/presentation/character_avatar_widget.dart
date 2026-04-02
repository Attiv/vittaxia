import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class CharacterAvatarWidget extends StatelessWidget {
  final String name;
  final bool isPlayer;
  final bool isDead;

  const CharacterAvatarWidget({
    super.key,
    required this.name,
    this.isPlayer = true,
    this.isDead = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isDead ? 0.3 : 1.0,
      child: Transform.scale(
        scale: isDead ? 0.9 : 1.0,
        child: Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: isPlayer ? AppColors.primaryDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPlayer ? AppColors.primary : AppColors.danger,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isPlayer ? AppColors.primary : AppColors.danger).withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Center(
            child: RotatedBox(
              quarterTurns: isDead ? 1 : 0,
              child: Text(
                name.length > 2 ? name.substring(0, 2) : name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

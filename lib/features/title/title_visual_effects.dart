import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/arena.dart';

/// 称号视觉效果配置
class TitleVisualEffect {
  final String titleId;
  final Color primaryColor;
  final Color secondaryColor;
  final Color glowColor;
  final IconData? icon;
  final bool hasAnimation;
  final List<Color>? gradientColors;

  const TitleVisualEffect({
    required this.titleId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.glowColor,
    this.icon,
    this.hasAnimation = false,
    this.gradientColors,
  });
}

/// 称号视觉效果数据
final titleVisualEffects = <String, TitleVisualEffect>{
  'novice': const TitleVisualEffect(
    titleId: 'novice',
    primaryColor: Color(0xFF9E9E9E),
    secondaryColor: Color(0xFF757575),
    glowColor: Color(0xFFBDBDBD),
    icon: Icons.star_border,
  ),
  'warrior': const TitleVisualEffect(
    titleId: 'warrior',
    primaryColor: Color(0xFF4CAF50),
    secondaryColor: Color(0xFF388E3C),
    glowColor: Color(0xFF81C784),
    icon: Icons.shield,
    hasAnimation: true,
  ),
  'master': const TitleVisualEffect(
    titleId: 'master',
    primaryColor: Color(0xFF2196F3),
    secondaryColor: Color(0xFF1976D2),
    glowColor: Color(0xFF64B5F6),
    icon: Icons.school,
    hasAnimation: true,
    gradientColors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
  ),
  'grandmaster': const TitleVisualEffect(
    titleId: 'grandmaster',
    primaryColor: Color(0xFF9C27B0),
    secondaryColor: Color(0xFF7B1FA2),
    glowColor: Color(0xFFBA68C8),
    icon: Icons.auto_awesome,
    hasAnimation: true,
    gradientColors: [Color(0xFF9C27B0), Color(0xFFBA68C8), Color(0xFFE1BEE7)],
  ),
  'legend': const TitleVisualEffect(
    titleId: 'legend',
    primaryColor: Color(0xFFFF9800),
    secondaryColor: Color(0xFFF57C00),
    glowColor: Color(0xFFFFB74D),
    icon: Icons.emoji_events,
    hasAnimation: true,
    gradientColors: [Color(0xFFFF9800), Color(0xFFFFB74D), Color(0xFFFFE0B2)],
  ),
  'immortal': const TitleVisualEffect(
    titleId: 'immortal',
    primaryColor: Color(0xFFFF5722),
    secondaryColor: Color(0xFFE64A19),
    glowColor: Color(0xFFFF8A65),
    icon: Icons.whatshot,
    hasAnimation: true,
    gradientColors: [
      Color(0xFFFF5722),
      Color(0xFFFF9800),
      Color(0xFFFFEB3B),
    ],
  ),
  'wealthy': const TitleVisualEffect(
    titleId: 'wealthy',
    primaryColor: Color(0xFFFFD700),
    secondaryColor: Color(0xFFFFA500),
    glowColor: Color(0xFFFFE55C),
    icon: Icons.monetization_on,
    hasAnimation: true,
    gradientColors: [Color(0xFFFFD700), Color(0xFFFFE55C)],
  ),
  'scholar': const TitleVisualEffect(
    titleId: 'scholar',
    primaryColor: Color(0xFF00BCD4),
    secondaryColor: Color(0xFF0097A7),
    glowColor: Color(0xFF4DD0E1),
    icon: Icons.menu_book,
  ),
  'explorer': const TitleVisualEffect(
    titleId: 'explorer',
    primaryColor: Color(0xFF8BC34A),
    secondaryColor: Color(0xFF689F38),
    glowColor: Color(0xFFAED581),
    icon: Icons.explore,
  ),
  'collector': const TitleVisualEffect(
    titleId: 'collector',
    primaryColor: Color(0xFF795548),
    secondaryColor: Color(0xFF5D4037),
    glowColor: Color(0xFFA1887F),
    icon: Icons.inventory,
  ),
  'socialite': const TitleVisualEffect(
    titleId: 'socialite',
    primaryColor: Color(0xFFE91E63),
    secondaryColor: Color(0xFFC2185B),
    glowColor: Color(0xFFF06292),
    icon: Icons.favorite,
    hasAnimation: true,
  ),
};

/// 称号显示组件
class TitleDisplay extends StatelessWidget {
  final CharacterTitle title;
  final double fontSize;
  final bool showIcon;
  final bool showGlow;

  const TitleDisplay({
    super.key,
    required this.title,
    this.fontSize = 12,
    this.showIcon = true,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final effect = titleVisualEffects[title.id];
    if (effect == null) {
      return Text(
        title.name,
        style: TextStyle(fontSize: fontSize),
      );
    }

    Widget titleWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon && effect.icon != null) ...[
          Icon(
            effect.icon,
            size: fontSize * 1.2,
            color: effect.primaryColor,
          ),
          SizedBox(width: fontSize * 0.3),
        ],
        if (effect.gradientColors != null)
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: effect.gradientColors!,
            ).createShader(bounds),
            child: Text(
              title.name,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        else
          Text(
            title.name,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: effect.primaryColor,
            ),
          ),
      ],
    );

    if (showGlow && effect.hasAnimation) {
      return TitleGlowAnimation(
        glowColor: effect.glowColor,
        child: titleWidget,
      );
    }

    return titleWidget;
  }
}

/// 称号发光动画
class TitleGlowAnimation extends StatefulWidget {
  final Widget child;
  final Color glowColor;

  const TitleGlowAnimation({
    super.key,
    required this.child,
    required this.glowColor,
  });

  @override
  State<TitleGlowAnimation> createState() => _TitleGlowAnimationState();
}

class _TitleGlowAnimationState extends State<TitleGlowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withValues(alpha: 0.4 * _animation.value),
                blurRadius: 8 * _animation.value,
                spreadRadius: 2 * _animation.value,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// 称号徽章组件
class TitleBadge extends StatelessWidget {
  final CharacterTitle title;
  final VoidCallback? onTap;
  final bool isActive;

  const TitleBadge({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final effect = titleVisualEffects[title.id];
    if (effect == null) {
      return _buildDefaultBadge(context);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: effect.gradientColors != null
              ? LinearGradient(colors: effect.gradientColors!)
              : null,
          color: effect.gradientColors == null
              ? effect.primaryColor.withValues(alpha: isActive ? 0.3 : 0.15)
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? effect.primaryColor : effect.secondaryColor,
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: effect.glowColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (effect.icon != null) ...[
              Icon(
                effect.icon,
                size: 16,
                color: effect.gradientColors != null
                    ? Colors.white
                    : effect.primaryColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              title.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: effect.gradientColors != null
                    ? Colors.white
                    : effect.primaryColor,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.check_circle,
                size: 14,
                color: effect.gradientColors != null
                    ? Colors.white
                    : effect.primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Text(
        title.name,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

/// 角色名字带称号显示
class CharacterNameWithTitle extends StatelessWidget {
  final String characterName;
  final CharacterTitle? activeTitle;
  final double nameSize;
  final double titleSize;

  const CharacterNameWithTitle({
    super.key,
    required this.characterName,
    this.activeTitle,
    this.nameSize = 18,
    this.titleSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (activeTitle != null) ...[
          TitleDisplay(
            title: activeTitle!,
            fontSize: titleSize,
            showIcon: true,
            showGlow: true,
          ),
          SizedBox(width: nameSize * 0.3),
        ],
        Text(
          characterName,
          style: TextStyle(
            fontSize: nameSize,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}

/// 称号获得动画
class TitleUnlockAnimation extends StatefulWidget {
  final CharacterTitle title;
  final VoidCallback? onComplete;

  const TitleUnlockAnimation({
    super.key,
    required this.title,
    this.onComplete,
  });

  @override
  State<TitleUnlockAnimation> createState() => _TitleUnlockAnimationState();
}

class _TitleUnlockAnimationState extends State<TitleUnlockAnimation>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
    _rotateController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onComplete?.call();
      });
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effect = titleVisualEffects[widget.title.id];

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleController, _rotateController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value * 0.5,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: effect?.gradientColors != null
                    ? LinearGradient(colors: effect!.gradientColors!)
                    : null,
                color: effect?.gradientColors == null
                    ? (effect?.primaryColor ?? AppColors.accent)
                        .withValues(alpha: 0.2)
                    : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (effect?.glowColor ?? AppColors.accent)
                        .withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (effect?.icon != null)
                    Icon(
                      effect!.icon,
                      size: 64,
                      color: effect.gradientColors != null
                          ? Colors.white
                          : effect.primaryColor,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    '获得称号',
                    style: TextStyle(
                      fontSize: 16,
                      color: effect?.gradientColors != null
                          ? Colors.white.withValues(alpha: 0.8)
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: effect?.gradientColors != null
                          ? Colors.white
                          : (effect?.primaryColor ?? AppColors.accent),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: effect?.gradientColors != null
                          ? Colors.white.withValues(alpha: 0.9)
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 称号属性加成显示
class TitleBonusDisplay extends StatelessWidget {
  final CharacterTitle title;

  const TitleBonusDisplay({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bonuses = <Widget>[];

    if (title.atkBonus > 0) {
      bonuses.add(_buildBonusChip('攻击', '+${title.atkBonus}', AppColors.danger));
    }
    if (title.defBonus > 0) {
      bonuses.add(_buildBonusChip('防御', '+${title.defBonus}', AppColors.mp));
    }
    if (title.hpBonus > 0) {
      bonuses.add(_buildBonusChip('生命', '+${title.hpBonus}', AppColors.hp));
    }
    if (title.speedBonus > 0) {
      bonuses.add(_buildBonusChip('速度', '+${title.speedBonus}', AppColors.exp));
    }
    if (title.luckBonus > 0) {
      bonuses.add(_buildBonusChip('运气', '+${title.luckBonus}', AppColors.warning));
    }

    if (bonuses.isEmpty) {
      return Text(
        '无属性加成',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: bonuses,
    );
  }

  Widget _buildBonusChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

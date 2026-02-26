import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// 装备套装视觉效果配置
class EquipmentSetVisualEffect {
  final String setId;
  final Color primaryColor;
  final Color secondaryColor;
  final Color glowColor;
  final String attackEffect;
  final List<Color> particleColors;
  final IconData? specialIcon;

  const EquipmentSetVisualEffect({
    required this.setId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.glowColor,
    required this.attackEffect,
    required this.particleColors,
    this.specialIcon,
  });
}

/// 套装视觉效果数据
final setVisualEffects = <String, EquipmentSetVisualEffect>{
  'iron_warrior': const EquipmentSetVisualEffect(
    setId: 'iron_warrior',
    primaryColor: Color(0xFF8B8B8B),
    secondaryColor: Color(0xFF5A5A5A),
    glowColor: Color(0xFFB0B0B0),
    attackEffect: '铁甲冲击',
    particleColors: [Color(0xFF8B8B8B), Color(0xFFB0B0B0)],
    specialIcon: Icons.shield,
  ),
  'wind_shadow': const EquipmentSetVisualEffect(
    setId: 'wind_shadow',
    primaryColor: Color(0xFF00CED1),
    secondaryColor: Color(0xFF87CEEB),
    glowColor: Color(0xFF00FFFF),
    attackEffect: '疾风斩',
    particleColors: [Color(0xFF00CED1), Color(0xFF87CEEB), Color(0xFFAFEEEE)],
    specialIcon: Icons.air,
  ),
  'cold_moon': const EquipmentSetVisualEffect(
    setId: 'cold_moon',
    primaryColor: Color(0xFF4169E1),
    secondaryColor: Color(0xFF191970),
    glowColor: Color(0xFF6495ED),
    attackEffect: '寒月斩',
    particleColors: [Color(0xFF4169E1), Color(0xFF6495ED), Color(0xFFB0C4DE)],
    specialIcon: Icons.ac_unit,
  ),
  'steel_frontier': const EquipmentSetVisualEffect(
    setId: 'steel_frontier',
    primaryColor: Color(0xFF607D8B),
    secondaryColor: Color(0xFF455A64),
    glowColor: Color(0xFF90A4AE),
    attackEffect: '钢锋突进',
    particleColors: [Color(0xFF607D8B), Color(0xFF90A4AE)],
    specialIcon: Icons.gavel,
  ),
  'night_veil': const EquipmentSetVisualEffect(
    setId: 'night_veil',
    primaryColor: Color(0xFF4A148C),
    secondaryColor: Color(0xFF1A237E),
    glowColor: Color(0xFF7E57C2),
    attackEffect: '夜幕绝袭',
    particleColors: [Color(0xFF4A148C), Color(0xFF7E57C2), Color(0xFF1A237E)],
    specialIcon: Icons.nights_stay,
  ),
  'heaven_pulse': const EquipmentSetVisualEffect(
    setId: 'heaven_pulse',
    primaryColor: Color(0xFFFFA000),
    secondaryColor: Color(0xFFF57C00),
    glowColor: Color(0xFFFFD54F),
    attackEffect: '天脉共鸣',
    particleColors: [Color(0xFFFFA000), Color(0xFFFFD54F), Color(0xFFF57C00)],
    specialIcon: Icons.bolt,
  ),
};

/// 装备发光效果组件
class EquipmentGlowEffect extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double intensity;
  final bool enabled;

  const EquipmentGlowEffect({
    super.key,
    required this.child,
    required this.glowColor,
    this.intensity = 1.0,
    this.enabled = true,
  });

  @override
  State<EquipmentGlowEffect> createState() => _EquipmentGlowEffectState();
}

class _EquipmentGlowEffectState extends State<EquipmentGlowEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withValues(
                  alpha: 0.3 * _animation.value * widget.intensity,
                ),
                blurRadius: 12 * _animation.value * widget.intensity,
                spreadRadius: 3 * _animation.value * widget.intensity,
              ),
              BoxShadow(
                color: widget.glowColor.withValues(
                  alpha: 0.2 * _animation.value * widget.intensity,
                ),
                blurRadius: 20 * _animation.value * widget.intensity,
                spreadRadius: 5 * _animation.value * widget.intensity,
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

/// 套装名称带颜色显示
class SetNameText extends StatelessWidget {
  final String setName;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const SetNameText({
    super.key,
    required this.setName,
    required this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color, color.withValues(alpha: 0.7), color],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        setName,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// 攻击特效动画
class AttackEffectAnimation extends StatefulWidget {
  final String effectName;
  final List<Color> colors;
  final VoidCallback? onComplete;

  const AttackEffectAnimation({
    super.key,
    required this.effectName,
    required this.colors,
    this.onComplete,
  });

  @override
  State<AttackEffectAnimation> createState() => _AttackEffectAnimationState();
}

class _AttackEffectAnimationState extends State<AttackEffectAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: widget.colors.first.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Text(
                widget.effectName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 套装激活粒子效果
class SetActivationParticles extends StatefulWidget {
  final List<Color> colors;
  final int particleCount;

  const SetActivationParticles({
    super.key,
    required this.colors,
    this.particleCount = 20,
  });

  @override
  State<SetActivationParticles> createState() => _SetActivationParticlesState();
}

class _SetActivationParticlesState extends State<SetActivationParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            progress: _controller.value,
            colors: widget.colors,
            particleCount: widget.particleCount,
          ),
          size: const Size(200, 200),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final List<Color> colors;
  final int particleCount;

  _ParticlePainter({
    required this.progress,
    required this.colors,
    required this.particleCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (var i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * 3.14159;
      final distance = maxRadius * progress;
      final x = center.dx + distance * math.cos(angle);
      final y = center.dy + distance * math.sin(angle);

      final paint = Paint()
        ..color = colors[i % colors.length].withValues(alpha: 1.0 - progress)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 4 * (1 - progress), paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// 装备品质颜色
class EquipmentQualityColor {
  static Color getColor(int quality) {
    switch (quality) {
      case 1:
        return const Color(0xFF9E9E9E); // 灰色 - 普通
      case 2:
        return const Color(0xFF4CAF50); // 绿色 - 优秀
      case 3:
        return const Color(0xFF2196F3); // 蓝色 - 精良
      case 4:
        return const Color(0xFF9C27B0); // 紫色 - 史诗
      case 5:
        return const Color(0xFFFF9800); // 橙色 - 传说
      default:
        return AppColors.textSecondary;
    }
  }

  static String getLabel(int quality) {
    switch (quality) {
      case 1:
        return '普通';
      case 2:
        return '优秀';
      case 3:
        return '精良';
      case 4:
        return '史诗';
      case 5:
        return '传说';
      default:
        return '未知';
    }
  }
}

/// 装备强化等级显示
class EnhancementLevelBadge extends StatelessWidget {
  final int level;
  final double size;

  const EnhancementLevelBadge({super.key, required this.level, this.size = 20});

  @override
  Widget build(BuildContext context) {
    if (level <= 0) return const SizedBox.shrink();

    Color color;
    if (level >= 10) {
      color = const Color(0xFFFF9800); // 橙色
    } else if (level >= 7) {
      color = const Color(0xFF9C27B0); // 紫色
    } else if (level >= 4) {
      color = const Color(0xFF2196F3); // 蓝色
    } else {
      color = const Color(0xFF4CAF50); // 绿色
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.4,
        vertical: size * 0.2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(size * 0.3),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        '+$level',
        style: TextStyle(
          fontSize: size * 0.6,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

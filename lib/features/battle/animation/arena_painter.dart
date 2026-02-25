import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/battle_speed_settings.dart';
import 'battle_fx.dart';
import 'battle_types.dart';
import 'particle_system.dart';
import 'pose.dart';
import 'timing.dart';

class ArenaPainter extends CustomPainter {
  final BattleAnimationStyle style;
  final double playerX;
  final double enemyX;
  final Pose playerPose;
  final Pose enemyPose;
  final bool playerDown;
  final bool enemyDown;
  final BattleActionType? playerIdleWeaponType;
  final BattleActionType? weaponType;
  final bool weaponOnPlayer;
  final bool attackerIsPlayer;

  final double impactT;
  final double trailT;
  final Color trailColor;
  final double auraT;
  final bool auraOnPlayer;
  final Color auraColor;

  final bool showProjectile;
  final double projX;
  final double projY;
  final Color projColor;

  final double textT;
  final double tagT;
  final bool isCrit;
  final bool isDodged;
  final int damageValue;
  final int healValue;

  final ParticleEmitter? particleEmitter;
  final double flashAlpha;
  final MotionBlurTrail motionBlur;
  final SlashTrail slashTrail;
  final double currentTime;

  bool get _isMinimalStyle => style == BattleAnimationStyle.minimal;
  bool get _isEnergeticStyle => style == BattleAnimationStyle.energetic;
  bool get _isJianghuStyle => style == BattleAnimationStyle.jianghu;
  double get _fxScale => styleFxScale(style);

  ArenaPainter({
    required this.style,
    required this.playerX,
    required this.enemyX,
    required this.playerPose,
    required this.enemyPose,
    required this.playerDown,
    required this.enemyDown,
    required this.playerIdleWeaponType,
    required this.weaponType,
    required this.weaponOnPlayer,
    required this.attackerIsPlayer,
    required this.impactT,
    required this.trailT,
    required this.trailColor,
    required this.auraT,
    required this.auraOnPlayer,
    required this.auraColor,
    required this.showProjectile,
    required this.projX,
    required this.projY,
    required this.projColor,
    required this.textT,
    required this.tagT,
    required this.isCrit,
    required this.isDodged,
    required this.damageValue,
    required this.healValue,
    this.particleEmitter,
    this.flashAlpha = 0,
    required this.motionBlur,
    required this.slashTrail,
    required this.currentTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackdrop(canvas, size);
    _drawGround(canvas, size);

    if (trailT > 0 && (!_isMinimalStyle || trailT > 0.2)) {
      _drawFlowLines(canvas, size, trailT, attackerIsPlayer, trailColor);
    }

    if (auraT > 0) {
      final x = (auraOnPlayer ? playerX : enemyX) * size.width;
      final y = size.height * 0.72;
      _drawAura(canvas, Offset(x, y), auraT, auraColor);
    }

    final playerWeapon = weaponOnPlayer ? weaponType : playerIdleWeaponType;
    final enemyWeapon = weaponOnPlayer ? null : weaponType;

    final playerEffect = attackerIsPlayer
        ? math.max<double>(trailT, impactT < 0 ? 0 : 1 - impactT) * _fxScale
        : 0.0;
    final enemyEffect = attackerIsPlayer
        ? 0.0
        : math.max<double>(trailT, impactT < 0 ? 0 : 1 - impactT) * _fxScale;

    // 运动模糊（在角色之前绘制）
    if (motionBlur.hasTrail && trailT > 0.1) {
      _drawMotionBlur(canvas, size, motionBlur, trailColor);
    }

    if (playerDown) {
      _drawDownFighter(canvas, size, playerX, true, const Color(0xFFEAF6FF), playerWeapon);
    } else {
      _drawFighter(canvas, size, playerX, playerPose, true, const Color(0xFFEAF6FF), playerWeapon, playerEffect);
    }

    if (enemyDown) {
      _drawDownFighter(canvas, size, enemyX, false, const Color(0xFFFFF1E7), enemyWeapon);
    } else {
      _drawFighter(canvas, size, enemyX, enemyPose, false, const Color(0xFFFFF1E7), enemyWeapon, enemyEffect);
    }

    if (showProjectile) _drawProjectile(canvas, size);

    if (impactT >= 0 && !isDodged) {
      final defX = attackerIsPlayer ? enemyX : playerX;
      _drawImpact(canvas, size, Offset(defX * size.width, size.height * 0.54), impactT);
    }

    // 斩击轨迹
    if (slashTrail.isActive) {
      final progress = slashTrail.progress(currentTime);
      if (progress > 0) {
        _drawSlashTrail(canvas, size, slashTrail, progress);
      }
    }

    // 粒子
    if (particleEmitter != null && !particleEmitter!.isEmpty) {
      canvas.save();
      canvas.scale(size.width, size.height);
      particleEmitter!.paint(canvas);
      canvas.restore();
    }

    // 伤害/治疗数字
    if (textT >= 0) {
      final isSupport =
          weaponType == BattleActionType.heal || weaponType == BattleActionType.buff;
      if (isSupport && healValue > 0) {
        final x = attackerIsPlayer ? playerX : enemyX;
        _drawFloatNumber(canvas, size, '+$healValue', x, const Color(0xFF73E6A8), textT, false);
      } else if (!isSupport && damageValue > 0 && !isDodged) {
        final x = attackerIsPlayer ? enemyX : playerX;
        _drawFloatNumber(canvas, size, '-$damageValue', x, const Color(0xFFFF7E7E), textT, isCrit);
      }
    }

    if (isCrit && !isDodged && tagT >= 0) {
      final x = attackerIsPlayer ? enemyX : playerX;
      _drawBadge(canvas, size, '暴击', x, tagT, const Color(0xFFFFB27A));
    }

    if (isDodged && tagT >= 0) {
      final x = attackerIsPlayer ? enemyX : playerX;
      _drawBadge(canvas, size, '闪避', x, tagT, const Color(0xFF8ED6FF));
    }

    // 闪白效果（最顶层）
    if (flashAlpha > 0) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white.withValues(alpha: flashAlpha),
      );
    }
  }

  // ── 背景 ──

  void _drawBackdrop(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final colors = switch (style) {
      BattleAnimationStyle.jianghu => const [Color(0xFF1D1813), Color(0xFF12100E)],
      BattleAnimationStyle.cinematic => const [Color(0xFF131B24), Color(0xFF0B0F14)],
      BattleAnimationStyle.swift => const [Color(0xFF151D22), Color(0xFF0E1318)],
      BattleAnimationStyle.minimal => const [Color(0xFF171A1F), Color(0xFF12151A)],
      BattleAnimationStyle.energetic => const [Color(0xFF1A1F28), Color(0xFF10131A)],
      BattleAnimationStyle.classic => const [Color(0xFF141B22), Color(0xFF0E1116)],
    };
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: colors,
        ).createShader(rect),
    );

    final bloomAlpha = _isJianghuStyle ? 0.02 : (_isMinimalStyle ? 0.03 : (_isEnergeticStyle ? 0.08 : 0.06));
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.24), size.width * 0.50,
      Paint()..color = const Color(0xFF9BC8FF).withValues(alpha: bloomAlpha),
    );
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.30), size.width * 0.32,
      Paint()..color = const Color(0xFFFFE7C2).withValues(alpha: _isMinimalStyle ? 0.02 : 0.04),
    );
  }

  void _drawGround(Canvas canvas, Size size) {
    final gy = size.height * 0.88;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width * 0.5, gy + 2), width: size.width * 0.90, height: size.height * 0.20),
      Paint()..color = const Color(0xFF000000).withValues(alpha: 0.30),
    );
    canvas.drawLine(
      Offset(size.width * 0.08, gy), Offset(size.width * 0.92, gy),
      Paint()..color = const Color(0xFF7089A3).withValues(alpha: 0.36)..strokeWidth = 1.4,
    );
  }

  void _drawFlowLines(Canvas canvas, Size size, double t, bool fromLeft, Color color) {
    if (_isJianghuStyle) return;
    final progress = t.clamp(0.0, 1.0);
    final alphaBase = _isMinimalStyle ? 0.08 : (_isEnergeticStyle ? 0.22 : 0.16);
    final alpha = (0.04 + alphaBase * (1 - (progress - 0.5).abs() * 2)).clamp(0.0, _isEnergeticStyle ? 0.26 : 0.2);
    final paint = Paint()..strokeCap = StrokeCap.round..strokeWidth = 1.4;

    final lineCount = _isMinimalStyle ? 6 : (_isEnergeticStyle ? 12 : 10);
    for (var i = 0; i < lineCount; i++) {
      final y = size.height * (0.20 + i * 0.055);
      final len = size.width * (0.08 + (i % 3) * 0.02);
      final baseX = fromLeft ? size.width * (0.04 + i * 0.012) : size.width * (0.96 - i * 0.012);
      final endX = fromLeft ? baseX + len : baseX - len;
      paint.color = color.withValues(alpha: alpha * (0.6 + (i % 4) * 0.1));
      canvas.drawLine(Offset(baseX, y), Offset(endX, y + len * 0.08), paint);
    }
  }

  void _drawAura(Canvas canvas, Offset center, double t, Color color) {
    final pulse = (0.85 + 0.18 * math.sin(t * math.pi * 3.5)).clamp(0.7, 1.2);
    final rings = _isMinimalStyle ? 2 : (_isEnergeticStyle ? 4 : 3);
    for (var i = 0; i < rings; i++) {
      final radius = (20 + i * 13) * pulse;
      final alpha = (0.24 - i * 0.05) * t * (_isEnergeticStyle ? 1.15 : 1.0);
      canvas.drawCircle(
        center, radius,
        Paint()..style = PaintingStyle.stroke..strokeWidth = (2.0 - i * 0.3).clamp(1.0, 2.2)
          ..color = color.withValues(alpha: alpha.clamp(0.0, 1.0)),
      );
    }
    canvas.drawCircle(
      center, 12 * pulse,
      Paint()..color = color.withValues(alpha: (_isMinimalStyle ? 0.16 : 0.22) * t.clamp(0.0, 1.0)),
    );
  }

  // ── 角色绘制 ──

  void _drawFighter(
    Canvas canvas,
    Size size,
    double normX,
    Pose pose,
    bool facingRight,
    Color color,
    BattleActionType? weapon,
    double effectT,
  ) {
    final groundY = size.height * 0.88;
    final scale = size.height / (_isJianghuStyle ? 224 : 204);
    final cx = size.width * normX;

    canvas.save();
    canvas.translate(cx, groundY);
    if (!facingRight) {
      canvas.scale(-1, 1);
    }

    const torsoLen = 20.0;
    const neckLen = 2.0;
    const headR = 6.8;
    const upperArm = 10.0;
    const foreArm = 9.2;
    const thigh = 12.8;
    const shin = 11.2;
    const shoulderHalf = 5.4;

    Offset limb(Offset from, double d, double len) {
      final angle = d * deg;
      return Offset(
        from.dx + len * scale * math.sin(angle),
        from.dy + len * scale * math.cos(angle),
      );
    }

    Offset up(Offset from, double lean, double len) {
      final angle = lean * deg;
      return Offset(
        from.dx + len * scale * math.sin(angle),
        from.dy - len * scale * math.cos(angle),
      );
    }

    final hip = Offset(0, -(thigh + shin) * scale + pose.torsoLift * scale);
    final shoulder = up(hip, pose.bodyLean, torsoLen);
    final neck = up(shoulder, pose.bodyLean, neckLen);
    final head = up(neck, pose.bodyLean, headR);

    final lShoulder = Offset(
      shoulder.dx - shoulderHalf * scale * math.cos(pose.bodyLean * deg),
      shoulder.dy - shoulderHalf * scale * math.sin(pose.bodyLean * deg),
    );
    final rShoulder = Offset(
      shoulder.dx + shoulderHalf * scale * math.cos(pose.bodyLean * deg),
      shoulder.dy + shoulderHalf * scale * math.sin(pose.bodyLean * deg),
    );

    final lElbow = limb(lShoulder, pose.lShoulder, upperArm);
    final lHand = limb(lElbow, pose.lElbow, foreArm);
    final rElbow = limb(rShoulder, pose.rShoulder, upperArm);
    final rHand = limb(rElbow, pose.rElbow, foreArm);

    final lHip = Offset(hip.dx - 3 * scale, hip.dy);
    final rHip = Offset(hip.dx + 3 * scale, hip.dy);
    final lKnee = limb(lHip, pose.lHip, thigh);
    final lFoot = limb(lKnee, pose.lKnee, shin);
    final rKnee = limb(rHip, pose.rHip, thigh);
    final rFoot = limb(rKnee, pose.rKnee, shin);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, -0.6 * scale),
        width: 32 * scale,
        height: 6.4 * scale,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.22),
    );

    final lineColor = Color.lerp(color, Colors.white, 0.08)!.withValues(alpha: 0.95);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 2.5 * scale;
    final thinPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.9)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 2.1 * scale;

    void bone(Offset a, Offset b, Paint p) => canvas.drawLine(a, b, p);

    bone(hip, shoulder, linePaint);
    bone(lShoulder, rShoulder, thinPaint);
    bone(lShoulder, lElbow, thinPaint);
    bone(lElbow, lHand, thinPaint);
    bone(rShoulder, rElbow, thinPaint);
    bone(rElbow, rHand, thinPaint);
    bone(lHip, lKnee, thinPaint);
    bone(lKnee, lFoot, thinPaint);
    bone(rHip, rKnee, thinPaint);
    bone(rKnee, rFoot, thinPaint);

    final footPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.82)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6 * scale;
    canvas.drawLine(
      lFoot.translate(-1.2 * scale, 0.5 * scale),
      lFoot.translate(2.3 * scale, 0.5 * scale),
      footPaint,
    );
    canvas.drawLine(
      rFoot.translate(-1.2 * scale, 0.5 * scale),
      rFoot.translate(2.3 * scale, 0.5 * scale),
      footPaint,
    );

    canvas.drawCircle(
      head, (headR + 0.6) * scale,
      Paint()..color = Colors.black.withValues(alpha: 0.28),
    );
    canvas.drawCircle(head, headR * scale, Paint()..color = lineColor);
    final bun = head.translate(-1.5 * scale, -4.8 * scale);
    canvas.drawCircle(
      bun, 1.7 * scale,
      Paint()..color = const Color(0xFF1E1E1E).withValues(alpha: 0.9),
    );

    if (effectT > 0.12) {
      final swing = math.sin(effectT * math.pi) * 2.0 * (facingRight ? 1 : -1);
      final sashPaint = Paint()
        ..color = lineColor.withValues(alpha: 0.45)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.3 * scale;
      canvas.drawLine(
        hip.translate(-1.2 * scale, -1.0 * scale),
        hip.translate((-6.0 - swing) * scale, (-4.2 + swing * 0.2) * scale),
        sashPaint,
      );
    }

    final weaponGlow = effectT.clamp(0.0, 1.0);
    _drawWeapon(canvas, pose, rHand, rFoot, weapon, weaponGlow, scale);

    canvas.restore();
  }

  void _drawDownFighter(
    Canvas canvas,
    Size size,
    double normX,
    bool facingRight,
    Color color,
    BattleActionType? weapon,
  ) {
    final groundY = size.height * 0.88;
    final scale = size.height / (_isJianghuStyle ? 224 : 204);
    final cx = size.width * normX;

    canvas.save();
    canvas.translate(cx, groundY);
    if (!facingRight) {
      canvas.scale(-1, 1);
    }

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, -0.6 * scale),
        width: 32 * scale,
        height: 6.8 * scale,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.26),
    );

    final lineColor = Color.lerp(color, Colors.white, 0.08)!.withValues(alpha: 0.94);
    final linePaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 2.2 * scale;
    final thinPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.88)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 1.9 * scale;

    void segment(Offset a, Offset b, Paint p) {
      canvas.drawLine(a, b, p);
    }

    final head = Offset(-12.0 * scale, -6.4 * scale);
    final neck = Offset(-6.8 * scale, -7.8 * scale);
    final hip = Offset(5.8 * scale, -8.9 * scale);
    final lElbow = Offset(-1.2 * scale, -2.4 * scale);
    final lHand = Offset(7.6 * scale, 0.5 * scale);
    final rElbow = Offset(1.6 * scale, -3.1 * scale);
    final rHand = Offset(10.0 * scale, -1.0 * scale);
    final lKnee = Offset(12.0 * scale, -3.0 * scale);
    final lFoot = Offset(18.2 * scale, -0.8 * scale);
    final rKnee = Offset(4.6 * scale, -1.7 * scale);
    final rFoot = Offset(11.2 * scale, 1.0 * scale);

    segment(neck, hip, linePaint);
    segment(neck, lElbow, thinPaint);
    segment(lElbow, lHand, thinPaint);
    segment(neck, rElbow, thinPaint);
    segment(rElbow, rHand, thinPaint);
    segment(hip, lKnee, thinPaint);
    segment(lKnee, lFoot, thinPaint);
    segment(hip, rKnee, thinPaint);
    segment(rKnee, rFoot, thinPaint);

    canvas.drawLine(
      lFoot.translate(-1.0 * scale, 0.4 * scale),
      lFoot.translate(2.0 * scale, 0.4 * scale),
      Paint()
        ..color = lineColor.withValues(alpha: 0.82)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.4 * scale,
    );
    canvas.drawLine(
      rFoot.translate(-1.0 * scale, 0.4 * scale),
      rFoot.translate(2.0 * scale, 0.4 * scale),
      Paint()
        ..color = lineColor.withValues(alpha: 0.82)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.4 * scale,
    );

    canvas.drawCircle(
      head, 7.2 * scale,
      Paint()..color = Colors.black.withValues(alpha: 0.28),
    );
    canvas.drawCircle(head, 6.4 * scale, Paint()..color = lineColor);
    canvas.drawCircle(
      head.translate(-1.4 * scale, -4.6 * scale),
      1.6 * scale,
      Paint()..color = const Color(0xFF1B1B1B).withValues(alpha: 0.86),
    );

    if (weapon == BattleActionType.sword || weapon == BattleActionType.blade) {
      final wStart = lHand + Offset(4.2 * scale, 1.3 * scale);
      final wEnd = wStart + Offset(15 * scale, 2.0 * scale);
      canvas.drawLine(
        wStart, wEnd,
        Paint()
          ..color = const Color(0xFFEBF4FF).withValues(alpha: 0.85)
          ..strokeWidth = 2.6 * scale
          ..strokeCap = StrokeCap.round,
      );
    }

    canvas.restore();
  }

  void _drawWeapon(
    Canvas canvas,
    Pose pose,
    Offset hand,
    Offset foot,
    BattleActionType? weapon,
    double glow,
    double scale,
  ) {
    if (weapon == null) return;
    final fx = _fxScale;

    if (weapon == BattleActionType.sword || weapon == BattleActionType.blade) {
      final bladeColor = actionColor(weapon);
      final length = weapon == BattleActionType.sword ? 34.0 : 30.0;
      final angle = pose.rElbow + (weapon == BattleActionType.sword ? -8 : 12);
      final rad = angle * deg;
      final end = Offset(
        hand.dx + length * scale * math.sin(rad),
        hand.dy + length * scale * math.cos(rad),
      );

      if (glow > 0.05) {
        canvas.drawLine(
          hand, end,
          Paint()
            ..color = bladeColor.withValues(
              alpha: (0.16 + glow * 0.22 * fx).clamp(0.0, 0.55),
            )
            ..strokeWidth = (6.0 + glow * 4.5 * fx) * scale
            ..strokeCap = StrokeCap.round,
        );
      }

      final handle = Offset(
        hand.dx - 6 * scale * math.sin(rad),
        hand.dy - 6 * scale * math.cos(rad),
      );
      canvas.drawLine(
        hand, handle,
        Paint()
          ..color = const Color(0xFF6F5948)
          ..strokeWidth = 2.8 * scale
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        hand, end,
        Paint()
          ..color = const Color(0xFFEAF2FF)
          ..strokeWidth = 2.2 * scale
          ..strokeCap = StrokeCap.round,
      );
      return;
    }

    if (weapon == BattleActionType.palm || weapon == BattleActionType.fist) {
      final c = actionColor(weapon);
      final radius = weapon == BattleActionType.palm ? 10.0 : 8.0;
      canvas.drawCircle(
        hand, (radius + glow * 4 * fx) * scale,
        Paint()
          ..color = c.withValues(
            alpha: (0.20 + glow * 0.24 * fx).clamp(0.0, 0.56),
          ),
      );
      canvas.drawCircle(
        hand, (radius * 0.45) * scale,
        Paint()..color = c.withValues(alpha: 0.72),
      );
      return;
    }

    if (weapon == BattleActionType.kick) {
      final c = actionColor(weapon);
      canvas.drawCircle(
        foot, (8 + glow * 4 * fx) * scale,
        Paint()
          ..color = c.withValues(
            alpha: (0.20 + glow * 0.22 * fx).clamp(0.0, 0.50),
          ),
      );
      canvas.drawCircle(
        foot, 3.6 * scale,
        Paint()..color = c.withValues(alpha: 0.70),
      );
      return;
    }

    if (weapon == BattleActionType.hidden) {
      final c = actionColor(weapon);
      final dart = Path()
        ..moveTo(hand.dx + 2 * scale, hand.dy - 3 * scale)
        ..lineTo(hand.dx + 9 * scale, hand.dy)
        ..lineTo(hand.dx + 2 * scale, hand.dy + 3 * scale)
        ..lineTo(hand.dx, hand.dy)
        ..close();
      canvas.drawPath(dart, Paint()..color = c.withValues(alpha: 0.80));
    }
  }

  // ── 投射物 ──

  void _drawProjectile(Canvas canvas, Size size) {
    final px = projX * size.width;
    final py = projY * size.height;

    final trailCount = _isMinimalStyle ? 2 : (_isEnergeticStyle ? 5 : 4);
    for (var i = 0; i < trailCount; i++) {
      final alpha = (0.28 - i * 0.05).clamp(0.05, _isEnergeticStyle ? 0.34 : 0.30);
      canvas.drawCircle(
        Offset(px - i * 8.0, py + i * 1.2),
        (4.3 - i * 0.7).clamp(2.0, 6.0),
        Paint()..color = projColor.withValues(alpha: alpha),
      );
    }

    final head = Path()
      ..moveTo(px, py - 6)
      ..lineTo(px + 4.5, py)
      ..lineTo(px, py + 6)
      ..lineTo(px - 4.5, py)
      ..close();
    canvas.drawPath(head, Paint()..color = projColor.withValues(alpha: 0.88));
    canvas.drawPath(head, Paint()..color = Colors.white.withValues(alpha: 0.42));
  }

  // ── 冲击波 ──

  void _drawImpact(Canvas canvas, Size size, Offset center, double t) {
    final p = t.clamp(0.0, 1.0);
    final alpha = (1.0 - p).clamp(0.0, 1.0);
    final radius =
        (14 + 30 * p) *
        (_isJianghuStyle ? 0.92 : (_isEnergeticStyle ? 1.18 : (_isMinimalStyle ? 0.85 : 1.0)));

    canvas.drawCircle(
      center, radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _isMinimalStyle ? 1.6 : 2.0
        ..color = trailColor.withValues(alpha: alpha * (_isMinimalStyle ? 0.34 : 0.45)),
    );

    canvas.drawCircle(
      center, radius * 0.46,
      Paint()..color = Colors.white.withValues(alpha: alpha * (_isMinimalStyle ? 0.22 : 0.35)),
    );

    final spikeCount = _isJianghuStyle ? 10 : (_isMinimalStyle ? 4 : (_isEnergeticStyle ? 8 : 6));
    for (var i = 0; i < spikeCount; i++) {
      final angle = (i / spikeCount) * math.pi * 2 + p * 1.2;
      final start = Offset(
        center.dx + math.cos(angle) * radius * 0.32,
        center.dy + math.sin(angle) * radius * 0.32,
      );
      final end = Offset(
        center.dx + math.cos(angle) * radius * 1.05,
        center.dy + math.sin(angle) * radius * 1.05,
      );
      canvas.drawLine(
        start, end,
        Paint()
          ..color = trailColor.withValues(alpha: alpha * (_isMinimalStyle ? 0.45 : 0.65))
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round,
      );
    }

    if (isCrit && !_isMinimalStyle) {
      final flashAlpha = ((1 - p) * (_isEnergeticStyle ? 0.18 : 0.14)).clamp(
        0.0, _isEnergeticStyle ? 0.18 : 0.14,
      );
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white.withValues(alpha: flashAlpha),
      );
    }
  }

  // ── 浮动数字 ──

  void _drawFloatNumber(
    Canvas canvas,
    Size size,
    String text,
    double normX,
    Color color,
    double t,
    bool crit,
  ) {
    final p = t.clamp(0.0, 2.0);
    final alpha = (1.0 - (p - 0.8).clamp(0.0, 1.2) / 1.2).clamp(0.0, 1.0);
    if (alpha <= 0) return;

    final pop = crit
        ? 1 + math.sin(p * math.pi * 8) * (_isMinimalStyle ? 0.06 : 0.12)
        : 1.0;
    final baseSize = _isMinimalStyle ? 16.0 : 18.0;
    final critSize = _isMinimalStyle ? 20.0 : 23.0;

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: alpha),
          fontSize: (crit ? critSize : baseSize) * pop,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: alpha * 0.85),
              blurRadius: 4,
              offset: const Offset(1.2, 1.8),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final x = normX * size.width - tp.width / 2;
    final y = size.height * 0.19 - p * 22;
    tp.paint(canvas, Offset(x, y));
  }

  // ── 标签徽章 ──

  void _drawBadge(
    Canvas canvas,
    Size size,
    String text,
    double normX,
    double t,
    Color color,
  ) {
    final p = t.clamp(0.0, 1.8);
    final alpha = (1.0 - (p - 0.8).clamp(0.0, 1.0)).clamp(0.0, 1.0);
    if (alpha <= 0) return;

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: alpha),
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final x = normX * size.width - tp.width / 2;
    final y = size.height * 0.12 - p * 11;

    final bg = RRect.fromRectAndRadius(
      Rect.fromLTWH(x - 8, y - 4, tp.width + 16, tp.height + 8),
      const Radius.circular(10),
    );
    canvas.drawRRect(bg, Paint()..color = color.withValues(alpha: alpha * 0.15));
    canvas.drawRRect(
      bg,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = color.withValues(alpha: alpha * 0.45),
    );
    tp.paint(canvas, Offset(x, y));
  }

  // ── 运动模糊 ──

  void _drawMotionBlur(Canvas canvas, Size size, MotionBlurTrail blur, Color color) {
    final positions = blur.positions;
    if (positions.length < 2) return;

    final path = Path();
    final firstPos = Offset(positions[0].dx * size.width, positions[0].dy * size.height);
    path.moveTo(firstPos.dx, firstPos.dy);

    for (int i = 1; i < positions.length; i++) {
      final pos = Offset(positions[i].dx * size.width, positions[i].dy * size.height);
      path.lineTo(pos.dx, pos.dy);
    }

    // 绘制渐变模糊轨迹
    for (int i = 0; i < positions.length - 1; i++) {
      final progress = i / (positions.length - 1);
      final alpha = (1.0 - progress) * 0.3;
      final width = (8.0 - progress * 4.0).clamp(2.0, 8.0);

      final start = Offset(positions[i].dx * size.width, positions[i].dy * size.height);
      final end = Offset(positions[i + 1].dx * size.width, positions[i + 1].dy * size.height);

      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = color.withValues(alpha: alpha)
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0),
      );
    }
  }

  // ── 斩击轨迹 ──

  void _drawSlashTrail(Canvas canvas, Size size, SlashTrail trail, double progress) {
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final cx = trail.centerX * size.width;
    final cy = trail.centerY * size.height;
    final radius = trail.radius * size.width;

    final path = Path();
    final sweepAngle = trail.endAngle - trail.startAngle;

    // 绘制弧形轨迹
    path.addArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      trail.startAngle,
      sweepAngle * (0.3 + progress * 0.7),
    );

    // 主轨迹
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0 * (1.0 - progress * 0.3)
        ..color = trail.color.withValues(alpha: alpha * 0.6)
        ..strokeCap = StrokeCap.round,
    );

    // 内层光晕
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0 * (1.0 - progress * 0.3)
        ..color = Colors.white.withValues(alpha: alpha * 0.8)
        ..strokeCap = StrokeCap.round,
    );

    // 外层扩散
    if (progress < 0.6) {
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12.0 * (1.0 + progress * 0.5)
          ..color = trail.color.withValues(alpha: alpha * 0.2)
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ArenaPainter oldDelegate) => true;
}

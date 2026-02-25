import 'dart:math' as math;
import 'dart:ui';

import 'battle_types.dart';

// ── 运动模糊系统 ──

class MotionBlurTrail {
  final List<Offset> _positions = [];
  static const int _maxPositions = 8;
  double _lastRecordTime = 0;
  static const double _recordInterval = 0.015; // 15ms 记录一次

  List<Offset> get positions => _positions;

  void record(double x, double y, double currentTime) {
    if (currentTime - _lastRecordTime < _recordInterval) return;
    _lastRecordTime = currentTime;

    if (_positions.length >= _maxPositions) {
      _positions.removeAt(0);
    }

    _positions.add(Offset(x, y));
  }

  void clear() {
    _positions.clear();
    _lastRecordTime = 0;
  }

  bool get hasTrail => _positions.length >= 2;
}

// ── 斩击轨迹 ──

class SlashTrail {
  double startTime = -1;
  double startAngle = 0;
  double endAngle = 0;
  double centerX = 0;
  double centerY = 0;
  double radius = 0;
  Color color = const Color(0xFFFFFFFF);
  BattleActionType weaponType = BattleActionType.sword;

  bool get isActive => startTime >= 0;

  void trigger({
    required double time,
    required double cx,
    required double cy,
    required double r,
    required double start,
    required double end,
    required Color c,
    required BattleActionType weapon,
  }) {
    startTime = time;
    centerX = cx;
    centerY = cy;
    radius = r;
    startAngle = start;
    endAngle = end;
    color = c;
    weaponType = weapon;
  }

  double progress(double currentTime) {
    if (!isActive) return 0;
    final elapsed = currentTime - startTime;
    const duration = 0.25; // 250ms
    if (elapsed >= duration) {
      startTime = -1;
      return 0;
    }
    return (elapsed / duration).clamp(0.0, 1.0);
  }

  void clear() {
    startTime = -1;
  }
}

// ── 增强冲击波效果 ──

class EnhancedShockwave {
  static void paint(
    Canvas canvas,
    Offset center,
    double progress,
    Color color,
    bool isCrit,
    bool isMinimal,
    bool isEnergetic,
  ) {
    final alpha = (1.0 - progress).clamp(0.0, 1.0);
    final baseRadius = 14 + 30 * progress;
    final radius = baseRadius * (isEnergetic ? 1.18 : (isMinimal ? 0.85 : 1.0));

    // 主圆环
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isMinimal ? 1.6 : 2.0
        ..color = color.withValues(alpha: alpha * (isMinimal ? 0.34 : 0.45)),
    );

    // 内核
    canvas.drawCircle(
      center,
      radius * 0.46,
      Paint()..color = const Color(0xFFFFFFFF).withValues(alpha: alpha * (isMinimal ? 0.22 : 0.35)),
    );

    // 扭曲环（新增）
    if (!isMinimal && progress < 0.6) {
      final distortRadius = radius * (0.7 + progress * 0.3);
      canvas.drawCircle(
        center,
        distortRadius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = color.withValues(alpha: alpha * 0.25),
      );
    }

    // 射线
    final spikeCount = isMinimal ? 4 : (isEnergetic ? 8 : 6);
    for (var i = 0; i < spikeCount; i++) {
      final angle = (i / spikeCount) * math.pi * 2 + progress * 1.2;
      final start = Offset(
        center.dx + math.cos(angle) * radius * 0.32,
        center.dy + math.sin(angle) * radius * 0.32,
      );
      final end = Offset(
        center.dx + math.cos(angle) * radius * 1.05,
        center.dy + math.sin(angle) * radius * 1.05,
      );
      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = color.withValues(alpha: alpha * (isMinimal ? 0.45 : 0.65))
          ..strokeWidth = 1.6
          ..strokeCap = StrokeCap.round,
      );
    }

    // 暴击额外效果
    if (isCrit && !isMinimal) {
      // 外圈光晕
      canvas.drawCircle(
        center,
        radius * 1.3,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = color.withValues(alpha: alpha * 0.15),
      );

      // 粒子环
      final particleCount = 12;
      for (var i = 0; i < particleCount; i++) {
        final angle = (i / particleCount) * math.pi * 2 + progress * 3;
        final particleRadius = radius * (1.1 + math.sin(progress * math.pi * 4 + i) * 0.1);
        final pos = Offset(
          center.dx + math.cos(angle) * particleRadius,
          center.dy + math.sin(angle) * particleRadius,
        );
        canvas.drawCircle(
          pos,
          2.0 * (1.0 - progress),
          Paint()..color = color.withValues(alpha: alpha * 0.6),
        );
      }
    }
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ── 粒子数据 ──

enum ParticleShape { circle, square, line, diamond }

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double life;
  double maxLife;
  double size;
  double rotation;
  double rotationSpeed;
  Color color;
  ParticleShape shape;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.life,
    required this.size,
    required this.color,
    this.shape = ParticleShape.circle,
    this.rotation = 0,
    this.rotationSpeed = 0,
  }) : maxLife = life;

  bool get dead => life <= 0;

  double get progress => 1.0 - (life / maxLife).clamp(0.0, 1.0);
}

// ── 粒子配置 ──

class ParticleConfig {
  final int count;
  final double minSpeed;
  final double maxSpeed;
  final double minLife;
  final double maxLife;
  final double minSize;
  final double maxSize;
  final double gravity;
  final double spreadAngle; // 弧度，全圆 = 2π
  final double baseAngle; // 发射方向中心
  final List<Color> colors;
  final ParticleShape shape;
  final double friction;

  const ParticleConfig({
    required this.count,
    this.minSpeed = 40,
    this.maxSpeed = 120,
    this.minLife = 0.3,
    this.maxLife = 0.8,
    this.minSize = 1.5,
    this.maxSize = 4.0,
    this.gravity = 180,
    this.spreadAngle = math.pi * 2,
    this.baseAngle = -math.pi / 2,
    this.colors = const [Color(0xFFFFD080), Color(0xFFFFAA44)],
    this.shape = ParticleShape.circle,
    this.friction = 0.97,
  });

  // 命中火花
  static const hitSparks = ParticleConfig(
    count: 12,
    minSpeed: 60,
    maxSpeed: 160,
    minLife: 0.2,
    maxLife: 0.5,
    minSize: 1.5,
    maxSize: 3.5,
    gravity: 220,
    spreadAngle: math.pi * 1.2,
    colors: [Color(0xFFFFE0A0), Color(0xFFFFBB55), Color(0xFFFFFFFF)],
    shape: ParticleShape.line,
  );

  // 暴击爆炸
  static const critExplosion = ParticleConfig(
    count: 28,
    minSpeed: 80,
    maxSpeed: 240,
    minLife: 0.3,
    maxLife: 0.7,
    minSize: 2.0,
    maxSize: 5.0,
    gravity: 160,
    spreadAngle: math.pi * 2,
    colors: [Color(0xFFFFDD66), Color(0xFFFF8844), Color(0xFFFFFFFF), Color(0xFFFFBB77)],
    shape: ParticleShape.diamond,
  );

  // 蓄力能量
  static const energyCharge = ParticleConfig(
    count: 8,
    minSpeed: 20,
    maxSpeed: 50,
    minLife: 0.4,
    maxLife: 0.9,
    minSize: 2.0,
    maxSize: 3.5,
    gravity: -40,
    spreadAngle: math.pi * 2,
    colors: [Color(0xFF88CCFF), Color(0xFFAADDFF)],
    shape: ParticleShape.circle,
    friction: 0.94,
  );

  // 碎片
  static const debris = ParticleConfig(
    count: 6,
    minSpeed: 30,
    maxSpeed: 90,
    minLife: 0.3,
    maxLife: 0.6,
    minSize: 2.0,
    maxSize: 4.5,
    gravity: 300,
    spreadAngle: math.pi * 0.8,
    colors: [Color(0xFFCCBBAA), Color(0xFF998877)],
    shape: ParticleShape.square,
  );

  // 治疗光辉
  static const healGlow = ParticleConfig(
    count: 10,
    minSpeed: 15,
    maxSpeed: 45,
    minLife: 0.5,
    maxLife: 1.0,
    minSize: 2.5,
    maxSize: 4.0,
    gravity: -60,
    spreadAngle: math.pi * 2,
    colors: [Color(0xFF88FFBB), Color(0xFF66EEAA), Color(0xFFAAFFDD)],
    shape: ParticleShape.circle,
    friction: 0.96,
  );
}

// ── 粒子发射器 ──

class ParticleEmitter {
  static const int _maxParticles = 80;
  final _rng = math.Random();
  final List<Particle> _particles = [];

  List<Particle> get particles => _particles;
  bool get isEmpty => _particles.isEmpty;

  void emit(double cx, double cy, ParticleConfig config, {double direction = 0}) {
    final baseAngle = config.baseAngle + direction;
    for (var i = 0; i < config.count; i++) {
      if (_particles.length >= _maxParticles) {
        // 回收最老的
        _particles.removeAt(0);
      }
      final angle = baseAngle + ((_rng.nextDouble() - 0.5) * config.spreadAngle);
      final speed = config.minSpeed + _rng.nextDouble() * (config.maxSpeed - config.minSpeed);
      final life = config.minLife + _rng.nextDouble() * (config.maxLife - config.minLife);
      final size = config.minSize + _rng.nextDouble() * (config.maxSize - config.minSize);
      final color = config.colors[_rng.nextInt(config.colors.length)];

      _particles.add(Particle(
        x: cx + (_rng.nextDouble() - 0.5) * 4,
        y: cy + (_rng.nextDouble() - 0.5) * 4,
        vx: math.cos(angle) * speed,
        vy: math.sin(angle) * speed,
        life: life,
        size: size,
        color: color,
        shape: config.shape,
        rotation: _rng.nextDouble() * math.pi * 2,
        rotationSpeed: (_rng.nextDouble() - 0.5) * 8,
      ));
    }
  }

  void update(double dt) {
    for (var i = _particles.length - 1; i >= 0; i--) {
      final p = _particles[i];
      p.life -= dt;
      if (p.dead) {
        _particles.removeAt(i);
        continue;
      }
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.vy += 180 * dt; // 默认重力，config.gravity 在 emit 时已融入速度
      p.vx *= 0.97;
      p.rotation += p.rotationSpeed * dt;
    }
  }

  void clear() => _particles.clear();

  void paint(Canvas canvas) {
    for (final p in _particles) {
      final alpha = (1.0 - p.progress).clamp(0.0, 1.0);
      final fadeAlpha = alpha * (alpha > 0.7 ? 1.0 : alpha / 0.7);
      final s = p.size * (1.0 - p.progress * 0.4);
      final paint = Paint()..color = p.color.withValues(alpha: fadeAlpha * 0.85);

      switch (p.shape) {
        case ParticleShape.circle:
          canvas.drawCircle(Offset(p.x, p.y), s, paint);
        case ParticleShape.square:
          canvas.save();
          canvas.translate(p.x, p.y);
          canvas.rotate(p.rotation);
          canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: s * 2, height: s * 2), paint);
          canvas.restore();
        case ParticleShape.line:
          final len = s * 2.5;
          final dx = math.cos(p.rotation) * len;
          final dy = math.sin(p.rotation) * len;
          canvas.drawLine(
            Offset(p.x - dx * 0.5, p.y - dy * 0.5),
            Offset(p.x + dx * 0.5, p.y + dy * 0.5),
            paint..strokeWidth = s * 0.6..strokeCap = StrokeCap.round,
          );
        case ParticleShape.diamond:
          final path = Path()
            ..moveTo(p.x, p.y - s)
            ..lineTo(p.x + s * 0.6, p.y)
            ..lineTo(p.x, p.y + s)
            ..lineTo(p.x - s * 0.6, p.y)
            ..close();
          canvas.drawPath(path, paint);
      }
    }
  }
}

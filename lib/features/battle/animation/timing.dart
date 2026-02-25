import 'package:flutter/material.dart';

import '../../../core/constants/battle_speed_settings.dart';
import 'battle_types.dart';

// ── 时序数据 ──

class MeleeTiming {
  final double dashEnd;
  final double windEnd;
  final double strikeEnd;

  const MeleeTiming({
    required this.dashEnd,
    required this.windEnd,
    required this.strikeEnd,
  });
}

class RangedTiming {
  final double prepareEnd;
  final double flightEnd;
  final double impactEnd;

  const RangedTiming({
    required this.prepareEnd,
    required this.flightEnd,
    required this.impactEnd,
  });
}

// ── 风格系数 ──

double styleDurationFactor(BattleAnimationStyle style) {
  switch (style) {
    case BattleAnimationStyle.jianghu:
      return 1.12;
    case BattleAnimationStyle.cinematic:
      return 1.22;
    case BattleAnimationStyle.swift:
      return 1.0;
    case BattleAnimationStyle.minimal:
      return 1.0;
    case BattleAnimationStyle.energetic:
      return 1.08;
    case BattleAnimationStyle.classic:
      return 1.12;
  }
}

double styleFxScale(BattleAnimationStyle style) {
  switch (style) {
    case BattleAnimationStyle.jianghu:
      return 0.88;
    case BattleAnimationStyle.cinematic:
      return 1.15;
    case BattleAnimationStyle.swift:
      return 0.92;
    case BattleAnimationStyle.minimal:
      return 0.55;
    case BattleAnimationStyle.energetic:
      return 1.30;
    case BattleAnimationStyle.classic:
      return 1.0;
  }
}

// ── 近战时序 ──

MeleeTiming meleeTiming(BattleActionType type, BattleAnimationStyle style) {
  final base = switch (type) {
    BattleActionType.kick => const MeleeTiming(
      dashEnd: 0.18, windEnd: 0.44, strikeEnd: 0.69,
    ),
    BattleActionType.palm => const MeleeTiming(
      dashEnd: 0.21, windEnd: 0.46, strikeEnd: 0.68,
    ),
    BattleActionType.sword || BattleActionType.blade => const MeleeTiming(
      dashEnd: 0.24, windEnd: 0.44, strikeEnd: 0.64,
    ),
    _ => const MeleeTiming(dashEnd: 0.20, windEnd: 0.40, strikeEnd: 0.66),
  };

  switch (style) {
    case BattleAnimationStyle.jianghu:
      return MeleeTiming(
        dashEnd: (base.dashEnd + 0.02).clamp(0.16, 0.30),
        windEnd: (base.windEnd + 0.06).clamp(0.32, 0.64),
        strikeEnd: (base.strikeEnd + 0.08).clamp(0.58, 0.86),
      );
    case BattleAnimationStyle.cinematic:
      return MeleeTiming(
        dashEnd: (base.dashEnd + 0.02).clamp(0.16, 0.32),
        windEnd: (base.windEnd + 0.04).clamp(0.32, 0.62),
        strikeEnd: (base.strikeEnd + 0.03).clamp(0.54, 0.82),
      );
    case BattleAnimationStyle.swift:
      return MeleeTiming(
        dashEnd: (base.dashEnd - 0.02).clamp(0.12, 0.26),
        windEnd: (base.windEnd - 0.04).clamp(0.26, 0.52),
        strikeEnd: (base.strikeEnd - 0.05).clamp(0.46, 0.72),
      );
    case BattleAnimationStyle.minimal:
      return MeleeTiming(dashEnd: 0.20, windEnd: 0.42, strikeEnd: 0.66);
    case BattleAnimationStyle.energetic:
      return MeleeTiming(
        dashEnd: (base.dashEnd - 0.01).clamp(0.14, 0.28),
        windEnd: (base.windEnd - 0.02).clamp(0.28, 0.56),
        strikeEnd: (base.strikeEnd - 0.02).clamp(0.50, 0.76),
      );
    case BattleAnimationStyle.classic:
      return base;
  }
}

// ── 远程时序 ──

RangedTiming rangedTiming(BattleAnimationStyle style) {
  switch (style) {
    case BattleAnimationStyle.jianghu:
      return const RangedTiming(prepareEnd: 0.24, flightEnd: 0.60, impactEnd: 0.82);
    case BattleAnimationStyle.cinematic:
      return const RangedTiming(prepareEnd: 0.28, flightEnd: 0.66, impactEnd: 0.85);
    case BattleAnimationStyle.swift:
      return const RangedTiming(prepareEnd: 0.19, flightEnd: 0.53, impactEnd: 0.73);
    case BattleAnimationStyle.minimal:
      return const RangedTiming(prepareEnd: 0.16, flightEnd: 0.48, impactEnd: 0.68);
    case BattleAnimationStyle.energetic:
      return const RangedTiming(prepareEnd: 0.22, flightEnd: 0.58, impactEnd: 0.76);
    case BattleAnimationStyle.classic:
      return const RangedTiming(prepareEnd: 0.25, flightEnd: 0.62, impactEnd: 0.80);
  }
}

// ── 出招曲线 & 击退 ──

Curve meleeStrikeCurve(BattleActionType type) {
  switch (type) {
    case BattleActionType.kick:
      return Curves.easeOutBack;
    case BattleActionType.palm:
      return Curves.easeOutQuart;
    case BattleActionType.sword:
    case BattleActionType.blade:
      return Curves.fastOutSlowIn;
    default:
      return Curves.easeOutCubic;
  }
}

double meleeKnock(BattleActionType type, bool defeated, BattleAnimationStyle style) {
  var amount = switch (type) {
    BattleActionType.kick => 0.050,
    BattleActionType.palm => 0.054,
    BattleActionType.sword => 0.047,
    BattleActionType.blade => 0.052,
    _ => 0.044,
  };
  if (defeated) amount += 0.020;
  final styleScale = switch (style) {
    BattleAnimationStyle.jianghu => 1.08,
    BattleAnimationStyle.minimal => 0.72,
    BattleAnimationStyle.energetic => 1.2,
    BattleAnimationStyle.cinematic => 1.12,
    _ => 1.0,
  };
  return amount * styleScale;
}

// ── 接触点 ──

double contactXFor(bool isPlayer, BattleActionType type, String? skillId) {
  var x = isPlayer ? 0.60 : 0.40;
  if (type == BattleActionType.kick) {
    x = isPlayer ? 0.58 : 0.42;
  }
  if (type == BattleActionType.sword || type == BattleActionType.blade) {
    x = isPlayer ? 0.63 : 0.37;
  }
  final lower = skillId?.toLowerCase() ?? '';
  if (lower.contains('mountain')) {
    x = isPlayer ? 0.65 : 0.35;
  }
  return x;
}

double mix(double a, double b, double t) => a + (b - a) * t;

// ── 风格配置 ──

class StyleConfig {
  final double particleScale;
  final double hitStopScale;
  final double shakeScale;
  final double afterImageInterval;
  final double slashTrailWidth;
  final double secondaryStiffness;
  final double secondaryDamping;

  const StyleConfig({
    required this.particleScale,
    required this.hitStopScale,
    required this.shakeScale,
    required this.afterImageInterval,
    required this.slashTrailWidth,
    required this.secondaryStiffness,
    required this.secondaryDamping,
  });

  static StyleConfig forStyle(BattleAnimationStyle style) {
    return switch (style) {
      BattleAnimationStyle.jianghu => const StyleConfig(
        particleScale: 1.1,
        hitStopScale: 1.2,
        shakeScale: 1.1,
        afterImageInterval: 0.07,
        slashTrailWidth: 1.2,
        secondaryStiffness: 150.0,
        secondaryDamping: 10.0,
      ),
      BattleAnimationStyle.cinematic => const StyleConfig(
        particleScale: 1.3,
        hitStopScale: 1.5,
        shakeScale: 1.3,
        afterImageInterval: 0.05,
        slashTrailWidth: 1.4,
        secondaryStiffness: 120.0,
        secondaryDamping: 8.0,
      ),
      BattleAnimationStyle.swift => const StyleConfig(
        particleScale: 0.8,
        hitStopScale: 0.7,
        shakeScale: 0.8,
        afterImageInterval: 0.04,
        slashTrailWidth: 0.9,
        secondaryStiffness: 220.0,
        secondaryDamping: 15.0,
      ),
      BattleAnimationStyle.minimal => const StyleConfig(
        particleScale: 0.6,
        hitStopScale: 0.5,
        shakeScale: 0.6,
        afterImageInterval: 0.10,
        slashTrailWidth: 0.7,
        secondaryStiffness: 200.0,
        secondaryDamping: 18.0,
      ),
      BattleAnimationStyle.energetic => const StyleConfig(
        particleScale: 1.5,
        hitStopScale: 1.3,
        shakeScale: 1.5,
        afterImageInterval: 0.03,
        slashTrailWidth: 1.5,
        secondaryStiffness: 250.0,
        secondaryDamping: 10.0,
      ),
      BattleAnimationStyle.classic => const StyleConfig(
        particleScale: 1.0,
        hitStopScale: 1.0,
        shakeScale: 1.0,
        afterImageInterval: 0.06,
        slashTrailWidth: 1.0,
        secondaryStiffness: 180.0,
        secondaryDamping: 12.0,
      ),
    };
  }
}

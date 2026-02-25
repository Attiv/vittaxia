import 'dart:math' as math;
import 'dart:ui';

import 'battle_types.dart';

const double deg = math.pi / 180;

class Pose {
  final double bodyLean;
  final double lShoulder;
  final double lElbow;
  final double rShoulder;
  final double rElbow;
  final double lHip;
  final double lKnee;
  final double rHip;
  final double rKnee;
  final double torsoLift;

  const Pose({
    this.bodyLean = 0,
    this.lShoulder = 0,
    this.lElbow = 0,
    this.rShoulder = 0,
    this.rElbow = 0,
    this.lHip = 0,
    this.lKnee = 0,
    this.rHip = 0,
    this.rKnee = 0,
    this.torsoLift = 0,
  });

  Pose lerp(Pose o, double t) {
    return Pose(
      bodyLean: _mix(bodyLean, o.bodyLean, t),
      lShoulder: _mix(lShoulder, o.lShoulder, t),
      lElbow: _mix(lElbow, o.lElbow, t),
      rShoulder: _mix(rShoulder, o.rShoulder, t),
      rElbow: _mix(rElbow, o.rElbow, t),
      lHip: _mix(lHip, o.lHip, t),
      lKnee: _mix(lKnee, o.lKnee, t),
      rHip: _mix(rHip, o.rHip, t),
      rKnee: _mix(rKnee, o.rKnee, t),
      torsoLift: _mix(torsoLift, o.torsoLift, t),
    );
  }

  static double _mix(double a, double b, double t) => a + (b - a) * t;
}

// ── 预定义姿势 ──

const idlePose = Pose(
  lShoulder: -16, lElbow: -34,
  rShoulder: 16, rElbow: 34,
  lHip: -5, rHip: 5,
);

const dashPoseA = Pose(
  bodyLean: 12,
  lShoulder: 44, lElbow: 70, rShoulder: -30, rElbow: -52,
  lHip: -30, lKnee: -40, rHip: 28, rKnee: 36, torsoLift: -1.5,
);

const dashPoseB = Pose(
  bodyLean: 12,
  lShoulder: -30, lElbow: -52, rShoulder: 44, rElbow: 70,
  lHip: 28, lKnee: 36, rHip: -30, rKnee: -40, torsoLift: -1.5,
);

const windUpPose = Pose(
  bodyLean: -12,
  lShoulder: -44, lElbow: -72, rShoulder: -34, rElbow: -82,
  lHip: -10, rHip: 12, rKnee: 6, torsoLift: 0.8,
);

const weaponWindUpPose = Pose(
  bodyLean: -10,
  lShoulder: -30, lElbow: -46, rShoulder: -62, rElbow: -104,
  lHip: -8, rHip: 9, torsoLift: 0.5,
);

const kickWindUpPose = Pose(
  bodyLean: -5,
  lShoulder: -22, lElbow: -36, rShoulder: 18, rElbow: 32,
  lHip: -6, rHip: -24, rKnee: -62, torsoLift: 0.2,
);

const fistStrikePose = Pose(
  bodyLean: 14,
  lShoulder: -28, lElbow: -58, rShoulder: 94, rElbow: 102,
  lHip: -12, rHip: 22, rKnee: 8, torsoLift: -0.4,
);

const kickStrikePose = Pose(
  bodyLean: -2,
  lShoulder: -18, lElbow: -34, rShoulder: 24, rElbow: 46,
  lHip: -10, rHip: 88, rKnee: 92, torsoLift: -0.3,
);

const palmStrikePose = Pose(
  bodyLean: 18,
  lShoulder: -34, lElbow: -60, rShoulder: 86, rElbow: 94,
  lHip: -14, rHip: 20, rKnee: 6, torsoLift: -0.5,
);

const swordStrikePose = Pose(
  bodyLean: 16,
  lShoulder: -22, lElbow: -40, rShoulder: 72, rElbow: 42,
  lHip: -10, rHip: 24, rKnee: 9, torsoLift: -0.4,
);

const bladeStrikePose = Pose(
  bodyLean: 20,
  lShoulder: -30, lElbow: -48, rShoulder: 78, rElbow: 54,
  lHip: -14, rHip: 26, rKnee: 10, torsoLift: -0.5,
);

const throwPose = Pose(
  bodyLean: 8,
  lShoulder: -14, lElbow: -26, rShoulder: 82, rElbow: 112,
  lHip: -8, rHip: 16, rKnee: 6, torsoLift: -0.2,
);

const hurtPose = Pose(
  bodyLean: -30,
  lShoulder: 36, lElbow: 62, rShoulder: -44, rElbow: -30,
  lHip: 14, lKnee: 10, rHip: 8, rKnee: 6, torsoLift: 1.0,
);

const dodgePose = Pose(
  bodyLean: -28,
  lShoulder: 16, lElbow: 24, rShoulder: -14, rElbow: -24,
  lHip: -22, lKnee: -10, rHip: 20, rKnee: -6, torsoLift: 1.6,
);

const supportHealPose = Pose(
  bodyLean: -6,
  lShoulder: -58, lElbow: -76, rShoulder: 58, rElbow: 76,
  lHip: -6, rHip: 6, torsoLift: -2,
);

const supportBuffPose = Pose(
  bodyLean: 8,
  lShoulder: -20, lElbow: -30, rShoulder: 20, rElbow: 30,
  lHip: -4, rHip: 4, torsoLift: -1,
);

// ── 姿势选择 & 技能变体 ──

Pose windUpPoseOf(BattleActionType type, String? skillId) {
  final lower = skillId?.toLowerCase() ?? '';
  Pose base;
  if (lower.contains('kick')) {
    base = kickWindUpPose;
  } else {
    switch (type) {
      case BattleActionType.kick:
        base = kickWindUpPose;
      case BattleActionType.sword:
      case BattleActionType.blade:
      case BattleActionType.hidden:
        base = weaponWindUpPose;
      case BattleActionType.heal:
      case BattleActionType.buff:
        base = idlePose;
      default:
        base = windUpPose;
    }
  }
  return applySkillVariant(base, skillId, type: type, windUp: true);
}

Pose attackPoseOf(BattleActionType type, String? skillId) {
  final lower = skillId?.toLowerCase() ?? '';
  Pose base;
  if (lower.contains('kick')) {
    base = kickStrikePose;
  } else if (lower.contains('palm')) {
    base = palmStrikePose;
  } else if (lower.contains('sword')) {
    base = swordStrikePose;
  } else if (lower.contains('blade')) {
    base = bladeStrikePose;
  } else if (lower.contains('shadow') || lower.contains('dart')) {
    base = throwPose;
  } else {
    switch (type) {
      case BattleActionType.kick:
        base = kickStrikePose;
      case BattleActionType.palm:
        base = palmStrikePose;
      case BattleActionType.sword:
        base = swordStrikePose;
      case BattleActionType.blade:
        base = bladeStrikePose;
      case BattleActionType.hidden:
        base = throwPose;
      default:
        base = fistStrikePose;
    }
  }
  return applySkillVariant(base, skillId, type: type, windUp: false);
}

Pose supportPoseOf(BattleActionType type, String? skillId) {
  final lower = skillId?.toLowerCase() ?? '';
  final base =
      type == BattleActionType.heal ||
          lower.contains('return') ||
          lower.contains('moon') ||
          lower.contains('breathing')
      ? supportHealPose
      : supportBuffPose;
  return applySkillVariant(base, skillId, type: type, windUp: false, support: true);
}

// ── 技能变体哈希 ──

int skillSeed(String? skillId, BattleActionType type, bool windUp) {
  final source = '${skillId ?? ''}:${type.index}:${windUp ? 1 : 0}';
  var hash = 0x811C9DC5;
  for (final unit in source.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0x7fffffff;
  }
  return hash;
}

double seedNorm(int seed, int shift) => ((seed >> shift) & 0xFF) / 255.0;

double _seedOffset(int seed, int shift, double amplitude) {
  return (seedNorm(seed, shift) * 2 - 1) * amplitude;
}

double _clampDeg(double value) => value.clamp(-130.0, 130.0).toDouble();

Pose applySkillVariant(
  Pose base,
  String? skillId, {
  required BattleActionType type,
  required bool windUp,
  bool support = false,
}) {
  if (skillId == null || skillId.isEmpty) return base;
  final seed = skillSeed(skillId, type, windUp);
  final armAmp = support ? 4.0 : (windUp ? 6.0 : 9.0);
  final legAmp = support ? 2.5 : (windUp ? 4.0 : 5.5);
  final bodyAmp = support ? 3.0 : (windUp ? 4.5 : 6.5);

  return Pose(
    bodyLean: _clampDeg(base.bodyLean + _seedOffset(seed, 2, bodyAmp)),
    lShoulder: _clampDeg(base.lShoulder + _seedOffset(seed, 6, armAmp)),
    lElbow: _clampDeg(base.lElbow + _seedOffset(seed, 10, armAmp * 1.1)),
    rShoulder: _clampDeg(base.rShoulder + _seedOffset(seed, 14, armAmp)),
    rElbow: _clampDeg(base.rElbow + _seedOffset(seed, 18, armAmp * 1.1)),
    lHip: _clampDeg(base.lHip + _seedOffset(seed, 4, legAmp)),
    lKnee: _clampDeg(base.lKnee + _seedOffset(seed, 8, legAmp)),
    rHip: _clampDeg(base.rHip + _seedOffset(seed, 12, legAmp)),
    rKnee: _clampDeg(base.rKnee + _seedOffset(seed, 16, legAmp)),
    torsoLift: base.torsoLift + _seedOffset(seed, 20, support ? 0.6 : 0.9),
  );
}

Color supportGlowColor(String? skillId, BattleActionType type) {
  final lower = skillId?.toLowerCase() ?? '';
  if (lower.contains('mist')) return const Color(0xFF84E0FF);
  if (lower.contains('golden')) return const Color(0xFFFFD3A1);
  if (lower.contains('surge')) return const Color(0xFF7DD1FF);
  if (lower.contains('moon')) return const Color(0xFFABC5FF);
  if (lower.contains('return')) return const Color(0xFF8AEAAF);
  if (lower.contains('breathing')) return const Color(0xFF8BE8BE);
  return actionColor(type);
}

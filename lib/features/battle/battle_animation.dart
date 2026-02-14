import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ──────────────────────────────────────────────
// 动作类型 & 映射
// ──────────────────────────────────────────────

/// 战斗动画动作类型
enum BattleActionType { fist, kick, palm, sword, blade, hidden, heal, buff }

/// 根据技能 ID 推断动画类型
BattleActionType skillToActionType(String skillId) {
  const map = <String, BattleActionType>{
    'basic_fist': BattleActionType.fist,
    'basic_kick': BattleActionType.kick,
    'iron_palm': BattleActionType.palm,
    'mountain_palm': BattleActionType.palm,
    'gale_sword': BattleActionType.sword,
    'jade_bamboo_sword': BattleActionType.sword,
    'shadow_strike': BattleActionType.hidden,
    'swallow_dart': BattleActionType.hidden,
    'tuna_breathing': BattleActionType.heal,
    'golden_bell': BattleActionType.buff,
    'qi_surge': BattleActionType.buff,
    'spring_return': BattleActionType.heal,
    'mist_step': BattleActionType.buff,
    'moongazing_art': BattleActionType.heal,
    // 被动
    'passive_follow_fist': BattleActionType.fist,
    'passive_sweep_kick': BattleActionType.kick,
    'passive_elbow_strike': BattleActionType.fist,
    'passive_iron_body': BattleActionType.fist,
    'passive_palm_strike': BattleActionType.palm,
    'passive_finger_flick': BattleActionType.hidden,
    'passive_hidden_needle': BattleActionType.hidden,
    'passive_sword_qi': BattleActionType.sword,
    'passive_blade_wind': BattleActionType.blade,
    'passive_counter_punch': BattleActionType.fist,
    'passive_shadow_step': BattleActionType.kick,
    'passive_qi_burst': BattleActionType.fist,
  };
  return map[skillId] ?? BattleActionType.fist;
}

/// 每种动作对应的武器 / 特效颜色
Color actionColor(BattleActionType type) {
  switch (type) {
    case BattleActionType.fist:
      return const Color(0xFFFFD54F);
    case BattleActionType.kick:
      return const Color(0xFFBCAAA4);
    case BattleActionType.palm:
      return const Color(0xFFFF6E40);
    case BattleActionType.sword:
      return const Color(0xFF40C4FF);
    case BattleActionType.blade:
      return const Color(0xFFFF1744);
    case BattleActionType.hidden:
      return const Color(0xFFAB47BC);
    case BattleActionType.heal:
      return const Color(0xFF66BB6A);
    case BattleActionType.buff:
      return const Color(0xFFFFD54F);
  }
}

// ──────────────────────────────────────────────
// 火柴人姿势
// ──────────────────────────────────────────────

const _deg = math.pi / 180;

/// 关节角度定义（面朝右，角度以竖直向下为 0，正值 = 前方/右侧）
class _Pose {
  final double bodyLean;
  final double la1, la2;
  final double ra1, ra2;
  final double ll1, ll2;
  final double rl1, rl2;

  const _Pose({
    this.bodyLean = 0,
    this.la1 = 0,
    this.la2 = 0,
    this.ra1 = 0,
    this.ra2 = 0,
    this.ll1 = 0,
    this.ll2 = 0,
    this.rl1 = 0,
    this.rl2 = 0,
  });

  _Pose lerp(_Pose o, double t) => _Pose(
    bodyLean: _mix(bodyLean, o.bodyLean, t),
    la1: _mix(la1, o.la1, t),
    la2: _mix(la2, o.la2, t),
    ra1: _mix(ra1, o.ra1, t),
    ra2: _mix(ra2, o.ra2, t),
    ll1: _mix(ll1, o.ll1, t),
    ll2: _mix(ll2, o.ll2, t),
    rl1: _mix(rl1, o.rl1, t),
    rl2: _mix(rl2, o.rl2, t),
  );

  static double _mix(double a, double b, double t) => a + (b - a) * t;
}

// 预设姿势
const _idle = _Pose(la1: -15, la2: -30, ra1: 15, ra2: 30, ll1: -5, rl1: 5);

const _run1 = _Pose(
  bodyLean: 14,
  la1: 45,
  la2: 75,
  ra1: -35,
  ra2: -55,
  ll1: -30,
  ll2: -45,
  rl1: 38,
  rl2: 38,
);

const _run2 = _Pose(
  bodyLean: 14,
  la1: -35,
  la2: -55,
  ra1: 45,
  ra2: 75,
  ll1: 38,
  ll2: 38,
  rl1: -30,
  rl2: -45,
);

// 蓄力姿势：身体后仰蓄力
const _windUp = _Pose(
  bodyLean: -8,
  la1: -50,
  la2: -90,
  ra1: -30,
  ra2: -75,
  ll1: -10,
  rl1: 12,
  rl2: -5,
);

const _punch = _Pose(
  bodyLean: 12,
  la1: -35,
  la2: -80,
  ra1: 85,
  ra2: 85,
  ll1: -12,
  rl1: 20,
  rl2: 5,
);

const _kick = _Pose(
  bodyLean: -5,
  la1: -20,
  la2: -40,
  ra1: 25,
  ra2: 45,
  ll1: -8,
  rl1: 88,
  rl2: 85,
);

const _palmStrike = _Pose(
  bodyLean: 16,
  la1: -42,
  la2: -68,
  ra1: 80,
  ra2: 92,
  ll1: -12,
  rl1: 24,
  rl2: 6,
);

const _swordSlash = _Pose(
  bodyLean: 18,
  la1: -28,
  la2: -55,
  ra1: 65,
  ra2: 45,
  ll1: -10,
  rl1: 25,
  rl2: 10,
);

const _bladeSlash = _Pose(
  bodyLean: 22,
  la1: -32,
  la2: -60,
  ra1: 75,
  ra2: 55,
  ll1: -14,
  rl1: 28,
  rl2: 10,
);

const _throwPose = _Pose(
  bodyLean: 5,
  la1: -18,
  la2: -35,
  ra1: 72,
  ra2: 100,
  ll1: -8,
  rl1: 15,
  rl2: 5,
);

const _hurt = _Pose(
  // 受击主姿态：躯干后仰，腿部前撑，避免“撅屁股”
  bodyLean: -44,
  la1: 42,
  la2: 74,
  ra1: -56,
  ra2: -34,
  ll1: 16,
  ll2: 12,
  rl1: 10,
  rl2: 8,
);

// 被击退后弹一下
const _hurtRecoil = _Pose(
  bodyLean: -30,
  la1: 26,
  la2: 44,
  ra1: -36,
  ra2: -20,
  ll1: 10,
  ll2: 8,
  rl1: 6,
  rl2: 5,
);

// 受击后站不稳的过渡姿态
const _hurtStagger = _Pose(
  bodyLean: -18,
  la1: 14,
  la2: 20,
  ra1: -22,
  ra2: -12,
  ll1: 6,
  ll2: 5,
  rl1: 3,
  rl2: 3,
);

const _dodge = _Pose(
  bodyLean: -28,
  la1: 12,
  la2: 22,
  ra1: -12,
  ra2: -22,
  ll1: -18,
  ll2: -5,
  rl1: 18,
  rl2: -12,
);

// 倒地：躯干几乎平躺于地面
const _down = _Pose(
  bodyLean: 88,
  la1: 95,
  la2: 85,
  ra1: 80,
  ra2: 70,
  ll1: 62,
  ll2: 78,
  rl1: 40,
  rl2: 28,
);

// 蓄力用的武器准备姿势（剑/刀举高）
const _swordWindUp = _Pose(
  bodyLean: -6,
  la1: -35,
  la2: -50,
  ra1: -60,
  ra2: -100,
  ll1: -8,
  rl1: 10,
);

const _kickWindUp = _Pose(
  bodyLean: -3,
  la1: -25,
  la2: -45,
  ra1: 20,
  ra2: 40,
  ll1: -5,
  rl1: -25,
  rl2: -60,
);

// 武功细分动作（每种武功不同动作）
const _ironPalmWindUp = _Pose(
  bodyLean: -12,
  la1: -58,
  la2: -96,
  ra1: -48,
  ra2: -82,
  ll1: -12,
  rl1: 10,
);

const _ironPalmStrike = _Pose(
  bodyLean: 20,
  la1: -38,
  la2: -70,
  ra1: 92,
  ra2: 98,
  ll1: -14,
  rl1: 26,
  rl2: 8,
);

const _mountainPalmWindUp = _Pose(
  bodyLean: -16,
  la1: -62,
  la2: -102,
  ra1: -54,
  ra2: -92,
  ll1: -15,
  rl1: 16,
);

const _mountainPalmStrike = _Pose(
  bodyLean: 28,
  la1: -46,
  la2: -74,
  ra1: 106,
  ra2: 108,
  ll1: -18,
  rl1: 30,
  rl2: 12,
);

const _galeSwordWindUp = _Pose(
  bodyLean: -8,
  la1: -40,
  la2: -56,
  ra1: -76,
  ra2: -112,
  ll1: -10,
  rl1: 12,
);

const _galeSwordSlash = _Pose(
  bodyLean: 24,
  la1: -18,
  la2: -34,
  ra1: 82,
  ra2: 52,
  ll1: -12,
  rl1: 30,
  rl2: 15,
);

const _jadeSwordWindUp = _Pose(
  bodyLean: -4,
  la1: -30,
  la2: -46,
  ra1: -68,
  ra2: -104,
  ll1: -8,
  rl1: 9,
);

const _jadeSwordSlash = _Pose(
  bodyLean: 18,
  la1: -24,
  la2: -40,
  ra1: 74,
  ra2: 40,
  ll1: -8,
  rl1: 24,
  rl2: 10,
);

const _shadowStrikeWindUp = _Pose(
  bodyLean: -18,
  la1: -12,
  la2: -24,
  ra1: -62,
  ra2: -108,
  ll1: -18,
  rl1: 20,
);

const _shadowStrikeThrow = _Pose(
  bodyLean: 12,
  la1: -10,
  la2: -24,
  ra1: 88,
  ra2: 112,
  ll1: -8,
  rl1: 26,
  rl2: 8,
);

const _swallowDartWindUp = _Pose(
  bodyLean: -6,
  la1: -20,
  la2: -38,
  ra1: -52,
  ra2: -94,
  ll1: -10,
  rl1: 12,
);

const _swallowDartThrow = _Pose(
  bodyLean: 6,
  la1: -16,
  la2: -30,
  ra1: 78,
  ra2: 102,
  ll1: -6,
  rl1: 18,
  rl2: 6,
);

const _tunaPose = _Pose(
  bodyLean: -4,
  la1: -42,
  la2: -58,
  ra1: 42,
  ra2: 58,
  ll1: -6,
  rl1: 6,
);

const _springReturnPose = _Pose(
  bodyLean: -2,
  la1: -64,
  la2: -74,
  ra1: 64,
  ra2: 74,
  ll1: -4,
  rl1: 4,
);

const _goldenBellPose = _Pose(
  bodyLean: 2,
  la1: -24,
  la2: -36,
  ra1: 24,
  ra2: 36,
  ll1: -5,
  rl1: 5,
);

const _qiSurgePose = _Pose(
  bodyLean: 8,
  la1: -72,
  la2: -84,
  ra1: 72,
  ra2: 84,
  ll1: -6,
  rl1: 6,
);

const _mistStepPose = _Pose(
  bodyLean: -18,
  la1: 6,
  la2: 14,
  ra1: -10,
  ra2: -18,
  ll1: -24,
  ll2: -18,
  rl1: 20,
  rl2: -8,
);

const _moongazingPose = _Pose(
  bodyLean: -10,
  la1: -58,
  la2: -78,
  ra1: 58,
  ra2: 78,
  ll1: -5,
  rl1: 5,
);

_Pose _windUpPoseOf(BattleActionType t, String? skillId) {
  final _Pose basePose;
  switch (skillId) {
    case 'basic_kick':
    case 'passive_sweep_kick':
    case 'passive_shadow_step':
      basePose = _kickWindUp;
      break;
    case 'iron_palm':
    case 'passive_palm_strike':
      basePose = _ironPalmWindUp;
      break;
    case 'mountain_palm':
      basePose = _mountainPalmWindUp;
      break;
    case 'gale_sword':
    case 'passive_sword_qi':
      basePose = _galeSwordWindUp;
      break;
    case 'jade_bamboo_sword':
      basePose = _jadeSwordWindUp;
      break;
    case 'shadow_strike':
      basePose = _shadowStrikeWindUp;
      break;
    case 'swallow_dart':
    case 'passive_hidden_needle':
      basePose = _swallowDartWindUp;
      break;
    default:
      switch (t) {
        case BattleActionType.kick:
          basePose = _kickWindUp;
          break;
        case BattleActionType.sword:
        case BattleActionType.blade:
          basePose = _swordWindUp;
          break;
        default:
          basePose = _windUp;
          break;
      }
      break;
  }
  return _applySkillVariant(basePose, skillId, type: t, windUp: true);
}

_Pose _attackPoseOf(BattleActionType t, String? skillId) {
  final _Pose basePose;
  switch (skillId) {
    case 'basic_fist':
    case 'passive_follow_fist':
    case 'passive_elbow_strike':
    case 'passive_counter_punch':
    case 'passive_qi_burst':
      basePose = _punch;
      break;
    case 'basic_kick':
    case 'passive_sweep_kick':
    case 'passive_shadow_step':
      basePose = _kick;
      break;
    case 'iron_palm':
    case 'passive_palm_strike':
      basePose = _ironPalmStrike;
      break;
    case 'mountain_palm':
      basePose = _mountainPalmStrike;
      break;
    case 'gale_sword':
    case 'passive_sword_qi':
      basePose = _galeSwordSlash;
      break;
    case 'jade_bamboo_sword':
      basePose = _jadeSwordSlash;
      break;
    case 'shadow_strike':
    case 'passive_finger_flick':
      basePose = _shadowStrikeThrow;
      break;
    case 'swallow_dart':
    case 'passive_hidden_needle':
      basePose = _swallowDartThrow;
      break;
    default:
      switch (t) {
        case BattleActionType.kick:
          basePose = _kick;
          break;
        case BattleActionType.palm:
          basePose = _palmStrike;
          break;
        case BattleActionType.sword:
          basePose = _swordSlash;
          break;
        case BattleActionType.blade:
          basePose = _bladeSlash;
          break;
        case BattleActionType.hidden:
          basePose = _throwPose;
          break;
        default:
          basePose = _punch;
          break;
      }
      break;
  }
  return _applySkillVariant(basePose, skillId, type: t, windUp: false);
}

_Pose _supportPoseOf(String? skillId, BattleActionType type) {
  final _Pose basePose;
  switch (skillId) {
    case 'tuna_breathing':
      basePose = _tunaPose;
      break;
    case 'spring_return':
      basePose = _springReturnPose;
      break;
    case 'golden_bell':
      basePose = _goldenBellPose;
      break;
    case 'qi_surge':
      basePose = _qiSurgePose;
      break;
    case 'mist_step':
      basePose = _mistStepPose;
      break;
    case 'moongazing_art':
      basePose = _moongazingPose;
      break;
    default:
      basePose = _idle;
      break;
  }
  return _applySkillVariant(
    basePose,
    skillId,
    type: type,
    windUp: false,
    support: true,
  );
}

int _skillSeed(String value) {
  var hash = 0x811C9DC5;
  for (final c in value.codeUnits) {
    hash ^= c;
    hash = (hash * 0x01000193) & 0x7fffffff;
  }
  return hash;
}

double _seedNorm(int seed, int shift) {
  return ((seed >> shift) & 0xFF) / 255.0;
}

double _seedAngle(int seed, int shift, double amplitude) {
  return (_seedNorm(seed, shift) * 2 - 1) * amplitude;
}

_Pose _poseShift(
  _Pose base, {
  double bodyLean = 0,
  double la1 = 0,
  double la2 = 0,
  double ra1 = 0,
  double ra2 = 0,
  double ll1 = 0,
  double ll2 = 0,
  double rl1 = 0,
  double rl2 = 0,
}) {
  double clampDeg(double v) => v.clamp(-130.0, 130.0).toDouble();
  return _Pose(
    bodyLean: clampDeg(base.bodyLean + bodyLean),
    la1: clampDeg(base.la1 + la1),
    la2: clampDeg(base.la2 + la2),
    ra1: clampDeg(base.ra1 + ra1),
    ra2: clampDeg(base.ra2 + ra2),
    ll1: clampDeg(base.ll1 + ll1),
    ll2: clampDeg(base.ll2 + ll2),
    rl1: clampDeg(base.rl1 + rl1),
    rl2: clampDeg(base.rl2 + rl2),
  );
}

_Pose _applySkillVariant(
  _Pose base,
  String? skillId, {
  required BattleActionType type,
  required bool windUp,
  bool support = false,
}) {
  if (skillId == null || skillId.isEmpty) return base;
  final seed = _skillSeed(
    '$skillId:${type.index}:${windUp
        ? "wind"
        : support
        ? "support"
        : "attack"}',
  );
  final armAmp = switch (type) {
    BattleActionType.sword || BattleActionType.blade => windUp ? 8.0 : 11.0,
    BattleActionType.hidden => windUp ? 9.0 : 12.0,
    BattleActionType.kick => windUp ? 7.5 : 10.5,
    BattleActionType.palm => windUp ? 8.0 : 10.0,
    BattleActionType.heal || BattleActionType.buff => 6.0,
    _ => windUp ? 7.0 : 9.0,
  };
  final legAmp = support ? armAmp * 0.35 : armAmp * 0.55;
  final bodyAmp = support ? 4.0 : (windUp ? 5.5 : 7.0);
  return _poseShift(
    base,
    bodyLean: _seedAngle(seed, 1, bodyAmp),
    la1: _seedAngle(seed, 3, armAmp),
    la2: _seedAngle(seed, 7, armAmp * 1.2),
    ra1: _seedAngle(seed, 11, armAmp),
    ra2: _seedAngle(seed, 15, armAmp * 1.2),
    ll1: _seedAngle(seed, 19, legAmp),
    ll2: _seedAngle(seed, 23, legAmp * 0.8),
    rl1: _seedAngle(seed, 5, legAmp),
    rl2: _seedAngle(seed, 27, legAmp * 0.8),
  );
}

// ──────────────────────────────────────────────
// 控制器
// ──────────────────────────────────────────────

class BattleArenaController {
  _BattleArenaState? _state;
  void _attach(_BattleArenaState s) => _state = s;
  void _detach() => _state = null;

  Future<void> playAction({
    required bool isPlayer,
    required BattleActionType type,
    String? skillId,
    bool crit = false,
    bool dodged = false,
    int damage = 0,
    int healAmount = 0,
    bool defenderDefeated = false,
  }) {
    return _state?._playAction(
          isPlayer: isPlayer,
          type: type,
          skillId: skillId,
          crit: crit,
          dodged: dodged,
          damage: damage,
          healAmount: healAmount,
          defenderDefeated: defenderDefeated,
        ) ??
        Future.value();
  }
}

// ──────────────────────────────────────────────
// 战斗擂台 Widget
// ──────────────────────────────────────────────

class BattleArenaWidget extends StatefulWidget {
  final BattleArenaController controller;
  final BattleActionType? idlePlayerWeaponType;
  final double height;

  const BattleArenaWidget({
    super.key,
    required this.controller,
    this.idlePlayerWeaponType,
    this.height = 220,
  });

  @override
  State<BattleArenaWidget> createState() => _BattleArenaState();
}

class _BattleArenaState extends State<BattleArenaWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  // 当前帧状态
  double _playerX = 0.25;
  double _enemyX = 0.75;
  _Pose _playerPose = _idle;
  _Pose _enemyPose = _idle;

  // 动画参数
  bool _isAnimating = false;
  bool _attackerIsPlayer = true;
  BattleActionType _actionType = BattleActionType.fist;
  String? _actionSkillId;
  bool _isCrit = false;
  bool _isDodged = false;
  int _damageValue = 0;
  int _healValue = 0;
  bool _defenderDefeated = false;
  bool _playerDown = false;
  bool _enemyDown = false;

  // 特效
  double _impactT = -1;
  double _glowT = -1;
  double _speedT = -1;
  bool _glowOnPlayer = true;
  Color _glowColor = Colors.green;

  // 伤害数字浮动进度 (0~1)
  double _dmgTextT = -1;

  // 暗器飞行
  double _projX = 0;
  double _projY = 0;
  bool _showProj = false;

  Completer<void>? _completer;

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    _anim = AnimationController(vsync: this)..addListener(_tick);
  }

  @override
  void dispose() {
    widget.controller._detach();
    _anim.dispose();
    super.dispose();
  }

  Future<void> _playAction({
    required bool isPlayer,
    required BattleActionType type,
    String? skillId,
    bool crit = false,
    bool dodged = false,
    int damage = 0,
    int healAmount = 0,
    bool defenderDefeated = false,
  }) async {
    if (_isAnimating) return;
    _attackerIsPlayer = isPlayer;
    _actionType = type;
    _actionSkillId = skillId;
    _isCrit = crit;
    _isDodged = dodged;
    _damageValue = damage;
    _healValue = healAmount;
    _defenderDefeated = defenderDefeated && !dodged;
    _isAnimating = true;
    _playerDown = false;
    _enemyDown = false;
    _impactT = -1;
    _glowT = -1;
    _speedT = -1;
    _dmgTextT = -1;
    _showProj = false;

    final isHealBuff =
        type == BattleActionType.heal || type == BattleActionType.buff;
    // 放慢动作节奏，强化武器可读性（尤其是剑/刀）
    final isBlade =
        type == BattleActionType.sword || type == BattleActionType.blade;
    _anim.duration = Duration(
      milliseconds: isHealBuff
          ? 560
          : type == BattleActionType.hidden
          ? 920
          : isBlade
          ? 980
          : 820,
    );

    _completer = Completer<void>();
    _anim.forward(from: 0);
    await _completer!.future;
  }

  void _tick() {
    final t = _anim.value;
    final isHealBuff =
        _actionType == BattleActionType.heal ||
        _actionType == BattleActionType.buff;

    if (isHealBuff) {
      _updateHealBuff(t);
    } else if (_actionType == BattleActionType.hidden) {
      _updateRanged(t);
    } else {
      _updateMelee(t);
    }

    if (t >= 1.0) _reset();
    setState(() {});
  }

  void _reset() {
    _playerX = 0.25;
    _enemyX = 0.75;
    if (_defenderDefeated) {
      _playerDown = !_attackerIsPlayer;
      _enemyDown = _attackerIsPlayer;
      _playerPose = _playerDown ? _down : _idle;
      _enemyPose = _enemyDown ? _down : _idle;
    } else {
      _playerDown = false;
      _enemyDown = false;
      _playerPose = _idle;
      _enemyPose = _idle;
    }
    _isAnimating = false;
    _impactT = -1;
    _glowT = -1;
    _speedT = -1;
    _dmgTextT = -1;
    _showProj = false;
    _completer?.complete();
    _completer = null;
  }

  // ── 近战：冲过去 → 蓄力 → 打 → 弹开 → 回 ──

  void _updateMelee(double t) {
    final attackPose = _attackPoseOf(_actionType, _actionSkillId);
    final windUpPose = _windUpPoseOf(_actionType, _actionSkillId);
    final startX = _attackerIsPlayer ? 0.25 : 0.75;
    var targetX = _attackerIsPlayer ? 0.63 : 0.37;
    switch (_actionSkillId) {
      case 'mountain_palm':
        targetX = _attackerIsPlayer ? 0.67 : 0.33;
      case 'basic_kick':
      case 'passive_sweep_kick':
        targetX = _attackerIsPlayer ? 0.60 : 0.40;
      case 'gale_sword':
        targetX = _attackerIsPlayer ? 0.65 : 0.35;
      case 'jade_bamboo_sword':
        targetX = _attackerIsPlayer ? 0.64 : 0.36;
      default:
        break;
    }

    _showProj = false;
    _glowT = -1;
    _speedT = -1;

    // 阶段划分（总比例=1.0）：
    // 冲刺 0~0.24  蓄力 0.24~0.42  出招 0.42~0.62  击中 0.62~0.74  回退 0.74~0.94  归位 0.94~1.0
    if (t < 0.24) {
      // 冲刺
      final p = t / 0.24;
      final ep = Curves.easeInQuad.transform(p);
      final runT = (math.sin(p * math.pi * 5) + 1) / 2; // 跑步频率更快
      _setAttacker(startX + (targetX - startX) * ep, _run1.lerp(_run2, runT));
      _setDefender(_idle);
      _speedT = p;
      _dmgTextT = -1;
    } else if (t < 0.42) {
      // 蓄力
      final p = ((t - 0.24) / 0.18).clamp(0.0, 1.0);
      _setAttacker(
        targetX,
        _idle.lerp(windUpPose, Curves.easeOut.transform(p)),
      );
      _setDefender(_idle);
      _speedT = -1;
      _dmgTextT = -1;
    } else if (t < 0.62) {
      // 出招（蓄力→攻击姿势，快速）
      final p = ((t - 0.42) / 0.20).clamp(0.0, 1.0);
      _setAttacker(
        targetX,
        windUpPose.lerp(attackPose, Curves.easeOutBack.transform(p)),
      );
      _setDefender(_idle);
      _speedT = 1.0;
      _dmgTextT = -1;
    } else if (t < 0.74) {
      // 击中：防御者受伤 + 显示伤害数字
      final p = ((t - 0.62) / 0.12).clamp(0.0, 1.0);
      _setAttacker(targetX, attackPose);
      if (_isDodged) {
        _setDefender(_idle.lerp(_dodge, (p * 2).clamp(0.0, 1.0)));
      } else {
        final knockAmp = _defenderDefeated ? 0.055 : 0.045;
        final knock = (math.sin(p * math.pi) * knockAmp).clamp(0.0, knockAmp);
        if (_attackerIsPlayer) {
          _enemyX = 0.75 + knock;
        } else {
          _playerX = 0.25 - knock;
        }
        // 受击分为：瞬间吃力 -> 后仰回弹 -> 踉跄，避免“木头人”感。
        if (_defenderDefeated) {
          final fallP = Curves.easeIn.transform(p);
          _setDefender(_hurt.lerp(_down, fallP));
        } else {
          if (p < 0.35) {
            final hitP = Curves.easeOutCubic.transform(
              (p / 0.35).clamp(0.0, 1.0),
            );
            _setDefender(_idle.lerp(_hurt, hitP));
          } else if (p < 0.78) {
            final recoilP = Curves.easeInOut.transform(
              ((p - 0.35) / 0.43).clamp(0.0, 1.0),
            );
            _setDefender(_hurt.lerp(_hurtRecoil, recoilP));
          } else {
            final staggerP = Curves.easeOut.transform(
              ((p - 0.78) / 0.22).clamp(0.0, 1.0),
            );
            _setDefender(_hurtRecoil.lerp(_hurtStagger, staggerP));
          }
        }
        _impactT = p;
        _dmgTextT = p;
      }
    } else if (t < 0.94) {
      // 回退
      final p = ((t - 0.74) / 0.20).clamp(0.0, 1.0);
      final ep = Curves.easeOutQuad.transform(p);
      _setAttacker(
        targetX + (startX - targetX) * ep,
        attackPose.lerp(_idle, ep),
      );
      if (_defenderDefeated && !_isDodged) {
        _setDefender(_down);
      } else {
        final defPose = _isDodged ? _dodge : _hurtStagger;
        _setDefender(defPose.lerp(_idle, ep));
      }
      _impactT = -1;
      _speedT = -1;
      // 伤害数字继续浮动上升
      _dmgTextT = 1.0 + p * 0.6;
    } else {
      _setAttacker(startX, _idle);
      _setDefender(_idle);
      _impactT = -1;
      _speedT = -1;
      final p = ((t - 0.94) / 0.06).clamp(0.0, 1.0);
      _dmgTextT = 1.6 + p * 0.4; // 淡出
    }
  }

  // ── 暗器 ──

  void _updateRanged(double t) {
    _impactT = -1;
    _glowT = -1;
    _speedT = -1;
    final startX = _attackerIsPlayer ? 0.25 : 0.75;
    final defX = _attackerIsPlayer ? 0.75 : 0.25;

    if (t < 0.18) {
      final p = (t / 0.18).clamp(0.0, 1.0);
      _setAttacker(
        startX,
        _idle.lerp(_windUpPoseOf(_actionType, _actionSkillId), p),
      );
      _setDefender(_idle);
      _showProj = false;
      _dmgTextT = -1;
    } else if (t < 0.48) {
      final p = ((t - 0.18) / 0.30).clamp(0.0, 1.0);
      final throwPose = _attackPoseOf(_actionType, _actionSkillId);
      _setAttacker(startX, throwPose);
      _setDefender(_idle);
      _showProj = true;
      _projX = startX + (defX - startX) * Curves.easeIn.transform(p);
      final arc = _actionSkillId == 'swallow_dart' ? 0.14 : 0.09;
      final drift = _actionSkillId == 'shadow_strike' ? 0.02 : 0.0;
      _projY = 0.42 - math.sin(p * math.pi) * arc + drift;
      _speedT = p;
      _dmgTextT = -1;
    } else if (t < 0.65) {
      final p = ((t - 0.48) / 0.17).clamp(0.0, 1.0);
      _setAttacker(
        startX,
        _attackPoseOf(_actionType, _actionSkillId).lerp(_idle, p),
      );
      _showProj = false;
      if (_isDodged) {
        _setDefender(_idle.lerp(_dodge, (p * 2).clamp(0.0, 1.0)));
      } else {
        final knockAmp = _defenderDefeated ? 0.04 : 0.032;
        final knock = (math.sin(p * math.pi) * knockAmp).clamp(0.0, knockAmp);
        if (_attackerIsPlayer) {
          _enemyX = 0.75 + knock;
        } else {
          _playerX = 0.25 - knock;
        }
        if (_defenderDefeated) {
          final fallP = Curves.easeIn.transform(p);
          _setDefender(_hurt.lerp(_down, fallP));
        } else {
          if (p < 0.45) {
            final hitP = Curves.easeOutCubic.transform(
              (p / 0.45).clamp(0.0, 1.0),
            );
            _setDefender(_idle.lerp(_hurt, hitP));
          } else {
            final recoilP = Curves.easeOut.transform(
              ((p - 0.45) / 0.55).clamp(0.0, 1.0),
            );
            _setDefender(_hurt.lerp(_hurtRecoil, recoilP));
          }
        }
        _impactT = p;
        _dmgTextT = p;
      }
    } else {
      final p = ((t - 0.65) / 0.35).clamp(0.0, 1.0);
      _setAttacker(startX, _idle);
      if (_defenderDefeated && !_isDodged) {
        _setDefender(_down);
      } else {
        final defPose = _isDodged ? _dodge : _hurtRecoil;
        _setDefender(defPose.lerp(_idle, Curves.easeOutCubic.transform(p)));
      }
      _impactT = -1;
      _showProj = false;
      _dmgTextT = 1.0 + p;
    }
  }

  // ── 回复 / 增益 ──

  void _updateHealBuff(double t) {
    _impactT = -1;
    _speedT = -1;
    _showProj = false;
    final supportPose = _supportPoseOf(_actionSkillId, _actionType);
    _playerPose = _attackerIsPlayer
        ? _idle.lerp(supportPose, Curves.easeInOut.transform(t.clamp(0.0, 1.0)))
        : _idle;
    _enemyPose = _attackerIsPlayer
        ? _idle
        : _idle.lerp(
            supportPose,
            Curves.easeInOut.transform(t.clamp(0.0, 1.0)),
          );
    _playerX = 0.25;
    _enemyX = 0.75;

    _glowOnPlayer = _attackerIsPlayer;
    _glowColor = switch (_actionSkillId) {
      'tuna_breathing' => const Color(0xFF69C37C),
      'spring_return' => const Color(0xFF8BE38F),
      'golden_bell' => const Color(0xFFF7C44A),
      'qi_surge' => const Color(0xFFFF9B4A),
      'mist_step' => const Color(0xFF7AC7FF),
      'moongazing_art' => const Color(0xFF9EB9FF),
      _ => actionColor(_actionType),
    };
    _glowT = t < 0.15
        ? t / 0.15
        : t < 0.75
        ? 1.0
        : 1.0 - ((t - 0.75) / 0.25).clamp(0.0, 1.0);
    // 回复数字在中段显示
    _dmgTextT = t > 0.2 ? (t - 0.2) / 0.8 * 2.0 : -1;
  }

  // ── 辅助 ──

  void _setAttacker(double x, _Pose pose) {
    if (_attackerIsPlayer) {
      _playerX = x;
      _playerPose = pose;
    } else {
      _enemyX = x;
      _enemyPose = pose;
    }
  }

  void _setDefender(_Pose pose) {
    if (_attackerIsPlayer) {
      _enemyPose = pose;
    } else {
      _playerPose = pose;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        painter: _ArenaPainter(
          playerX: _playerX,
          enemyX: _enemyX,
          playerPose: _playerPose,
          enemyPose: _enemyPose,
          impactT: _impactT,
          impactColor: actionColor(_actionType),
          impactOnDefender: !_attackerIsPlayer,
          isCrit: _isCrit,
          isDodged: _isDodged,
          showProj: _showProj,
          projX: _projX,
          projY: _projY,
          projColor: actionColor(_actionType),
          glowT: _glowT,
          speedT: _speedT,
          glowOnPlayer: _glowOnPlayer,
          glowColor: _glowColor,
          playerIdleWeaponType: widget.idlePlayerWeaponType,
          weaponType: _isAnimating ? _actionType : widget.idlePlayerWeaponType,
          weaponOnPlayer: _isAnimating ? _attackerIsPlayer : true,
          dmgTextT: _dmgTextT,
          damageValue: _damageValue,
          healValue: _healValue,
          attackerIsPlayer: _attackerIsPlayer,
          playerDown: _playerDown,
          enemyDown: _enemyDown,
        ),
        size: Size.infinite,
      ),
    );
  }
}

// ──────────────────────────────────────────────
// CustomPainter — 粗壮火柴人
// ──────────────────────────────────────────────

class _ArenaPainter extends CustomPainter {
  final double playerX, enemyX;
  final _Pose playerPose, enemyPose;
  final double impactT;
  final Color impactColor;
  final bool impactOnDefender;
  final bool isCrit, isDodged;
  final bool showProj;
  final double projX, projY;
  final Color projColor;
  final double glowT;
  final double speedT;
  final bool glowOnPlayer;
  final Color glowColor;
  final BattleActionType? playerIdleWeaponType;
  final BattleActionType? weaponType;
  final bool weaponOnPlayer;
  final double dmgTextT;
  final int damageValue;
  final int healValue;
  final bool attackerIsPlayer;
  final bool playerDown;
  final bool enemyDown;

  _ArenaPainter({
    required this.playerX,
    required this.enemyX,
    required this.playerPose,
    required this.enemyPose,
    required this.impactT,
    required this.impactColor,
    required this.impactOnDefender,
    required this.isCrit,
    required this.isDodged,
    required this.showProj,
    required this.projX,
    required this.projY,
    required this.projColor,
    required this.glowT,
    required this.speedT,
    required this.glowOnPlayer,
    required this.glowColor,
    required this.playerIdleWeaponType,
    required this.weaponType,
    required this.weaponOnPlayer,
    required this.dmgTextT,
    required this.damageValue,
    required this.healValue,
    required this.attackerIsPlayer,
    required this.playerDown,
    required this.enemyDown,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shake = impactT >= 0 && !isDodged
        ? (isCrit ? 6.0 : 3.2) *
              (1.0 - ((impactT - 0.35).abs() * 2.2)).clamp(0.0, 1.0)
        : 0.0;
    if (shake > 0) {
      canvas.save();
      canvas.translate(
        math.sin(impactT * 70) * shake,
        math.cos(impactT * 63) * shake * 0.55,
      );
    }

    _drawBackground(canvas, size);
    if (speedT >= 0) {
      _drawSpeedLines(canvas, size, speedT, attackerIsPlayer);
    }
    _drawGround(canvas, size);

    if (glowT > 0) {
      final gx = (glowOnPlayer ? playerX : enemyX) * size.width;
      final gy = size.height * 0.72;
      _drawGlow(canvas, Offset(gx, gy), glowT, glowColor);
    }

    final playerWeaponForFrame = weaponOnPlayer
        ? weaponType
        : playerIdleWeaponType;
    if (playerDown) {
      _drawDownFigure(
        canvas,
        size,
        playerX,
        true,
        const Color(0xFFFFFFFF),
        playerWeaponForFrame,
      );
    } else {
      _drawFigure(
        canvas,
        size,
        playerX,
        playerPose,
        true,
        const Color(0xFFFFFFFF),
        playerWeaponForFrame,
      );
    }
    if (enemyDown) {
      _drawDownFigure(
        canvas,
        size,
        enemyX,
        false,
        const Color(0xFFFFFFFF),
        !weaponOnPlayer ? weaponType : null,
      );
    } else {
      _drawFigure(
        canvas,
        size,
        enemyX,
        enemyPose,
        false,
        const Color(0xFFFFFFFF),
        !weaponOnPlayer ? weaponType : null,
      );
    }

    if (showProj) _drawProjectile(canvas, size);

    if (impactT >= 0 && !isDodged) {
      final defX = impactOnDefender ? playerX : enemyX;
      _drawImpact(
        canvas,
        Offset(defX * size.width, size.height * 0.55),
        impactT,
      );
      if (isCrit) _drawCritFlash(canvas, size, impactT);
    }

    // 伤害/回复数字
    if (dmgTextT >= 0) {
      final isHealBuff =
          weaponType == BattleActionType.heal ||
          weaponType == BattleActionType.buff;
      if (isHealBuff && healValue > 0) {
        final targetX = attackerIsPlayer ? playerX : enemyX;
        _drawDamageNumber(
          canvas,
          size,
          '+$healValue',
          targetX,
          const Color(0xFF66BB6A),
          dmgTextT,
          false,
        );
      } else if (!isHealBuff && damageValue > 0 && !isDodged) {
        final defX = impactOnDefender ? playerX : enemyX;
        _drawDamageNumber(
          canvas,
          size,
          '-$damageValue',
          defX,
          const Color(0xFFFF1744),
          dmgTextT,
          isCrit,
        );
      }
    }

    // 暴击/闪避文字
    if (isCrit && impactT > 0.2 && !isDodged) {
      final defX = impactOnDefender ? playerX : enemyX;
      _drawFloatingText(canvas, size, '暴击!', defX, const Color(0xFFFFD54F), 14);
    }

    if (isDodged && dmgTextT >= 0) {
      _drawFloatingText(
        canvas,
        size,
        '闪避',
        impactOnDefender ? playerX : enemyX,
        Colors.white,
        14,
      );
    }

    if (shake > 0) {
      canvas.restore();
    }
  }

  // ── 背景 ──

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E1C1A), Color(0xFF28241F)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  void _drawSpeedLines(
    Canvas canvas,
    Size size,
    double t,
    bool attackerIsPlayer,
  ) {
    final p = t.clamp(0.0, 1.0);
    final alpha = (0.06 + 0.18 * (1 - (p - 0.5).abs() * 2)).clamp(0.0, 0.2);
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: alpha)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    final tilt = attackerIsPlayer ? -14.0 : 14.0;
    for (var i = 0; i < 12; i++) {
      final y = size.height * (0.2 + i * 0.055);
      final baseX = attackerIsPlayer
          ? size.width * (0.03 + i * 0.01)
          : size.width * (0.97 - i * 0.01);
      final len = size.width * (0.08 + (i % 3) * 0.015);
      final dx = len * math.cos(tilt * _deg);
      final dy = len * math.sin(tilt * _deg) * 0.15;
      canvas.drawLine(
        Offset(baseX, y),
        attackerIsPlayer
            ? Offset(baseX + dx, y + dy)
            : Offset(baseX - dx, y + dy),
        linePaint,
      );
    }
  }

  void _drawGround(Canvas canvas, Size size) {
    final gy = size.height * 0.88;
    canvas.drawLine(
      Offset(size.width * 0.06, gy),
      Offset(size.width * 0.94, gy),
      Paint()
        ..color = const Color(0xFF4A4540)
        ..strokeWidth = 1.5,
    );
  }

  // ── 火柴人（粗壮版）──

  void _drawFigure(
    Canvas canvas,
    Size size,
    double normX,
    _Pose pose,
    bool facingRight,
    Color color,
    BattleActionType? weapon,
  ) {
    final groundY = size.height * 0.88;
    final s = size.height / 150;
    final cx = size.width * normX;

    canvas.save();
    canvas.translate(cx, groundY);
    if (!facingRight) canvas.scale(-1, 1);

    const bodyLen = 24.0;
    const neckLen = 3.0;
    const headR = 9.0;
    const uArmLen = 13.0;
    const fArmLen = 11.0;
    const thighLen = 16.0;
    const shinLen = 14.0;
    const shoulderW = 7.0;

    final hipY = -(thighLen + shinLen) * s;
    final hip = Offset(0, hipY);

    Offset limb(Offset from, double deg, double len) {
      final a = deg * _deg;
      return Offset(
        from.dx + len * s * math.sin(a),
        from.dy + len * s * math.cos(a),
      );
    }

    Offset up(Offset from, double lean, double len) {
      final a = lean * _deg;
      return Offset(
        from.dx + len * s * math.sin(a),
        from.dy - len * s * math.cos(a),
      );
    }

    final shoulder = up(hip, pose.bodyLean, bodyLen);
    final neck = up(shoulder, pose.bodyLean, neckLen);
    final headC = up(neck, pose.bodyLean, headR);

    final lShoulder = Offset(
      shoulder.dx - shoulderW * s * math.cos(pose.bodyLean * _deg),
      shoulder.dy - shoulderW * s * math.sin(pose.bodyLean * _deg),
    );
    final rShoulder = Offset(
      shoulder.dx + shoulderW * s * math.cos(pose.bodyLean * _deg),
      shoulder.dy + shoulderW * s * math.sin(pose.bodyLean * _deg),
    );

    final lElbow = limb(lShoulder, pose.la1, uArmLen);
    final lHand = limb(lElbow, pose.la2, fArmLen);
    final rElbow = limb(rShoulder, pose.ra1, uArmLen);
    final rHand = limb(rElbow, pose.ra2, fArmLen);

    final lHip = Offset(hip.dx - 3 * s, hip.dy);
    final rHip = Offset(hip.dx + 3 * s, hip.dy);
    final lKnee = limb(lHip, pose.ll1, thighLen);
    final lFoot = limb(lKnee, pose.ll2, shinLen);
    final rKnee = limb(rHip, pose.rl1, thighLen);
    final rFoot = limb(rKnee, pose.rl2, shinLen);

    final stickColor = color;
    final bodyPaint = Paint()
      ..color = stickColor
      ..strokeWidth = 6.8 * s
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;
    final limbPaint = Paint()
      ..color = stickColor
      ..strokeWidth = 5.5 * s
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(0, -2),
        width: 44 * s,
        height: 10 * s,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.26),
    );

    void drawBone(Offset a, Offset b, Paint paint) {
      canvas.drawLine(a, b, paint);
    }

    drawBone(hip, shoulder, bodyPaint);
    drawBone(lShoulder, rShoulder, bodyPaint);
    drawBone(lHip, lKnee, limbPaint);
    drawBone(lKnee, lFoot, limbPaint);
    drawBone(rHip, rKnee, limbPaint);
    drawBone(rKnee, rFoot, limbPaint);
    drawBone(lShoulder, lElbow, limbPaint);
    drawBone(lElbow, lHand, limbPaint);
    drawBone(rShoulder, rElbow, limbPaint);
    drawBone(rElbow, rHand, limbPaint);

    // 关节不画圆点，保留纯粗线火柴人风格

    for (final ft in [lFoot, rFoot]) {
      canvas.drawOval(
        Rect.fromCenter(center: ft, width: 8.6 * s, height: 4.8 * s),
        Paint()..color = stickColor,
      );
    }

    canvas.drawCircle(headC, headR * s * 0.9, Paint()..color = stickColor);

    if (weapon == BattleActionType.sword || weapon == BattleActionType.blade) {
      final wColor = actionColor(weapon!);
      final wLen = weapon == BattleActionType.sword ? 34.0 : 30.0;
      final wEnd = limb(rHand, pose.ra2, wLen);
      final dir = wEnd - rHand;
      final dirLen = dir.distance;
      final dirN = dirLen < 0.0001 ? const Offset(1, 0) : dir / dirLen;
      final perp = Offset(-dirN.dy, dirN.dx);

      final isAttacking = speedT >= 0 || impactT >= 0;
      if (isAttacking) _drawWeaponTrail(canvas, rHand, wEnd, wColor, s);

      final hiltEnd = rHand - dirN * (6.2 * s);
      canvas.drawLine(
        rHand,
        hiltEnd,
        Paint()
          ..color = const Color(0xFF4E3E2F)
          ..strokeWidth = 3.2 * s
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        rHand + perp * (4.3 * s),
        rHand - perp * (4.3 * s),
        Paint()
          ..color = const Color(0xFFB3A18A).withValues(alpha: 0.95)
          ..strokeWidth = 1.9 * s
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        rHand,
        wEnd,
        Paint()
          ..color = wColor.withValues(alpha: isAttacking ? 0.24 : 0.12)
          ..strokeWidth = isAttacking ? 10 * s : 8 * s
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        rHand,
        wEnd,
        Paint()
          ..color = const Color(0xFFE9EEF7).withValues(alpha: 0.95)
          ..strokeWidth = 2.5 * s
          ..strokeCap = StrokeCap.round,
      );
      if (isAttacking) {
        final spark = wEnd + dirN * (2.1 * s);
        canvas.drawCircle(
          spark,
          2.1 * s,
          Paint()..color = Colors.white.withValues(alpha: 0.72),
        );
      }
    }

    if (weapon == BattleActionType.palm) {
      final wc = actionColor(weapon!);
      _drawPalmWave(canvas, rHand, wc, s);
      canvas.drawCircle(
        rHand,
        10 * s,
        Paint()..color = wc.withValues(alpha: 0.3),
      );
      canvas.drawCircle(
        rHand,
        5 * s,
        Paint()..color = wc.withValues(alpha: 0.6),
      );
    }

    if (weapon == BattleActionType.fist) {
      final wc = actionColor(weapon!);
      canvas.drawCircle(
        rHand,
        5 * s,
        Paint()..color = wc.withValues(alpha: 0.45),
      );
    }

    if (weapon == BattleActionType.kick) {
      final wc = actionColor(weapon!);
      canvas.drawCircle(
        rFoot,
        6 * s,
        Paint()..color = wc.withValues(alpha: 0.4),
      );
    }

    canvas.restore();
  }

  void _drawDownFigure(
    Canvas canvas,
    Size size,
    double normX,
    bool facingRight,
    Color color,
    BattleActionType? weapon,
  ) {
    final groundY = size.height * 0.88;
    final s = size.height / 150;
    final cx = size.width * normX;

    canvas.save();
    canvas.translate(cx, groundY);
    if (!facingRight) canvas.scale(-1, 1);

    final stickColor = color;
    final bodyPaint = Paint()
      ..color = stickColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final head = Offset(-20 * s, -8 * s);
    final torsoStart = Offset(-10 * s, -7 * s);
    final torsoEnd = Offset(18 * s, -10 * s);
    final arm1 = Offset(-3 * s, -3 * s);
    final arm2 = Offset(9 * s, 1 * s);
    final leg1 = Offset(4 * s, -2 * s);
    final leg2 = Offset(22 * s, -1 * s);

    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(0, -2),
        width: 54 * s,
        height: 11 * s,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.3),
    );

    void drawL(Offset a, Offset b, double w) {
      canvas.drawLine(a, b, bodyPaint..strokeWidth = w);
    }

    drawL(torsoStart, torsoEnd, 6.1 * s);
    drawL(torsoStart, arm1, 4.6 * s);
    drawL(arm1, arm2, 4.2 * s);
    drawL(torsoEnd - Offset(6 * s, -2 * s), leg1, 4.8 * s);
    drawL(leg1, leg2, 4.3 * s);

    canvas.drawCircle(head, 7.6 * s, Paint()..color = stickColor);

    if (weapon == BattleActionType.sword || weapon == BattleActionType.blade) {
      // 倒地后武器脱手，掉在旁边
      final hand = arm2 + Offset(2 * s, 1 * s);
      final wStart = hand + Offset(3 * s, 2 * s);
      final wEnd = wStart + Offset(18 * s, 1.5 * s);
      canvas.drawLine(
        wStart,
        wEnd,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.8)
          ..strokeWidth = 3.1 * s
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawLine(
        wStart,
        wEnd,
        Paint()
          ..color = const Color(0xFFE9EEF7).withValues(alpha: 0.86)
          ..strokeWidth = 2.2 * s
          ..strokeCap = StrokeCap.round,
      );
    }

    canvas.restore();
  }

  void _drawWeaponTrail(
    Canvas canvas,
    Offset start,
    Offset end,
    Color color,
    double scale,
  ) {
    final normal = (end - start);
    final len = normal.distance;
    if (len <= 0.01) return;
    final nx = -normal.dy / len;
    final ny = normal.dx / len;
    final spread = 6.5 * scale;

    final path = Path()
      ..moveTo(start.dx + nx * spread, start.dy + ny * spread)
      ..lineTo(end.dx + nx * spread * 0.8, end.dy + ny * spread * 0.8)
      ..lineTo(end.dx - nx * spread * 0.8, end.dy - ny * spread * 0.8)
      ..lineTo(start.dx - nx * spread, start.dy - ny * spread)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          colors: [
            color.withValues(alpha: 0.0),
            color.withValues(alpha: 0.28),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromPoints(start, end)),
    );
  }

  void _drawPalmWave(Canvas canvas, Offset center, Color color, double scale) {
    for (var i = 0; i < 2; i++) {
      final r = (8 + i * 6) * scale;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = (2.2 - i * 0.6) * scale
          ..color = color.withValues(alpha: 0.22 - i * 0.08),
      );
    }
  }

  // ── 伤害数字 ──

  void _drawDamageNumber(
    Canvas canvas,
    Size size,
    String text,
    double normX,
    Color color,
    double t,
    bool crit,
  ) {
    // t: 0~2.0 左右，0~1 为显示阶段，1~2 为上浮淡出阶段
    final floatUp = t.clamp(0.0, 2.0) * 18;
    final alpha = (1.0 - (t - 0.8).clamp(0.0, 1.2) / 1.2).clamp(0.0, 1.0);
    if (alpha <= 0) return;

    final fontSize = crit ? 20.0 : 16.0;
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: alpha),
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: alpha * 0.8),
              blurRadius: 3,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final x = normX * size.width - tp.width / 2;
    final y = size.height * 0.22 - floatUp;
    tp.paint(canvas, Offset(x, y));
  }

  // ── 冲击 ──

  void _drawImpact(Canvas canvas, Offset center, double t) {
    if (t < 0 || t > 1) return;
    final a = (1.0 - t).clamp(0.0, 1.0);
    final baseR = isCrit ? 20.0 : 14.0;
    final r = baseR + 35 * t;

    canvas.drawCircle(
      center,
      r,
      Paint()..color = impactColor.withValues(alpha: a * 0.35),
    );
    canvas.drawCircle(
      center,
      r * 0.3,
      Paint()..color = Colors.white.withValues(alpha: a * 0.7),
    );

    final lp = Paint()
      ..color = impactColor.withValues(alpha: a * 0.6)
      ..strokeWidth = isCrit ? 2.8 : 2.0
      ..strokeCap = StrokeCap.round;
    final n = isCrit ? 8 : 5;
    for (int i = 0; i < n; i++) {
      final ang = i * 2 * math.pi / n + t * 0.8;
      canvas.drawLine(
        Offset(
          center.dx + r * 0.4 * math.cos(ang),
          center.dy + r * 0.4 * math.sin(ang),
        ),
        Offset(
          center.dx + r * 1.3 * math.cos(ang),
          center.dy + r * 1.3 * math.sin(ang),
        ),
        lp,
      );
    }

    final sparks = isCrit ? 12 : 7;
    for (int i = 0; i < sparks; i++) {
      final ang = i * 2 * math.pi / sparks + t * 1.7;
      final dist = r * (0.65 + (i % 3) * 0.22);
      final sparkCenter = Offset(
        center.dx + math.cos(ang) * dist,
        center.dy + math.sin(ang) * dist,
      );
      canvas.drawCircle(
        sparkCenter,
        isCrit ? 2.6 : 1.8,
        Paint()..color = Colors.white.withValues(alpha: a * 0.65),
      );
    }
  }

  void _drawCritFlash(Canvas canvas, Size size, double t) {
    final flash = (1.0 - (t - 0.1).abs() * 6).clamp(0.0, 1.0) * 0.2;
    if (flash <= 0) return;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white.withValues(alpha: flash),
    );
  }

  // ── 浮动文字（暴击/闪避）──

  void _drawFloatingText(
    Canvas canvas,
    Size size,
    String text,
    double defNormX,
    Color color,
    double fontSize,
  ) {
    final rawT = dmgTextT.clamp(0.0, 2.0);
    final alpha = (1.0 - (rawT - 0.5).clamp(0.0, 1.5) / 1.5).clamp(0.0, 1.0);
    if (alpha <= 0) return;

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: alpha),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: alpha * 0.6),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(
        defNormX * size.width - tp.width / 2,
        size.height * 0.12 - rawT * 10,
      ),
    );
  }

  // ── 暗器 ──

  void _drawProjectile(Canvas canvas, Size size) {
    final px = projX * size.width;
    final py = projY * size.height;
    for (var i = 1; i <= 3; i++) {
      final alpha = (0.2 - i * 0.05).clamp(0.04, 0.2);
      canvas.drawCircle(
        Offset(px - i * 8, py + i * 1.2),
        4.4 - i * 0.8,
        Paint()..color = projColor.withValues(alpha: alpha),
      );
    }
    final path = Path()
      ..moveTo(px, py - 6)
      ..lineTo(px + 4, py)
      ..lineTo(px, py + 6)
      ..lineTo(px - 4, py)
      ..close();
    canvas.drawPath(path, Paint()..color = projColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = projColor.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
  }

  // ── 光环 ──

  void _drawGlow(Canvas canvas, Offset center, double t, Color color) {
    final a = t.clamp(0.0, 1.0);
    final pulse = 1.0 + 0.15 * math.sin(t * math.pi * 4);
    final r = 30 * pulse;

    canvas.drawCircle(
      center,
      r,
      Paint()..color = color.withValues(alpha: a * 0.2),
    );
    canvas.drawCircle(
      center,
      r * 0.5,
      Paint()..color = color.withValues(alpha: a * 0.35),
    );

    if (t > 0.15 && t < 0.85) {
      for (int i = 0; i < 6; i++) {
        final tt = (t - 0.15) / 0.7;
        final ang = i * 0.95 + tt * math.pi * 2;
        final wave = math.sin(tt * math.pi * 2 + i) * 10;
        final px = center.dx + math.cos(ang) * (12 + i * 2);
        final py = center.dy - 28 * tt - wave * 0.2 - i * 2;
        canvas.drawCircle(
          Offset(px, py),
          2.2 + (i % 2) * 0.8,
          Paint()..color = color.withValues(alpha: a * (0.32 + i * 0.03)),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaPainter old) => true;
}

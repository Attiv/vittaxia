import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ──────────────────────────────────────────────
// 动作类型 & 映射
// ──────────────────────────────────────────────

/// 战斗动画动作类型
enum BattleActionType {
  fist,
  kick,
  palm,
  sword,
  blade,
  hidden,
  heal,
  buff,
}

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
    this.la1 = 0, this.la2 = 0,
    this.ra1 = 0, this.ra2 = 0,
    this.ll1 = 0, this.ll2 = 0,
    this.rl1 = 0, this.rl2 = 0,
  });

  _Pose lerp(_Pose o, double t) => _Pose(
        bodyLean: _mix(bodyLean, o.bodyLean, t),
        la1: _mix(la1, o.la1, t), la2: _mix(la2, o.la2, t),
        ra1: _mix(ra1, o.ra1, t), ra2: _mix(ra2, o.ra2, t),
        ll1: _mix(ll1, o.ll1, t), ll2: _mix(ll2, o.ll2, t),
        rl1: _mix(rl1, o.rl1, t), rl2: _mix(rl2, o.rl2, t),
      );

  static double _mix(double a, double b, double t) => a + (b - a) * t;
}

// 预设姿势
const _idle = _Pose(
  la1: -15, la2: -30, ra1: 15, ra2: 30,
  ll1: -5, rl1: 5,
);

const _run1 = _Pose(
  bodyLean: 14,
  la1: 45, la2: 75, ra1: -35, ra2: -55,
  ll1: -30, ll2: -45, rl1: 38, rl2: 38,
);

const _run2 = _Pose(
  bodyLean: 14,
  la1: -35, la2: -55, ra1: 45, ra2: 75,
  ll1: 38, ll2: 38, rl1: -30, rl2: -45,
);

const _punch = _Pose(
  bodyLean: 12,
  la1: -35, la2: -80, ra1: 85, ra2: 85,
  ll1: -12, rl1: 20, rl2: 5,
);

const _kick = _Pose(
  bodyLean: -5,
  la1: -20, la2: -40, ra1: 25, ra2: 45,
  ll1: -8, rl1: 88, rl2: 85,
);

const _palmStrike = _Pose(
  bodyLean: 16,
  la1: -42, la2: -68, ra1: 80, ra2: 92,
  ll1: -12, rl1: 24, rl2: 6,
);

const _swordSlash = _Pose(
  bodyLean: 18,
  la1: -28, la2: -55, ra1: 65, ra2: 45,
  ll1: -10, rl1: 25, rl2: 10,
);

const _bladeSlash = _Pose(
  bodyLean: 22,
  la1: -32, la2: -60, ra1: 75, ra2: 55,
  ll1: -14, rl1: 28, rl2: 10,
);

const _throwPose = _Pose(
  bodyLean: 5,
  la1: -18, la2: -35, ra1: 72, ra2: 100,
  ll1: -8, rl1: 15, rl2: 5,
);

const _hurt = _Pose(
  bodyLean: -18,
  la1: 30, la2: 55, ra1: -10, ra2: 20,
  ll1: 10, rl1: -6,
);

const _dodge = _Pose(
  bodyLean: -28,
  la1: 12, la2: 22, ra1: -12, ra2: -22,
  ll1: -18, ll2: -5, rl1: 18, rl2: -12,
);

_Pose _attackPoseOf(BattleActionType t) {
  switch (t) {
    case BattleActionType.kick:
      return _kick;
    case BattleActionType.palm:
      return _palmStrike;
    case BattleActionType.sword:
      return _swordSlash;
    case BattleActionType.blade:
      return _bladeSlash;
    case BattleActionType.hidden:
      return _throwPose;
    default:
      return _punch;
  }
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
    bool crit = false,
    bool dodged = false,
  }) {
    return _state?._playAction(
          isPlayer: isPlayer,
          type: type,
          crit: crit,
          dodged: dodged,
        ) ??
        Future.value();
  }
}

// ──────────────────────────────────────────────
// 战斗擂台 Widget
// ──────────────────────────────────────────────

class BattleArenaWidget extends StatefulWidget {
  final BattleArenaController controller;
  const BattleArenaWidget({super.key, required this.controller});

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
  bool _isCrit = false;
  bool _isDodged = false;

  // 特效
  double _impactT = -1;
  double _glowT = -1;
  bool _glowOnPlayer = true;
  Color _glowColor = Colors.green;

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
    bool crit = false,
    bool dodged = false,
  }) async {
    if (_isAnimating) return;
    _attackerIsPlayer = isPlayer;
    _actionType = type;
    _isCrit = crit;
    _isDodged = dodged;
    _isAnimating = true;
    _impactT = -1;
    _glowT = -1;
    _showProj = false;

    final isHealBuff =
        type == BattleActionType.heal || type == BattleActionType.buff;
    _anim.duration = Duration(milliseconds: isHealBuff ? 600 : 850);

    _completer = Completer<void>();
    _anim.forward(from: 0);
    await _completer!.future;
  }

  void _tick() {
    final t = _anim.value;
    final isHealBuff = _actionType == BattleActionType.heal ||
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
    _playerPose = _idle;
    _enemyPose = _idle;
    _isAnimating = false;
    _impactT = -1;
    _glowT = -1;
    _showProj = false;
    _completer?.complete();
    _completer = null;
  }

  // ── 近战：冲过去打到对方 ──

  void _updateMelee(double t) {
    final pose = _attackPoseOf(_actionType);
    final startX = _attackerIsPlayer ? 0.25 : 0.75;
    // 贴近目标：距对方只留一点空隙让拳/脚/剑刚好够到
    final targetX = _attackerIsPlayer ? 0.63 : 0.37;

    _showProj = false;
    _glowT = -1;

    if (t < 0.28) {
      final p = t / 0.28;
      final ep = Curves.easeInQuad.transform(p);
      final runT = (math.sin(p * math.pi * 4) + 1) / 2;
      _setAttacker(startX + (targetX - startX) * ep, _run1.lerp(_run2, runT));
      _setDefender(_idle);
    } else if (t < 0.48) {
      final p = ((t - 0.28) / 0.20).clamp(0.0, 1.0);
      _setAttacker(targetX, _idle.lerp(pose, Curves.easeOut.transform(p)));
      _setDefender(_idle);
    } else if (t < 0.62) {
      final p = ((t - 0.48) / 0.14).clamp(0.0, 1.0);
      _setAttacker(targetX, pose);
      if (_isDodged) {
        _setDefender(_idle.lerp(_dodge, (p * 2).clamp(0.0, 1.0)));
      } else {
        _setDefender(_idle.lerp(_hurt, (p * 2).clamp(0.0, 1.0)));
        _impactT = p;
      }
    } else if (t < 0.88) {
      final p = ((t - 0.62) / 0.26).clamp(0.0, 1.0);
      final ep = Curves.easeOutQuad.transform(p);
      _setAttacker(targetX + (startX - targetX) * ep, pose.lerp(_idle, ep));
      final defPose = _isDodged ? _dodge : _hurt;
      _setDefender(defPose.lerp(_idle, ep));
      _impactT = -1;
    } else {
      _setAttacker(startX, _idle);
      _setDefender(_idle);
      _impactT = -1;
    }
  }

  // ── 暗器 ──

  void _updateRanged(double t) {
    _impactT = -1;
    _glowT = -1;
    final startX = _attackerIsPlayer ? 0.25 : 0.75;
    final defX = _attackerIsPlayer ? 0.75 : 0.25;

    if (t < 0.22) {
      final p = (t / 0.22).clamp(0.0, 1.0);
      _setAttacker(startX, _idle.lerp(_throwPose, p));
      _setDefender(_idle);
      _showProj = false;
    } else if (t < 0.55) {
      final p = ((t - 0.22) / 0.33).clamp(0.0, 1.0);
      _setAttacker(startX, _throwPose);
      _setDefender(_idle);
      _showProj = true;
      _projX = startX + (defX - startX) * Curves.easeIn.transform(p);
      _projY = 0.42 - math.sin(p * math.pi) * 0.1;
    } else if (t < 0.72) {
      final p = ((t - 0.55) / 0.17).clamp(0.0, 1.0);
      _setAttacker(startX, _throwPose.lerp(_idle, p));
      _showProj = false;
      if (_isDodged) {
        _setDefender(_idle.lerp(_dodge, (p * 2).clamp(0.0, 1.0)));
      } else {
        _setDefender(_idle.lerp(_hurt, (p * 2).clamp(0.0, 1.0)));
        _impactT = p;
      }
    } else {
      final p = ((t - 0.72) / 0.28).clamp(0.0, 1.0);
      _setAttacker(startX, _idle);
      final defPose = _isDodged ? _dodge : _hurt;
      _setDefender(defPose.lerp(_idle, Curves.easeOut.transform(p)));
      _impactT = -1;
      _showProj = false;
    }
  }

  // ── 回复 / 增益 ──

  void _updateHealBuff(double t) {
    _impactT = -1;
    _showProj = false;
    _playerPose = _idle;
    _enemyPose = _idle;
    _playerX = 0.25;
    _enemyX = 0.75;

    _glowOnPlayer = _attackerIsPlayer;
    _glowColor = actionColor(_actionType);
    _glowT = t < 0.15
        ? t / 0.15
        : t < 0.75
            ? 1.0
            : 1.0 - ((t - 0.75) / 0.25).clamp(0.0, 1.0);
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
      height: 160,
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
          glowOnPlayer: _glowOnPlayer,
          glowColor: _glowColor,
          weaponType: _isAnimating ? _actionType : null,
          weaponOnPlayer: _attackerIsPlayer,
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
  final bool glowOnPlayer;
  final Color glowColor;
  final BattleActionType? weaponType;
  final bool weaponOnPlayer;

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
    required this.glowOnPlayer,
    required this.glowColor,
    required this.weaponType,
    required this.weaponOnPlayer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawGround(canvas, size);

    if (glowT > 0) {
      final gx = (glowOnPlayer ? playerX : enemyX) * size.width;
      final gy = size.height * 0.72;
      _drawGlow(canvas, Offset(gx, gy), glowT, glowColor);
    }

    _drawFigure(canvas, size, playerX, playerPose, true,
        const Color(0xFFE8C36A), weaponOnPlayer ? weaponType : null);
    _drawFigure(canvas, size, enemyX, enemyPose, false,
        const Color(0xFFEF5350), !weaponOnPlayer ? weaponType : null);

    if (showProj) _drawProjectile(canvas, size);

    if (impactT >= 0 && !isDodged) {
      final defX = impactOnDefender ? playerX : enemyX;
      _drawImpact(
          canvas, Offset(defX * size.width, size.height * 0.55), impactT);
    }

    if (isCrit && impactT > 0.2 && !isDodged) {
      _drawFloatingText(canvas, size, '暴击!', impactOnDefender ? playerX : enemyX,
          const Color(0xFFFFD54F), 16);
    }

    if (isDodged && impactT >= 0) {
      _drawFloatingText(canvas, size, '闪避', impactOnDefender ? playerX : enemyX,
          Colors.white, 14);
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

  void _drawFigure(Canvas canvas, Size size, double normX, _Pose pose,
      bool facingRight, Color color, BattleActionType? weapon) {
    final groundY = size.height * 0.88;
    final s = size.height / 175; // 缩放因子
    final cx = size.width * normX;

    canvas.save();
    canvas.translate(cx, groundY);
    if (!facingRight) canvas.scale(-1, 1);

    // 骨骼参数
    const bodyLen = 24.0;
    const neckLen = 3.0;
    const headR = 9.0;
    const uArmLen = 13.0;
    const fArmLen = 11.0;
    const thighLen = 16.0;
    const shinLen = 14.0;
    const shoulderW = 7.0; // 肩宽（单侧）

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

    // 肩膀两端（用于让身体看起来有宽度）
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

    // 腿从臀部稍微分开
    final lHip = Offset(hip.dx - 3 * s, hip.dy);
    final rHip = Offset(hip.dx + 3 * s, hip.dy);
    final lKnee = limb(lHip, pose.ll1, thighLen);
    final lFoot = limb(lKnee, pose.ll2, shinLen);
    final rKnee = limb(rHip, pose.rl1, thighLen);
    final rFoot = limb(rKnee, pose.rl2, shinLen);

    // 画笔：粗壮风格
    final bodyPaint = Paint()
      ..color = color
      ..strokeWidth = 5.5 * s
      ..strokeCap = StrokeCap.round;

    final limbPaint = Paint()
      ..color = color
      ..strokeWidth = 4.0 * s
      ..strokeCap = StrokeCap.round;

    final jointPaint = Paint()..color = color;

    final darkColor = Color.lerp(color, Colors.black, 0.3)!;
    final outlinePaint = Paint()
      ..color = darkColor
      ..strokeWidth = 6.5 * s
      ..strokeCap = StrokeCap.round;

    final limbOutline = Paint()
      ..color = darkColor
      ..strokeWidth = 5.0 * s
      ..strokeCap = StrokeCap.round;

    // === 描边层（轮廓感）===
    // 身体
    canvas.drawLine(hip, shoulder, outlinePaint);
    canvas.drawLine(lShoulder, rShoulder, outlinePaint);
    // 腿
    canvas.drawLine(lHip, lKnee, limbOutline);
    canvas.drawLine(lKnee, lFoot, limbOutline);
    canvas.drawLine(rHip, rKnee, limbOutline);
    canvas.drawLine(rKnee, rFoot, limbOutline);
    // 臂
    canvas.drawLine(lShoulder, lElbow, limbOutline);
    canvas.drawLine(lElbow, lHand, limbOutline);
    canvas.drawLine(rShoulder, rElbow, limbOutline);
    canvas.drawLine(rElbow, rHand, limbOutline);

    // === 主色层 ===
    // 腿
    canvas.drawLine(lHip, lKnee, limbPaint);
    canvas.drawLine(lKnee, lFoot, limbPaint);
    canvas.drawLine(rHip, rKnee, limbPaint);
    canvas.drawLine(rKnee, rFoot, limbPaint);
    // 身体 + 肩
    canvas.drawLine(hip, shoulder, bodyPaint);
    canvas.drawLine(lShoulder, rShoulder, bodyPaint);
    // 臂
    canvas.drawLine(lShoulder, lElbow, limbPaint);
    canvas.drawLine(lElbow, lHand, limbPaint);
    canvas.drawLine(rShoulder, rElbow, limbPaint);
    canvas.drawLine(rElbow, rHand, limbPaint);

    // 关节圆点
    final jr = 2.8 * s;
    for (final pt in [lElbow, rElbow, lKnee, rKnee]) {
      canvas.drawCircle(pt, jr, jointPaint);
    }

    // 手（稍大的圆）
    final handR = 3.5 * s;
    canvas.drawCircle(lHand, handR, jointPaint);
    canvas.drawCircle(rHand, handR, jointPaint);

    // 脚（椭圆形）
    for (final ft in [lFoot, rFoot]) {
      canvas.drawOval(
        Rect.fromCenter(center: ft, width: 7 * s, height: 4 * s),
        jointPaint,
      );
    }

    // 头：填充 + 轮廓
    canvas.drawCircle(headC, headR * s,
        Paint()..color = Color.lerp(color, Colors.black, 0.15)!);
    canvas.drawCircle(headC, headR * s * 0.85, Paint()..color = color);
    // 眼睛的小点（面朝方向侧）
    final eyeOff = Offset(headR * s * 0.35, -headR * s * 0.15);
    canvas.drawCircle(
      Offset(headC.dx + eyeOff.dx, headC.dy + eyeOff.dy),
      1.8 * s,
      Paint()..color = darkColor,
    );

    // === 武器特效 ===
    if (weapon == BattleActionType.sword || weapon == BattleActionType.blade) {
      final wColor = actionColor(weapon!);
      final wLen = weapon == BattleActionType.sword ? 24.0 : 20.0;
      final wEnd = limb(rHand, pose.ra2, wLen);
      // 光晕
      canvas.drawLine(rHand, wEnd, Paint()
        ..color = wColor.withValues(alpha: 0.2)
        ..strokeWidth = 9 * s
        ..strokeCap = StrokeCap.round);
      // 刃
      canvas.drawLine(rHand, wEnd, Paint()
        ..color = wColor
        ..strokeWidth = 3.0 * s
        ..strokeCap = StrokeCap.round);
    }

    if (weapon == BattleActionType.palm) {
      final wc = actionColor(weapon!);
      canvas.drawCircle(rHand, 10 * s, Paint()..color = wc.withValues(alpha: 0.3));
      canvas.drawCircle(rHand, 5 * s, Paint()..color = wc.withValues(alpha: 0.6));
    }

    if (weapon == BattleActionType.fist) {
      final wc = actionColor(weapon!);
      canvas.drawCircle(rHand, 5 * s, Paint()..color = wc.withValues(alpha: 0.45));
    }

    if (weapon == BattleActionType.kick) {
      final wc = actionColor(weapon!);
      canvas.drawCircle(rFoot, 6 * s, Paint()..color = wc.withValues(alpha: 0.4));
    }

    canvas.restore();
  }

  // ── 冲击 ──

  void _drawImpact(Canvas canvas, Offset center, double t) {
    if (t < 0 || t > 1) return;
    final a = (1.0 - t).clamp(0.0, 1.0);
    final baseR = isCrit ? 20.0 : 14.0;
    final r = baseR + 35 * t;

    canvas.drawCircle(center, r,
        Paint()..color = impactColor.withValues(alpha: a * 0.35));
    canvas.drawCircle(center, r * 0.3,
        Paint()..color = Colors.white.withValues(alpha: a * 0.7));

    final lp = Paint()
      ..color = impactColor.withValues(alpha: a * 0.6)
      ..strokeWidth = isCrit ? 2.8 : 2.0
      ..strokeCap = StrokeCap.round;
    final n = isCrit ? 8 : 5;
    for (int i = 0; i < n; i++) {
      final ang = i * 2 * math.pi / n + t * 0.8;
      canvas.drawLine(
        Offset(center.dx + r * 0.4 * math.cos(ang),
            center.dy + r * 0.4 * math.sin(ang)),
        Offset(center.dx + r * 1.3 * math.cos(ang),
            center.dy + r * 1.3 * math.sin(ang)),
        lp,
      );
    }
  }

  // ── 浮动文字 ──

  void _drawFloatingText(Canvas canvas, Size size, String text,
      double defNormX, Color color, double fontSize) {
    final a = (1.0 - impactT).clamp(0.0, 1.0);
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(alpha: a),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: a * 0.6),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas,
        Offset(defNormX * size.width - tp.width / 2,
            size.height * 0.32 - 25 * impactT));
  }

  // ── 暗器 ──

  void _drawProjectile(Canvas canvas, Size size) {
    final px = projX * size.width;
    final py = projY * size.height;
    final path = Path()
      ..moveTo(px, py - 6)
      ..lineTo(px + 4, py)
      ..lineTo(px, py + 6)
      ..lineTo(px - 4, py)
      ..close();
    canvas.drawPath(path, Paint()..color = projColor);
    canvas.drawPath(path, Paint()
      ..color = projColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5));
  }

  // ── 光环 ──

  void _drawGlow(Canvas canvas, Offset center, double t, Color color) {
    final a = t.clamp(0.0, 1.0);
    final pulse = 1.0 + 0.15 * math.sin(t * math.pi * 4);
    final r = 30 * pulse;

    canvas.drawCircle(center, r, Paint()..color = color.withValues(alpha: a * 0.2));
    canvas.drawCircle(
        center, r * 0.5, Paint()..color = color.withValues(alpha: a * 0.35));

    if (t > 0.15 && t < 0.85) {
      final rng = math.Random(42);
      for (int i = 0; i < 5; i++) {
        final px = center.dx + (rng.nextDouble() - 0.5) * 28;
        final py = center.dy - 35 * ((t - 0.15) / 0.7) - rng.nextDouble() * 18;
        canvas.drawCircle(Offset(px, py), 3.0,
            Paint()..color = color.withValues(alpha: a * (0.4 + rng.nextDouble() * 0.3)));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ArenaPainter old) => true;
}

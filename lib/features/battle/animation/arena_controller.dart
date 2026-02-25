import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/battle_speed_settings.dart';
import 'arena_painter.dart';
import 'battle_fx.dart';
import 'battle_types.dart';
import 'hit_feedback.dart';
import 'particle_system.dart';
import 'pose.dart';
import 'pose_sequence.dart';
import 'timing.dart';

const double _playerHomeX = 0.24;
const double _enemyHomeX = 0.76;

class BattleArenaController {
  _BattleArenaState? _state;

  void _attach(_BattleArenaState state) => _state = state;

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
  final ParticleEmitter _particles = ParticleEmitter();
  final HitFeedbackState _hitFeedback = HitFeedbackState();
  final MotionBlurTrail _motionBlur = MotionBlurTrail();
  final SlashTrail _slashTrail = SlashTrail();
  final SecondaryMotionSet _secondaryMotion = SecondaryMotionSet();
  double _lastAnimValue = 0;
  bool _particlesEmitted = false;

  double _playerX = _playerHomeX;
  double _enemyX = _enemyHomeX;
  Pose _playerPose = idlePose;
  Pose _enemyPose = idlePose;

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

  double _impactT = -1;
  double _trailT = -1;
  double _auraT = -1;
  bool _auraOnPlayer = true;
  Color _auraColor = const Color(0xFF79E2A7);
  double _textT = -1;
  double _tagT = -1;

  bool _showProjectile = false;
  double _projX = 0;
  double _projY = 0;

  Completer<void>? _completer;

  BattleAnimationStyle get _style => BattleSpeedSettings.animationStyle;

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

    if (BattleSpeedSettings.skipAnimation) {
      _applySkipResult(
        isPlayer: isPlayer,
        type: type,
        crit: crit,
        dodged: dodged,
        damage: damage,
        healAmount: healAmount,
        defenderDefeated: defenderDefeated,
      );
      return;
    }

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
    _trailT = -1;
    _auraT = -1;
    _textT = -1;
    _tagT = -1;
    _showProjectile = false;
    _particles.clear();
    _particlesEmitted = false;
    _hitFeedback.reset();
    _motionBlur.clear();
    _slashTrail.clear();
    _secondaryMotion.reset();
    _lastAnimValue = 0;

    // 应用风格配置（运动模糊不需要风格配置）

    final baseDuration = switch (type) {
      BattleActionType.heal ||
      BattleActionType.buff => const Duration(milliseconds: 620),
      BattleActionType.hidden => const Duration(milliseconds: 760),
      BattleActionType.sword ||
      BattleActionType.blade => const Duration(milliseconds: 800),
      _ => const Duration(milliseconds: 700),
    };
    final durationScale = styleDurationFactor(_style);
    final styledDuration = Duration(
      milliseconds: (baseDuration.inMilliseconds * durationScale).round(),
    );
    _anim.duration = BattleSpeedSettings.adjustDuration(styledDuration);

    _completer = Completer<void>();
    _anim.forward(from: 0);
    await _completer!.future;
  }

  void _applySkipResult({
    required bool isPlayer,
    required BattleActionType type,
    required bool crit,
    required bool dodged,
    required int damage,
    required int healAmount,
    required bool defenderDefeated,
  }) {
    _attackerIsPlayer = isPlayer;
    _actionType = type;
    _isCrit = crit;
    _isDodged = dodged;
    _damageValue = damage;
    _healValue = healAmount;
    _defenderDefeated = defenderDefeated && !dodged;

    if (_defenderDefeated) {
      _playerDown = !isPlayer;
      _enemyDown = isPlayer;
    } else {
      _playerDown = false;
      _enemyDown = false;
    }

    if (mounted) {
      setState(() {
        _playerX = _playerHomeX;
        _enemyX = _enemyHomeX;
        _playerPose = idlePose;
        _enemyPose = idlePose;
      });
    }
  }

  void _tick() {
    final t = _anim.value;
    final dt = (t - _lastAnimValue).abs();
    _lastAnimValue = t;

    // 更新打击感（实时 dt）
    final realDt = dt * (_anim.duration?.inMilliseconds ?? 700) / 1000;
    _hitFeedback.update(realDt);

    // 顿帧期间暂停主动画，但粒子继续
    if (!_hitFeedback.isHitStop) {
      if (_actionType == BattleActionType.heal ||
          _actionType == BattleActionType.buff) {
        _updateSupport(t);
      } else if (_actionType == BattleActionType.hidden) {
        _updateRanged(t);
      } else {
        _updateMelee(t);
      }
    }

    // 更新次级运动
    _secondaryMotion.update(_attackerIsPlayer ? _playerPose : _enemyPose, realDt);

    // 粒子始终更新
    _particles.update(realDt);

    if (t >= 1.0) {
      _finishAction();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _finishAction() {
    _playerX = _playerHomeX;
    _enemyX = _enemyHomeX;

    if (_defenderDefeated) {
      _playerDown = !_attackerIsPlayer;
      _enemyDown = _attackerIsPlayer;
    } else {
      _playerDown = false;
      _enemyDown = false;
    }

    _playerPose = idlePose;
    _enemyPose = idlePose;
    _isAnimating = false;

    _impactT = -1;
    _trailT = -1;
    _auraT = -1;
    _textT = -1;
    _tagT = -1;
    _showProjectile = false;

    _completer?.complete();
    _completer = null;
  }

  void _updateMelee(double t) {
    _playerX = _playerHomeX;
    _enemyX = _enemyHomeX;

    _showProjectile = false;
    _auraT = -1;
    _auraColor = actionColor(_actionType);
    _auraOnPlayer = _attackerIsPlayer;

    final startX = _attackerIsPlayer ? _playerHomeX : _enemyHomeX;
    final contactX = contactXFor(_attackerIsPlayer, _actionType, _actionSkillId);
    final wuPose = windUpPoseOf(_actionType, _actionSkillId);
    final atkPose = attackPoseOf(_actionType, _actionSkillId);

    final mt = meleeTiming(_actionType, _style);
    final dashEnd = mt.dashEnd;
    final windEnd = mt.windEnd;
    final strikeEnd = mt.strikeEnd;
    final fxScale = styleFxScale(_style);
    final strikeCurve = meleeStrikeCurve(_actionType);

    if (t < dashEnd) {
      final p = (t / dashEnd).clamp(0.0, 1.0);
      final move = Curves.easeOutCubic.transform(p);
      final runBlend =
          (math.sin(p * math.pi * (_actionType == BattleActionType.kick ? 5 : 4)) + 1) / 2;

      final currentPose = dashPoseA.lerp(dashPoseB, runBlend);
      _setAttacker(mix(startX, contactX, move), currentPose);
      _setDefender(idlePose);

      // 冲刺时记录运动模糊轨迹
      final attackerX = _attackerIsPlayer ? _playerX : _enemyX;
      _motionBlur.record(attackerX, 0.54, t);

      _trailT = p;
      _impactT = -1;
      _textT = -1;
      _tagT = -1;
      return;
    }

    if (t < windEnd) {
      final p = ((t - dashEnd) / (windEnd - dashEnd)).clamp(0.0, 1.0);
      final eased = Curves.easeInOut.transform(p);

      _setAttacker(contactX, idlePose.lerp(wuPose, eased));
      _setDefender(idlePose);

      _trailT = -1;
      _impactT = -1;
      _textT = -1;
      _tagT = -1;
      if (p > 0.40) {
        final aura = (p - 0.40) / 0.60;
        _auraT = (aura * (0.8 + fxScale * 0.2)).clamp(0.0, 1.0);
      }
      return;
    }

    if (t < strikeEnd) {
      final p = ((t - windEnd) / (strikeEnd - windEnd)).clamp(0.0, 1.0);
      final eased = strikeCurve.transform(p);
      final attackerBackDir = _attackerIsPlayer ? -1.0 : 1.0;

      if (_isDodged) {
        if (p < 0.42) {
          final dp = (p / 0.42).clamp(0.0, 1.0);
          _setAttacker(contactX, wuPose.lerp(atkPose, eased));
          final dodgeP = Curves.easeOutBack.transform((dp * 1.1).clamp(0.0, 1.0));
          _setDefender(idlePose.lerp(dodgePose, dodgeP));
          final dodgeShift = math.sin(dp * math.pi) * (0.024 + 0.008 * fxScale);
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + dodgeShift;
          } else {
            _playerX = _playerHomeX - dodgeShift;
          }
          _trailT = ((1.0 - dp * 0.25) * fxScale).clamp(0.0, 1.0);
        } else {
          final dp = ((p - 0.42) / 0.58).clamp(0.0, 1.0);
          final recoilX = contactX + attackerBackDir * 0.012 * dp;
          _setAttacker(
            recoilX,
            atkPose.lerp(idlePose, Curves.easeOut.transform(dp * 0.45)),
          );
          _setDefender(
            dodgePose.lerp(idlePose, Curves.easeOut.transform(dp * 0.35)),
          );
          _trailT = ((0.75 - dp * 0.35) * fxScale).clamp(0.0, 1.0);
        }
        _impactT = -1;
        _textT = -1;
        _tagT = p;
      } else {
        final baseKnock = meleeKnock(_actionType, _defenderDefeated, _style);
        if (p < 0.30) {
          final hp = (p / 0.30).clamp(0.0, 1.0);
          final snap = Curves.easeOutQuart.transform(hp);
          _setAttacker(contactX, wuPose.lerp(atkPose, snap));
          _setDefender(
            idlePose.lerp(hurtPose, ((hp - 0.55) / 0.45).clamp(0.0, 1.0)),
          );
          _impactT = hp * 0.18;
          _emitHitParticles();

          // 触发斩击轨迹（剑/刀类武器）
          if (_actionType == BattleActionType.sword || _actionType == BattleActionType.blade) {
            final attackerX = (_attackerIsPlayer ? _playerX : _enemyX);
            final defenderX = (_attackerIsPlayer ? _enemyX : _playerX);
            final centerX = (attackerX + defenderX) / 2;
            _slashTrail.trigger(
              time: t,
              cx: centerX,
              cy: 0.54,
              r: 0.15,
              start: _attackerIsPlayer ? -math.pi * 0.3 : math.pi * 0.7,
              end: _attackerIsPlayer ? math.pi * 0.3 : math.pi * 1.3,
              c: actionColor(_actionType),
              weapon: _actionType,
            );
          }

          _trailT = ((1.0 - hp * 0.2) * fxScale).clamp(0.0, 1.0);
          _textT = -1;
          _tagT = -1;
        } else if (p < 0.52) {
          final hp = ((p - 0.30) / 0.22).clamp(0.0, 1.0);
          final holdPulse = math.sin(hp * math.pi);
          final recoilX = contactX + attackerBackDir * 0.007 * holdPulse;
          _setAttacker(recoilX, atkPose);
          final defenderKnock = baseKnock * (0.20 + hp * 0.12);
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + defenderKnock;
          } else {
            _playerX = _playerHomeX - defenderKnock;
          }
          _setDefender(hurtPose);
          _impactT = 0.18 + hp * 0.24;
          _trailT = ((0.88 - hp * 0.30) * fxScale).clamp(0.0, 1.0);
          _textT = hp * 0.25;
          _tagT = _isCrit ? hp * 0.2 : -1;
        } else {
          final hp = ((p - 0.52) / 0.48).clamp(0.0, 1.0);
          final recoil = Curves.easeOutCubic.transform(hp);
          final recoilX =
              contactX +
              attackerBackDir * 0.015 * (1.0 - (hp - 0.15).abs() * 1.7).clamp(0.0, 1.0);
          _setAttacker(
            recoilX,
            atkPose.lerp(idlePose, (recoil * 0.45).clamp(0.0, 1.0)),
          );
          final defenderKnock = math.sin(hp * math.pi) * baseKnock * 1.25;
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + defenderKnock;
          } else {
            _playerX = _playerHomeX - defenderKnock;
          }
          if (_defenderDefeated) {
            _setDefender(hurtPose.lerp(dodgePose, Curves.easeIn.transform(hp)));
          } else {
            _setDefender(hurtPose);
          }
          _impactT = 0.42 + hp * 0.58;
          _trailT = ((0.62 - hp * 0.42) * fxScale).clamp(0.0, 1.0);
          _textT = hp;
          _tagT = _isCrit ? hp : -1;
        }
      }
      return;
    }

    // 返回阶段
    final p = ((t - strikeEnd) / (1.0 - strikeEnd)).clamp(0.0, 1.0);
    final eased = Curves.easeOutCubic.transform(p);

    _setAttacker(mix(contactX, startX, eased), atkPose.lerp(idlePose, eased));

    if (_defenderDefeated && !_isDodged) {
      _setDefender(dodgePose);
    } else {
      final fromPose = _isDodged ? dodgePose : hurtPose;
      _setDefender(fromPose.lerp(idlePose, eased));
    }

    _impactT = -1;
    _trailT = -1;
    _auraT = -1;
    _textT = _textT < 0 ? -1 : 1 + p;
    _tagT = _tagT < 0 ? -1 : 1 + p;
  }

  void _updateRanged(double t) {
    _playerX = _playerHomeX;
    _enemyX = _enemyHomeX;

    _auraOnPlayer = _attackerIsPlayer;
    _auraColor = actionColor(_actionType);

    final startX = _attackerIsPlayer ? _playerHomeX : _enemyHomeX;
    final defenderX = _attackerIsPlayer ? _enemyHomeX : _playerHomeX;
    final wuPose = windUpPoseOf(_actionType, _actionSkillId);
    final tPose = attackPoseOf(_actionType, _actionSkillId);

    final seed = skillSeed(_actionSkillId, _actionType, false);
    final arc = 0.10 + seedNorm(seed, 8) * 0.06;
    final drift = (seedNorm(seed, 14) - 0.5) * 0.03;
    final rt = rangedTiming(_style);
    final fxScale = styleFxScale(_style);

    if (t < rt.prepareEnd) {
      final p = (t / rt.prepareEnd).clamp(0.0, 1.0);
      final eased = Curves.easeInOut.transform(p);

      _setAttacker(startX, idlePose.lerp(wuPose, eased));
      _setDefender(idlePose);

      _showProjectile = false;
      _trailT = -1;
      _impactT = -1;
      _textT = -1;
      _tagT = -1;
      _auraT = p > 0.50 ? (p - 0.50) / 0.50 : -1;
      return;
    }

    if (t < rt.flightEnd) {
      final p = ((t - rt.prepareEnd) / (rt.flightEnd - rt.prepareEnd)).clamp(0.0, 1.0);
      final eased = (_style == BattleAnimationStyle.cinematic)
          ? Curves.easeInOutCubic.transform(p)
          : (_style == BattleAnimationStyle.jianghu)
          ? Curves.easeOut.transform(p)
          : Curves.easeInCubic.transform(p);

      _setAttacker(startX, tPose);
      _setDefender(idlePose);

      _showProjectile = true;
      _projX = mix(startX, defenderX, eased);
      _projY = 0.45 - math.sin(p * math.pi) * arc * (0.8 + fxScale * 0.2) + drift;

      _trailT = p;
      _impactT = -1;
      _textT = -1;
      _tagT = -1;
      _auraT = 1.0 - p;
      return;
    }

    if (t < rt.impactEnd) {
      final p = ((t - rt.flightEnd) / (rt.impactEnd - rt.flightEnd)).clamp(0.0, 1.0);
      final eased = Curves.easeOut.transform(p);
      final attackerBackDir = _attackerIsPlayer ? -1.0 : 1.0;

      _setAttacker(startX, tPose.lerp(idlePose, eased));
      _showProjectile = false;
      _trailT = -1;
      _auraT = -1;

      if (_isDodged) {
        final dodgeP = Curves.easeOutBack.transform((p * 1.2).clamp(0.0, 1.0));
        _setDefender(idlePose.lerp(dodgePose, dodgeP));
        final dodgeShift = math.sin(p * math.pi) * (0.022 + 0.008 * fxScale);
        if (_attackerIsPlayer) {
          _enemyX = _enemyHomeX + dodgeShift;
        } else {
          _playerX = _playerHomeX - dodgeShift;
        }
        _impactT = -1;
        _textT = -1;
        _tagT = p;
      } else {
        final baseKnock =
            (_defenderDefeated ? 0.06 : 0.04) *
            switch (_style) {
              BattleAnimationStyle.jianghu => 1.1,
              BattleAnimationStyle.minimal => 0.75,
              BattleAnimationStyle.energetic => 1.25,
              BattleAnimationStyle.cinematic => 1.1,
              _ => 1.0,
            };
        if (p < 0.34) {
          final hp = (p / 0.34).clamp(0.0, 1.0);
          final snap = Curves.easeOutQuart.transform(hp);
          _setAttacker(
            startX + attackerBackDir * 0.004 * hp,
            tPose.lerp(idlePose, snap * 0.35),
          );
          final knock = baseKnock * hp * 0.25;
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + knock;
          } else {
            _playerX = _playerHomeX - knock;
          }
          _setDefender(idlePose.lerp(hurtPose, Curves.easeOutBack.transform(hp)));
          _impactT = hp * 0.22;
          _emitHitParticles();
          _textT = -1;
          _tagT = _isCrit ? hp * 0.15 : -1;
        } else if (p < 0.58) {
          final hp = ((p - 0.34) / 0.24).clamp(0.0, 1.0);
          _setAttacker(
            startX + attackerBackDir * 0.006 * math.sin(hp * math.pi),
            tPose.lerp(idlePose, 0.40),
          );
          final knock = baseKnock * (0.28 + hp * 0.10);
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + knock;
          } else {
            _playerX = _playerHomeX - knock;
          }
          _setDefender(hurtPose);
          _impactT = 0.22 + hp * 0.22;
          _textT = hp * 0.22;
          _tagT = _isCrit ? hp * 0.3 : -1;
        } else {
          final hp = ((p - 0.58) / 0.42).clamp(0.0, 1.0);
          _setAttacker(
            startX,
            tPose.lerp(idlePose, Curves.easeOut.transform(0.40 + hp * 0.60)),
          );
          final knock = math.sin(hp * math.pi) * baseKnock * 1.18;
          if (_attackerIsPlayer) {
            _enemyX = _enemyHomeX + knock;
          } else {
            _playerX = _playerHomeX - knock;
          }
          if (_defenderDefeated) {
            _setDefender(hurtPose.lerp(dodgePose, Curves.easeIn.transform(hp)));
          } else {
            _setDefender(hurtPose);
          }
          _impactT = 0.44 + hp * 0.56;
          _textT = hp;
          _tagT = _isCrit ? hp : -1;
        }
      }
      return;
    }

    // 返回阶段
    final p = ((t - rt.impactEnd) / (1.0 - rt.impactEnd)).clamp(0.0, 1.0);
    final eased = Curves.easeOutCubic.transform(p);

    _setAttacker(startX, idlePose);

    if (_defenderDefeated && !_isDodged) {
      _setDefender(dodgePose);
    } else {
      final fromPose = _isDodged ? dodgePose : hurtPose;
      _setDefender(fromPose.lerp(idlePose, eased));
    }

    _impactT = -1;
    _textT = _textT < 0 ? -1 : 1 + p;
    _tagT = _tagT < 0 ? -1 : 1 + p;
  }

  void _updateSupport(double t) {
    _playerX = _playerHomeX;
    _enemyX = _enemyHomeX;

    final pose = supportPoseOf(_actionType, _actionSkillId);
    final pulseBase = math.sin(t * math.pi).clamp(0.0, 1.0);
    final pulse = switch (_style) {
      BattleAnimationStyle.jianghu => Curves.easeOut.transform(pulseBase),
      BattleAnimationStyle.cinematic => Curves.easeInOut.transform(pulseBase),
      BattleAnimationStyle.swift => Curves.easeOut.transform(pulseBase),
      BattleAnimationStyle.minimal => Curves.linear.transform(pulseBase),
      BattleAnimationStyle.energetic => Curves.easeOutBack.transform(
        (pulseBase * 0.95).clamp(0.0, 1.0),
      ),
      BattleAnimationStyle.classic => pulseBase,
    };
    final blend = Curves.easeInOut.transform(pulse);

    _setAttacker(
      _attackerIsPlayer ? _playerHomeX : _enemyHomeX,
      idlePose.lerp(pose, blend),
    );
    _setDefender(idlePose);

    _showProjectile = false;
    _impactT = -1;
    _trailT = -1;
    _tagT = -1;

    _auraOnPlayer = _attackerIsPlayer;
    _auraColor = supportGlowColor(_actionSkillId, _actionType);
    _auraT = pulse;

    final textStart =
        (_style == BattleAnimationStyle.swift || _style == BattleAnimationStyle.jianghu)
        ? 0.14
        : 0.18;
    _textT = t > textStart ? ((t - textStart) / (1 - textStart)) * 2.0 : -1;
  }

  void _emitHitParticles() {
    if (_particlesEmitted || _isDodged) return;
    _particlesEmitted = true;
    // 用归一化坐标存储，painter 绘制时转换为实际像素
    final defX = _attackerIsPlayer ? _enemyX : _playerX;
    final defY = 0.54;
    final direction = _attackerIsPlayer ? 0.0 : math.pi;

    // 获取风格配置
    final styleConfig = StyleConfig.forStyle(_style);

    if (_isCrit) {
      _particles.emit(defX, defY, ParticleConfig.critExplosion);
      _hitFeedback.trigger(
        HitFeedbackConfig.critical.withStyleScale(
          styleConfig.hitStopScale,
          styleConfig.shakeScale,
        ),
      );
    } else {
      _particles.emit(defX, defY, ParticleConfig.hitSparks, direction: direction);
      _hitFeedback.trigger(
        HitFeedbackConfig.normal.withStyleScale(
          styleConfig.hitStopScale,
          styleConfig.shakeScale,
        ),
      );
    }
  }

  void _setAttacker(double x, Pose pose) {
    if (_attackerIsPlayer) {
      _playerX = x;
      _playerPose = pose;
    } else {
      _enemyX = x;
      _enemyPose = pose;
    }
  }

  void _setDefender(Pose pose) {
    if (_attackerIsPlayer) {
      _enemyPose = pose;
    } else {
      _playerPose = pose;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_hitFeedback.shakeX, _hitFeedback.shakeY),
      child: SizedBox(
        height: widget.height,
        child: CustomPaint(
          size: Size.infinite,
          painter: ArenaPainter(
            style: _style,
            playerX: _playerX,
            enemyX: _enemyX,
            playerPose: _playerPose,
            enemyPose: _enemyPose,
            playerDown: _playerDown,
            enemyDown: _enemyDown,
            playerIdleWeaponType: widget.idlePlayerWeaponType,
            weaponType: _isAnimating ? _actionType : widget.idlePlayerWeaponType,
            weaponOnPlayer: _isAnimating ? _attackerIsPlayer : true,
            attackerIsPlayer: _attackerIsPlayer,
            impactT: _impactT,
            trailT: _trailT,
            trailColor: actionColor(_actionType),
            auraT: _auraT,
            auraOnPlayer: _auraOnPlayer,
            auraColor: _auraColor,
            showProjectile: _showProjectile,
            projX: _projX,
            projY: _projY,
            projColor: actionColor(_actionType),
            textT: _textT,
            tagT: _tagT,
            isCrit: _isCrit,
            isDodged: _isDodged,
            damageValue: _damageValue,
            healValue: _healValue,
            particleEmitter: _particles,
            flashAlpha: _hitFeedback.flashAlpha,
            motionBlur: _motionBlur,
            slashTrail: _slashTrail,
            currentTime: _anim.value,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/animation.dart';

import 'pose.dart';

// ── 姿势关键帧 ──

class PoseKeyframe {
  final double time; // 0.0 ~ 1.0
  final Pose pose;
  final Curve curve;

  const PoseKeyframe({
    required this.time,
    required this.pose,
    this.curve = Curves.linear,
  });
}

// ── 姿势序列 ──

class PoseSequence {
  final List<PoseKeyframe> keyframes;

  const PoseSequence(this.keyframes);

  Pose evaluate(double t) {
    if (keyframes.isEmpty) return idlePose;
    if (keyframes.length == 1) return keyframes[0].pose;

    final clamped = t.clamp(0.0, 1.0);

    // 找到当前时间所在的关键帧区间
    int startIdx = 0;
    for (int i = 0; i < keyframes.length - 1; i++) {
      if (clamped >= keyframes[i].time && clamped <= keyframes[i + 1].time) {
        startIdx = i;
        break;
      }
    }

    final start = keyframes[startIdx];
    final end = keyframes[startIdx + 1];

    // 计算区间内的归一化进度
    final segmentDuration = end.time - start.time;
    if (segmentDuration <= 0) return start.pose;

    final segmentProgress = ((clamped - start.time) / segmentDuration).clamp(0.0, 1.0);
    final easedProgress = end.curve.transform(segmentProgress);

    return start.pose.lerp(end.pose, easedProgress);
  }

  // 预定义序列

  // 冲刺序列（3 关键帧）
  static final dash = PoseSequence([
    PoseKeyframe(time: 0.0, pose: idlePose, curve: Curves.easeOut),
    PoseKeyframe(time: 0.3, pose: dashPoseA, curve: Curves.linear),
    PoseKeyframe(time: 0.7, pose: dashPoseB, curve: Curves.easeIn),
    PoseKeyframe(time: 1.0, pose: dashPoseA),
  ]);

  // 出拳序列（4 关键帧，带预备和收招）
  static final fistStrike = PoseSequence([
    PoseKeyframe(time: 0.0, pose: idlePose, curve: Curves.easeInOut),
    PoseKeyframe(time: 0.25, pose: windUpPose, curve: Curves.easeIn),
    PoseKeyframe(time: 0.35, pose: windUpPose, curve: Curves.easeOutQuart),
    PoseKeyframe(time: 0.50, pose: fistStrikePose, curve: Curves.easeOut),
    PoseKeyframe(time: 1.0, pose: idlePose),
  ]);

  // 闪避序列（快速侧移）
  static final dodge = PoseSequence([
    PoseKeyframe(time: 0.0, pose: idlePose, curve: Curves.easeOutBack),
    PoseKeyframe(time: 0.4, pose: dodgePose, curve: Curves.easeInOut),
    PoseKeyframe(time: 0.7, pose: dodgePose, curve: Curves.easeOut),
    PoseKeyframe(time: 1.0, pose: idlePose),
  ]);

  // 受击序列（带反弹）
  static final hurt = PoseSequence([
    PoseKeyframe(time: 0.0, pose: idlePose, curve: Curves.easeOutQuart),
    PoseKeyframe(time: 0.2, pose: hurtPose, curve: Curves.linear),
    PoseKeyframe(time: 0.6, pose: hurtPose, curve: Curves.easeOut),
    PoseKeyframe(time: 1.0, pose: idlePose),
  ]);
}

// ── 次级运动系统 ──

class SecondaryMotion {
  double _position = 0;
  double _velocity = 0;

  // 弹簧阻尼参数
  static const double _stiffness = 180.0; // 刚度
  static const double _damping = 12.0; // 阻尼

  void update(double target, double dt) {
    final displacement = target - _position;
    final springForce = displacement * _stiffness;
    final dampingForce = -_velocity * _damping;
    final acceleration = springForce + dampingForce;

    _velocity += acceleration * dt;
    _position += _velocity * dt;

    // 防止过冲
    if (displacement.abs() < 0.001 && _velocity.abs() < 0.01) {
      _position = target;
      _velocity = 0;
    }
  }

  double get value => _position;

  void reset([double initialValue = 0]) {
    _position = initialValue;
    _velocity = 0;
  }
}

// ── 次级运动容器 ──

class SecondaryMotionSet {
  final SecondaryMotion headTilt = SecondaryMotion();
  final SecondaryMotion sashSwing = SecondaryMotion();
  final SecondaryMotion hairBounce = SecondaryMotion();

  void update(Pose targetPose, double dt) {
    // 头部倾斜跟随身体倾斜
    headTilt.update(targetPose.bodyLean * 0.3, dt);

    // 腰带摆动跟随腿部运动
    final legMotion = (targetPose.lHip + targetPose.rHip) * 0.5;
    sashSwing.update(legMotion * 0.2, dt);

    // 发髻弹跳跟随躯干抬升
    hairBounce.update(targetPose.torsoLift * 0.5, dt);
  }

  void reset() {
    headTilt.reset();
    sashSwing.reset();
    hairBounce.reset();
  }
}

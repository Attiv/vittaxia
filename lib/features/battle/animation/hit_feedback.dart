import 'dart:math' as math;

// ── 打击感配置 ──

class HitFeedbackConfig {
  final Duration hitStopDuration;
  final double shakeAmplitude;
  final double flashAlpha;
  final double timeScale;
  final Duration timeScaleDuration;

  const HitFeedbackConfig({
    required this.hitStopDuration,
    required this.shakeAmplitude,
    this.flashAlpha = 0,
    this.timeScale = 1.0,
    this.timeScaleDuration = Duration.zero,
  });

  // 普通命中
  static const normal = HitFeedbackConfig(
    hitStopDuration: Duration.zero, // removed hit-stop for smoothness
    shakeAmplitude: 2.0,
  );

  // 暴击
  static const critical = HitFeedbackConfig(
    hitStopDuration: Duration.zero, // removed hit-stop for smoothness
    shakeAmplitude: 4.0,
    flashAlpha: 0.0, // removed flash
    timeScale: 1.0, // removed slow-mo for smoothness
    timeScaleDuration: Duration.zero,
  );

  // 应用风格系数
  HitFeedbackConfig withStyleScale(double hitStopScale, double shakeScale) {
    return HitFeedbackConfig(
      hitStopDuration: Duration(
        milliseconds: (hitStopDuration.inMilliseconds * hitStopScale).round(),
      ),
      shakeAmplitude: shakeAmplitude * shakeScale,
      flashAlpha: flashAlpha,
      timeScale: timeScale,
      timeScaleDuration: timeScaleDuration,
    );
  }
}

// ── 打击感状态 ──

class HitFeedbackState {
  bool _isHitStop = false;
  double _hitStopRemaining = 0;
  double _shakeX = 0;
  double _shakeY = 0;
  double _flashAlpha = 0;
  double _timeScale = 1.0;
  double _timeScaleProgress = 0;
  HitFeedbackConfig? _activeConfig;

  final _rng = math.Random();

  bool get isHitStop => _isHitStop;
  double get shakeX => _shakeX;
  double get shakeY => _shakeY;
  double get flashAlpha => _flashAlpha;
  double get timeScale => _timeScale;

  void trigger(HitFeedbackConfig config) {
    _activeConfig = config;
    _isHitStop = true;
    _hitStopRemaining = config.hitStopDuration.inMilliseconds / 1000.0;
    _flashAlpha = config.flashAlpha;
    _timeScale = config.timeScale;
    _timeScaleProgress = 0;
    _updateShake(config.shakeAmplitude);
  }

  void update(double dt) {
    // 顿帧倒计时
    if (_isHitStop) {
      _hitStopRemaining -= dt;
      if (_hitStopRemaining <= 0) {
        _isHitStop = false;
        _hitStopRemaining = 0;
      }
      // 顿帧期间持续震屏
      if (_activeConfig != null) {
        _updateShake(_activeConfig!.shakeAmplitude);
      }
    } else {
      // 顿帧结束后震屏衰减
      _shakeX *= 0.85;
      _shakeY *= 0.85;
      if (_shakeX.abs() < 0.1) _shakeX = 0;
      if (_shakeY.abs() < 0.1) _shakeY = 0;
    }

    // 闪白衰减
    if (_flashAlpha > 0) {
      _flashAlpha -= dt * 3.0;
      if (_flashAlpha < 0) _flashAlpha = 0;
    }

    // 时间膨胀恢复
    if (_activeConfig != null && _timeScale < 1.0) {
      final duration = _activeConfig!.timeScaleDuration.inMilliseconds / 1000.0;
      _timeScaleProgress += dt;
      if (_timeScaleProgress >= duration) {
        _timeScale = 1.0;
        _timeScaleProgress = 0;
        _activeConfig = null;
      } else {
        final t = (_timeScaleProgress / duration).clamp(0.0, 1.0);
        _timeScale = _activeConfig!.timeScale + (1.0 - _activeConfig!.timeScale) * t;
      }
    }
  }

  void _updateShake(double amplitude) {
    _shakeX = (_rng.nextDouble() - 0.5) * 2 * amplitude;
    _shakeY = (_rng.nextDouble() - 0.5) * 2 * amplitude;
  }

  void reset() {
    _isHitStop = false;
    _hitStopRemaining = 0;
    _shakeX = 0;
    _shakeY = 0;
    _flashAlpha = 0;
    _timeScale = 1.0;
    _timeScaleProgress = 0;
    _activeConfig = null;
  }
}

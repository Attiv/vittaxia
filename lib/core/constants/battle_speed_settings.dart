/// 战斗动画速度设置
class BattleSpeedSettings {
  /// 动画速度倍率 (1.0 = 正常, 2.0 = 2倍速, 0 = 跳过)
  static double animationSpeed = 1.0;

  /// 是否跳过动画
  static bool get skipAnimation => animationSpeed == 0;

  /// 设置速度模式
  static void setSpeed(BattleSpeed speed) {
    switch (speed) {
      case BattleSpeed.normal:
        animationSpeed = 1.0;
        break;
      case BattleSpeed.fast:
        animationSpeed = 2.0;
        break;
      case BattleSpeed.skip:
        animationSpeed = 0;
        break;
    }
  }

  /// 获取当前速度模式
  static BattleSpeed get currentSpeed {
    if (animationSpeed == 0) return BattleSpeed.skip;
    if (animationSpeed >= 2.0) return BattleSpeed.fast;
    return BattleSpeed.normal;
  }

  /// 根据倍率计算实际动画时长
  static Duration adjustDuration(Duration original) {
    if (skipAnimation) return Duration.zero;
    return Duration(
      milliseconds: (original.inMilliseconds / animationSpeed).round(),
    );
  }
}

/// 战斗速度枚举
enum BattleSpeed {
  normal, // 1x
  fast, // 2x
  skip, // 跳过
}

extension BattleSpeedExtension on BattleSpeed {
  String get label {
    switch (this) {
      case BattleSpeed.normal:
        return '1x';
      case BattleSpeed.fast:
        return '2x';
      case BattleSpeed.skip:
        return '跳过';
    }
  }
}

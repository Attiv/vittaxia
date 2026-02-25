import 'package:shared_preferences/shared_preferences.dart';

/// 战斗动画速度设置
class BattleSpeedSettings {
  BattleSpeedSettings._();

  static const _animStyleKey = 'settings.battle_animation_style';

  /// 动画速度倍率 (1.0 = 正常, 2.0 = 2倍速, 0 = 跳过)
  static double animationSpeed = 1.0;

  /// 自动战斗开关（全局设置）
  static bool autoEnabled = false;

  /// 战斗动画风格
  static BattleAnimationStyle animationStyle = BattleAnimationStyle.jianghu;

  static bool _styleInitialized = false;

  /// 初始化动画风格
  static Future<void> ensureInitialized() async {
    if (_styleInitialized) return;
    final prefs = await SharedPreferences.getInstance();
    final styleId = prefs.getString(_animStyleKey);
    if (styleId != null) {
      animationStyle =
          BattleAnimationStyleX.fromId(styleId) ?? BattleAnimationStyle.jianghu;
    }
    _styleInitialized = true;
  }

  /// 设置动画风格（立即生效）
  static void setAnimationStyle(BattleAnimationStyle style) {
    animationStyle = style;
    _styleInitialized = true;
    _persistAnimationStyle(style);
  }

  static Future<void> _persistAnimationStyle(BattleAnimationStyle style) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_animStyleKey, style.id);
  }

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

/// 战斗动画风格
enum BattleAnimationStyle {
  jianghu,
  cinematic,
  swift,
  minimal,
  energetic,
  classic,
}

const battleAnimationStyleOrder = <BattleAnimationStyle>[
  BattleAnimationStyle.jianghu,
  BattleAnimationStyle.cinematic,
  BattleAnimationStyle.swift,
  BattleAnimationStyle.minimal,
  BattleAnimationStyle.energetic,
  BattleAnimationStyle.classic,
];

extension BattleAnimationStyleX on BattleAnimationStyle {
  String get id {
    switch (this) {
      case BattleAnimationStyle.jianghu:
        return 'jianghu';
      case BattleAnimationStyle.cinematic:
        return 'cinematic';
      case BattleAnimationStyle.swift:
        return 'swift';
      case BattleAnimationStyle.minimal:
        return 'minimal';
      case BattleAnimationStyle.energetic:
        return 'energetic';
      case BattleAnimationStyle.classic:
        return 'classic';
    }
  }

  String get label {
    switch (this) {
      case BattleAnimationStyle.jianghu:
        return '江湖';
      case BattleAnimationStyle.cinematic:
        return '电影感';
      case BattleAnimationStyle.swift:
        return '凌厉';
      case BattleAnimationStyle.minimal:
        return '极简';
      case BattleAnimationStyle.energetic:
        return '豪放';
      case BattleAnimationStyle.classic:
        return '经典';
    }
  }

  String get subtitle {
    switch (this) {
      case BattleAnimationStyle.jianghu:
        return '小体量，重打击，近似放置江湖';
      case BattleAnimationStyle.cinematic:
        return '更强调蓄势与冲击';
      case BattleAnimationStyle.swift:
        return '节奏更快，反馈直接';
      case BattleAnimationStyle.minimal:
        return '特效克制，干净清爽';
      case BattleAnimationStyle.energetic:
        return '特效更强，打击更猛';
      case BattleAnimationStyle.classic:
        return '均衡表现，稳定耐看';
    }
  }

  static BattleAnimationStyle? fromId(String id) {
    for (final style in BattleAnimationStyle.values) {
      if (style.id == id) return style;
    }
    return null;
  }
}

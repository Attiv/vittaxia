import '../../core/constants/game_constants.dart';

/// 离线收益计算结果
class IdleReward {
  final int exp;
  final int silver;
  final Map<String, int> items;
  final int minutesIdle;
  final bool wasCapped;

  IdleReward({
    required this.exp,
    required this.silver,
    required this.items,
    required this.minutesIdle,
    required this.wasCapped,
  });

  bool get hasAny => exp > 0 || silver > 0 || items.isNotEmpty;
}

/// 挂机收益计算器
class IdleCalculator {
  /// 计算离线收益
  /// [comprehension] 悟性值
  /// [lastOnline] 上次在线时间
  static IdleReward calculate({
    required int comprehension,
    required DateTime lastOnline,
  }) {
    final now = DateTime.now();
    var diff = now.difference(lastOnline);

    // 上限 12 小时
    final maxDuration = Duration(hours: GameConstants.maxIdleHours);
    final wasCapped = diff > maxDuration;
    if (wasCapped) diff = maxDuration;

    final minutes = diff.inMinutes;
    if (minutes <= 0) {
      return IdleReward(
        exp: 0,
        silver: 0,
        items: const {},
        minutesIdle: 0,
        wasCapped: false,
      );
    }

    // 经验 = 悟性 × 0.3 × 分钟数
    final exp = (comprehension * GameConstants.idleExpMultiplier * minutes)
        .round();
    final silver =
        (comprehension * GameConstants.idleSilverMultiplier * minutes).round();
    final items = _calcIdleItems(
      minutes: minutes,
      comprehension: comprehension,
    );

    return IdleReward(
      exp: exp,
      silver: silver,
      items: items,
      minutesIdle: minutes,
      wasCapped: wasCapped,
    );
  }

  static Map<String, int> _calcIdleItems({
    required int minutes,
    required int comprehension,
  }) {
    final rewards = <String, int>{};

    // 基础补给：每 4 小时获得 1 粗铁矿，每 6 小时获得 1 金创药。
    final roughIron = minutes ~/ 240;
    if (roughIron > 0) {
      rewards['rough_iron'] = roughIron;
    }

    final healingPill = minutes ~/ 360;
    if (healingPill > 0) {
      rewards['healing_pill'] = healingPill;
    }

    // 高悟性额外收益：8 小时以上可稳定带回 1 精铁矿。
    if (comprehension >= 18 && minutes >= 480) {
      rewards['fine_iron'] = 1;
    }

    return rewards;
  }

  /// 格式化时间
  static String formatDuration(int minutes) {
    if (minutes < 60) return '$minutes分钟';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '$hours小时';
    return '$hours小时$mins分钟';
  }
}

import '../../core/constants/game_constants.dart';

/// 离线收益计算结果
class IdleReward {
  final int exp;
  final int minutesIdle;
  final bool wasCapped;

  IdleReward({required this.exp, required this.minutesIdle, required this.wasCapped});
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
      return IdleReward(exp: 0, minutesIdle: 0, wasCapped: false);
    }

    // 经验 = 悟性 × 0.5 × 分钟数
    final exp = (comprehension * GameConstants.idleExpMultiplier * minutes).round();

    return IdleReward(
      exp: exp,
      minutesIdle: minutes,
      wasCapped: wasCapped,
    );
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

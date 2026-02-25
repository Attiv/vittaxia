import 'dart:math';

import '../../models/cultivation.dart';
import '../../models/enums.dart';

/// 修炼收益计算器
class CultivationCalculator {
  static final _random = Random();

  /// 计算打坐修炼收益
  static Map<String, dynamic> calculateMeditation({
    required int comprehension,
    required RealmTier realmTier,
    required int durationMinutes,
  }) {
    // 基础经验 = 悟性 × 境界系数 × 时长
    final realmMultiplier = 1.0 + (realmTier.rank * 0.2);
    final baseExp = (comprehension * realmMultiplier * durationMinutes * 0.5).round();

    // 随机波动 ±20%
    final variance = baseExp * 0.2;
    final exp = (baseExp + (_random.nextDouble() * variance * 2 - variance)).round();

    // 有概率获得突破材料
    final items = <String, int>{};
    if (durationMinutes >= 120 && _random.nextDouble() < 0.3) {
      items['spirit_pill'] = 1;
    }
    if (durationMinutes >= 240 && _random.nextDouble() < 0.15) {
      items['bixin_herb'] = 1;
    }

    return {
      'exp': exp,
      'silver': 0,
      'items': items,
    };
  }

  /// 计算武技修炼收益
  static Map<String, dynamic> calculatePractice({
    required int comprehension,
    required RealmTier realmTier,
    required int durationMinutes,
    String? skillId,
  }) {
    // 武技修炼经验较少，但有技能经验
    final realmMultiplier = 1.0 + (realmTier.rank * 0.15);
    final baseExp = (comprehension * realmMultiplier * durationMinutes * 0.3).round();

    final variance = baseExp * 0.2;
    final exp = (baseExp + (_random.nextDouble() * variance * 2 - variance)).round();

    // 技能经验
    final skillExp = (durationMinutes * 2).round();

    final items = <String, int>{};
    // 有概率获得修炼心得
    if (durationMinutes >= 180 && _random.nextDouble() < 0.2) {
      items['healing_pill'] = 1;
    }

    return {
      'exp': exp,
      'silver': 0,
      'items': items,
      'skillExp': skillExp,
      'skillId': skillId,
    };
  }

  /// 计算历练探索收益
  static Map<String, dynamic> calculateAdventure({
    required int comprehension,
    required int luck,
    required RealmTier realmTier,
    required int durationMinutes,
    String? locationId,
  }) {
    // 历练收益最丰富但也最随机
    final realmMultiplier = 1.0 + (realmTier.rank * 0.25);
    final luckMultiplier = 1.0 + (luck * 0.02);

    final baseExp = (comprehension * realmMultiplier * durationMinutes * 0.4).round();
    final baseSilver = (luck * luckMultiplier * durationMinutes * 0.3).round();

    final variance = 0.3;
    final exp = (baseExp * (1 + (_random.nextDouble() * variance * 2 - variance))).round();
    final silver = (baseSilver * (1 + (_random.nextDouble() * variance * 2 - variance))).round();

    // 根据地点和时长获得不同材料
    final items = <String, int>{};

    // 基础材料
    if (durationMinutes >= 60) {
      final materialRoll = _random.nextDouble();
      if (materialRoll < 0.4) {
        items['rough_iron'] = 1 + (durationMinutes ~/ 120);
      } else if (materialRoll < 0.7) {
        items['healing_pill'] = 1 + (durationMinutes ~/ 180);
      } else if (materialRoll < 0.9) {
        items['bixin_herb'] = 1;
      }
    }

    // 稀有材料（长时间历练）
    if (durationMinutes >= 240) {
      if (_random.nextDouble() < 0.15 * luckMultiplier) {
        final rareItems = ['fine_iron', 'tianxing_stone', 'moonflower', 'cold_iron'];
        items[rareItems[_random.nextInt(rareItems.length)]] = 1;
      }
    }

    // 超稀有材料（极长时间 + 高运气）
    if (durationMinutes >= 480 && luck >= 15) {
      if (_random.nextDouble() < 0.05 * luckMultiplier) {
        items['star_iron'] = 1;
      }
    }

    return {
      'exp': exp,
      'silver': silver,
      'items': items,
    };
  }

  /// 根据修炼类型计算收益
  static Map<String, dynamic> calculateReward({
    required CultivationType type,
    required int comprehension,
    required int luck,
    required RealmTier realmTier,
    required int durationMinutes,
    String? skillId,
    String? locationId,
  }) {
    switch (type) {
      case CultivationType.meditation:
        return calculateMeditation(
          comprehension: comprehension,
          realmTier: realmTier,
          durationMinutes: durationMinutes,
        );
      case CultivationType.practice:
        return calculatePractice(
          comprehension: comprehension,
          realmTier: realmTier,
          durationMinutes: durationMinutes,
          skillId: skillId,
        );
      case CultivationType.adventure:
        return calculateAdventure(
          comprehension: comprehension,
          luck: luck,
          realmTier: realmTier,
          durationMinutes: durationMinutes,
          locationId: locationId,
        );
    }
  }

  /// 推荐修炼时长选项（分钟）
  static List<int> get recommendedDurations => [
        30, // 30分钟
        60, // 1小时
        120, // 2小时
        240, // 4小时
        480, // 8小时
        720, // 12小时
      ];

  /// 格式化时长
  static String formatDuration(int minutes) {
    if (minutes < 60) return '$minutes分钟';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '$hours小时';
    return '$hours小时$mins分钟';
  }
}

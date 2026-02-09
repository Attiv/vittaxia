import 'dart:math';

import '../../data/event_data.dart';
import '../../data/map_data.dart';
import '../../models/game_event_data.dart';

/// 随机事件引擎：根据地点和事件池按权重随机抽取
class EventEngine {
  final Random _random;

  EventEngine([Random? random]) : _random = random ?? Random();

  /// 获取指定地点的一个随机事件
  GameEventData? rollEvent(String locationId) {
    final location = mapLocations[locationId];
    if (location == null || location.eventIds.isEmpty) return null;

    final candidates = <GameEventData>[];
    final weights = <int>[];

    for (final eventId in location.eventIds) {
      final event = gameEvents[eventId];
      if (event != null) {
        candidates.add(event);
        weights.add(event.weight);
      }
    }
    if (candidates.isEmpty) return null;

    return _weightedRandom(candidates, weights);
  }

  T _weightedRandom<T>(List<T> items, List<int> weights) {
    final totalWeight = weights.reduce((a, b) => a + b);
    var roll = _random.nextInt(totalWeight);
    for (var i = 0; i < items.length; i++) {
      roll -= weights[i];
      if (roll < 0) return items[i];
    }
    return items.last;
  }
}

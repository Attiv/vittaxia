import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/map_data.dart';
import '../../models/game_event.dart';
import '../../models/map_location.dart';
import '../character/character_provider.dart';
import 'event_engine.dart';

/// 地图数据 provider
final mapLocationsProvider = Provider<Map<String, MapLocation>>((ref) {
  return mapLocations;
});

/// 当前位置
final currentLocationProvider = Provider<MapLocation?>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return null;
  return mapLocations[character.locationId];
});

/// 事件引擎
final eventEngineProvider = Provider<EventEngine>((ref) {
  return EventEngine();
});

/// 游戏日志
final gameLogProvider = StateNotifierProvider<GameLogNotifier, List<GameLog>>((ref) {
  return GameLogNotifier();
});

class GameLogNotifier extends StateNotifier<List<GameLog>> {
  GameLogNotifier() : super([]);

  static const _maxLogs = 100;

  void addLog(String message, {LogType type = LogType.system}) {
    final log = GameLog(
      message: message,
      timestamp: DateTime.now(),
      type: type,
    );
    state = [log, ...state].take(_maxLogs).toList();
  }

  void clear() => state = [];
}

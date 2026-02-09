import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'map_location.freezed.dart';
part 'map_location.g.dart';

@freezed
class MapLocation with _$MapLocation {
  const factory MapLocation({
    required String id,
    required String name,
    required String description,
    required LocationType type,
    required int dangerLevel,
    @Default([]) List<String> adjacentIds,
    @Default([]) List<String> npcIds,
    @Default([]) List<String> eventIds,
    @Default(30) int explorationSeconds,
    // 进入条件
    RealmTier? requiredRealm,
    String? requiredQuestId,
  }) = _MapLocation;

  factory MapLocation.fromJson(Map<String, dynamic> json) =>
      _$MapLocationFromJson(json);
}

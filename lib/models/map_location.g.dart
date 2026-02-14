// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapLocationImpl _$$MapLocationImplFromJson(
  Map<String, dynamic> json,
) => _$MapLocationImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$LocationTypeEnumMap, json['type']),
  dangerLevel: (json['dangerLevel'] as num).toInt(),
  adjacentIds:
      (json['adjacentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  npcIds:
      (json['npcIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  eventIds:
      (json['eventIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  explorationSeconds: (json['explorationSeconds'] as num?)?.toInt() ?? 30,
  requiredRealm: $enumDecodeNullable(_$RealmTierEnumMap, json['requiredRealm']),
  requiredQuestId: json['requiredQuestId'] as String?,
);

Map<String, dynamic> _$$MapLocationImplToJson(_$MapLocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$LocationTypeEnumMap[instance.type]!,
      'dangerLevel': instance.dangerLevel,
      'adjacentIds': instance.adjacentIds,
      'npcIds': instance.npcIds,
      'eventIds': instance.eventIds,
      'explorationSeconds': instance.explorationSeconds,
      'requiredRealm': _$RealmTierEnumMap[instance.requiredRealm],
      'requiredQuestId': instance.requiredQuestId,
    };

const _$LocationTypeEnumMap = {
  LocationType.village: 'village',
  LocationType.city: 'city',
  LocationType.wilderness: 'wilderness',
  LocationType.dungeon: 'dungeon',
  LocationType.sect: 'sect',
  LocationType.special: 'special',
};

const _$RealmTierEnumMap = {
  RealmTier.lianQi: 'lianQi',
  RealmTier.lianTi: 'lianTi',
  RealmTier.houTian: 'houTian',
  RealmTier.xianTian: 'xianTian',
  RealmTier.zhuJi: 'zhuJi',
  RealmTier.guiYuan: 'guiYuan',
  RealmTier.zongShi: 'zongShi',
  RealmTier.wuSheng: 'wuSheng',
  RealmTier.huaJing: 'huaJing',
};

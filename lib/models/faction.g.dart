// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FactionImpl _$$FactionImplFromJson(Map<String, dynamic> json) =>
    _$FactionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$FactionTypeEnumMap, json['type']),
      relations:
          (json['relations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      specialties:
          (json['specialties'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      territoryIds:
          (json['territoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FactionImplToJson(_$FactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$FactionTypeEnumMap[instance.type]!,
      'relations': instance.relations,
      'specialties': instance.specialties,
      'territoryIds': instance.territoryIds,
    };

const _$FactionTypeEnumMap = {
  FactionType.righteous: 'righteous',
  FactionType.evil: 'evil',
  FactionType.neutral: 'neutral',
};

_$FactionEventImpl _$$FactionEventImplFromJson(Map<String, dynamic> json) =>
    _$FactionEventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$FactionEventTypeEnumMap, json['type']),
      involvedFactionIds: (json['involvedFactionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      availableSides:
          (json['availableSides'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      rewardReputation: (json['rewardReputation'] as num?)?.toInt() ?? 0,
      rewardItemId: json['rewardItemId'] as String?,
    );

Map<String, dynamic> _$$FactionEventImplToJson(_$FactionEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$FactionEventTypeEnumMap[instance.type]!,
      'involvedFactionIds': instance.involvedFactionIds,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'availableSides': instance.availableSides,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardReputation': instance.rewardReputation,
      'rewardItemId': instance.rewardItemId,
    };

const _$FactionEventTypeEnumMap = {
  FactionEventType.war: 'war',
  FactionEventType.alliance: 'alliance',
  FactionEventType.betrayal: 'betrayal',
  FactionEventType.invasion: 'invasion',
  FactionEventType.festival: 'festival',
};

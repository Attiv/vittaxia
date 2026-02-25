// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultivation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CultivationSessionImpl _$$CultivationSessionImplFromJson(
  Map<String, dynamic> json,
) => _$CultivationSessionImpl(
  id: json['id'] as String,
  characterId: json['characterId'] as String,
  type: $enumDecode(_$CultivationTypeEnumMap, json['type']),
  status: $enumDecode(_$CultivationStatusEnumMap, json['status']),
  skillId: json['skillId'] as String?,
  locationId: json['locationId'] as String?,
  startTime: DateTime.parse(json['startTime'] as String),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  completedTime: json['completedTime'] == null
      ? null
      : DateTime.parse(json['completedTime'] as String),
  rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
  rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
  rewardItems:
      (json['rewardItems'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  rewardSkillId: json['rewardSkillId'] as String?,
);

Map<String, dynamic> _$$CultivationSessionImplToJson(
  _$CultivationSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'characterId': instance.characterId,
  'type': _$CultivationTypeEnumMap[instance.type]!,
  'status': _$CultivationStatusEnumMap[instance.status]!,
  'skillId': instance.skillId,
  'locationId': instance.locationId,
  'startTime': instance.startTime.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'completedTime': instance.completedTime?.toIso8601String(),
  'rewardExp': instance.rewardExp,
  'rewardSilver': instance.rewardSilver,
  'rewardItems': instance.rewardItems,
  'rewardSkillId': instance.rewardSkillId,
};

const _$CultivationTypeEnumMap = {
  CultivationType.meditation: 'meditation',
  CultivationType.practice: 'practice',
  CultivationType.adventure: 'adventure',
};

const _$CultivationStatusEnumMap = {
  CultivationStatus.idle: 'idle',
  CultivationStatus.cultivating: 'cultivating',
  CultivationStatus.completed: 'completed',
};

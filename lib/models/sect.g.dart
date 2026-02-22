// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectImpl _$$SectImplFromJson(Map<String, dynamic> json) => _$SectImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$SectTypeEnumMap, json['type']),
  requiredRealm:
      $enumDecodeNullable(_$RealmTierEnumMap, json['requiredRealm']) ??
      RealmTier.houTian,
  requiredReputation: (json['requiredReputation'] as num?)?.toInt() ?? 0,
  requiredQuestId: json['requiredQuestId'] as String?,
  specialtySkills:
      (json['specialtySkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  teacherNpcIds:
      (json['teacherNpcIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sectQuestIds:
      (json['sectQuestIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  atkBonus: (json['atkBonus'] as num?)?.toInt() ?? 0,
  defBonus: (json['defBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SectImplToJson(_$SectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$SectTypeEnumMap[instance.type]!,
      'requiredRealm': _$RealmTierEnumMap[instance.requiredRealm]!,
      'requiredReputation': instance.requiredReputation,
      'requiredQuestId': instance.requiredQuestId,
      'specialtySkills': instance.specialtySkills,
      'teacherNpcIds': instance.teacherNpcIds,
      'sectQuestIds': instance.sectQuestIds,
      'atkBonus': instance.atkBonus,
      'defBonus': instance.defBonus,
      'speedBonus': instance.speedBonus,
    };

const _$SectTypeEnumMap = {
  SectType.sword: 'sword',
  SectType.blade: 'blade',
  SectType.fist: 'fist',
  SectType.palm: 'palm',
  SectType.hidden: 'hidden',
  SectType.medicine: 'medicine',
  SectType.scholar: 'scholar',
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

_$SectQuestImpl _$$SectQuestImplFromJson(Map<String, dynamic> json) =>
    _$SectQuestImpl(
      id: json['id'] as String,
      sectId: json['sectId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      objectives: (json['objectives'] as List<dynamic>)
          .map((e) => SectQuestObjective.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      rewardContribution: (json['rewardContribution'] as num?)?.toInt() ?? 0,
      rewardSkillId: json['rewardSkillId'] as String?,
      rewardItemId: json['rewardItemId'] as String?,
      requiredContribution:
          (json['requiredContribution'] as num?)?.toInt() ?? 0,
      requiredRealm:
          $enumDecodeNullable(_$RealmTierEnumMap, json['requiredRealm']) ??
          RealmTier.houTian,
      repeatable: json['repeatable'] as bool? ?? false,
      cooldownHours: (json['cooldownHours'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SectQuestImplToJson(_$SectQuestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sectId': instance.sectId,
      'name': instance.name,
      'description': instance.description,
      'objectives': instance.objectives,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardContribution': instance.rewardContribution,
      'rewardSkillId': instance.rewardSkillId,
      'rewardItemId': instance.rewardItemId,
      'requiredContribution': instance.requiredContribution,
      'requiredRealm': _$RealmTierEnumMap[instance.requiredRealm]!,
      'repeatable': instance.repeatable,
      'cooldownHours': instance.cooldownHours,
    };

_$SectQuestObjectiveImpl _$$SectQuestObjectiveImplFromJson(
  Map<String, dynamic> json,
) => _$SectQuestObjectiveImpl(
  id: json['id'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$QuestObjectiveTypeEnumMap, json['type']),
  targetId: json['targetId'] as String?,
  requiredCount: (json['requiredCount'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$SectQuestObjectiveImplToJson(
  _$SectQuestObjectiveImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'description': instance.description,
  'type': _$QuestObjectiveTypeEnumMap[instance.type]!,
  'targetId': instance.targetId,
  'requiredCount': instance.requiredCount,
};

const _$QuestObjectiveTypeEnumMap = {
  QuestObjectiveType.kill: 'kill',
  QuestObjectiveType.collect: 'collect',
  QuestObjectiveType.talk: 'talk',
  QuestObjectiveType.explore: 'explore',
};

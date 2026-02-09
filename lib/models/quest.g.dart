// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestImpl _$$QuestImplFromJson(Map<String, dynamic> json) => _$QuestImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$QuestTypeEnumMap, json['type']),
  objectives:
      (json['objectives'] as List<dynamic>?)
          ?.map((e) => QuestObjective.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
  rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
  rewardReputation: (json['rewardReputation'] as num?)?.toInt() ?? 0,
  rewardItemId: json['rewardItemId'] as String?,
  rewardSkillId: json['rewardSkillId'] as String?,
  prerequisiteQuestId: json['prerequisiteQuestId'] as String?,
  questGiverNpcId: json['questGiverNpcId'] as String?,
  questLocationId: json['questLocationId'] as String?,
);

Map<String, dynamic> _$$QuestImplToJson(_$QuestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$QuestTypeEnumMap[instance.type]!,
      'objectives': instance.objectives,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardReputation': instance.rewardReputation,
      'rewardItemId': instance.rewardItemId,
      'rewardSkillId': instance.rewardSkillId,
      'prerequisiteQuestId': instance.prerequisiteQuestId,
      'questGiverNpcId': instance.questGiverNpcId,
      'questLocationId': instance.questLocationId,
    };

const _$QuestTypeEnumMap = {
  QuestType.main: 'main',
  QuestType.side: 'side',
  QuestType.hidden: 'hidden',
};

_$QuestObjectiveImpl _$$QuestObjectiveImplFromJson(Map<String, dynamic> json) =>
    _$QuestObjectiveImpl(
      id: json['id'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$QuestObjectiveTypeEnumMap, json['type']),
      targetId: json['targetId'] as String?,
      requiredCount: (json['requiredCount'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$QuestObjectiveImplToJson(
  _$QuestObjectiveImpl instance,
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

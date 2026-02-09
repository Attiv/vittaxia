// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NpcImpl _$$NpcImplFromJson(Map<String, dynamic> json) => _$NpcImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$NpcTypeEnumMap, json['type']),
  locationId: json['locationId'] as String,
  dialogueIds:
      (json['dialogueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  teachableSkillIds:
      (json['teachableSkillIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  shopItemIds:
      (json['shopItemIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$NpcImplToJson(_$NpcImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'title': instance.title,
  'description': instance.description,
  'type': _$NpcTypeEnumMap[instance.type]!,
  'locationId': instance.locationId,
  'dialogueIds': instance.dialogueIds,
  'teachableSkillIds': instance.teachableSkillIds,
  'shopItemIds': instance.shopItemIds,
};

const _$NpcTypeEnumMap = {
  NpcType.story: 'story',
  NpcType.merchant: 'merchant',
  NpcType.master: 'master',
  NpcType.questGiver: 'questGiver',
  NpcType.companion: 'companion',
  NpcType.hostile: 'hostile',
};

_$DialogueNodeImpl _$$DialogueNodeImplFromJson(Map<String, dynamic> json) =>
    _$DialogueNodeImpl(
      id: json['id'] as String,
      speaker: json['speaker'] as String,
      text: json['text'] as String,
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => DialogueChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nextId: json['nextId'] as String?,
      affectionChange: (json['affectionChange'] as num?)?.toInt() ?? 0,
      expReward: (json['expReward'] as num?)?.toInt() ?? 0,
      silverReward: (json['silverReward'] as num?)?.toInt() ?? 0,
      rewardItemId: json['rewardItemId'] as String?,
      teachSkillId: json['teachSkillId'] as String?,
      requiredAffection: (json['requiredAffection'] as num?)?.toInt(),
      requiredQuestId: json['requiredQuestId'] as String?,
    );

Map<String, dynamic> _$$DialogueNodeImplToJson(_$DialogueNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'speaker': instance.speaker,
      'text': instance.text,
      'choices': instance.choices,
      'nextId': instance.nextId,
      'affectionChange': instance.affectionChange,
      'expReward': instance.expReward,
      'silverReward': instance.silverReward,
      'rewardItemId': instance.rewardItemId,
      'teachSkillId': instance.teachSkillId,
      'requiredAffection': instance.requiredAffection,
      'requiredQuestId': instance.requiredQuestId,
    };

_$DialogueChoiceImpl _$$DialogueChoiceImplFromJson(Map<String, dynamic> json) =>
    _$DialogueChoiceImpl(
      text: json['text'] as String,
      nextId: json['nextId'] as String,
      affectionChange: (json['affectionChange'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DialogueChoiceImplToJson(
  _$DialogueChoiceImpl instance,
) => <String, dynamic>{
  'text': instance.text,
  'nextId': instance.nextId,
  'affectionChange': instance.affectionChange,
};

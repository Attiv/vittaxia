// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameEventDataImpl _$$GameEventDataImplFromJson(Map<String, dynamic> json) =>
    _$GameEventDataImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$GameEventTypeEnumMap, json['type']),
      weight: (json['weight'] as num?)?.toInt() ?? 10,
      minDangerLevel: (json['minDangerLevel'] as num?)?.toInt() ?? 0,
      maxDangerLevel: (json['maxDangerLevel'] as num?)?.toInt() ?? 10,
      enemyId: json['enemyId'] as String?,
      rewardItemId: json['rewardItemId'] as String?,
      rewardItemCount: (json['rewardItemCount'] as num?)?.toInt() ?? 1,
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => EventChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameEventDataImplToJson(_$GameEventDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$GameEventTypeEnumMap[instance.type]!,
      'weight': instance.weight,
      'minDangerLevel': instance.minDangerLevel,
      'maxDangerLevel': instance.maxDangerLevel,
      'enemyId': instance.enemyId,
      'rewardItemId': instance.rewardItemId,
      'rewardItemCount': instance.rewardItemCount,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'choices': instance.choices,
    };

const _$GameEventTypeEnumMap = {
  GameEventType.battle: 'battle',
  GameEventType.treasure: 'treasure',
  GameEventType.npcEncounter: 'npcEncounter',
  GameEventType.trap: 'trap',
  GameEventType.scenery: 'scenery',
  GameEventType.adventure: 'adventure',
  GameEventType.merchant: 'merchant',
};

_$EventChoiceImpl _$$EventChoiceImplFromJson(Map<String, dynamic> json) =>
    _$EventChoiceImpl(
      text: json['text'] as String,
      resultText: json['resultText'] as String,
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      rewardItemId: json['rewardItemId'] as String?,
      hpChange: (json['hpChange'] as num?)?.toInt() ?? 0,
      triggerBattle: json['triggerBattle'] as bool? ?? false,
      enemyId: json['enemyId'] as String?,
    );

Map<String, dynamic> _$$EventChoiceImplToJson(_$EventChoiceImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'resultText': instance.resultText,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardItemId': instance.rewardItemId,
      'hpChange': instance.hpChange,
      'triggerBattle': instance.triggerBattle,
      'enemyId': instance.enemyId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameLogImpl _$$GameLogImplFromJson(Map<String, dynamic> json) =>
    _$GameLogImpl(
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type:
          $enumDecodeNullable(_$LogTypeEnumMap, json['type']) ?? LogType.system,
    );

Map<String, dynamic> _$$GameLogImplToJson(_$GameLogImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$LogTypeEnumMap[instance.type]!,
    };

const _$LogTypeEnumMap = {
  LogType.system: 'system',
  LogType.combat: 'combat',
  LogType.explore: 'explore',
  LogType.quest: 'quest',
  LogType.dialogue: 'dialogue',
  LogType.item: 'item',
};

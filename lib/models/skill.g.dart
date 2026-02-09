// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$SkillTypeEnumMap, json['type']),
  quality:
      $enumDecodeNullable(_$SkillQualityEnumMap, json['quality']) ??
      SkillQuality.crude,
  baseDamage: (json['baseDamage'] as num?)?.toInt() ?? 10,
  damageMultiplier: (json['damageMultiplier'] as num?)?.toDouble() ?? 1.0,
  mpCost: (json['mpCost'] as num?)?.toInt() ?? 0,
  buffAtk: (json['buffAtk'] as num?)?.toInt() ?? 0,
  buffDef: (json['buffDef'] as num?)?.toInt() ?? 0,
  buffSpeed: (json['buffSpeed'] as num?)?.toInt() ?? 0,
  healAmount: (json['healAmount'] as num?)?.toInt() ?? 0,
  buffDuration: (json['buffDuration'] as num?)?.toInt() ?? 0,
  requiredLevel: (json['requiredLevel'] as num?)?.toInt() ?? 0,
  learnCost: (json['learnCost'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$SkillTypeEnumMap[instance.type]!,
      'quality': _$SkillQualityEnumMap[instance.quality]!,
      'baseDamage': instance.baseDamage,
      'damageMultiplier': instance.damageMultiplier,
      'mpCost': instance.mpCost,
      'buffAtk': instance.buffAtk,
      'buffDef': instance.buffDef,
      'buffSpeed': instance.buffSpeed,
      'healAmount': instance.healAmount,
      'buffDuration': instance.buffDuration,
      'requiredLevel': instance.requiredLevel,
      'learnCost': instance.learnCost,
    };

const _$SkillTypeEnumMap = {
  SkillType.attack: 'attack',
  SkillType.innerForce: 'innerForce',
  SkillType.movement: 'movement',
  SkillType.hidden: 'hidden',
  SkillType.passive: 'passive',
};

const _$SkillQualityEnumMap = {
  SkillQuality.crude: 'crude',
  SkillQuality.refined: 'refined',
  SkillQuality.superior: 'superior',
  SkillQuality.ultimate: 'ultimate',
  SkillQuality.divine: 'divine',
};

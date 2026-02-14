// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterImpl _$$CharacterImplFromJson(Map<String, dynamic> json) =>
    _$CharacterImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      baseHp: (json['baseHp'] as num?)?.toInt() ?? 100,
      baseMp: (json['baseMp'] as num?)?.toInt() ?? 50,
      baseAtk: (json['baseAtk'] as num?)?.toInt() ?? 10,
      baseDef: (json['baseDef'] as num?)?.toInt() ?? 5,
      baseSpeed: (json['baseSpeed'] as num?)?.toInt() ?? 8,
      baseLuck: (json['baseLuck'] as num?)?.toInt() ?? 5,
      baseComprehension: (json['baseComprehension'] as num?)?.toInt() ?? 10,
      exp: (json['exp'] as num?)?.toInt() ?? 0,
      silver: (json['silver'] as num?)?.toInt() ?? 100,
      reputation: (json['reputation'] as num?)?.toInt() ?? 0,
      realmTier:
          $enumDecodeNullable(_$RealmTierEnumMap, json['realmTier']) ??
          RealmTier.lianQi,
      realmStage:
          $enumDecodeNullable(_$RealmStageEnumMap, json['realmStage']) ??
          RealmStage.early,
      currentHp: (json['currentHp'] as num?)?.toInt() ?? 100,
      currentMp: (json['currentMp'] as num?)?.toInt() ?? 50,
      weaponId: json['weaponId'] as String?,
      armorId: json['armorId'] as String?,
      shoesId: json['shoesId'] as String?,
      accessoryId: json['accessoryId'] as String?,
      locationId: json['locationId'] as String? ?? 'qingyun_village',
      lastOnlineTime: json['lastOnlineTime'] == null
          ? null
          : DateTime.parse(json['lastOnlineTime'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CharacterImplToJson(_$CharacterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseHp': instance.baseHp,
      'baseMp': instance.baseMp,
      'baseAtk': instance.baseAtk,
      'baseDef': instance.baseDef,
      'baseSpeed': instance.baseSpeed,
      'baseLuck': instance.baseLuck,
      'baseComprehension': instance.baseComprehension,
      'exp': instance.exp,
      'silver': instance.silver,
      'reputation': instance.reputation,
      'realmTier': _$RealmTierEnumMap[instance.realmTier]!,
      'realmStage': _$RealmStageEnumMap[instance.realmStage]!,
      'currentHp': instance.currentHp,
      'currentMp': instance.currentMp,
      'weaponId': instance.weaponId,
      'armorId': instance.armorId,
      'shoesId': instance.shoesId,
      'accessoryId': instance.accessoryId,
      'locationId': instance.locationId,
      'lastOnlineTime': instance.lastOnlineTime?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
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

const _$RealmStageEnumMap = {
  RealmStage.early: 'early',
  RealmStage.mid: 'mid',
  RealmStage.late_: 'late_',
  RealmStage.peak: 'peak',
};

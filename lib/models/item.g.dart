// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$ItemTypeEnumMap, json['type']),
  rarity:
      $enumDecodeNullable(_$ItemRarityEnumMap, json['rarity']) ??
      ItemRarity.common,
  atkBonus: (json['atkBonus'] as num?)?.toInt() ?? 0,
  defBonus: (json['defBonus'] as num?)?.toInt() ?? 0,
  hpBonus: (json['hpBonus'] as num?)?.toInt() ?? 0,
  mpBonus: (json['mpBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  luckBonus: (json['luckBonus'] as num?)?.toInt() ?? 0,
  healHp: (json['healHp'] as num?)?.toInt() ?? 0,
  healMp: (json['healMp'] as num?)?.toInt() ?? 0,
  healStamina: (json['healStamina'] as num?)?.toInt() ?? 0,
  buyPrice: (json['buyPrice'] as num?)?.toInt() ?? 0,
  sellPrice: (json['sellPrice'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'rarity': _$ItemRarityEnumMap[instance.rarity]!,
      'atkBonus': instance.atkBonus,
      'defBonus': instance.defBonus,
      'hpBonus': instance.hpBonus,
      'mpBonus': instance.mpBonus,
      'speedBonus': instance.speedBonus,
      'luckBonus': instance.luckBonus,
      'healHp': instance.healHp,
      'healMp': instance.healMp,
      'healStamina': instance.healStamina,
      'buyPrice': instance.buyPrice,
      'sellPrice': instance.sellPrice,
    };

const _$ItemTypeEnumMap = {
  ItemType.weapon: 'weapon',
  ItemType.armor: 'armor',
  ItemType.shoes: 'shoes',
  ItemType.accessory: 'accessory',
  ItemType.consumable: 'consumable',
  ItemType.material: 'material',
  ItemType.questItem: 'questItem',
};

const _$ItemRarityEnumMap = {
  ItemRarity.common: 'common',
  ItemRarity.uncommon: 'uncommon',
  ItemRarity.rare: 'rare',
  ItemRarity.epic: 'epic',
  ItemRarity.legendary: 'legendary',
};

import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// 物品模板
@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required String description,
    required ItemType type,
    @Default(ItemRarity.common) ItemRarity rarity,
    // 装备属性加成
    @Default(0) int atkBonus,
    @Default(0) int defBonus,
    @Default(0) int hpBonus,
    @Default(0) int mpBonus,
    @Default(0) int speedBonus,
    @Default(0) int luckBonus,
    // 消耗品效果
    @Default(0) int healHp,
    @Default(0) int healMp,
    @Default(0) int healStamina,
    // 价格
    @Default(0) int buyPrice,
    @Default(0) int sellPrice,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

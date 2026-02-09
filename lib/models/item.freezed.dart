// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ItemType get type => throw _privateConstructorUsedError;
  ItemRarity get rarity => throw _privateConstructorUsedError; // 装备属性加成
  int get atkBonus => throw _privateConstructorUsedError;
  int get defBonus => throw _privateConstructorUsedError;
  int get hpBonus => throw _privateConstructorUsedError;
  int get mpBonus => throw _privateConstructorUsedError;
  int get speedBonus => throw _privateConstructorUsedError;
  int get luckBonus => throw _privateConstructorUsedError; // 消耗品效果
  int get healHp => throw _privateConstructorUsedError;
  int get healMp => throw _privateConstructorUsedError; // 价格
  int get buyPrice => throw _privateConstructorUsedError;
  int get sellPrice => throw _privateConstructorUsedError;

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    ItemType type,
    ItemRarity rarity,
    int atkBonus,
    int defBonus,
    int hpBonus,
    int mpBonus,
    int speedBonus,
    int luckBonus,
    int healHp,
    int healMp,
    int buyPrice,
    int sellPrice,
  });
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? rarity = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? hpBonus = null,
    Object? mpBonus = null,
    Object? speedBonus = null,
    Object? luckBonus = null,
    Object? healHp = null,
    Object? healMp = null,
    Object? buyPrice = null,
    Object? sellPrice = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ItemType,
            rarity: null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as ItemRarity,
            atkBonus: null == atkBonus
                ? _value.atkBonus
                : atkBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            defBonus: null == defBonus
                ? _value.defBonus
                : defBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            hpBonus: null == hpBonus
                ? _value.hpBonus
                : hpBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            mpBonus: null == mpBonus
                ? _value.mpBonus
                : mpBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            speedBonus: null == speedBonus
                ? _value.speedBonus
                : speedBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            luckBonus: null == luckBonus
                ? _value.luckBonus
                : luckBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            healHp: null == healHp
                ? _value.healHp
                : healHp // ignore: cast_nullable_to_non_nullable
                      as int,
            healMp: null == healMp
                ? _value.healMp
                : healMp // ignore: cast_nullable_to_non_nullable
                      as int,
            buyPrice: null == buyPrice
                ? _value.buyPrice
                : buyPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            sellPrice: null == sellPrice
                ? _value.sellPrice
                : sellPrice // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
    _$ItemImpl value,
    $Res Function(_$ItemImpl) then,
  ) = __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    ItemType type,
    ItemRarity rarity,
    int atkBonus,
    int defBonus,
    int hpBonus,
    int mpBonus,
    int speedBonus,
    int luckBonus,
    int healHp,
    int healMp,
    int buyPrice,
    int sellPrice,
  });
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
    : super(_value, _then);

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? rarity = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? hpBonus = null,
    Object? mpBonus = null,
    Object? speedBonus = null,
    Object? luckBonus = null,
    Object? healHp = null,
    Object? healMp = null,
    Object? buyPrice = null,
    Object? sellPrice = null,
  }) {
    return _then(
      _$ItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ItemType,
        rarity: null == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as ItemRarity,
        atkBonus: null == atkBonus
            ? _value.atkBonus
            : atkBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        defBonus: null == defBonus
            ? _value.defBonus
            : defBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        hpBonus: null == hpBonus
            ? _value.hpBonus
            : hpBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        mpBonus: null == mpBonus
            ? _value.mpBonus
            : mpBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        speedBonus: null == speedBonus
            ? _value.speedBonus
            : speedBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        luckBonus: null == luckBonus
            ? _value.luckBonus
            : luckBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        healHp: null == healHp
            ? _value.healHp
            : healHp // ignore: cast_nullable_to_non_nullable
                  as int,
        healMp: null == healMp
            ? _value.healMp
            : healMp // ignore: cast_nullable_to_non_nullable
                  as int,
        buyPrice: null == buyPrice
            ? _value.buyPrice
            : buyPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        sellPrice: null == sellPrice
            ? _value.sellPrice
            : sellPrice // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  const _$ItemImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.rarity = ItemRarity.common,
    this.atkBonus = 0,
    this.defBonus = 0,
    this.hpBonus = 0,
    this.mpBonus = 0,
    this.speedBonus = 0,
    this.luckBonus = 0,
    this.healHp = 0,
    this.healMp = 0,
    this.buyPrice = 0,
    this.sellPrice = 0,
  });

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final ItemType type;
  @override
  @JsonKey()
  final ItemRarity rarity;
  // 装备属性加成
  @override
  @JsonKey()
  final int atkBonus;
  @override
  @JsonKey()
  final int defBonus;
  @override
  @JsonKey()
  final int hpBonus;
  @override
  @JsonKey()
  final int mpBonus;
  @override
  @JsonKey()
  final int speedBonus;
  @override
  @JsonKey()
  final int luckBonus;
  // 消耗品效果
  @override
  @JsonKey()
  final int healHp;
  @override
  @JsonKey()
  final int healMp;
  // 价格
  @override
  @JsonKey()
  final int buyPrice;
  @override
  @JsonKey()
  final int sellPrice;

  @override
  String toString() {
    return 'Item(id: $id, name: $name, description: $description, type: $type, rarity: $rarity, atkBonus: $atkBonus, defBonus: $defBonus, hpBonus: $hpBonus, mpBonus: $mpBonus, speedBonus: $speedBonus, luckBonus: $luckBonus, healHp: $healHp, healMp: $healMp, buyPrice: $buyPrice, sellPrice: $sellPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.atkBonus, atkBonus) ||
                other.atkBonus == atkBonus) &&
            (identical(other.defBonus, defBonus) ||
                other.defBonus == defBonus) &&
            (identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus) &&
            (identical(other.mpBonus, mpBonus) || other.mpBonus == mpBonus) &&
            (identical(other.speedBonus, speedBonus) ||
                other.speedBonus == speedBonus) &&
            (identical(other.luckBonus, luckBonus) ||
                other.luckBonus == luckBonus) &&
            (identical(other.healHp, healHp) || other.healHp == healHp) &&
            (identical(other.healMp, healMp) || other.healMp == healMp) &&
            (identical(other.buyPrice, buyPrice) ||
                other.buyPrice == buyPrice) &&
            (identical(other.sellPrice, sellPrice) ||
                other.sellPrice == sellPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    rarity,
    atkBonus,
    defBonus,
    hpBonus,
    mpBonus,
    speedBonus,
    luckBonus,
    healHp,
    healMp,
    buyPrice,
    sellPrice,
  );

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(this);
  }
}

abstract class _Item implements Item {
  const factory _Item({
    required final String id,
    required final String name,
    required final String description,
    required final ItemType type,
    final ItemRarity rarity,
    final int atkBonus,
    final int defBonus,
    final int hpBonus,
    final int mpBonus,
    final int speedBonus,
    final int luckBonus,
    final int healHp,
    final int healMp,
    final int buyPrice,
    final int sellPrice,
  }) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  ItemType get type;
  @override
  ItemRarity get rarity; // 装备属性加成
  @override
  int get atkBonus;
  @override
  int get defBonus;
  @override
  int get hpBonus;
  @override
  int get mpBonus;
  @override
  int get speedBonus;
  @override
  int get luckBonus; // 消耗品效果
  @override
  int get healHp;
  @override
  int get healMp; // 价格
  @override
  int get buyPrice;
  @override
  int get sellPrice;

  /// Create a copy of Item
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

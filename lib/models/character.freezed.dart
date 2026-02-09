// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
mixin _$Character {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get baseHp => throw _privateConstructorUsedError;
  int get baseMp => throw _privateConstructorUsedError;
  int get baseAtk => throw _privateConstructorUsedError;
  int get baseDef => throw _privateConstructorUsedError;
  int get baseSpeed => throw _privateConstructorUsedError;
  int get baseLuck => throw _privateConstructorUsedError;
  int get baseComprehension => throw _privateConstructorUsedError;
  int get exp => throw _privateConstructorUsedError;
  int get silver => throw _privateConstructorUsedError;
  int get reputation => throw _privateConstructorUsedError;
  RealmTier get realmTier => throw _privateConstructorUsedError;
  RealmStage get realmStage => throw _privateConstructorUsedError; // 当前状态
  int get currentHp => throw _privateConstructorUsedError;
  int get currentMp => throw _privateConstructorUsedError; // 装备 ID
  String? get weaponId => throw _privateConstructorUsedError;
  String? get armorId => throw _privateConstructorUsedError;
  String? get shoesId => throw _privateConstructorUsedError;
  String? get accessoryId => throw _privateConstructorUsedError; // 位置
  String get locationId => throw _privateConstructorUsedError; // 时间
  DateTime? get lastOnlineTime => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Character to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterCopyWith<Character> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) =
      _$CharacterCopyWithImpl<$Res, Character>;
  @useResult
  $Res call({
    String id,
    String name,
    int baseHp,
    int baseMp,
    int baseAtk,
    int baseDef,
    int baseSpeed,
    int baseLuck,
    int baseComprehension,
    int exp,
    int silver,
    int reputation,
    RealmTier realmTier,
    RealmStage realmStage,
    int currentHp,
    int currentMp,
    String? weaponId,
    String? armorId,
    String? shoesId,
    String? accessoryId,
    String locationId,
    DateTime? lastOnlineTime,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res, $Val extends Character>
    implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseHp = null,
    Object? baseMp = null,
    Object? baseAtk = null,
    Object? baseDef = null,
    Object? baseSpeed = null,
    Object? baseLuck = null,
    Object? baseComprehension = null,
    Object? exp = null,
    Object? silver = null,
    Object? reputation = null,
    Object? realmTier = null,
    Object? realmStage = null,
    Object? currentHp = null,
    Object? currentMp = null,
    Object? weaponId = freezed,
    Object? armorId = freezed,
    Object? shoesId = freezed,
    Object? accessoryId = freezed,
    Object? locationId = null,
    Object? lastOnlineTime = freezed,
    Object? createdAt = freezed,
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
            baseHp: null == baseHp
                ? _value.baseHp
                : baseHp // ignore: cast_nullable_to_non_nullable
                      as int,
            baseMp: null == baseMp
                ? _value.baseMp
                : baseMp // ignore: cast_nullable_to_non_nullable
                      as int,
            baseAtk: null == baseAtk
                ? _value.baseAtk
                : baseAtk // ignore: cast_nullable_to_non_nullable
                      as int,
            baseDef: null == baseDef
                ? _value.baseDef
                : baseDef // ignore: cast_nullable_to_non_nullable
                      as int,
            baseSpeed: null == baseSpeed
                ? _value.baseSpeed
                : baseSpeed // ignore: cast_nullable_to_non_nullable
                      as int,
            baseLuck: null == baseLuck
                ? _value.baseLuck
                : baseLuck // ignore: cast_nullable_to_non_nullable
                      as int,
            baseComprehension: null == baseComprehension
                ? _value.baseComprehension
                : baseComprehension // ignore: cast_nullable_to_non_nullable
                      as int,
            exp: null == exp
                ? _value.exp
                : exp // ignore: cast_nullable_to_non_nullable
                      as int,
            silver: null == silver
                ? _value.silver
                : silver // ignore: cast_nullable_to_non_nullable
                      as int,
            reputation: null == reputation
                ? _value.reputation
                : reputation // ignore: cast_nullable_to_non_nullable
                      as int,
            realmTier: null == realmTier
                ? _value.realmTier
                : realmTier // ignore: cast_nullable_to_non_nullable
                      as RealmTier,
            realmStage: null == realmStage
                ? _value.realmStage
                : realmStage // ignore: cast_nullable_to_non_nullable
                      as RealmStage,
            currentHp: null == currentHp
                ? _value.currentHp
                : currentHp // ignore: cast_nullable_to_non_nullable
                      as int,
            currentMp: null == currentMp
                ? _value.currentMp
                : currentMp // ignore: cast_nullable_to_non_nullable
                      as int,
            weaponId: freezed == weaponId
                ? _value.weaponId
                : weaponId // ignore: cast_nullable_to_non_nullable
                      as String?,
            armorId: freezed == armorId
                ? _value.armorId
                : armorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            shoesId: freezed == shoesId
                ? _value.shoesId
                : shoesId // ignore: cast_nullable_to_non_nullable
                      as String?,
            accessoryId: freezed == accessoryId
                ? _value.accessoryId
                : accessoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationId: null == locationId
                ? _value.locationId
                : locationId // ignore: cast_nullable_to_non_nullable
                      as String,
            lastOnlineTime: freezed == lastOnlineTime
                ? _value.lastOnlineTime
                : lastOnlineTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterImplCopyWith<$Res>
    implements $CharacterCopyWith<$Res> {
  factory _$$CharacterImplCopyWith(
    _$CharacterImpl value,
    $Res Function(_$CharacterImpl) then,
  ) = __$$CharacterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int baseHp,
    int baseMp,
    int baseAtk,
    int baseDef,
    int baseSpeed,
    int baseLuck,
    int baseComprehension,
    int exp,
    int silver,
    int reputation,
    RealmTier realmTier,
    RealmStage realmStage,
    int currentHp,
    int currentMp,
    String? weaponId,
    String? armorId,
    String? shoesId,
    String? accessoryId,
    String locationId,
    DateTime? lastOnlineTime,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$CharacterImplCopyWithImpl<$Res>
    extends _$CharacterCopyWithImpl<$Res, _$CharacterImpl>
    implements _$$CharacterImplCopyWith<$Res> {
  __$$CharacterImplCopyWithImpl(
    _$CharacterImpl _value,
    $Res Function(_$CharacterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseHp = null,
    Object? baseMp = null,
    Object? baseAtk = null,
    Object? baseDef = null,
    Object? baseSpeed = null,
    Object? baseLuck = null,
    Object? baseComprehension = null,
    Object? exp = null,
    Object? silver = null,
    Object? reputation = null,
    Object? realmTier = null,
    Object? realmStage = null,
    Object? currentHp = null,
    Object? currentMp = null,
    Object? weaponId = freezed,
    Object? armorId = freezed,
    Object? shoesId = freezed,
    Object? accessoryId = freezed,
    Object? locationId = null,
    Object? lastOnlineTime = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CharacterImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        baseHp: null == baseHp
            ? _value.baseHp
            : baseHp // ignore: cast_nullable_to_non_nullable
                  as int,
        baseMp: null == baseMp
            ? _value.baseMp
            : baseMp // ignore: cast_nullable_to_non_nullable
                  as int,
        baseAtk: null == baseAtk
            ? _value.baseAtk
            : baseAtk // ignore: cast_nullable_to_non_nullable
                  as int,
        baseDef: null == baseDef
            ? _value.baseDef
            : baseDef // ignore: cast_nullable_to_non_nullable
                  as int,
        baseSpeed: null == baseSpeed
            ? _value.baseSpeed
            : baseSpeed // ignore: cast_nullable_to_non_nullable
                  as int,
        baseLuck: null == baseLuck
            ? _value.baseLuck
            : baseLuck // ignore: cast_nullable_to_non_nullable
                  as int,
        baseComprehension: null == baseComprehension
            ? _value.baseComprehension
            : baseComprehension // ignore: cast_nullable_to_non_nullable
                  as int,
        exp: null == exp
            ? _value.exp
            : exp // ignore: cast_nullable_to_non_nullable
                  as int,
        silver: null == silver
            ? _value.silver
            : silver // ignore: cast_nullable_to_non_nullable
                  as int,
        reputation: null == reputation
            ? _value.reputation
            : reputation // ignore: cast_nullable_to_non_nullable
                  as int,
        realmTier: null == realmTier
            ? _value.realmTier
            : realmTier // ignore: cast_nullable_to_non_nullable
                  as RealmTier,
        realmStage: null == realmStage
            ? _value.realmStage
            : realmStage // ignore: cast_nullable_to_non_nullable
                  as RealmStage,
        currentHp: null == currentHp
            ? _value.currentHp
            : currentHp // ignore: cast_nullable_to_non_nullable
                  as int,
        currentMp: null == currentMp
            ? _value.currentMp
            : currentMp // ignore: cast_nullable_to_non_nullable
                  as int,
        weaponId: freezed == weaponId
            ? _value.weaponId
            : weaponId // ignore: cast_nullable_to_non_nullable
                  as String?,
        armorId: freezed == armorId
            ? _value.armorId
            : armorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        shoesId: freezed == shoesId
            ? _value.shoesId
            : shoesId // ignore: cast_nullable_to_non_nullable
                  as String?,
        accessoryId: freezed == accessoryId
            ? _value.accessoryId
            : accessoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                  as String,
        lastOnlineTime: freezed == lastOnlineTime
            ? _value.lastOnlineTime
            : lastOnlineTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterImpl implements _Character {
  const _$CharacterImpl({
    required this.id,
    required this.name,
    this.baseHp = 100,
    this.baseMp = 50,
    this.baseAtk = 10,
    this.baseDef = 5,
    this.baseSpeed = 8,
    this.baseLuck = 5,
    this.baseComprehension = 10,
    this.exp = 0,
    this.silver = 100,
    this.reputation = 0,
    this.realmTier = RealmTier.lianQi,
    this.realmStage = RealmStage.early,
    this.currentHp = 100,
    this.currentMp = 50,
    this.weaponId,
    this.armorId,
    this.shoesId,
    this.accessoryId,
    this.locationId = 'qingyun_village',
    this.lastOnlineTime,
    this.createdAt,
  });

  factory _$CharacterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final int baseHp;
  @override
  @JsonKey()
  final int baseMp;
  @override
  @JsonKey()
  final int baseAtk;
  @override
  @JsonKey()
  final int baseDef;
  @override
  @JsonKey()
  final int baseSpeed;
  @override
  @JsonKey()
  final int baseLuck;
  @override
  @JsonKey()
  final int baseComprehension;
  @override
  @JsonKey()
  final int exp;
  @override
  @JsonKey()
  final int silver;
  @override
  @JsonKey()
  final int reputation;
  @override
  @JsonKey()
  final RealmTier realmTier;
  @override
  @JsonKey()
  final RealmStage realmStage;
  // 当前状态
  @override
  @JsonKey()
  final int currentHp;
  @override
  @JsonKey()
  final int currentMp;
  // 装备 ID
  @override
  final String? weaponId;
  @override
  final String? armorId;
  @override
  final String? shoesId;
  @override
  final String? accessoryId;
  // 位置
  @override
  @JsonKey()
  final String locationId;
  // 时间
  @override
  final DateTime? lastOnlineTime;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Character(id: $id, name: $name, baseHp: $baseHp, baseMp: $baseMp, baseAtk: $baseAtk, baseDef: $baseDef, baseSpeed: $baseSpeed, baseLuck: $baseLuck, baseComprehension: $baseComprehension, exp: $exp, silver: $silver, reputation: $reputation, realmTier: $realmTier, realmStage: $realmStage, currentHp: $currentHp, currentMp: $currentMp, weaponId: $weaponId, armorId: $armorId, shoesId: $shoesId, accessoryId: $accessoryId, locationId: $locationId, lastOnlineTime: $lastOnlineTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.baseHp, baseHp) || other.baseHp == baseHp) &&
            (identical(other.baseMp, baseMp) || other.baseMp == baseMp) &&
            (identical(other.baseAtk, baseAtk) || other.baseAtk == baseAtk) &&
            (identical(other.baseDef, baseDef) || other.baseDef == baseDef) &&
            (identical(other.baseSpeed, baseSpeed) ||
                other.baseSpeed == baseSpeed) &&
            (identical(other.baseLuck, baseLuck) ||
                other.baseLuck == baseLuck) &&
            (identical(other.baseComprehension, baseComprehension) ||
                other.baseComprehension == baseComprehension) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.silver, silver) || other.silver == silver) &&
            (identical(other.reputation, reputation) ||
                other.reputation == reputation) &&
            (identical(other.realmTier, realmTier) ||
                other.realmTier == realmTier) &&
            (identical(other.realmStage, realmStage) ||
                other.realmStage == realmStage) &&
            (identical(other.currentHp, currentHp) ||
                other.currentHp == currentHp) &&
            (identical(other.currentMp, currentMp) ||
                other.currentMp == currentMp) &&
            (identical(other.weaponId, weaponId) ||
                other.weaponId == weaponId) &&
            (identical(other.armorId, armorId) || other.armorId == armorId) &&
            (identical(other.shoesId, shoesId) || other.shoesId == shoesId) &&
            (identical(other.accessoryId, accessoryId) ||
                other.accessoryId == accessoryId) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.lastOnlineTime, lastOnlineTime) ||
                other.lastOnlineTime == lastOnlineTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    baseHp,
    baseMp,
    baseAtk,
    baseDef,
    baseSpeed,
    baseLuck,
    baseComprehension,
    exp,
    silver,
    reputation,
    realmTier,
    realmStage,
    currentHp,
    currentMp,
    weaponId,
    armorId,
    shoesId,
    accessoryId,
    locationId,
    lastOnlineTime,
    createdAt,
  ]);

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      __$$CharacterImplCopyWithImpl<_$CharacterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterImplToJson(this);
  }
}

abstract class _Character implements Character {
  const factory _Character({
    required final String id,
    required final String name,
    final int baseHp,
    final int baseMp,
    final int baseAtk,
    final int baseDef,
    final int baseSpeed,
    final int baseLuck,
    final int baseComprehension,
    final int exp,
    final int silver,
    final int reputation,
    final RealmTier realmTier,
    final RealmStage realmStage,
    final int currentHp,
    final int currentMp,
    final String? weaponId,
    final String? armorId,
    final String? shoesId,
    final String? accessoryId,
    final String locationId,
    final DateTime? lastOnlineTime,
    final DateTime? createdAt,
  }) = _$CharacterImpl;

  factory _Character.fromJson(Map<String, dynamic> json) =
      _$CharacterImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get baseHp;
  @override
  int get baseMp;
  @override
  int get baseAtk;
  @override
  int get baseDef;
  @override
  int get baseSpeed;
  @override
  int get baseLuck;
  @override
  int get baseComprehension;
  @override
  int get exp;
  @override
  int get silver;
  @override
  int get reputation;
  @override
  RealmTier get realmTier;
  @override
  RealmStage get realmStage; // 当前状态
  @override
  int get currentHp;
  @override
  int get currentMp; // 装备 ID
  @override
  String? get weaponId;
  @override
  String? get armorId;
  @override
  String? get shoesId;
  @override
  String? get accessoryId; // 位置
  @override
  String get locationId; // 时间
  @override
  DateTime? get lastOnlineTime;
  @override
  DateTime? get createdAt;

  /// Create a copy of Character
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterImplCopyWith<_$CharacterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

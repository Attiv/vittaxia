// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  SkillType get type => throw _privateConstructorUsedError;
  SkillQuality get quality => throw _privateConstructorUsedError;
  int get baseDamage => throw _privateConstructorUsedError;
  double get damageMultiplier => throw _privateConstructorUsedError;
  int get mpCost => throw _privateConstructorUsedError; // buff 效果
  int get buffAtk => throw _privateConstructorUsedError;
  int get buffDef => throw _privateConstructorUsedError;
  int get buffSpeed => throw _privateConstructorUsedError;
  int get healAmount => throw _privateConstructorUsedError;
  int get buffDuration => throw _privateConstructorUsedError; // 学习条件
  int get requiredLevel => throw _privateConstructorUsedError;
  int get learnCost => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    SkillType type,
    SkillQuality quality,
    int baseDamage,
    double damageMultiplier,
    int mpCost,
    int buffAtk,
    int buffDef,
    int buffSpeed,
    int healAmount,
    int buffDuration,
    int requiredLevel,
    int learnCost,
  });
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? quality = null,
    Object? baseDamage = null,
    Object? damageMultiplier = null,
    Object? mpCost = null,
    Object? buffAtk = null,
    Object? buffDef = null,
    Object? buffSpeed = null,
    Object? healAmount = null,
    Object? buffDuration = null,
    Object? requiredLevel = null,
    Object? learnCost = null,
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
                      as SkillType,
            quality: null == quality
                ? _value.quality
                : quality // ignore: cast_nullable_to_non_nullable
                      as SkillQuality,
            baseDamage: null == baseDamage
                ? _value.baseDamage
                : baseDamage // ignore: cast_nullable_to_non_nullable
                      as int,
            damageMultiplier: null == damageMultiplier
                ? _value.damageMultiplier
                : damageMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            mpCost: null == mpCost
                ? _value.mpCost
                : mpCost // ignore: cast_nullable_to_non_nullable
                      as int,
            buffAtk: null == buffAtk
                ? _value.buffAtk
                : buffAtk // ignore: cast_nullable_to_non_nullable
                      as int,
            buffDef: null == buffDef
                ? _value.buffDef
                : buffDef // ignore: cast_nullable_to_non_nullable
                      as int,
            buffSpeed: null == buffSpeed
                ? _value.buffSpeed
                : buffSpeed // ignore: cast_nullable_to_non_nullable
                      as int,
            healAmount: null == healAmount
                ? _value.healAmount
                : healAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            buffDuration: null == buffDuration
                ? _value.buffDuration
                : buffDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredLevel: null == requiredLevel
                ? _value.requiredLevel
                : requiredLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            learnCost: null == learnCost
                ? _value.learnCost
                : learnCost // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
    _$SkillImpl value,
    $Res Function(_$SkillImpl) then,
  ) = __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    SkillType type,
    SkillQuality quality,
    int baseDamage,
    double damageMultiplier,
    int mpCost,
    int buffAtk,
    int buffDef,
    int buffSpeed,
    int healAmount,
    int buffDuration,
    int requiredLevel,
    int learnCost,
  });
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
    _$SkillImpl _value,
    $Res Function(_$SkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? quality = null,
    Object? baseDamage = null,
    Object? damageMultiplier = null,
    Object? mpCost = null,
    Object? buffAtk = null,
    Object? buffDef = null,
    Object? buffSpeed = null,
    Object? healAmount = null,
    Object? buffDuration = null,
    Object? requiredLevel = null,
    Object? learnCost = null,
  }) {
    return _then(
      _$SkillImpl(
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
                  as SkillType,
        quality: null == quality
            ? _value.quality
            : quality // ignore: cast_nullable_to_non_nullable
                  as SkillQuality,
        baseDamage: null == baseDamage
            ? _value.baseDamage
            : baseDamage // ignore: cast_nullable_to_non_nullable
                  as int,
        damageMultiplier: null == damageMultiplier
            ? _value.damageMultiplier
            : damageMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        mpCost: null == mpCost
            ? _value.mpCost
            : mpCost // ignore: cast_nullable_to_non_nullable
                  as int,
        buffAtk: null == buffAtk
            ? _value.buffAtk
            : buffAtk // ignore: cast_nullable_to_non_nullable
                  as int,
        buffDef: null == buffDef
            ? _value.buffDef
            : buffDef // ignore: cast_nullable_to_non_nullable
                  as int,
        buffSpeed: null == buffSpeed
            ? _value.buffSpeed
            : buffSpeed // ignore: cast_nullable_to_non_nullable
                  as int,
        healAmount: null == healAmount
            ? _value.healAmount
            : healAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        buffDuration: null == buffDuration
            ? _value.buffDuration
            : buffDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredLevel: null == requiredLevel
            ? _value.requiredLevel
            : requiredLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        learnCost: null == learnCost
            ? _value.learnCost
            : learnCost // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl implements _Skill {
  const _$SkillImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.quality = SkillQuality.crude,
    this.baseDamage = 10,
    this.damageMultiplier = 1.0,
    this.mpCost = 0,
    this.buffAtk = 0,
    this.buffDef = 0,
    this.buffSpeed = 0,
    this.healAmount = 0,
    this.buffDuration = 0,
    this.requiredLevel = 0,
    this.learnCost = 0,
  });

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final SkillType type;
  @override
  @JsonKey()
  final SkillQuality quality;
  @override
  @JsonKey()
  final int baseDamage;
  @override
  @JsonKey()
  final double damageMultiplier;
  @override
  @JsonKey()
  final int mpCost;
  // buff 效果
  @override
  @JsonKey()
  final int buffAtk;
  @override
  @JsonKey()
  final int buffDef;
  @override
  @JsonKey()
  final int buffSpeed;
  @override
  @JsonKey()
  final int healAmount;
  @override
  @JsonKey()
  final int buffDuration;
  // 学习条件
  @override
  @JsonKey()
  final int requiredLevel;
  @override
  @JsonKey()
  final int learnCost;

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, description: $description, type: $type, quality: $quality, baseDamage: $baseDamage, damageMultiplier: $damageMultiplier, mpCost: $mpCost, buffAtk: $buffAtk, buffDef: $buffDef, buffSpeed: $buffSpeed, healAmount: $healAmount, buffDuration: $buffDuration, requiredLevel: $requiredLevel, learnCost: $learnCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.baseDamage, baseDamage) ||
                other.baseDamage == baseDamage) &&
            (identical(other.damageMultiplier, damageMultiplier) ||
                other.damageMultiplier == damageMultiplier) &&
            (identical(other.mpCost, mpCost) || other.mpCost == mpCost) &&
            (identical(other.buffAtk, buffAtk) || other.buffAtk == buffAtk) &&
            (identical(other.buffDef, buffDef) || other.buffDef == buffDef) &&
            (identical(other.buffSpeed, buffSpeed) ||
                other.buffSpeed == buffSpeed) &&
            (identical(other.healAmount, healAmount) ||
                other.healAmount == healAmount) &&
            (identical(other.buffDuration, buffDuration) ||
                other.buffDuration == buffDuration) &&
            (identical(other.requiredLevel, requiredLevel) ||
                other.requiredLevel == requiredLevel) &&
            (identical(other.learnCost, learnCost) ||
                other.learnCost == learnCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    quality,
    baseDamage,
    damageMultiplier,
    mpCost,
    buffAtk,
    buffDef,
    buffSpeed,
    healAmount,
    buffDuration,
    requiredLevel,
    learnCost,
  );

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(this);
  }
}

abstract class _Skill implements Skill {
  const factory _Skill({
    required final String id,
    required final String name,
    required final String description,
    required final SkillType type,
    final SkillQuality quality,
    final int baseDamage,
    final double damageMultiplier,
    final int mpCost,
    final int buffAtk,
    final int buffDef,
    final int buffSpeed,
    final int healAmount,
    final int buffDuration,
    final int requiredLevel,
    final int learnCost,
  }) = _$SkillImpl;

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  SkillType get type;
  @override
  SkillQuality get quality;
  @override
  int get baseDamage;
  @override
  double get damageMultiplier;
  @override
  int get mpCost; // buff 效果
  @override
  int get buffAtk;
  @override
  int get buffDef;
  @override
  int get buffSpeed;
  @override
  int get healAmount;
  @override
  int get buffDuration; // 学习条件
  @override
  int get requiredLevel;
  @override
  int get learnCost;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

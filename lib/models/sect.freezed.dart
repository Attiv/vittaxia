// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Sect _$SectFromJson(Map<String, dynamic> json) {
  return _Sect.fromJson(json);
}

/// @nodoc
mixin _$Sect {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  SectType get type => throw _privateConstructorUsedError; // 入门要求
  RealmTier get requiredRealm => throw _privateConstructorUsedError;
  int get requiredReputation => throw _privateConstructorUsedError;
  String? get requiredQuestId => throw _privateConstructorUsedError; // 师门特色
  List<String> get specialtySkills => throw _privateConstructorUsedError;
  List<String> get teacherNpcIds => throw _privateConstructorUsedError; // 师门任务
  List<String> get sectQuestIds => throw _privateConstructorUsedError; // 师门加成
  int get atkBonus => throw _privateConstructorUsedError;
  int get defBonus => throw _privateConstructorUsedError;
  int get speedBonus => throw _privateConstructorUsedError;

  /// Serializes this Sect to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectCopyWith<Sect> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectCopyWith<$Res> {
  factory $SectCopyWith(Sect value, $Res Function(Sect) then) =
      _$SectCopyWithImpl<$Res, Sect>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    SectType type,
    RealmTier requiredRealm,
    int requiredReputation,
    String? requiredQuestId,
    List<String> specialtySkills,
    List<String> teacherNpcIds,
    List<String> sectQuestIds,
    int atkBonus,
    int defBonus,
    int speedBonus,
  });
}

/// @nodoc
class _$SectCopyWithImpl<$Res, $Val extends Sect>
    implements $SectCopyWith<$Res> {
  _$SectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? requiredRealm = null,
    Object? requiredReputation = null,
    Object? requiredQuestId = freezed,
    Object? specialtySkills = null,
    Object? teacherNpcIds = null,
    Object? sectQuestIds = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? speedBonus = null,
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
                      as SectType,
            requiredRealm: null == requiredRealm
                ? _value.requiredRealm
                : requiredRealm // ignore: cast_nullable_to_non_nullable
                      as RealmTier,
            requiredReputation: null == requiredReputation
                ? _value.requiredReputation
                : requiredReputation // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredQuestId: freezed == requiredQuestId
                ? _value.requiredQuestId
                : requiredQuestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialtySkills: null == specialtySkills
                ? _value.specialtySkills
                : specialtySkills // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            teacherNpcIds: null == teacherNpcIds
                ? _value.teacherNpcIds
                : teacherNpcIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            sectQuestIds: null == sectQuestIds
                ? _value.sectQuestIds
                : sectQuestIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            atkBonus: null == atkBonus
                ? _value.atkBonus
                : atkBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            defBonus: null == defBonus
                ? _value.defBonus
                : defBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            speedBonus: null == speedBonus
                ? _value.speedBonus
                : speedBonus // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SectImplCopyWith<$Res> implements $SectCopyWith<$Res> {
  factory _$$SectImplCopyWith(
    _$SectImpl value,
    $Res Function(_$SectImpl) then,
  ) = __$$SectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    SectType type,
    RealmTier requiredRealm,
    int requiredReputation,
    String? requiredQuestId,
    List<String> specialtySkills,
    List<String> teacherNpcIds,
    List<String> sectQuestIds,
    int atkBonus,
    int defBonus,
    int speedBonus,
  });
}

/// @nodoc
class __$$SectImplCopyWithImpl<$Res>
    extends _$SectCopyWithImpl<$Res, _$SectImpl>
    implements _$$SectImplCopyWith<$Res> {
  __$$SectImplCopyWithImpl(_$SectImpl _value, $Res Function(_$SectImpl) _then)
    : super(_value, _then);

  /// Create a copy of Sect
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? requiredRealm = null,
    Object? requiredReputation = null,
    Object? requiredQuestId = freezed,
    Object? specialtySkills = null,
    Object? teacherNpcIds = null,
    Object? sectQuestIds = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? speedBonus = null,
  }) {
    return _then(
      _$SectImpl(
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
                  as SectType,
        requiredRealm: null == requiredRealm
            ? _value.requiredRealm
            : requiredRealm // ignore: cast_nullable_to_non_nullable
                  as RealmTier,
        requiredReputation: null == requiredReputation
            ? _value.requiredReputation
            : requiredReputation // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredQuestId: freezed == requiredQuestId
            ? _value.requiredQuestId
            : requiredQuestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialtySkills: null == specialtySkills
            ? _value._specialtySkills
            : specialtySkills // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        teacherNpcIds: null == teacherNpcIds
            ? _value._teacherNpcIds
            : teacherNpcIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        sectQuestIds: null == sectQuestIds
            ? _value._sectQuestIds
            : sectQuestIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        atkBonus: null == atkBonus
            ? _value.atkBonus
            : atkBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        defBonus: null == defBonus
            ? _value.defBonus
            : defBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        speedBonus: null == speedBonus
            ? _value.speedBonus
            : speedBonus // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SectImpl implements _Sect {
  const _$SectImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.requiredRealm = RealmTier.houTian,
    this.requiredReputation = 0,
    this.requiredQuestId,
    final List<String> specialtySkills = const [],
    final List<String> teacherNpcIds = const [],
    final List<String> sectQuestIds = const [],
    this.atkBonus = 0,
    this.defBonus = 0,
    this.speedBonus = 0,
  }) : _specialtySkills = specialtySkills,
       _teacherNpcIds = teacherNpcIds,
       _sectQuestIds = sectQuestIds;

  factory _$SectImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final SectType type;
  // 入门要求
  @override
  @JsonKey()
  final RealmTier requiredRealm;
  @override
  @JsonKey()
  final int requiredReputation;
  @override
  final String? requiredQuestId;
  // 师门特色
  final List<String> _specialtySkills;
  // 师门特色
  @override
  @JsonKey()
  List<String> get specialtySkills {
    if (_specialtySkills is EqualUnmodifiableListView) return _specialtySkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialtySkills);
  }

  final List<String> _teacherNpcIds;
  @override
  @JsonKey()
  List<String> get teacherNpcIds {
    if (_teacherNpcIds is EqualUnmodifiableListView) return _teacherNpcIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teacherNpcIds);
  }

  // 师门任务
  final List<String> _sectQuestIds;
  // 师门任务
  @override
  @JsonKey()
  List<String> get sectQuestIds {
    if (_sectQuestIds is EqualUnmodifiableListView) return _sectQuestIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sectQuestIds);
  }

  // 师门加成
  @override
  @JsonKey()
  final int atkBonus;
  @override
  @JsonKey()
  final int defBonus;
  @override
  @JsonKey()
  final int speedBonus;

  @override
  String toString() {
    return 'Sect(id: $id, name: $name, description: $description, type: $type, requiredRealm: $requiredRealm, requiredReputation: $requiredReputation, requiredQuestId: $requiredQuestId, specialtySkills: $specialtySkills, teacherNpcIds: $teacherNpcIds, sectQuestIds: $sectQuestIds, atkBonus: $atkBonus, defBonus: $defBonus, speedBonus: $speedBonus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.requiredRealm, requiredRealm) ||
                other.requiredRealm == requiredRealm) &&
            (identical(other.requiredReputation, requiredReputation) ||
                other.requiredReputation == requiredReputation) &&
            (identical(other.requiredQuestId, requiredQuestId) ||
                other.requiredQuestId == requiredQuestId) &&
            const DeepCollectionEquality().equals(
              other._specialtySkills,
              _specialtySkills,
            ) &&
            const DeepCollectionEquality().equals(
              other._teacherNpcIds,
              _teacherNpcIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._sectQuestIds,
              _sectQuestIds,
            ) &&
            (identical(other.atkBonus, atkBonus) ||
                other.atkBonus == atkBonus) &&
            (identical(other.defBonus, defBonus) ||
                other.defBonus == defBonus) &&
            (identical(other.speedBonus, speedBonus) ||
                other.speedBonus == speedBonus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    requiredRealm,
    requiredReputation,
    requiredQuestId,
    const DeepCollectionEquality().hash(_specialtySkills),
    const DeepCollectionEquality().hash(_teacherNpcIds),
    const DeepCollectionEquality().hash(_sectQuestIds),
    atkBonus,
    defBonus,
    speedBonus,
  );

  /// Create a copy of Sect
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectImplCopyWith<_$SectImpl> get copyWith =>
      __$$SectImplCopyWithImpl<_$SectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectImplToJson(this);
  }
}

abstract class _Sect implements Sect {
  const factory _Sect({
    required final String id,
    required final String name,
    required final String description,
    required final SectType type,
    final RealmTier requiredRealm,
    final int requiredReputation,
    final String? requiredQuestId,
    final List<String> specialtySkills,
    final List<String> teacherNpcIds,
    final List<String> sectQuestIds,
    final int atkBonus,
    final int defBonus,
    final int speedBonus,
  }) = _$SectImpl;

  factory _Sect.fromJson(Map<String, dynamic> json) = _$SectImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  SectType get type; // 入门要求
  @override
  RealmTier get requiredRealm;
  @override
  int get requiredReputation;
  @override
  String? get requiredQuestId; // 师门特色
  @override
  List<String> get specialtySkills;
  @override
  List<String> get teacherNpcIds; // 师门任务
  @override
  List<String> get sectQuestIds; // 师门加成
  @override
  int get atkBonus;
  @override
  int get defBonus;
  @override
  int get speedBonus;

  /// Create a copy of Sect
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectImplCopyWith<_$SectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SectQuest _$SectQuestFromJson(Map<String, dynamic> json) {
  return _SectQuest.fromJson(json);
}

/// @nodoc
mixin _$SectQuest {
  String get id => throw _privateConstructorUsedError;
  String get sectId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<SectQuestObjective> get objectives =>
      throw _privateConstructorUsedError; // 奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  int get rewardContribution => throw _privateConstructorUsedError; // 师门贡献度
  String? get rewardSkillId => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError; // 要求
  int get requiredContribution => throw _privateConstructorUsedError;
  RealmTier get requiredRealm => throw _privateConstructorUsedError; // 可重复
  bool get repeatable => throw _privateConstructorUsedError;
  int get cooldownHours => throw _privateConstructorUsedError;

  /// Serializes this SectQuest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectQuest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectQuestCopyWith<SectQuest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectQuestCopyWith<$Res> {
  factory $SectQuestCopyWith(SectQuest value, $Res Function(SectQuest) then) =
      _$SectQuestCopyWithImpl<$Res, SectQuest>;
  @useResult
  $Res call({
    String id,
    String sectId,
    String name,
    String description,
    List<SectQuestObjective> objectives,
    int rewardExp,
    int rewardSilver,
    int rewardContribution,
    String? rewardSkillId,
    String? rewardItemId,
    int requiredContribution,
    RealmTier requiredRealm,
    bool repeatable,
    int cooldownHours,
  });
}

/// @nodoc
class _$SectQuestCopyWithImpl<$Res, $Val extends SectQuest>
    implements $SectQuestCopyWith<$Res> {
  _$SectQuestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectQuest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sectId = null,
    Object? name = null,
    Object? description = null,
    Object? objectives = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardContribution = null,
    Object? rewardSkillId = freezed,
    Object? rewardItemId = freezed,
    Object? requiredContribution = null,
    Object? requiredRealm = null,
    Object? repeatable = null,
    Object? cooldownHours = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sectId: null == sectId
                ? _value.sectId
                : sectId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            objectives: null == objectives
                ? _value.objectives
                : objectives // ignore: cast_nullable_to_non_nullable
                      as List<SectQuestObjective>,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardContribution: null == rewardContribution
                ? _value.rewardContribution
                : rewardContribution // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSkillId: freezed == rewardSkillId
                ? _value.rewardSkillId
                : rewardSkillId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredContribution: null == requiredContribution
                ? _value.requiredContribution
                : requiredContribution // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredRealm: null == requiredRealm
                ? _value.requiredRealm
                : requiredRealm // ignore: cast_nullable_to_non_nullable
                      as RealmTier,
            repeatable: null == repeatable
                ? _value.repeatable
                : repeatable // ignore: cast_nullable_to_non_nullable
                      as bool,
            cooldownHours: null == cooldownHours
                ? _value.cooldownHours
                : cooldownHours // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SectQuestImplCopyWith<$Res>
    implements $SectQuestCopyWith<$Res> {
  factory _$$SectQuestImplCopyWith(
    _$SectQuestImpl value,
    $Res Function(_$SectQuestImpl) then,
  ) = __$$SectQuestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sectId,
    String name,
    String description,
    List<SectQuestObjective> objectives,
    int rewardExp,
    int rewardSilver,
    int rewardContribution,
    String? rewardSkillId,
    String? rewardItemId,
    int requiredContribution,
    RealmTier requiredRealm,
    bool repeatable,
    int cooldownHours,
  });
}

/// @nodoc
class __$$SectQuestImplCopyWithImpl<$Res>
    extends _$SectQuestCopyWithImpl<$Res, _$SectQuestImpl>
    implements _$$SectQuestImplCopyWith<$Res> {
  __$$SectQuestImplCopyWithImpl(
    _$SectQuestImpl _value,
    $Res Function(_$SectQuestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SectQuest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sectId = null,
    Object? name = null,
    Object? description = null,
    Object? objectives = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardContribution = null,
    Object? rewardSkillId = freezed,
    Object? rewardItemId = freezed,
    Object? requiredContribution = null,
    Object? requiredRealm = null,
    Object? repeatable = null,
    Object? cooldownHours = null,
  }) {
    return _then(
      _$SectQuestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sectId: null == sectId
            ? _value.sectId
            : sectId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        objectives: null == objectives
            ? _value._objectives
            : objectives // ignore: cast_nullable_to_non_nullable
                  as List<SectQuestObjective>,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardContribution: null == rewardContribution
            ? _value.rewardContribution
            : rewardContribution // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSkillId: freezed == rewardSkillId
            ? _value.rewardSkillId
            : rewardSkillId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredContribution: null == requiredContribution
            ? _value.requiredContribution
            : requiredContribution // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredRealm: null == requiredRealm
            ? _value.requiredRealm
            : requiredRealm // ignore: cast_nullable_to_non_nullable
                  as RealmTier,
        repeatable: null == repeatable
            ? _value.repeatable
            : repeatable // ignore: cast_nullable_to_non_nullable
                  as bool,
        cooldownHours: null == cooldownHours
            ? _value.cooldownHours
            : cooldownHours // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SectQuestImpl implements _SectQuest {
  const _$SectQuestImpl({
    required this.id,
    required this.sectId,
    required this.name,
    required this.description,
    required final List<SectQuestObjective> objectives,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardContribution = 0,
    this.rewardSkillId,
    this.rewardItemId,
    this.requiredContribution = 0,
    this.requiredRealm = RealmTier.houTian,
    this.repeatable = false,
    this.cooldownHours = 0,
  }) : _objectives = objectives;

  factory _$SectQuestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectQuestImplFromJson(json);

  @override
  final String id;
  @override
  final String sectId;
  @override
  final String name;
  @override
  final String description;
  final List<SectQuestObjective> _objectives;
  @override
  List<SectQuestObjective> get objectives {
    if (_objectives is EqualUnmodifiableListView) return _objectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectives);
  }

  // 奖励
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  @override
  @JsonKey()
  final int rewardContribution;
  // 师门贡献度
  @override
  final String? rewardSkillId;
  @override
  final String? rewardItemId;
  // 要求
  @override
  @JsonKey()
  final int requiredContribution;
  @override
  @JsonKey()
  final RealmTier requiredRealm;
  // 可重复
  @override
  @JsonKey()
  final bool repeatable;
  @override
  @JsonKey()
  final int cooldownHours;

  @override
  String toString() {
    return 'SectQuest(id: $id, sectId: $sectId, name: $name, description: $description, objectives: $objectives, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardContribution: $rewardContribution, rewardSkillId: $rewardSkillId, rewardItemId: $rewardItemId, requiredContribution: $requiredContribution, requiredRealm: $requiredRealm, repeatable: $repeatable, cooldownHours: $cooldownHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectQuestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sectId, sectId) || other.sectId == sectId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._objectives,
              _objectives,
            ) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardContribution, rewardContribution) ||
                other.rewardContribution == rewardContribution) &&
            (identical(other.rewardSkillId, rewardSkillId) ||
                other.rewardSkillId == rewardSkillId) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.requiredContribution, requiredContribution) ||
                other.requiredContribution == requiredContribution) &&
            (identical(other.requiredRealm, requiredRealm) ||
                other.requiredRealm == requiredRealm) &&
            (identical(other.repeatable, repeatable) ||
                other.repeatable == repeatable) &&
            (identical(other.cooldownHours, cooldownHours) ||
                other.cooldownHours == cooldownHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sectId,
    name,
    description,
    const DeepCollectionEquality().hash(_objectives),
    rewardExp,
    rewardSilver,
    rewardContribution,
    rewardSkillId,
    rewardItemId,
    requiredContribution,
    requiredRealm,
    repeatable,
    cooldownHours,
  );

  /// Create a copy of SectQuest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectQuestImplCopyWith<_$SectQuestImpl> get copyWith =>
      __$$SectQuestImplCopyWithImpl<_$SectQuestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectQuestImplToJson(this);
  }
}

abstract class _SectQuest implements SectQuest {
  const factory _SectQuest({
    required final String id,
    required final String sectId,
    required final String name,
    required final String description,
    required final List<SectQuestObjective> objectives,
    final int rewardExp,
    final int rewardSilver,
    final int rewardContribution,
    final String? rewardSkillId,
    final String? rewardItemId,
    final int requiredContribution,
    final RealmTier requiredRealm,
    final bool repeatable,
    final int cooldownHours,
  }) = _$SectQuestImpl;

  factory _SectQuest.fromJson(Map<String, dynamic> json) =
      _$SectQuestImpl.fromJson;

  @override
  String get id;
  @override
  String get sectId;
  @override
  String get name;
  @override
  String get description;
  @override
  List<SectQuestObjective> get objectives; // 奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  int get rewardContribution; // 师门贡献度
  @override
  String? get rewardSkillId;
  @override
  String? get rewardItemId; // 要求
  @override
  int get requiredContribution;
  @override
  RealmTier get requiredRealm; // 可重复
  @override
  bool get repeatable;
  @override
  int get cooldownHours;

  /// Create a copy of SectQuest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectQuestImplCopyWith<_$SectQuestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SectQuestObjective _$SectQuestObjectiveFromJson(Map<String, dynamic> json) {
  return _SectQuestObjective.fromJson(json);
}

/// @nodoc
mixin _$SectQuestObjective {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  QuestObjectiveType get type => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;
  int get requiredCount => throw _privateConstructorUsedError;

  /// Serializes this SectQuestObjective to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectQuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectQuestObjectiveCopyWith<SectQuestObjective> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectQuestObjectiveCopyWith<$Res> {
  factory $SectQuestObjectiveCopyWith(
    SectQuestObjective value,
    $Res Function(SectQuestObjective) then,
  ) = _$SectQuestObjectiveCopyWithImpl<$Res, SectQuestObjective>;
  @useResult
  $Res call({
    String id,
    String description,
    QuestObjectiveType type,
    String? targetId,
    int requiredCount,
  });
}

/// @nodoc
class _$SectQuestObjectiveCopyWithImpl<$Res, $Val extends SectQuestObjective>
    implements $SectQuestObjectiveCopyWith<$Res> {
  _$SectQuestObjectiveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectQuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? type = null,
    Object? targetId = freezed,
    Object? requiredCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as QuestObjectiveType,
            targetId: freezed == targetId
                ? _value.targetId
                : targetId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredCount: null == requiredCount
                ? _value.requiredCount
                : requiredCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SectQuestObjectiveImplCopyWith<$Res>
    implements $SectQuestObjectiveCopyWith<$Res> {
  factory _$$SectQuestObjectiveImplCopyWith(
    _$SectQuestObjectiveImpl value,
    $Res Function(_$SectQuestObjectiveImpl) then,
  ) = __$$SectQuestObjectiveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String description,
    QuestObjectiveType type,
    String? targetId,
    int requiredCount,
  });
}

/// @nodoc
class __$$SectQuestObjectiveImplCopyWithImpl<$Res>
    extends _$SectQuestObjectiveCopyWithImpl<$Res, _$SectQuestObjectiveImpl>
    implements _$$SectQuestObjectiveImplCopyWith<$Res> {
  __$$SectQuestObjectiveImplCopyWithImpl(
    _$SectQuestObjectiveImpl _value,
    $Res Function(_$SectQuestObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SectQuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? type = null,
    Object? targetId = freezed,
    Object? requiredCount = null,
  }) {
    return _then(
      _$SectQuestObjectiveImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as QuestObjectiveType,
        targetId: freezed == targetId
            ? _value.targetId
            : targetId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredCount: null == requiredCount
            ? _value.requiredCount
            : requiredCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SectQuestObjectiveImpl implements _SectQuestObjective {
  const _$SectQuestObjectiveImpl({
    required this.id,
    required this.description,
    required this.type,
    this.targetId,
    this.requiredCount = 1,
  });

  factory _$SectQuestObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectQuestObjectiveImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final QuestObjectiveType type;
  @override
  final String? targetId;
  @override
  @JsonKey()
  final int requiredCount;

  @override
  String toString() {
    return 'SectQuestObjective(id: $id, description: $description, type: $type, targetId: $targetId, requiredCount: $requiredCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectQuestObjectiveImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.requiredCount, requiredCount) ||
                other.requiredCount == requiredCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, description, type, targetId, requiredCount);

  /// Create a copy of SectQuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectQuestObjectiveImplCopyWith<_$SectQuestObjectiveImpl> get copyWith =>
      __$$SectQuestObjectiveImplCopyWithImpl<_$SectQuestObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SectQuestObjectiveImplToJson(this);
  }
}

abstract class _SectQuestObjective implements SectQuestObjective {
  const factory _SectQuestObjective({
    required final String id,
    required final String description,
    required final QuestObjectiveType type,
    final String? targetId,
    final int requiredCount,
  }) = _$SectQuestObjectiveImpl;

  factory _SectQuestObjective.fromJson(Map<String, dynamic> json) =
      _$SectQuestObjectiveImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  QuestObjectiveType get type;
  @override
  String? get targetId;
  @override
  int get requiredCount;

  /// Create a copy of SectQuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectQuestObjectiveImplCopyWith<_$SectQuestObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

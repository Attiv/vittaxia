// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Quest _$QuestFromJson(Map<String, dynamic> json) {
  return _Quest.fromJson(json);
}

/// @nodoc
mixin _$Quest {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  QuestType get type => throw _privateConstructorUsedError;
  List<QuestObjective> get objectives =>
      throw _privateConstructorUsedError; // 奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  int get rewardReputation => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;
  String? get rewardSkillId => throw _privateConstructorUsedError; // 前置任务
  String? get prerequisiteQuestId =>
      throw _privateConstructorUsedError; // 接取地点/NPC
  String? get questGiverNpcId => throw _privateConstructorUsedError;
  String? get questLocationId => throw _privateConstructorUsedError;

  /// Serializes this Quest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestCopyWith<Quest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestCopyWith<$Res> {
  factory $QuestCopyWith(Quest value, $Res Function(Quest) then) =
      _$QuestCopyWithImpl<$Res, Quest>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    QuestType type,
    List<QuestObjective> objectives,
    int rewardExp,
    int rewardSilver,
    int rewardReputation,
    String? rewardItemId,
    String? rewardSkillId,
    String? prerequisiteQuestId,
    String? questGiverNpcId,
    String? questLocationId,
  });
}

/// @nodoc
class _$QuestCopyWithImpl<$Res, $Val extends Quest>
    implements $QuestCopyWith<$Res> {
  _$QuestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? objectives = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardReputation = null,
    Object? rewardItemId = freezed,
    Object? rewardSkillId = freezed,
    Object? prerequisiteQuestId = freezed,
    Object? questGiverNpcId = freezed,
    Object? questLocationId = freezed,
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
                      as QuestType,
            objectives: null == objectives
                ? _value.objectives
                : objectives // ignore: cast_nullable_to_non_nullable
                      as List<QuestObjective>,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardReputation: null == rewardReputation
                ? _value.rewardReputation
                : rewardReputation // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardSkillId: freezed == rewardSkillId
                ? _value.rewardSkillId
                : rewardSkillId // ignore: cast_nullable_to_non_nullable
                      as String?,
            prerequisiteQuestId: freezed == prerequisiteQuestId
                ? _value.prerequisiteQuestId
                : prerequisiteQuestId // ignore: cast_nullable_to_non_nullable
                      as String?,
            questGiverNpcId: freezed == questGiverNpcId
                ? _value.questGiverNpcId
                : questGiverNpcId // ignore: cast_nullable_to_non_nullable
                      as String?,
            questLocationId: freezed == questLocationId
                ? _value.questLocationId
                : questLocationId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestImplCopyWith<$Res> implements $QuestCopyWith<$Res> {
  factory _$$QuestImplCopyWith(
    _$QuestImpl value,
    $Res Function(_$QuestImpl) then,
  ) = __$$QuestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    QuestType type,
    List<QuestObjective> objectives,
    int rewardExp,
    int rewardSilver,
    int rewardReputation,
    String? rewardItemId,
    String? rewardSkillId,
    String? prerequisiteQuestId,
    String? questGiverNpcId,
    String? questLocationId,
  });
}

/// @nodoc
class __$$QuestImplCopyWithImpl<$Res>
    extends _$QuestCopyWithImpl<$Res, _$QuestImpl>
    implements _$$QuestImplCopyWith<$Res> {
  __$$QuestImplCopyWithImpl(
    _$QuestImpl _value,
    $Res Function(_$QuestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Quest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? objectives = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardReputation = null,
    Object? rewardItemId = freezed,
    Object? rewardSkillId = freezed,
    Object? prerequisiteQuestId = freezed,
    Object? questGiverNpcId = freezed,
    Object? questLocationId = freezed,
  }) {
    return _then(
      _$QuestImpl(
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
                  as QuestType,
        objectives: null == objectives
            ? _value._objectives
            : objectives // ignore: cast_nullable_to_non_nullable
                  as List<QuestObjective>,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardReputation: null == rewardReputation
            ? _value.rewardReputation
            : rewardReputation // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardSkillId: freezed == rewardSkillId
            ? _value.rewardSkillId
            : rewardSkillId // ignore: cast_nullable_to_non_nullable
                  as String?,
        prerequisiteQuestId: freezed == prerequisiteQuestId
            ? _value.prerequisiteQuestId
            : prerequisiteQuestId // ignore: cast_nullable_to_non_nullable
                  as String?,
        questGiverNpcId: freezed == questGiverNpcId
            ? _value.questGiverNpcId
            : questGiverNpcId // ignore: cast_nullable_to_non_nullable
                  as String?,
        questLocationId: freezed == questLocationId
            ? _value.questLocationId
            : questLocationId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestImpl implements _Quest {
  const _$QuestImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    final List<QuestObjective> objectives = const [],
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardReputation = 0,
    this.rewardItemId,
    this.rewardSkillId,
    this.prerequisiteQuestId,
    this.questGiverNpcId,
    this.questLocationId,
  }) : _objectives = objectives;

  factory _$QuestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final QuestType type;
  final List<QuestObjective> _objectives;
  @override
  @JsonKey()
  List<QuestObjective> get objectives {
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
  final int rewardReputation;
  @override
  final String? rewardItemId;
  @override
  final String? rewardSkillId;
  // 前置任务
  @override
  final String? prerequisiteQuestId;
  // 接取地点/NPC
  @override
  final String? questGiverNpcId;
  @override
  final String? questLocationId;

  @override
  String toString() {
    return 'Quest(id: $id, name: $name, description: $description, type: $type, objectives: $objectives, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardReputation: $rewardReputation, rewardItemId: $rewardItemId, rewardSkillId: $rewardSkillId, prerequisiteQuestId: $prerequisiteQuestId, questGiverNpcId: $questGiverNpcId, questLocationId: $questLocationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._objectives,
              _objectives,
            ) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardReputation, rewardReputation) ||
                other.rewardReputation == rewardReputation) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.rewardSkillId, rewardSkillId) ||
                other.rewardSkillId == rewardSkillId) &&
            (identical(other.prerequisiteQuestId, prerequisiteQuestId) ||
                other.prerequisiteQuestId == prerequisiteQuestId) &&
            (identical(other.questGiverNpcId, questGiverNpcId) ||
                other.questGiverNpcId == questGiverNpcId) &&
            (identical(other.questLocationId, questLocationId) ||
                other.questLocationId == questLocationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    const DeepCollectionEquality().hash(_objectives),
    rewardExp,
    rewardSilver,
    rewardReputation,
    rewardItemId,
    rewardSkillId,
    prerequisiteQuestId,
    questGiverNpcId,
    questLocationId,
  );

  /// Create a copy of Quest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestImplCopyWith<_$QuestImpl> get copyWith =>
      __$$QuestImplCopyWithImpl<_$QuestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestImplToJson(this);
  }
}

abstract class _Quest implements Quest {
  const factory _Quest({
    required final String id,
    required final String name,
    required final String description,
    required final QuestType type,
    final List<QuestObjective> objectives,
    final int rewardExp,
    final int rewardSilver,
    final int rewardReputation,
    final String? rewardItemId,
    final String? rewardSkillId,
    final String? prerequisiteQuestId,
    final String? questGiverNpcId,
    final String? questLocationId,
  }) = _$QuestImpl;

  factory _Quest.fromJson(Map<String, dynamic> json) = _$QuestImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  QuestType get type;
  @override
  List<QuestObjective> get objectives; // 奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  int get rewardReputation;
  @override
  String? get rewardItemId;
  @override
  String? get rewardSkillId; // 前置任务
  @override
  String? get prerequisiteQuestId; // 接取地点/NPC
  @override
  String? get questGiverNpcId;
  @override
  String? get questLocationId;

  /// Create a copy of Quest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestImplCopyWith<_$QuestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestObjective _$QuestObjectiveFromJson(Map<String, dynamic> json) {
  return _QuestObjective.fromJson(json);
}

/// @nodoc
mixin _$QuestObjective {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  QuestObjectiveType get type =>
      throw _privateConstructorUsedError; // 目标 ID（敌人/物品/NPC/地点）
  String? get targetId => throw _privateConstructorUsedError;
  int get requiredCount => throw _privateConstructorUsedError;

  /// Serializes this QuestObjective to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestObjectiveCopyWith<QuestObjective> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestObjectiveCopyWith<$Res> {
  factory $QuestObjectiveCopyWith(
    QuestObjective value,
    $Res Function(QuestObjective) then,
  ) = _$QuestObjectiveCopyWithImpl<$Res, QuestObjective>;
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
class _$QuestObjectiveCopyWithImpl<$Res, $Val extends QuestObjective>
    implements $QuestObjectiveCopyWith<$Res> {
  _$QuestObjectiveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestObjective
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
abstract class _$$QuestObjectiveImplCopyWith<$Res>
    implements $QuestObjectiveCopyWith<$Res> {
  factory _$$QuestObjectiveImplCopyWith(
    _$QuestObjectiveImpl value,
    $Res Function(_$QuestObjectiveImpl) then,
  ) = __$$QuestObjectiveImplCopyWithImpl<$Res>;
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
class __$$QuestObjectiveImplCopyWithImpl<$Res>
    extends _$QuestObjectiveCopyWithImpl<$Res, _$QuestObjectiveImpl>
    implements _$$QuestObjectiveImplCopyWith<$Res> {
  __$$QuestObjectiveImplCopyWithImpl(
    _$QuestObjectiveImpl _value,
    $Res Function(_$QuestObjectiveImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestObjective
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
      _$QuestObjectiveImpl(
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
class _$QuestObjectiveImpl implements _QuestObjective {
  const _$QuestObjectiveImpl({
    required this.id,
    required this.description,
    required this.type,
    this.targetId,
    this.requiredCount = 1,
  });

  factory _$QuestObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestObjectiveImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final QuestObjectiveType type;
  // 目标 ID（敌人/物品/NPC/地点）
  @override
  final String? targetId;
  @override
  @JsonKey()
  final int requiredCount;

  @override
  String toString() {
    return 'QuestObjective(id: $id, description: $description, type: $type, targetId: $targetId, requiredCount: $requiredCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestObjectiveImpl &&
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

  /// Create a copy of QuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestObjectiveImplCopyWith<_$QuestObjectiveImpl> get copyWith =>
      __$$QuestObjectiveImplCopyWithImpl<_$QuestObjectiveImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestObjectiveImplToJson(this);
  }
}

abstract class _QuestObjective implements QuestObjective {
  const factory _QuestObjective({
    required final String id,
    required final String description,
    required final QuestObjectiveType type,
    final String? targetId,
    final int requiredCount,
  }) = _$QuestObjectiveImpl;

  factory _QuestObjective.fromJson(Map<String, dynamic> json) =
      _$QuestObjectiveImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  QuestObjectiveType get type; // 目标 ID（敌人/物品/NPC/地点）
  @override
  String? get targetId;
  @override
  int get requiredCount;

  /// Create a copy of QuestObjective
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestObjectiveImplCopyWith<_$QuestObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

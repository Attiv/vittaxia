// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cultivation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CultivationSession _$CultivationSessionFromJson(Map<String, dynamic> json) {
  return _CultivationSession.fromJson(json);
}

/// @nodoc
mixin _$CultivationSession {
  String get id => throw _privateConstructorUsedError;
  String get characterId => throw _privateConstructorUsedError;
  CultivationType get type => throw _privateConstructorUsedError;
  CultivationStatus get status => throw _privateConstructorUsedError; // 修炼配置
  String? get skillId => throw _privateConstructorUsedError; // 修炼的技能ID（武技修炼时使用）
  String? get locationId => throw _privateConstructorUsedError; // 历练地点（历练探索时使用）
  // 时间
  DateTime get startTime => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError; // 预计修炼时长（分钟）
  DateTime? get completedTime =>
      throw _privateConstructorUsedError; // 奖励（完成后填充）
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  Map<String, int> get rewardItems => throw _privateConstructorUsedError;
  String? get rewardSkillId => throw _privateConstructorUsedError;

  /// Serializes this CultivationSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CultivationSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CultivationSessionCopyWith<CultivationSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CultivationSessionCopyWith<$Res> {
  factory $CultivationSessionCopyWith(
    CultivationSession value,
    $Res Function(CultivationSession) then,
  ) = _$CultivationSessionCopyWithImpl<$Res, CultivationSession>;
  @useResult
  $Res call({
    String id,
    String characterId,
    CultivationType type,
    CultivationStatus status,
    String? skillId,
    String? locationId,
    DateTime startTime,
    int durationMinutes,
    DateTime? completedTime,
    int rewardExp,
    int rewardSilver,
    Map<String, int> rewardItems,
    String? rewardSkillId,
  });
}

/// @nodoc
class _$CultivationSessionCopyWithImpl<$Res, $Val extends CultivationSession>
    implements $CultivationSessionCopyWith<$Res> {
  _$CultivationSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CultivationSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? characterId = null,
    Object? type = null,
    Object? status = null,
    Object? skillId = freezed,
    Object? locationId = freezed,
    Object? startTime = null,
    Object? durationMinutes = null,
    Object? completedTime = freezed,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItems = null,
    Object? rewardSkillId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            characterId: null == characterId
                ? _value.characterId
                : characterId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CultivationType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CultivationStatus,
            skillId: freezed == skillId
                ? _value.skillId
                : skillId // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationId: freezed == locationId
                ? _value.locationId
                : locationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            completedTime: freezed == completedTime
                ? _value.completedTime
                : completedTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardItems: null == rewardItems
                ? _value.rewardItems
                : rewardItems // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            rewardSkillId: freezed == rewardSkillId
                ? _value.rewardSkillId
                : rewardSkillId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CultivationSessionImplCopyWith<$Res>
    implements $CultivationSessionCopyWith<$Res> {
  factory _$$CultivationSessionImplCopyWith(
    _$CultivationSessionImpl value,
    $Res Function(_$CultivationSessionImpl) then,
  ) = __$$CultivationSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String characterId,
    CultivationType type,
    CultivationStatus status,
    String? skillId,
    String? locationId,
    DateTime startTime,
    int durationMinutes,
    DateTime? completedTime,
    int rewardExp,
    int rewardSilver,
    Map<String, int> rewardItems,
    String? rewardSkillId,
  });
}

/// @nodoc
class __$$CultivationSessionImplCopyWithImpl<$Res>
    extends _$CultivationSessionCopyWithImpl<$Res, _$CultivationSessionImpl>
    implements _$$CultivationSessionImplCopyWith<$Res> {
  __$$CultivationSessionImplCopyWithImpl(
    _$CultivationSessionImpl _value,
    $Res Function(_$CultivationSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CultivationSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? characterId = null,
    Object? type = null,
    Object? status = null,
    Object? skillId = freezed,
    Object? locationId = freezed,
    Object? startTime = null,
    Object? durationMinutes = null,
    Object? completedTime = freezed,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItems = null,
    Object? rewardSkillId = freezed,
  }) {
    return _then(
      _$CultivationSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        characterId: null == characterId
            ? _value.characterId
            : characterId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CultivationType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CultivationStatus,
        skillId: freezed == skillId
            ? _value.skillId
            : skillId // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationId: freezed == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        completedTime: freezed == completedTime
            ? _value.completedTime
            : completedTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardItems: null == rewardItems
            ? _value._rewardItems
            : rewardItems // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        rewardSkillId: freezed == rewardSkillId
            ? _value.rewardSkillId
            : rewardSkillId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CultivationSessionImpl implements _CultivationSession {
  const _$CultivationSessionImpl({
    required this.id,
    required this.characterId,
    required this.type,
    required this.status,
    this.skillId,
    this.locationId,
    required this.startTime,
    required this.durationMinutes,
    this.completedTime,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    final Map<String, int> rewardItems = const {},
    this.rewardSkillId,
  }) : _rewardItems = rewardItems;

  factory _$CultivationSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CultivationSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String characterId;
  @override
  final CultivationType type;
  @override
  final CultivationStatus status;
  // 修炼配置
  @override
  final String? skillId;
  // 修炼的技能ID（武技修炼时使用）
  @override
  final String? locationId;
  // 历练地点（历练探索时使用）
  // 时间
  @override
  final DateTime startTime;
  @override
  final int durationMinutes;
  // 预计修炼时长（分钟）
  @override
  final DateTime? completedTime;
  // 奖励（完成后填充）
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  final Map<String, int> _rewardItems;
  @override
  @JsonKey()
  Map<String, int> get rewardItems {
    if (_rewardItems is EqualUnmodifiableMapView) return _rewardItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rewardItems);
  }

  @override
  final String? rewardSkillId;

  @override
  String toString() {
    return 'CultivationSession(id: $id, characterId: $characterId, type: $type, status: $status, skillId: $skillId, locationId: $locationId, startTime: $startTime, durationMinutes: $durationMinutes, completedTime: $completedTime, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardItems: $rewardItems, rewardSkillId: $rewardSkillId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CultivationSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.characterId, characterId) ||
                other.characterId == characterId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.skillId, skillId) || other.skillId == skillId) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.completedTime, completedTime) ||
                other.completedTime == completedTime) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            const DeepCollectionEquality().equals(
              other._rewardItems,
              _rewardItems,
            ) &&
            (identical(other.rewardSkillId, rewardSkillId) ||
                other.rewardSkillId == rewardSkillId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    characterId,
    type,
    status,
    skillId,
    locationId,
    startTime,
    durationMinutes,
    completedTime,
    rewardExp,
    rewardSilver,
    const DeepCollectionEquality().hash(_rewardItems),
    rewardSkillId,
  );

  /// Create a copy of CultivationSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CultivationSessionImplCopyWith<_$CultivationSessionImpl> get copyWith =>
      __$$CultivationSessionImplCopyWithImpl<_$CultivationSessionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CultivationSessionImplToJson(this);
  }
}

abstract class _CultivationSession implements CultivationSession {
  const factory _CultivationSession({
    required final String id,
    required final String characterId,
    required final CultivationType type,
    required final CultivationStatus status,
    final String? skillId,
    final String? locationId,
    required final DateTime startTime,
    required final int durationMinutes,
    final DateTime? completedTime,
    final int rewardExp,
    final int rewardSilver,
    final Map<String, int> rewardItems,
    final String? rewardSkillId,
  }) = _$CultivationSessionImpl;

  factory _CultivationSession.fromJson(Map<String, dynamic> json) =
      _$CultivationSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get characterId;
  @override
  CultivationType get type;
  @override
  CultivationStatus get status; // 修炼配置
  @override
  String? get skillId; // 修炼的技能ID（武技修炼时使用）
  @override
  String? get locationId; // 历练地点（历练探索时使用）
  // 时间
  @override
  DateTime get startTime;
  @override
  int get durationMinutes; // 预计修炼时长（分钟）
  @override
  DateTime? get completedTime; // 奖励（完成后填充）
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  Map<String, int> get rewardItems;
  @override
  String? get rewardSkillId;

  /// Create a copy of CultivationSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CultivationSessionImplCopyWith<_$CultivationSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

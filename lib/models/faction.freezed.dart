// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Faction _$FactionFromJson(Map<String, dynamic> json) {
  return _Faction.fromJson(json);
}

/// @nodoc
mixin _$Faction {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  FactionType get type =>
      throw _privateConstructorUsedError; // 势力关系（其他势力ID -> 关系值，-100到100）
  Map<String, int> get relations => throw _privateConstructorUsedError; // 势力特色
  List<String> get specialties => throw _privateConstructorUsedError; // 势力据点
  List<String> get territoryIds => throw _privateConstructorUsedError;

  /// Serializes this Faction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FactionCopyWith<Faction> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FactionCopyWith<$Res> {
  factory $FactionCopyWith(Faction value, $Res Function(Faction) then) =
      _$FactionCopyWithImpl<$Res, Faction>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    FactionType type,
    Map<String, int> relations,
    List<String> specialties,
    List<String> territoryIds,
  });
}

/// @nodoc
class _$FactionCopyWithImpl<$Res, $Val extends Faction>
    implements $FactionCopyWith<$Res> {
  _$FactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? relations = null,
    Object? specialties = null,
    Object? territoryIds = null,
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
                      as FactionType,
            relations: null == relations
                ? _value.relations
                : relations // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            specialties: null == specialties
                ? _value.specialties
                : specialties // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            territoryIds: null == territoryIds
                ? _value.territoryIds
                : territoryIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FactionImplCopyWith<$Res> implements $FactionCopyWith<$Res> {
  factory _$$FactionImplCopyWith(
    _$FactionImpl value,
    $Res Function(_$FactionImpl) then,
  ) = __$$FactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    FactionType type,
    Map<String, int> relations,
    List<String> specialties,
    List<String> territoryIds,
  });
}

/// @nodoc
class __$$FactionImplCopyWithImpl<$Res>
    extends _$FactionCopyWithImpl<$Res, _$FactionImpl>
    implements _$$FactionImplCopyWith<$Res> {
  __$$FactionImplCopyWithImpl(
    _$FactionImpl _value,
    $Res Function(_$FactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? relations = null,
    Object? specialties = null,
    Object? territoryIds = null,
  }) {
    return _then(
      _$FactionImpl(
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
                  as FactionType,
        relations: null == relations
            ? _value._relations
            : relations // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        specialties: null == specialties
            ? _value._specialties
            : specialties // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        territoryIds: null == territoryIds
            ? _value._territoryIds
            : territoryIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FactionImpl implements _Faction {
  const _$FactionImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    final Map<String, int> relations = const {},
    final List<String> specialties = const [],
    final List<String> territoryIds = const [],
  }) : _relations = relations,
       _specialties = specialties,
       _territoryIds = territoryIds;

  factory _$FactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FactionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final FactionType type;
  // 势力关系（其他势力ID -> 关系值，-100到100）
  final Map<String, int> _relations;
  // 势力关系（其他势力ID -> 关系值，-100到100）
  @override
  @JsonKey()
  Map<String, int> get relations {
    if (_relations is EqualUnmodifiableMapView) return _relations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_relations);
  }

  // 势力特色
  final List<String> _specialties;
  // 势力特色
  @override
  @JsonKey()
  List<String> get specialties {
    if (_specialties is EqualUnmodifiableListView) return _specialties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialties);
  }

  // 势力据点
  final List<String> _territoryIds;
  // 势力据点
  @override
  @JsonKey()
  List<String> get territoryIds {
    if (_territoryIds is EqualUnmodifiableListView) return _territoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_territoryIds);
  }

  @override
  String toString() {
    return 'Faction(id: $id, name: $name, description: $description, type: $type, relations: $relations, specialties: $specialties, territoryIds: $territoryIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._relations,
              _relations,
            ) &&
            const DeepCollectionEquality().equals(
              other._specialties,
              _specialties,
            ) &&
            const DeepCollectionEquality().equals(
              other._territoryIds,
              _territoryIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    const DeepCollectionEquality().hash(_relations),
    const DeepCollectionEquality().hash(_specialties),
    const DeepCollectionEquality().hash(_territoryIds),
  );

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FactionImplCopyWith<_$FactionImpl> get copyWith =>
      __$$FactionImplCopyWithImpl<_$FactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FactionImplToJson(this);
  }
}

abstract class _Faction implements Faction {
  const factory _Faction({
    required final String id,
    required final String name,
    required final String description,
    required final FactionType type,
    final Map<String, int> relations,
    final List<String> specialties,
    final List<String> territoryIds,
  }) = _$FactionImpl;

  factory _Faction.fromJson(Map<String, dynamic> json) = _$FactionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  FactionType get type; // 势力关系（其他势力ID -> 关系值，-100到100）
  @override
  Map<String, int> get relations; // 势力特色
  @override
  List<String> get specialties; // 势力据点
  @override
  List<String> get territoryIds;

  /// Create a copy of Faction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FactionImplCopyWith<_$FactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FactionEvent _$FactionEventFromJson(Map<String, dynamic> json) {
  return _FactionEvent.fromJson(json);
}

/// @nodoc
mixin _$FactionEvent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  FactionEventType get type => throw _privateConstructorUsedError;
  List<String> get involvedFactionIds => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError; // 玩家可以选择的阵营
  List<String> get availableSides => throw _privateConstructorUsedError; // 奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  int get rewardReputation => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;

  /// Serializes this FactionEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FactionEventCopyWith<FactionEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FactionEventCopyWith<$Res> {
  factory $FactionEventCopyWith(
    FactionEvent value,
    $Res Function(FactionEvent) then,
  ) = _$FactionEventCopyWithImpl<$Res, FactionEvent>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    FactionEventType type,
    List<String> involvedFactionIds,
    DateTime startTime,
    DateTime endTime,
    List<String> availableSides,
    int rewardExp,
    int rewardSilver,
    int rewardReputation,
    String? rewardItemId,
  });
}

/// @nodoc
class _$FactionEventCopyWithImpl<$Res, $Val extends FactionEvent>
    implements $FactionEventCopyWith<$Res> {
  _$FactionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? involvedFactionIds = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? availableSides = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardReputation = null,
    Object? rewardItemId = freezed,
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
                      as FactionEventType,
            involvedFactionIds: null == involvedFactionIds
                ? _value.involvedFactionIds
                : involvedFactionIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            availableSides: null == availableSides
                ? _value.availableSides
                : availableSides // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FactionEventImplCopyWith<$Res>
    implements $FactionEventCopyWith<$Res> {
  factory _$$FactionEventImplCopyWith(
    _$FactionEventImpl value,
    $Res Function(_$FactionEventImpl) then,
  ) = __$$FactionEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    FactionEventType type,
    List<String> involvedFactionIds,
    DateTime startTime,
    DateTime endTime,
    List<String> availableSides,
    int rewardExp,
    int rewardSilver,
    int rewardReputation,
    String? rewardItemId,
  });
}

/// @nodoc
class __$$FactionEventImplCopyWithImpl<$Res>
    extends _$FactionEventCopyWithImpl<$Res, _$FactionEventImpl>
    implements _$$FactionEventImplCopyWith<$Res> {
  __$$FactionEventImplCopyWithImpl(
    _$FactionEventImpl _value,
    $Res Function(_$FactionEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? involvedFactionIds = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? availableSides = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardReputation = null,
    Object? rewardItemId = freezed,
  }) {
    return _then(
      _$FactionEventImpl(
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
                  as FactionEventType,
        involvedFactionIds: null == involvedFactionIds
            ? _value._involvedFactionIds
            : involvedFactionIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        availableSides: null == availableSides
            ? _value._availableSides
            : availableSides // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FactionEventImpl implements _FactionEvent {
  const _$FactionEventImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required final List<String> involvedFactionIds,
    required this.startTime,
    required this.endTime,
    final List<String> availableSides = const [],
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardReputation = 0,
    this.rewardItemId,
  }) : _involvedFactionIds = involvedFactionIds,
       _availableSides = availableSides;

  factory _$FactionEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$FactionEventImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final FactionEventType type;
  final List<String> _involvedFactionIds;
  @override
  List<String> get involvedFactionIds {
    if (_involvedFactionIds is EqualUnmodifiableListView)
      return _involvedFactionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_involvedFactionIds);
  }

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  // 玩家可以选择的阵营
  final List<String> _availableSides;
  // 玩家可以选择的阵营
  @override
  @JsonKey()
  List<String> get availableSides {
    if (_availableSides is EqualUnmodifiableListView) return _availableSides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSides);
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
  String toString() {
    return 'FactionEvent(id: $id, name: $name, description: $description, type: $type, involvedFactionIds: $involvedFactionIds, startTime: $startTime, endTime: $endTime, availableSides: $availableSides, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardReputation: $rewardReputation, rewardItemId: $rewardItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FactionEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._involvedFactionIds,
              _involvedFactionIds,
            ) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality().equals(
              other._availableSides,
              _availableSides,
            ) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardReputation, rewardReputation) ||
                other.rewardReputation == rewardReputation) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    const DeepCollectionEquality().hash(_involvedFactionIds),
    startTime,
    endTime,
    const DeepCollectionEquality().hash(_availableSides),
    rewardExp,
    rewardSilver,
    rewardReputation,
    rewardItemId,
  );

  /// Create a copy of FactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FactionEventImplCopyWith<_$FactionEventImpl> get copyWith =>
      __$$FactionEventImplCopyWithImpl<_$FactionEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FactionEventImplToJson(this);
  }
}

abstract class _FactionEvent implements FactionEvent {
  const factory _FactionEvent({
    required final String id,
    required final String name,
    required final String description,
    required final FactionEventType type,
    required final List<String> involvedFactionIds,
    required final DateTime startTime,
    required final DateTime endTime,
    final List<String> availableSides,
    final int rewardExp,
    final int rewardSilver,
    final int rewardReputation,
    final String? rewardItemId,
  }) = _$FactionEventImpl;

  factory _FactionEvent.fromJson(Map<String, dynamic> json) =
      _$FactionEventImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  FactionEventType get type;
  @override
  List<String> get involvedFactionIds;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime; // 玩家可以选择的阵营
  @override
  List<String> get availableSides; // 奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  int get rewardReputation;
  @override
  String? get rewardItemId;

  /// Create a copy of FactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FactionEventImplCopyWith<_$FactionEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

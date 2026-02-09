// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MapLocation _$MapLocationFromJson(Map<String, dynamic> json) {
  return _MapLocation.fromJson(json);
}

/// @nodoc
mixin _$MapLocation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  LocationType get type => throw _privateConstructorUsedError;
  int get dangerLevel => throw _privateConstructorUsedError;
  List<String> get adjacentIds => throw _privateConstructorUsedError;
  List<String> get npcIds => throw _privateConstructorUsedError;
  List<String> get eventIds => throw _privateConstructorUsedError;
  int get explorationSeconds => throw _privateConstructorUsedError; // 进入条件
  RealmTier? get requiredRealm => throw _privateConstructorUsedError;
  String? get requiredQuestId => throw _privateConstructorUsedError;

  /// Serializes this MapLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapLocationCopyWith<MapLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapLocationCopyWith<$Res> {
  factory $MapLocationCopyWith(
    MapLocation value,
    $Res Function(MapLocation) then,
  ) = _$MapLocationCopyWithImpl<$Res, MapLocation>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    LocationType type,
    int dangerLevel,
    List<String> adjacentIds,
    List<String> npcIds,
    List<String> eventIds,
    int explorationSeconds,
    RealmTier? requiredRealm,
    String? requiredQuestId,
  });
}

/// @nodoc
class _$MapLocationCopyWithImpl<$Res, $Val extends MapLocation>
    implements $MapLocationCopyWith<$Res> {
  _$MapLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? dangerLevel = null,
    Object? adjacentIds = null,
    Object? npcIds = null,
    Object? eventIds = null,
    Object? explorationSeconds = null,
    Object? requiredRealm = freezed,
    Object? requiredQuestId = freezed,
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
                      as LocationType,
            dangerLevel: null == dangerLevel
                ? _value.dangerLevel
                : dangerLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            adjacentIds: null == adjacentIds
                ? _value.adjacentIds
                : adjacentIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            npcIds: null == npcIds
                ? _value.npcIds
                : npcIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            eventIds: null == eventIds
                ? _value.eventIds
                : eventIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            explorationSeconds: null == explorationSeconds
                ? _value.explorationSeconds
                : explorationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredRealm: freezed == requiredRealm
                ? _value.requiredRealm
                : requiredRealm // ignore: cast_nullable_to_non_nullable
                      as RealmTier?,
            requiredQuestId: freezed == requiredQuestId
                ? _value.requiredQuestId
                : requiredQuestId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapLocationImplCopyWith<$Res>
    implements $MapLocationCopyWith<$Res> {
  factory _$$MapLocationImplCopyWith(
    _$MapLocationImpl value,
    $Res Function(_$MapLocationImpl) then,
  ) = __$$MapLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    LocationType type,
    int dangerLevel,
    List<String> adjacentIds,
    List<String> npcIds,
    List<String> eventIds,
    int explorationSeconds,
    RealmTier? requiredRealm,
    String? requiredQuestId,
  });
}

/// @nodoc
class __$$MapLocationImplCopyWithImpl<$Res>
    extends _$MapLocationCopyWithImpl<$Res, _$MapLocationImpl>
    implements _$$MapLocationImplCopyWith<$Res> {
  __$$MapLocationImplCopyWithImpl(
    _$MapLocationImpl _value,
    $Res Function(_$MapLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? dangerLevel = null,
    Object? adjacentIds = null,
    Object? npcIds = null,
    Object? eventIds = null,
    Object? explorationSeconds = null,
    Object? requiredRealm = freezed,
    Object? requiredQuestId = freezed,
  }) {
    return _then(
      _$MapLocationImpl(
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
                  as LocationType,
        dangerLevel: null == dangerLevel
            ? _value.dangerLevel
            : dangerLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        adjacentIds: null == adjacentIds
            ? _value._adjacentIds
            : adjacentIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        npcIds: null == npcIds
            ? _value._npcIds
            : npcIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        eventIds: null == eventIds
            ? _value._eventIds
            : eventIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        explorationSeconds: null == explorationSeconds
            ? _value.explorationSeconds
            : explorationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredRealm: freezed == requiredRealm
            ? _value.requiredRealm
            : requiredRealm // ignore: cast_nullable_to_non_nullable
                  as RealmTier?,
        requiredQuestId: freezed == requiredQuestId
            ? _value.requiredQuestId
            : requiredQuestId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MapLocationImpl implements _MapLocation {
  const _$MapLocationImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.dangerLevel,
    final List<String> adjacentIds = const [],
    final List<String> npcIds = const [],
    final List<String> eventIds = const [],
    this.explorationSeconds = 30,
    this.requiredRealm,
    this.requiredQuestId,
  }) : _adjacentIds = adjacentIds,
       _npcIds = npcIds,
       _eventIds = eventIds;

  factory _$MapLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapLocationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final LocationType type;
  @override
  final int dangerLevel;
  final List<String> _adjacentIds;
  @override
  @JsonKey()
  List<String> get adjacentIds {
    if (_adjacentIds is EqualUnmodifiableListView) return _adjacentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adjacentIds);
  }

  final List<String> _npcIds;
  @override
  @JsonKey()
  List<String> get npcIds {
    if (_npcIds is EqualUnmodifiableListView) return _npcIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_npcIds);
  }

  final List<String> _eventIds;
  @override
  @JsonKey()
  List<String> get eventIds {
    if (_eventIds is EqualUnmodifiableListView) return _eventIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eventIds);
  }

  @override
  @JsonKey()
  final int explorationSeconds;
  // 进入条件
  @override
  final RealmTier? requiredRealm;
  @override
  final String? requiredQuestId;

  @override
  String toString() {
    return 'MapLocation(id: $id, name: $name, description: $description, type: $type, dangerLevel: $dangerLevel, adjacentIds: $adjacentIds, npcIds: $npcIds, eventIds: $eventIds, explorationSeconds: $explorationSeconds, requiredRealm: $requiredRealm, requiredQuestId: $requiredQuestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapLocationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.dangerLevel, dangerLevel) ||
                other.dangerLevel == dangerLevel) &&
            const DeepCollectionEquality().equals(
              other._adjacentIds,
              _adjacentIds,
            ) &&
            const DeepCollectionEquality().equals(other._npcIds, _npcIds) &&
            const DeepCollectionEquality().equals(other._eventIds, _eventIds) &&
            (identical(other.explorationSeconds, explorationSeconds) ||
                other.explorationSeconds == explorationSeconds) &&
            (identical(other.requiredRealm, requiredRealm) ||
                other.requiredRealm == requiredRealm) &&
            (identical(other.requiredQuestId, requiredQuestId) ||
                other.requiredQuestId == requiredQuestId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    dangerLevel,
    const DeepCollectionEquality().hash(_adjacentIds),
    const DeepCollectionEquality().hash(_npcIds),
    const DeepCollectionEquality().hash(_eventIds),
    explorationSeconds,
    requiredRealm,
    requiredQuestId,
  );

  /// Create a copy of MapLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapLocationImplCopyWith<_$MapLocationImpl> get copyWith =>
      __$$MapLocationImplCopyWithImpl<_$MapLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapLocationImplToJson(this);
  }
}

abstract class _MapLocation implements MapLocation {
  const factory _MapLocation({
    required final String id,
    required final String name,
    required final String description,
    required final LocationType type,
    required final int dangerLevel,
    final List<String> adjacentIds,
    final List<String> npcIds,
    final List<String> eventIds,
    final int explorationSeconds,
    final RealmTier? requiredRealm,
    final String? requiredQuestId,
  }) = _$MapLocationImpl;

  factory _MapLocation.fromJson(Map<String, dynamic> json) =
      _$MapLocationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  LocationType get type;
  @override
  int get dangerLevel;
  @override
  List<String> get adjacentIds;
  @override
  List<String> get npcIds;
  @override
  List<String> get eventIds;
  @override
  int get explorationSeconds; // 进入条件
  @override
  RealmTier? get requiredRealm;
  @override
  String? get requiredQuestId;

  /// Create a copy of MapLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapLocationImplCopyWith<_$MapLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

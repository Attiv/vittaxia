// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameLog _$GameLogFromJson(Map<String, dynamic> json) {
  return _GameLog.fromJson(json);
}

/// @nodoc
mixin _$GameLog {
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  LogType get type => throw _privateConstructorUsedError;

  /// Serializes this GameLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameLogCopyWith<GameLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameLogCopyWith<$Res> {
  factory $GameLogCopyWith(GameLog value, $Res Function(GameLog) then) =
      _$GameLogCopyWithImpl<$Res, GameLog>;
  @useResult
  $Res call({String message, DateTime timestamp, LogType type});
}

/// @nodoc
class _$GameLogCopyWithImpl<$Res, $Val extends GameLog>
    implements $GameLogCopyWith<$Res> {
  _$GameLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LogType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameLogImplCopyWith<$Res> implements $GameLogCopyWith<$Res> {
  factory _$$GameLogImplCopyWith(
    _$GameLogImpl value,
    $Res Function(_$GameLogImpl) then,
  ) = __$$GameLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime timestamp, LogType type});
}

/// @nodoc
class __$$GameLogImplCopyWithImpl<$Res>
    extends _$GameLogCopyWithImpl<$Res, _$GameLogImpl>
    implements _$$GameLogImplCopyWith<$Res> {
  __$$GameLogImplCopyWithImpl(
    _$GameLogImpl _value,
    $Res Function(_$GameLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? timestamp = null,
    Object? type = null,
  }) {
    return _then(
      _$GameLogImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LogType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameLogImpl implements _GameLog {
  const _$GameLogImpl({
    required this.message,
    required this.timestamp,
    this.type = LogType.system,
  });

  factory _$GameLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameLogImplFromJson(json);

  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final LogType type;

  @override
  String toString() {
    return 'GameLog(message: $message, timestamp: $timestamp, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameLogImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, timestamp, type);

  /// Create a copy of GameLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameLogImplCopyWith<_$GameLogImpl> get copyWith =>
      __$$GameLogImplCopyWithImpl<_$GameLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameLogImplToJson(this);
  }
}

abstract class _GameLog implements GameLog {
  const factory _GameLog({
    required final String message,
    required final DateTime timestamp,
    final LogType type,
  }) = _$GameLogImpl;

  factory _GameLog.fromJson(Map<String, dynamic> json) = _$GameLogImpl.fromJson;

  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  LogType get type;

  /// Create a copy of GameLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameLogImplCopyWith<_$GameLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

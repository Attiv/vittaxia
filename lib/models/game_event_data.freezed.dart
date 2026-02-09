// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_event_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameEventData _$GameEventDataFromJson(Map<String, dynamic> json) {
  return _GameEventData.fromJson(json);
}

/// @nodoc
mixin _$GameEventData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  GameEventType get type => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get minDangerLevel => throw _privateConstructorUsedError;
  int get maxDangerLevel => throw _privateConstructorUsedError; // 战斗事件的敌人 ID
  String? get enemyId => throw _privateConstructorUsedError; // 宝物事件的物品 ID 和数量
  String? get rewardItemId => throw _privateConstructorUsedError;
  int get rewardItemCount => throw _privateConstructorUsedError; // 经验/银两奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError; // 选项
  List<EventChoice> get choices => throw _privateConstructorUsedError;

  /// Serializes this GameEventData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameEventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameEventDataCopyWith<GameEventData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventDataCopyWith<$Res> {
  factory $GameEventDataCopyWith(
    GameEventData value,
    $Res Function(GameEventData) then,
  ) = _$GameEventDataCopyWithImpl<$Res, GameEventData>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    GameEventType type,
    int weight,
    int minDangerLevel,
    int maxDangerLevel,
    String? enemyId,
    String? rewardItemId,
    int rewardItemCount,
    int rewardExp,
    int rewardSilver,
    List<EventChoice> choices,
  });
}

/// @nodoc
class _$GameEventDataCopyWithImpl<$Res, $Val extends GameEventData>
    implements $GameEventDataCopyWith<$Res> {
  _$GameEventDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameEventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? weight = null,
    Object? minDangerLevel = null,
    Object? maxDangerLevel = null,
    Object? enemyId = freezed,
    Object? rewardItemId = freezed,
    Object? rewardItemCount = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? choices = null,
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
                      as GameEventType,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as int,
            minDangerLevel: null == minDangerLevel
                ? _value.minDangerLevel
                : minDangerLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            maxDangerLevel: null == maxDangerLevel
                ? _value.maxDangerLevel
                : maxDangerLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            enemyId: freezed == enemyId
                ? _value.enemyId
                : enemyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardItemCount: null == rewardItemCount
                ? _value.rewardItemCount
                : rewardItemCount // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            choices: null == choices
                ? _value.choices
                : choices // ignore: cast_nullable_to_non_nullable
                      as List<EventChoice>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameEventDataImplCopyWith<$Res>
    implements $GameEventDataCopyWith<$Res> {
  factory _$$GameEventDataImplCopyWith(
    _$GameEventDataImpl value,
    $Res Function(_$GameEventDataImpl) then,
  ) = __$$GameEventDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    GameEventType type,
    int weight,
    int minDangerLevel,
    int maxDangerLevel,
    String? enemyId,
    String? rewardItemId,
    int rewardItemCount,
    int rewardExp,
    int rewardSilver,
    List<EventChoice> choices,
  });
}

/// @nodoc
class __$$GameEventDataImplCopyWithImpl<$Res>
    extends _$GameEventDataCopyWithImpl<$Res, _$GameEventDataImpl>
    implements _$$GameEventDataImplCopyWith<$Res> {
  __$$GameEventDataImplCopyWithImpl(
    _$GameEventDataImpl _value,
    $Res Function(_$GameEventDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameEventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? weight = null,
    Object? minDangerLevel = null,
    Object? maxDangerLevel = null,
    Object? enemyId = freezed,
    Object? rewardItemId = freezed,
    Object? rewardItemCount = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? choices = null,
  }) {
    return _then(
      _$GameEventDataImpl(
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
                  as GameEventType,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as int,
        minDangerLevel: null == minDangerLevel
            ? _value.minDangerLevel
            : minDangerLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        maxDangerLevel: null == maxDangerLevel
            ? _value.maxDangerLevel
            : maxDangerLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        enemyId: freezed == enemyId
            ? _value.enemyId
            : enemyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardItemCount: null == rewardItemCount
            ? _value.rewardItemCount
            : rewardItemCount // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        choices: null == choices
            ? _value._choices
            : choices // ignore: cast_nullable_to_non_nullable
                  as List<EventChoice>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEventDataImpl implements _GameEventData {
  const _$GameEventDataImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.weight = 10,
    this.minDangerLevel = 0,
    this.maxDangerLevel = 10,
    this.enemyId,
    this.rewardItemId,
    this.rewardItemCount = 1,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    final List<EventChoice> choices = const [],
  }) : _choices = choices;

  factory _$GameEventDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEventDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final GameEventType type;
  @override
  @JsonKey()
  final int weight;
  @override
  @JsonKey()
  final int minDangerLevel;
  @override
  @JsonKey()
  final int maxDangerLevel;
  // 战斗事件的敌人 ID
  @override
  final String? enemyId;
  // 宝物事件的物品 ID 和数量
  @override
  final String? rewardItemId;
  @override
  @JsonKey()
  final int rewardItemCount;
  // 经验/银两奖励
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  // 选项
  final List<EventChoice> _choices;
  // 选项
  @override
  @JsonKey()
  List<EventChoice> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  @override
  String toString() {
    return 'GameEventData(id: $id, name: $name, description: $description, type: $type, weight: $weight, minDangerLevel: $minDangerLevel, maxDangerLevel: $maxDangerLevel, enemyId: $enemyId, rewardItemId: $rewardItemId, rewardItemCount: $rewardItemCount, rewardExp: $rewardExp, rewardSilver: $rewardSilver, choices: $choices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.minDangerLevel, minDangerLevel) ||
                other.minDangerLevel == minDangerLevel) &&
            (identical(other.maxDangerLevel, maxDangerLevel) ||
                other.maxDangerLevel == maxDangerLevel) &&
            (identical(other.enemyId, enemyId) || other.enemyId == enemyId) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.rewardItemCount, rewardItemCount) ||
                other.rewardItemCount == rewardItemCount) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            const DeepCollectionEquality().equals(other._choices, _choices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    type,
    weight,
    minDangerLevel,
    maxDangerLevel,
    enemyId,
    rewardItemId,
    rewardItemCount,
    rewardExp,
    rewardSilver,
    const DeepCollectionEquality().hash(_choices),
  );

  /// Create a copy of GameEventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventDataImplCopyWith<_$GameEventDataImpl> get copyWith =>
      __$$GameEventDataImplCopyWithImpl<_$GameEventDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEventDataImplToJson(this);
  }
}

abstract class _GameEventData implements GameEventData {
  const factory _GameEventData({
    required final String id,
    required final String name,
    required final String description,
    required final GameEventType type,
    final int weight,
    final int minDangerLevel,
    final int maxDangerLevel,
    final String? enemyId,
    final String? rewardItemId,
    final int rewardItemCount,
    final int rewardExp,
    final int rewardSilver,
    final List<EventChoice> choices,
  }) = _$GameEventDataImpl;

  factory _GameEventData.fromJson(Map<String, dynamic> json) =
      _$GameEventDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  GameEventType get type;
  @override
  int get weight;
  @override
  int get minDangerLevel;
  @override
  int get maxDangerLevel; // 战斗事件的敌人 ID
  @override
  String? get enemyId; // 宝物事件的物品 ID 和数量
  @override
  String? get rewardItemId;
  @override
  int get rewardItemCount; // 经验/银两奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver; // 选项
  @override
  List<EventChoice> get choices;

  /// Create a copy of GameEventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameEventDataImplCopyWith<_$GameEventDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventChoice _$EventChoiceFromJson(Map<String, dynamic> json) {
  return _EventChoice.fromJson(json);
}

/// @nodoc
mixin _$EventChoice {
  String get text => throw _privateConstructorUsedError;
  String get resultText => throw _privateConstructorUsedError;
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;
  int get hpChange => throw _privateConstructorUsedError; // 是否触发战斗
  bool get triggerBattle => throw _privateConstructorUsedError;
  String? get enemyId => throw _privateConstructorUsedError;

  /// Serializes this EventChoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventChoiceCopyWith<EventChoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventChoiceCopyWith<$Res> {
  factory $EventChoiceCopyWith(
    EventChoice value,
    $Res Function(EventChoice) then,
  ) = _$EventChoiceCopyWithImpl<$Res, EventChoice>;
  @useResult
  $Res call({
    String text,
    String resultText,
    int rewardExp,
    int rewardSilver,
    String? rewardItemId,
    int hpChange,
    bool triggerBattle,
    String? enemyId,
  });
}

/// @nodoc
class _$EventChoiceCopyWithImpl<$Res, $Val extends EventChoice>
    implements $EventChoiceCopyWith<$Res> {
  _$EventChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? resultText = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItemId = freezed,
    Object? hpChange = null,
    Object? triggerBattle = null,
    Object? enemyId = freezed,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            resultText: null == resultText
                ? _value.resultText
                : resultText // ignore: cast_nullable_to_non_nullable
                      as String,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            hpChange: null == hpChange
                ? _value.hpChange
                : hpChange // ignore: cast_nullable_to_non_nullable
                      as int,
            triggerBattle: null == triggerBattle
                ? _value.triggerBattle
                : triggerBattle // ignore: cast_nullable_to_non_nullable
                      as bool,
            enemyId: freezed == enemyId
                ? _value.enemyId
                : enemyId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventChoiceImplCopyWith<$Res>
    implements $EventChoiceCopyWith<$Res> {
  factory _$$EventChoiceImplCopyWith(
    _$EventChoiceImpl value,
    $Res Function(_$EventChoiceImpl) then,
  ) = __$$EventChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String text,
    String resultText,
    int rewardExp,
    int rewardSilver,
    String? rewardItemId,
    int hpChange,
    bool triggerBattle,
    String? enemyId,
  });
}

/// @nodoc
class __$$EventChoiceImplCopyWithImpl<$Res>
    extends _$EventChoiceCopyWithImpl<$Res, _$EventChoiceImpl>
    implements _$$EventChoiceImplCopyWith<$Res> {
  __$$EventChoiceImplCopyWithImpl(
    _$EventChoiceImpl _value,
    $Res Function(_$EventChoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? resultText = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItemId = freezed,
    Object? hpChange = null,
    Object? triggerBattle = null,
    Object? enemyId = freezed,
  }) {
    return _then(
      _$EventChoiceImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        resultText: null == resultText
            ? _value.resultText
            : resultText // ignore: cast_nullable_to_non_nullable
                  as String,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        hpChange: null == hpChange
            ? _value.hpChange
            : hpChange // ignore: cast_nullable_to_non_nullable
                  as int,
        triggerBattle: null == triggerBattle
            ? _value.triggerBattle
            : triggerBattle // ignore: cast_nullable_to_non_nullable
                  as bool,
        enemyId: freezed == enemyId
            ? _value.enemyId
            : enemyId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventChoiceImpl implements _EventChoice {
  const _$EventChoiceImpl({
    required this.text,
    required this.resultText,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardItemId,
    this.hpChange = 0,
    this.triggerBattle = false,
    this.enemyId,
  });

  factory _$EventChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventChoiceImplFromJson(json);

  @override
  final String text;
  @override
  final String resultText;
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  @override
  final String? rewardItemId;
  @override
  @JsonKey()
  final int hpChange;
  // 是否触发战斗
  @override
  @JsonKey()
  final bool triggerBattle;
  @override
  final String? enemyId;

  @override
  String toString() {
    return 'EventChoice(text: $text, resultText: $resultText, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardItemId: $rewardItemId, hpChange: $hpChange, triggerBattle: $triggerBattle, enemyId: $enemyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventChoiceImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.resultText, resultText) ||
                other.resultText == resultText) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.hpChange, hpChange) ||
                other.hpChange == hpChange) &&
            (identical(other.triggerBattle, triggerBattle) ||
                other.triggerBattle == triggerBattle) &&
            (identical(other.enemyId, enemyId) || other.enemyId == enemyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    resultText,
    rewardExp,
    rewardSilver,
    rewardItemId,
    hpChange,
    triggerBattle,
    enemyId,
  );

  /// Create a copy of EventChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventChoiceImplCopyWith<_$EventChoiceImpl> get copyWith =>
      __$$EventChoiceImplCopyWithImpl<_$EventChoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventChoiceImplToJson(this);
  }
}

abstract class _EventChoice implements EventChoice {
  const factory _EventChoice({
    required final String text,
    required final String resultText,
    final int rewardExp,
    final int rewardSilver,
    final String? rewardItemId,
    final int hpChange,
    final bool triggerBattle,
    final String? enemyId,
  }) = _$EventChoiceImpl;

  factory _EventChoice.fromJson(Map<String, dynamic> json) =
      _$EventChoiceImpl.fromJson;

  @override
  String get text;
  @override
  String get resultText;
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  String? get rewardItemId;
  @override
  int get hpChange; // 是否触发战斗
  @override
  bool get triggerBattle;
  @override
  String? get enemyId;

  /// Create a copy of EventChoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventChoiceImplCopyWith<_$EventChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

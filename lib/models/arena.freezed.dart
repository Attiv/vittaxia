// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arena.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ArenaOpponent _$ArenaOpponentFromJson(Map<String, dynamic> json) {
  return _ArenaOpponent.fromJson(json);
}

/// @nodoc
mixin _$ArenaOpponent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get hp => throw _privateConstructorUsedError;
  int get atk => throw _privateConstructorUsedError;
  int get def => throw _privateConstructorUsedError;
  int get speed => throw _privateConstructorUsedError;
  List<String> get skillIds => throw _privateConstructorUsedError;
  String? get weaponId => throw _privateConstructorUsedError;
  String? get armorId => throw _privateConstructorUsedError; // 奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  int get rewardRanking => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;

  /// Serializes this ArenaOpponent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArenaOpponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArenaOpponentCopyWith<ArenaOpponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArenaOpponentCopyWith<$Res> {
  factory $ArenaOpponentCopyWith(
    ArenaOpponent value,
    $Res Function(ArenaOpponent) then,
  ) = _$ArenaOpponentCopyWithImpl<$Res, ArenaOpponent>;
  @useResult
  $Res call({
    String id,
    String name,
    String title,
    int level,
    int hp,
    int atk,
    int def,
    int speed,
    List<String> skillIds,
    String? weaponId,
    String? armorId,
    int rewardExp,
    int rewardSilver,
    int rewardRanking,
    String? rewardItemId,
  });
}

/// @nodoc
class _$ArenaOpponentCopyWithImpl<$Res, $Val extends ArenaOpponent>
    implements $ArenaOpponentCopyWith<$Res> {
  _$ArenaOpponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArenaOpponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? level = null,
    Object? hp = null,
    Object? atk = null,
    Object? def = null,
    Object? speed = null,
    Object? skillIds = null,
    Object? weaponId = freezed,
    Object? armorId = freezed,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardRanking = null,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            hp: null == hp
                ? _value.hp
                : hp // ignore: cast_nullable_to_non_nullable
                      as int,
            atk: null == atk
                ? _value.atk
                : atk // ignore: cast_nullable_to_non_nullable
                      as int,
            def: null == def
                ? _value.def
                : def // ignore: cast_nullable_to_non_nullable
                      as int,
            speed: null == speed
                ? _value.speed
                : speed // ignore: cast_nullable_to_non_nullable
                      as int,
            skillIds: null == skillIds
                ? _value.skillIds
                : skillIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            weaponId: freezed == weaponId
                ? _value.weaponId
                : weaponId // ignore: cast_nullable_to_non_nullable
                      as String?,
            armorId: freezed == armorId
                ? _value.armorId
                : armorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardExp: null == rewardExp
                ? _value.rewardExp
                : rewardExp // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardSilver: null == rewardSilver
                ? _value.rewardSilver
                : rewardSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardRanking: null == rewardRanking
                ? _value.rewardRanking
                : rewardRanking // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ArenaOpponentImplCopyWith<$Res>
    implements $ArenaOpponentCopyWith<$Res> {
  factory _$$ArenaOpponentImplCopyWith(
    _$ArenaOpponentImpl value,
    $Res Function(_$ArenaOpponentImpl) then,
  ) = __$$ArenaOpponentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String title,
    int level,
    int hp,
    int atk,
    int def,
    int speed,
    List<String> skillIds,
    String? weaponId,
    String? armorId,
    int rewardExp,
    int rewardSilver,
    int rewardRanking,
    String? rewardItemId,
  });
}

/// @nodoc
class __$$ArenaOpponentImplCopyWithImpl<$Res>
    extends _$ArenaOpponentCopyWithImpl<$Res, _$ArenaOpponentImpl>
    implements _$$ArenaOpponentImplCopyWith<$Res> {
  __$$ArenaOpponentImplCopyWithImpl(
    _$ArenaOpponentImpl _value,
    $Res Function(_$ArenaOpponentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArenaOpponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? level = null,
    Object? hp = null,
    Object? atk = null,
    Object? def = null,
    Object? speed = null,
    Object? skillIds = null,
    Object? weaponId = freezed,
    Object? armorId = freezed,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardRanking = null,
    Object? rewardItemId = freezed,
  }) {
    return _then(
      _$ArenaOpponentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        hp: null == hp
            ? _value.hp
            : hp // ignore: cast_nullable_to_non_nullable
                  as int,
        atk: null == atk
            ? _value.atk
            : atk // ignore: cast_nullable_to_non_nullable
                  as int,
        def: null == def
            ? _value.def
            : def // ignore: cast_nullable_to_non_nullable
                  as int,
        speed: null == speed
            ? _value.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as int,
        skillIds: null == skillIds
            ? _value._skillIds
            : skillIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        weaponId: freezed == weaponId
            ? _value.weaponId
            : weaponId // ignore: cast_nullable_to_non_nullable
                  as String?,
        armorId: freezed == armorId
            ? _value.armorId
            : armorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardExp: null == rewardExp
            ? _value.rewardExp
            : rewardExp // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardSilver: null == rewardSilver
            ? _value.rewardSilver
            : rewardSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardRanking: null == rewardRanking
            ? _value.rewardRanking
            : rewardRanking // ignore: cast_nullable_to_non_nullable
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
class _$ArenaOpponentImpl implements _ArenaOpponent {
  const _$ArenaOpponentImpl({
    required this.id,
    required this.name,
    required this.title,
    required this.level,
    required this.hp,
    required this.atk,
    required this.def,
    required this.speed,
    final List<String> skillIds = const [],
    this.weaponId,
    this.armorId,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardRanking = 0,
    this.rewardItemId,
  }) : _skillIds = skillIds;

  factory _$ArenaOpponentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArenaOpponentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String title;
  @override
  final int level;
  @override
  final int hp;
  @override
  final int atk;
  @override
  final int def;
  @override
  final int speed;
  final List<String> _skillIds;
  @override
  @JsonKey()
  List<String> get skillIds {
    if (_skillIds is EqualUnmodifiableListView) return _skillIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skillIds);
  }

  @override
  final String? weaponId;
  @override
  final String? armorId;
  // 奖励
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  @override
  @JsonKey()
  final int rewardRanking;
  @override
  final String? rewardItemId;

  @override
  String toString() {
    return 'ArenaOpponent(id: $id, name: $name, title: $title, level: $level, hp: $hp, atk: $atk, def: $def, speed: $speed, skillIds: $skillIds, weaponId: $weaponId, armorId: $armorId, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardRanking: $rewardRanking, rewardItemId: $rewardItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArenaOpponentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.atk, atk) || other.atk == atk) &&
            (identical(other.def, def) || other.def == def) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            const DeepCollectionEquality().equals(other._skillIds, _skillIds) &&
            (identical(other.weaponId, weaponId) ||
                other.weaponId == weaponId) &&
            (identical(other.armorId, armorId) || other.armorId == armorId) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardRanking, rewardRanking) ||
                other.rewardRanking == rewardRanking) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    title,
    level,
    hp,
    atk,
    def,
    speed,
    const DeepCollectionEquality().hash(_skillIds),
    weaponId,
    armorId,
    rewardExp,
    rewardSilver,
    rewardRanking,
    rewardItemId,
  );

  /// Create a copy of ArenaOpponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArenaOpponentImplCopyWith<_$ArenaOpponentImpl> get copyWith =>
      __$$ArenaOpponentImplCopyWithImpl<_$ArenaOpponentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArenaOpponentImplToJson(this);
  }
}

abstract class _ArenaOpponent implements ArenaOpponent {
  const factory _ArenaOpponent({
    required final String id,
    required final String name,
    required final String title,
    required final int level,
    required final int hp,
    required final int atk,
    required final int def,
    required final int speed,
    final List<String> skillIds,
    final String? weaponId,
    final String? armorId,
    final int rewardExp,
    final int rewardSilver,
    final int rewardRanking,
    final String? rewardItemId,
  }) = _$ArenaOpponentImpl;

  factory _ArenaOpponent.fromJson(Map<String, dynamic> json) =
      _$ArenaOpponentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get title;
  @override
  int get level;
  @override
  int get hp;
  @override
  int get atk;
  @override
  int get def;
  @override
  int get speed;
  @override
  List<String> get skillIds;
  @override
  String? get weaponId;
  @override
  String? get armorId; // 奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  int get rewardRanking;
  @override
  String? get rewardItemId;

  /// Create a copy of ArenaOpponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArenaOpponentImplCopyWith<_$ArenaOpponentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) {
  return _LeaderboardEntry.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntry {
  int get rank => throw _privateConstructorUsedError;
  String get characterId => throw _privateConstructorUsedError;
  String get characterName => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  String? get sectName => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
    LeaderboardEntry value,
    $Res Function(LeaderboardEntry) then,
  ) = _$LeaderboardEntryCopyWithImpl<$Res, LeaderboardEntry>;
  @useResult
  $Res call({
    int rank,
    String characterId,
    String characterName,
    int value,
    String? sectName,
    String? title,
  });
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res, $Val extends LeaderboardEntry>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? characterId = null,
    Object? characterName = null,
    Object? value = null,
    Object? sectName = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _value.copyWith(
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
            characterId: null == characterId
                ? _value.characterId
                : characterId // ignore: cast_nullable_to_non_nullable
                      as String,
            characterName: null == characterName
                ? _value.characterName
                : characterName // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            sectName: freezed == sectName
                ? _value.sectName
                : sectName // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaderboardEntryImplCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$$LeaderboardEntryImplCopyWith(
    _$LeaderboardEntryImpl value,
    $Res Function(_$LeaderboardEntryImpl) then,
  ) = __$$LeaderboardEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int rank,
    String characterId,
    String characterName,
    int value,
    String? sectName,
    String? title,
  });
}

/// @nodoc
class __$$LeaderboardEntryImplCopyWithImpl<$Res>
    extends _$LeaderboardEntryCopyWithImpl<$Res, _$LeaderboardEntryImpl>
    implements _$$LeaderboardEntryImplCopyWith<$Res> {
  __$$LeaderboardEntryImplCopyWithImpl(
    _$LeaderboardEntryImpl _value,
    $Res Function(_$LeaderboardEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? characterId = null,
    Object? characterName = null,
    Object? value = null,
    Object? sectName = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _$LeaderboardEntryImpl(
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
        characterId: null == characterId
            ? _value.characterId
            : characterId // ignore: cast_nullable_to_non_nullable
                  as String,
        characterName: null == characterName
            ? _value.characterName
            : characterName // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        sectName: freezed == sectName
            ? _value.sectName
            : sectName // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardEntryImpl implements _LeaderboardEntry {
  const _$LeaderboardEntryImpl({
    required this.rank,
    required this.characterId,
    required this.characterName,
    required this.value,
    this.sectName,
    this.title,
  });

  factory _$LeaderboardEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntryImplFromJson(json);

  @override
  final int rank;
  @override
  final String characterId;
  @override
  final String characterName;
  @override
  final int value;
  @override
  final String? sectName;
  @override
  final String? title;

  @override
  String toString() {
    return 'LeaderboardEntry(rank: $rank, characterId: $characterId, characterName: $characterName, value: $value, sectName: $sectName, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.characterId, characterId) ||
                other.characterId == characterId) &&
            (identical(other.characterName, characterName) ||
                other.characterName == characterName) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.sectName, sectName) ||
                other.sectName == sectName) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rank,
    characterId,
    characterName,
    value,
    sectName,
    title,
  );

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      __$$LeaderboardEntryImplCopyWithImpl<_$LeaderboardEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntryImplToJson(this);
  }
}

abstract class _LeaderboardEntry implements LeaderboardEntry {
  const factory _LeaderboardEntry({
    required final int rank,
    required final String characterId,
    required final String characterName,
    required final int value,
    final String? sectName,
    final String? title,
  }) = _$LeaderboardEntryImpl;

  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntryImpl.fromJson;

  @override
  int get rank;
  @override
  String get characterId;
  @override
  String get characterName;
  @override
  int get value;
  @override
  String? get sectName;
  @override
  String? get title;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  AchievementCategory get category => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError; // 奖励
  int get rewardExp => throw _privateConstructorUsedError;
  int get rewardSilver => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;
  String? get rewardTitle => throw _privateConstructorUsedError;

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
    Achievement value,
    $Res Function(Achievement) then,
  ) = _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    AchievementCategory category,
    int targetValue,
    int rewardExp,
    int rewardSilver,
    String? rewardItemId,
    String? rewardTitle,
  });
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? targetValue = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItemId = freezed,
    Object? rewardTitle = freezed,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as AchievementCategory,
            targetValue: null == targetValue
                ? _value.targetValue
                : targetValue // ignore: cast_nullable_to_non_nullable
                      as int,
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
            rewardTitle: freezed == rewardTitle
                ? _value.rewardTitle
                : rewardTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
    _$AchievementImpl value,
    $Res Function(_$AchievementImpl) then,
  ) = __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    AchievementCategory category,
    int targetValue,
    int rewardExp,
    int rewardSilver,
    String? rewardItemId,
    String? rewardTitle,
  });
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
    _$AchievementImpl _value,
    $Res Function(_$AchievementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? targetValue = null,
    Object? rewardExp = null,
    Object? rewardSilver = null,
    Object? rewardItemId = freezed,
    Object? rewardTitle = freezed,
  }) {
    return _then(
      _$AchievementImpl(
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
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as AchievementCategory,
        targetValue: null == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as int,
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
        rewardTitle: freezed == rewardTitle
            ? _value.rewardTitle
            : rewardTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.targetValue,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.rewardItemId,
    this.rewardTitle,
  });

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final AchievementCategory category;
  @override
  final int targetValue;
  // 奖励
  @override
  @JsonKey()
  final int rewardExp;
  @override
  @JsonKey()
  final int rewardSilver;
  @override
  final String? rewardItemId;
  @override
  final String? rewardTitle;

  @override
  String toString() {
    return 'Achievement(id: $id, name: $name, description: $description, category: $category, targetValue: $targetValue, rewardExp: $rewardExp, rewardSilver: $rewardSilver, rewardItemId: $rewardItemId, rewardTitle: $rewardTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.rewardExp, rewardExp) ||
                other.rewardExp == rewardExp) &&
            (identical(other.rewardSilver, rewardSilver) ||
                other.rewardSilver == rewardSilver) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.rewardTitle, rewardTitle) ||
                other.rewardTitle == rewardTitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    category,
    targetValue,
    rewardExp,
    rewardSilver,
    rewardItemId,
    rewardTitle,
  );

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(this);
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement({
    required final String id,
    required final String name,
    required final String description,
    required final AchievementCategory category,
    required final int targetValue,
    final int rewardExp,
    final int rewardSilver,
    final String? rewardItemId,
    final String? rewardTitle,
  }) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  AchievementCategory get category;
  @override
  int get targetValue; // 奖励
  @override
  int get rewardExp;
  @override
  int get rewardSilver;
  @override
  String? get rewardItemId;
  @override
  String? get rewardTitle;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Title _$TitleFromJson(Map<String, dynamic> json) {
  return _Title.fromJson(json);
}

/// @nodoc
mixin _$Title {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError; // 属性加成
  int get atkBonus => throw _privateConstructorUsedError;
  int get defBonus => throw _privateConstructorUsedError;
  int get hpBonus => throw _privateConstructorUsedError;
  int get speedBonus => throw _privateConstructorUsedError;
  int get luckBonus => throw _privateConstructorUsedError; // 获取条件
  String? get achievementId => throw _privateConstructorUsedError;
  int? get requiredRanking => throw _privateConstructorUsedError;

  /// Serializes this Title to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Title
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TitleCopyWith<Title> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TitleCopyWith<$Res> {
  factory $TitleCopyWith(Title value, $Res Function(Title) then) =
      _$TitleCopyWithImpl<$Res, Title>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int atkBonus,
    int defBonus,
    int hpBonus,
    int speedBonus,
    int luckBonus,
    String? achievementId,
    int? requiredRanking,
  });
}

/// @nodoc
class _$TitleCopyWithImpl<$Res, $Val extends Title>
    implements $TitleCopyWith<$Res> {
  _$TitleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Title
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? hpBonus = null,
    Object? speedBonus = null,
    Object? luckBonus = null,
    Object? achievementId = freezed,
    Object? requiredRanking = freezed,
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
            speedBonus: null == speedBonus
                ? _value.speedBonus
                : speedBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            luckBonus: null == luckBonus
                ? _value.luckBonus
                : luckBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            achievementId: freezed == achievementId
                ? _value.achievementId
                : achievementId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredRanking: freezed == requiredRanking
                ? _value.requiredRanking
                : requiredRanking // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TitleImplCopyWith<$Res> implements $TitleCopyWith<$Res> {
  factory _$$TitleImplCopyWith(
    _$TitleImpl value,
    $Res Function(_$TitleImpl) then,
  ) = __$$TitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    int atkBonus,
    int defBonus,
    int hpBonus,
    int speedBonus,
    int luckBonus,
    String? achievementId,
    int? requiredRanking,
  });
}

/// @nodoc
class __$$TitleImplCopyWithImpl<$Res>
    extends _$TitleCopyWithImpl<$Res, _$TitleImpl>
    implements _$$TitleImplCopyWith<$Res> {
  __$$TitleImplCopyWithImpl(
    _$TitleImpl _value,
    $Res Function(_$TitleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Title
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? hpBonus = null,
    Object? speedBonus = null,
    Object? luckBonus = null,
    Object? achievementId = freezed,
    Object? requiredRanking = freezed,
  }) {
    return _then(
      _$TitleImpl(
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
        speedBonus: null == speedBonus
            ? _value.speedBonus
            : speedBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        luckBonus: null == luckBonus
            ? _value.luckBonus
            : luckBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        achievementId: freezed == achievementId
            ? _value.achievementId
            : achievementId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredRanking: freezed == requiredRanking
            ? _value.requiredRanking
            : requiredRanking // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TitleImpl implements _Title {
  const _$TitleImpl({
    required this.id,
    required this.name,
    required this.description,
    this.atkBonus = 0,
    this.defBonus = 0,
    this.hpBonus = 0,
    this.speedBonus = 0,
    this.luckBonus = 0,
    this.achievementId,
    this.requiredRanking,
  });

  factory _$TitleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TitleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  // 属性加成
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
  final int speedBonus;
  @override
  @JsonKey()
  final int luckBonus;
  // 获取条件
  @override
  final String? achievementId;
  @override
  final int? requiredRanking;

  @override
  String toString() {
    return 'Title(id: $id, name: $name, description: $description, atkBonus: $atkBonus, defBonus: $defBonus, hpBonus: $hpBonus, speedBonus: $speedBonus, luckBonus: $luckBonus, achievementId: $achievementId, requiredRanking: $requiredRanking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.atkBonus, atkBonus) ||
                other.atkBonus == atkBonus) &&
            (identical(other.defBonus, defBonus) ||
                other.defBonus == defBonus) &&
            (identical(other.hpBonus, hpBonus) || other.hpBonus == hpBonus) &&
            (identical(other.speedBonus, speedBonus) ||
                other.speedBonus == speedBonus) &&
            (identical(other.luckBonus, luckBonus) ||
                other.luckBonus == luckBonus) &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.requiredRanking, requiredRanking) ||
                other.requiredRanking == requiredRanking));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    atkBonus,
    defBonus,
    hpBonus,
    speedBonus,
    luckBonus,
    achievementId,
    requiredRanking,
  );

  /// Create a copy of Title
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TitleImplCopyWith<_$TitleImpl> get copyWith =>
      __$$TitleImplCopyWithImpl<_$TitleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TitleImplToJson(this);
  }
}

abstract class _Title implements Title {
  const factory _Title({
    required final String id,
    required final String name,
    required final String description,
    final int atkBonus,
    final int defBonus,
    final int hpBonus,
    final int speedBonus,
    final int luckBonus,
    final String? achievementId,
    final int? requiredRanking,
  }) = _$TitleImpl;

  factory _Title.fromJson(Map<String, dynamic> json) = _$TitleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description; // 属性加成
  @override
  int get atkBonus;
  @override
  int get defBonus;
  @override
  int get hpBonus;
  @override
  int get speedBonus;
  @override
  int get luckBonus; // 获取条件
  @override
  String? get achievementId;
  @override
  int? get requiredRanking;

  /// Create a copy of Title
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TitleImplCopyWith<_$TitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Brotherhood _$BrotherhoodFromJson(Map<String, dynamic> json) {
  return _Brotherhood.fromJson(json);
}

/// @nodoc
mixin _$Brotherhood {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get exp => throw _privateConstructorUsedError; // 结义加成
  int get atkBonus => throw _privateConstructorUsedError;
  int get defBonus => throw _privateConstructorUsedError;
  int get expBonus => throw _privateConstructorUsedError;

  /// Serializes this Brotherhood to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Brotherhood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrotherhoodCopyWith<Brotherhood> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrotherhoodCopyWith<$Res> {
  factory $BrotherhoodCopyWith(
    Brotherhood value,
    $Res Function(Brotherhood) then,
  ) = _$BrotherhoodCopyWithImpl<$Res, Brotherhood>;
  @useResult
  $Res call({
    String id,
    String name,
    List<String> memberIds,
    DateTime createdAt,
    int level,
    int exp,
    int atkBonus,
    int defBonus,
    int expBonus,
  });
}

/// @nodoc
class _$BrotherhoodCopyWithImpl<$Res, $Val extends Brotherhood>
    implements $BrotherhoodCopyWith<$Res> {
  _$BrotherhoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Brotherhood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? memberIds = null,
    Object? createdAt = null,
    Object? level = null,
    Object? exp = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? expBonus = null,
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
            memberIds: null == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            exp: null == exp
                ? _value.exp
                : exp // ignore: cast_nullable_to_non_nullable
                      as int,
            atkBonus: null == atkBonus
                ? _value.atkBonus
                : atkBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            defBonus: null == defBonus
                ? _value.defBonus
                : defBonus // ignore: cast_nullable_to_non_nullable
                      as int,
            expBonus: null == expBonus
                ? _value.expBonus
                : expBonus // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrotherhoodImplCopyWith<$Res>
    implements $BrotherhoodCopyWith<$Res> {
  factory _$$BrotherhoodImplCopyWith(
    _$BrotherhoodImpl value,
    $Res Function(_$BrotherhoodImpl) then,
  ) = __$$BrotherhoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<String> memberIds,
    DateTime createdAt,
    int level,
    int exp,
    int atkBonus,
    int defBonus,
    int expBonus,
  });
}

/// @nodoc
class __$$BrotherhoodImplCopyWithImpl<$Res>
    extends _$BrotherhoodCopyWithImpl<$Res, _$BrotherhoodImpl>
    implements _$$BrotherhoodImplCopyWith<$Res> {
  __$$BrotherhoodImplCopyWithImpl(
    _$BrotherhoodImpl _value,
    $Res Function(_$BrotherhoodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Brotherhood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? memberIds = null,
    Object? createdAt = null,
    Object? level = null,
    Object? exp = null,
    Object? atkBonus = null,
    Object? defBonus = null,
    Object? expBonus = null,
  }) {
    return _then(
      _$BrotherhoodImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        memberIds: null == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        exp: null == exp
            ? _value.exp
            : exp // ignore: cast_nullable_to_non_nullable
                  as int,
        atkBonus: null == atkBonus
            ? _value.atkBonus
            : atkBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        defBonus: null == defBonus
            ? _value.defBonus
            : defBonus // ignore: cast_nullable_to_non_nullable
                  as int,
        expBonus: null == expBonus
            ? _value.expBonus
            : expBonus // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrotherhoodImpl implements _Brotherhood {
  const _$BrotherhoodImpl({
    required this.id,
    required this.name,
    required final List<String> memberIds,
    required this.createdAt,
    this.level = 0,
    this.exp = 0,
    this.atkBonus = 0,
    this.defBonus = 0,
    this.expBonus = 0,
  }) : _memberIds = memberIds;

  factory _$BrotherhoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrotherhoodImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int exp;
  // 结义加成
  @override
  @JsonKey()
  final int atkBonus;
  @override
  @JsonKey()
  final int defBonus;
  @override
  @JsonKey()
  final int expBonus;

  @override
  String toString() {
    return 'Brotherhood(id: $id, name: $name, memberIds: $memberIds, createdAt: $createdAt, level: $level, exp: $exp, atkBonus: $atkBonus, defBonus: $defBonus, expBonus: $expBonus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrotherhoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.atkBonus, atkBonus) ||
                other.atkBonus == atkBonus) &&
            (identical(other.defBonus, defBonus) ||
                other.defBonus == defBonus) &&
            (identical(other.expBonus, expBonus) ||
                other.expBonus == expBonus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_memberIds),
    createdAt,
    level,
    exp,
    atkBonus,
    defBonus,
    expBonus,
  );

  /// Create a copy of Brotherhood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrotherhoodImplCopyWith<_$BrotherhoodImpl> get copyWith =>
      __$$BrotherhoodImplCopyWithImpl<_$BrotherhoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrotherhoodImplToJson(this);
  }
}

abstract class _Brotherhood implements Brotherhood {
  const factory _Brotherhood({
    required final String id,
    required final String name,
    required final List<String> memberIds,
    required final DateTime createdAt,
    final int level,
    final int exp,
    final int atkBonus,
    final int defBonus,
    final int expBonus,
  }) = _$BrotherhoodImpl;

  factory _Brotherhood.fromJson(Map<String, dynamic> json) =
      _$BrotherhoodImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get memberIds;
  @override
  DateTime get createdAt;
  @override
  int get level;
  @override
  int get exp; // 结义加成
  @override
  int get atkBonus;
  @override
  int get defBonus;
  @override
  int get expBonus;

  /// Create a copy of Brotherhood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrotherhoodImplCopyWith<_$BrotherhoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Legacy _$LegacyFromJson(Map<String, dynamic> json) {
  return _Legacy.fromJson(json);
}

/// @nodoc
mixin _$Legacy {
  String get id => throw _privateConstructorUsedError;
  String get fromCharacterId => throw _privateConstructorUsedError;
  String get fromCharacterName => throw _privateConstructorUsedError;
  DateTime get retiredAt => throw _privateConstructorUsedError; // 可继承的内容
  int get inheritedExp => throw _privateConstructorUsedError;
  int get inheritedSilver => throw _privateConstructorUsedError;
  List<String> get inheritedSkillIds => throw _privateConstructorUsedError;
  List<String> get inheritedItemIds => throw _privateConstructorUsedError;
  int get inheritedReputation => throw _privateConstructorUsedError;

  /// Serializes this Legacy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Legacy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LegacyCopyWith<Legacy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LegacyCopyWith<$Res> {
  factory $LegacyCopyWith(Legacy value, $Res Function(Legacy) then) =
      _$LegacyCopyWithImpl<$Res, Legacy>;
  @useResult
  $Res call({
    String id,
    String fromCharacterId,
    String fromCharacterName,
    DateTime retiredAt,
    int inheritedExp,
    int inheritedSilver,
    List<String> inheritedSkillIds,
    List<String> inheritedItemIds,
    int inheritedReputation,
  });
}

/// @nodoc
class _$LegacyCopyWithImpl<$Res, $Val extends Legacy>
    implements $LegacyCopyWith<$Res> {
  _$LegacyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Legacy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromCharacterId = null,
    Object? fromCharacterName = null,
    Object? retiredAt = null,
    Object? inheritedExp = null,
    Object? inheritedSilver = null,
    Object? inheritedSkillIds = null,
    Object? inheritedItemIds = null,
    Object? inheritedReputation = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fromCharacterId: null == fromCharacterId
                ? _value.fromCharacterId
                : fromCharacterId // ignore: cast_nullable_to_non_nullable
                      as String,
            fromCharacterName: null == fromCharacterName
                ? _value.fromCharacterName
                : fromCharacterName // ignore: cast_nullable_to_non_nullable
                      as String,
            retiredAt: null == retiredAt
                ? _value.retiredAt
                : retiredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            inheritedExp: null == inheritedExp
                ? _value.inheritedExp
                : inheritedExp // ignore: cast_nullable_to_non_nullable
                      as int,
            inheritedSilver: null == inheritedSilver
                ? _value.inheritedSilver
                : inheritedSilver // ignore: cast_nullable_to_non_nullable
                      as int,
            inheritedSkillIds: null == inheritedSkillIds
                ? _value.inheritedSkillIds
                : inheritedSkillIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            inheritedItemIds: null == inheritedItemIds
                ? _value.inheritedItemIds
                : inheritedItemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            inheritedReputation: null == inheritedReputation
                ? _value.inheritedReputation
                : inheritedReputation // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LegacyImplCopyWith<$Res> implements $LegacyCopyWith<$Res> {
  factory _$$LegacyImplCopyWith(
    _$LegacyImpl value,
    $Res Function(_$LegacyImpl) then,
  ) = __$$LegacyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fromCharacterId,
    String fromCharacterName,
    DateTime retiredAt,
    int inheritedExp,
    int inheritedSilver,
    List<String> inheritedSkillIds,
    List<String> inheritedItemIds,
    int inheritedReputation,
  });
}

/// @nodoc
class __$$LegacyImplCopyWithImpl<$Res>
    extends _$LegacyCopyWithImpl<$Res, _$LegacyImpl>
    implements _$$LegacyImplCopyWith<$Res> {
  __$$LegacyImplCopyWithImpl(
    _$LegacyImpl _value,
    $Res Function(_$LegacyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Legacy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromCharacterId = null,
    Object? fromCharacterName = null,
    Object? retiredAt = null,
    Object? inheritedExp = null,
    Object? inheritedSilver = null,
    Object? inheritedSkillIds = null,
    Object? inheritedItemIds = null,
    Object? inheritedReputation = null,
  }) {
    return _then(
      _$LegacyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fromCharacterId: null == fromCharacterId
            ? _value.fromCharacterId
            : fromCharacterId // ignore: cast_nullable_to_non_nullable
                  as String,
        fromCharacterName: null == fromCharacterName
            ? _value.fromCharacterName
            : fromCharacterName // ignore: cast_nullable_to_non_nullable
                  as String,
        retiredAt: null == retiredAt
            ? _value.retiredAt
            : retiredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        inheritedExp: null == inheritedExp
            ? _value.inheritedExp
            : inheritedExp // ignore: cast_nullable_to_non_nullable
                  as int,
        inheritedSilver: null == inheritedSilver
            ? _value.inheritedSilver
            : inheritedSilver // ignore: cast_nullable_to_non_nullable
                  as int,
        inheritedSkillIds: null == inheritedSkillIds
            ? _value._inheritedSkillIds
            : inheritedSkillIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        inheritedItemIds: null == inheritedItemIds
            ? _value._inheritedItemIds
            : inheritedItemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        inheritedReputation: null == inheritedReputation
            ? _value.inheritedReputation
            : inheritedReputation // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LegacyImpl implements _Legacy {
  const _$LegacyImpl({
    required this.id,
    required this.fromCharacterId,
    required this.fromCharacterName,
    required this.retiredAt,
    this.inheritedExp = 0,
    this.inheritedSilver = 0,
    final List<String> inheritedSkillIds = const [],
    final List<String> inheritedItemIds = const [],
    this.inheritedReputation = 0,
  }) : _inheritedSkillIds = inheritedSkillIds,
       _inheritedItemIds = inheritedItemIds;

  factory _$LegacyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LegacyImplFromJson(json);

  @override
  final String id;
  @override
  final String fromCharacterId;
  @override
  final String fromCharacterName;
  @override
  final DateTime retiredAt;
  // 可继承的内容
  @override
  @JsonKey()
  final int inheritedExp;
  @override
  @JsonKey()
  final int inheritedSilver;
  final List<String> _inheritedSkillIds;
  @override
  @JsonKey()
  List<String> get inheritedSkillIds {
    if (_inheritedSkillIds is EqualUnmodifiableListView)
      return _inheritedSkillIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inheritedSkillIds);
  }

  final List<String> _inheritedItemIds;
  @override
  @JsonKey()
  List<String> get inheritedItemIds {
    if (_inheritedItemIds is EqualUnmodifiableListView)
      return _inheritedItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inheritedItemIds);
  }

  @override
  @JsonKey()
  final int inheritedReputation;

  @override
  String toString() {
    return 'Legacy(id: $id, fromCharacterId: $fromCharacterId, fromCharacterName: $fromCharacterName, retiredAt: $retiredAt, inheritedExp: $inheritedExp, inheritedSilver: $inheritedSilver, inheritedSkillIds: $inheritedSkillIds, inheritedItemIds: $inheritedItemIds, inheritedReputation: $inheritedReputation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LegacyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromCharacterId, fromCharacterId) ||
                other.fromCharacterId == fromCharacterId) &&
            (identical(other.fromCharacterName, fromCharacterName) ||
                other.fromCharacterName == fromCharacterName) &&
            (identical(other.retiredAt, retiredAt) ||
                other.retiredAt == retiredAt) &&
            (identical(other.inheritedExp, inheritedExp) ||
                other.inheritedExp == inheritedExp) &&
            (identical(other.inheritedSilver, inheritedSilver) ||
                other.inheritedSilver == inheritedSilver) &&
            const DeepCollectionEquality().equals(
              other._inheritedSkillIds,
              _inheritedSkillIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._inheritedItemIds,
              _inheritedItemIds,
            ) &&
            (identical(other.inheritedReputation, inheritedReputation) ||
                other.inheritedReputation == inheritedReputation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fromCharacterId,
    fromCharacterName,
    retiredAt,
    inheritedExp,
    inheritedSilver,
    const DeepCollectionEquality().hash(_inheritedSkillIds),
    const DeepCollectionEquality().hash(_inheritedItemIds),
    inheritedReputation,
  );

  /// Create a copy of Legacy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LegacyImplCopyWith<_$LegacyImpl> get copyWith =>
      __$$LegacyImplCopyWithImpl<_$LegacyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LegacyImplToJson(this);
  }
}

abstract class _Legacy implements Legacy {
  const factory _Legacy({
    required final String id,
    required final String fromCharacterId,
    required final String fromCharacterName,
    required final DateTime retiredAt,
    final int inheritedExp,
    final int inheritedSilver,
    final List<String> inheritedSkillIds,
    final List<String> inheritedItemIds,
    final int inheritedReputation,
  }) = _$LegacyImpl;

  factory _Legacy.fromJson(Map<String, dynamic> json) = _$LegacyImpl.fromJson;

  @override
  String get id;
  @override
  String get fromCharacterId;
  @override
  String get fromCharacterName;
  @override
  DateTime get retiredAt; // 可继承的内容
  @override
  int get inheritedExp;
  @override
  int get inheritedSilver;
  @override
  List<String> get inheritedSkillIds;
  @override
  List<String> get inheritedItemIds;
  @override
  int get inheritedReputation;

  /// Create a copy of Legacy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LegacyImplCopyWith<_$LegacyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JianghuRecord _$JianghuRecordFromJson(Map<String, dynamic> json) {
  return _JianghuRecord.fromJson(json);
}

/// @nodoc
mixin _$JianghuRecord {
  String get id => throw _privateConstructorUsedError;
  String get characterId => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isLegendary => throw _privateConstructorUsedError;

  /// Serializes this JianghuRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JianghuRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JianghuRecordCopyWith<JianghuRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JianghuRecordCopyWith<$Res> {
  factory $JianghuRecordCopyWith(
    JianghuRecord value,
    $Res Function(JianghuRecord) then,
  ) = _$JianghuRecordCopyWithImpl<$Res, JianghuRecord>;
  @useResult
  $Res call({
    String id,
    String characterId,
    String eventType,
    String description,
    DateTime timestamp,
    bool isLegendary,
  });
}

/// @nodoc
class _$JianghuRecordCopyWithImpl<$Res, $Val extends JianghuRecord>
    implements $JianghuRecordCopyWith<$Res> {
  _$JianghuRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JianghuRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? characterId = null,
    Object? eventType = null,
    Object? description = null,
    Object? timestamp = null,
    Object? isLegendary = null,
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
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isLegendary: null == isLegendary
                ? _value.isLegendary
                : isLegendary // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JianghuRecordImplCopyWith<$Res>
    implements $JianghuRecordCopyWith<$Res> {
  factory _$$JianghuRecordImplCopyWith(
    _$JianghuRecordImpl value,
    $Res Function(_$JianghuRecordImpl) then,
  ) = __$$JianghuRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String characterId,
    String eventType,
    String description,
    DateTime timestamp,
    bool isLegendary,
  });
}

/// @nodoc
class __$$JianghuRecordImplCopyWithImpl<$Res>
    extends _$JianghuRecordCopyWithImpl<$Res, _$JianghuRecordImpl>
    implements _$$JianghuRecordImplCopyWith<$Res> {
  __$$JianghuRecordImplCopyWithImpl(
    _$JianghuRecordImpl _value,
    $Res Function(_$JianghuRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JianghuRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? characterId = null,
    Object? eventType = null,
    Object? description = null,
    Object? timestamp = null,
    Object? isLegendary = null,
  }) {
    return _then(
      _$JianghuRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        characterId: null == characterId
            ? _value.characterId
            : characterId // ignore: cast_nullable_to_non_nullable
                  as String,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isLegendary: null == isLegendary
            ? _value.isLegendary
            : isLegendary // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JianghuRecordImpl implements _JianghuRecord {
  const _$JianghuRecordImpl({
    required this.id,
    required this.characterId,
    required this.eventType,
    required this.description,
    required this.timestamp,
    this.isLegendary = false,
  });

  factory _$JianghuRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$JianghuRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String characterId;
  @override
  final String eventType;
  @override
  final String description;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isLegendary;

  @override
  String toString() {
    return 'JianghuRecord(id: $id, characterId: $characterId, eventType: $eventType, description: $description, timestamp: $timestamp, isLegendary: $isLegendary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JianghuRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.characterId, characterId) ||
                other.characterId == characterId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isLegendary, isLegendary) ||
                other.isLegendary == isLegendary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    characterId,
    eventType,
    description,
    timestamp,
    isLegendary,
  );

  /// Create a copy of JianghuRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JianghuRecordImplCopyWith<_$JianghuRecordImpl> get copyWith =>
      __$$JianghuRecordImplCopyWithImpl<_$JianghuRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JianghuRecordImplToJson(this);
  }
}

abstract class _JianghuRecord implements JianghuRecord {
  const factory _JianghuRecord({
    required final String id,
    required final String characterId,
    required final String eventType,
    required final String description,
    required final DateTime timestamp,
    final bool isLegendary,
  }) = _$JianghuRecordImpl;

  factory _JianghuRecord.fromJson(Map<String, dynamic> json) =
      _$JianghuRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get characterId;
  @override
  String get eventType;
  @override
  String get description;
  @override
  DateTime get timestamp;
  @override
  bool get isLegendary;

  /// Create a copy of JianghuRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JianghuRecordImplCopyWith<_$JianghuRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

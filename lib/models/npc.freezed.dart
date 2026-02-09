// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'npc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Npc _$NpcFromJson(Map<String, dynamic> json) {
  return _Npc.fromJson(json);
}

/// @nodoc
mixin _$Npc {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  NpcType get type => throw _privateConstructorUsedError;
  String get locationId => throw _privateConstructorUsedError; // 对话 key 列表
  List<String> get dialogueIds => throw _privateConstructorUsedError; // 可教技能
  List<String> get teachableSkillIds =>
      throw _privateConstructorUsedError; // 商店物品
  List<String> get shopItemIds => throw _privateConstructorUsedError;

  /// Serializes this Npc to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Npc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NpcCopyWith<Npc> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NpcCopyWith<$Res> {
  factory $NpcCopyWith(Npc value, $Res Function(Npc) then) =
      _$NpcCopyWithImpl<$Res, Npc>;
  @useResult
  $Res call({
    String id,
    String name,
    String title,
    String description,
    NpcType type,
    String locationId,
    List<String> dialogueIds,
    List<String> teachableSkillIds,
    List<String> shopItemIds,
  });
}

/// @nodoc
class _$NpcCopyWithImpl<$Res, $Val extends Npc> implements $NpcCopyWith<$Res> {
  _$NpcCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Npc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? locationId = null,
    Object? dialogueIds = null,
    Object? teachableSkillIds = null,
    Object? shopItemIds = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NpcType,
            locationId: null == locationId
                ? _value.locationId
                : locationId // ignore: cast_nullable_to_non_nullable
                      as String,
            dialogueIds: null == dialogueIds
                ? _value.dialogueIds
                : dialogueIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            teachableSkillIds: null == teachableSkillIds
                ? _value.teachableSkillIds
                : teachableSkillIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            shopItemIds: null == shopItemIds
                ? _value.shopItemIds
                : shopItemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NpcImplCopyWith<$Res> implements $NpcCopyWith<$Res> {
  factory _$$NpcImplCopyWith(_$NpcImpl value, $Res Function(_$NpcImpl) then) =
      __$$NpcImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String title,
    String description,
    NpcType type,
    String locationId,
    List<String> dialogueIds,
    List<String> teachableSkillIds,
    List<String> shopItemIds,
  });
}

/// @nodoc
class __$$NpcImplCopyWithImpl<$Res> extends _$NpcCopyWithImpl<$Res, _$NpcImpl>
    implements _$$NpcImplCopyWith<$Res> {
  __$$NpcImplCopyWithImpl(_$NpcImpl _value, $Res Function(_$NpcImpl) _then)
    : super(_value, _then);

  /// Create a copy of Npc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? locationId = null,
    Object? dialogueIds = null,
    Object? teachableSkillIds = null,
    Object? shopItemIds = null,
  }) {
    return _then(
      _$NpcImpl(
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
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NpcType,
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                  as String,
        dialogueIds: null == dialogueIds
            ? _value._dialogueIds
            : dialogueIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        teachableSkillIds: null == teachableSkillIds
            ? _value._teachableSkillIds
            : teachableSkillIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        shopItemIds: null == shopItemIds
            ? _value._shopItemIds
            : shopItemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NpcImpl implements _Npc {
  const _$NpcImpl({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.type,
    required this.locationId,
    final List<String> dialogueIds = const [],
    final List<String> teachableSkillIds = const [],
    final List<String> shopItemIds = const [],
  }) : _dialogueIds = dialogueIds,
       _teachableSkillIds = teachableSkillIds,
       _shopItemIds = shopItemIds;

  factory _$NpcImpl.fromJson(Map<String, dynamic> json) =>
      _$$NpcImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String title;
  @override
  final String description;
  @override
  final NpcType type;
  @override
  final String locationId;
  // 对话 key 列表
  final List<String> _dialogueIds;
  // 对话 key 列表
  @override
  @JsonKey()
  List<String> get dialogueIds {
    if (_dialogueIds is EqualUnmodifiableListView) return _dialogueIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dialogueIds);
  }

  // 可教技能
  final List<String> _teachableSkillIds;
  // 可教技能
  @override
  @JsonKey()
  List<String> get teachableSkillIds {
    if (_teachableSkillIds is EqualUnmodifiableListView)
      return _teachableSkillIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teachableSkillIds);
  }

  // 商店物品
  final List<String> _shopItemIds;
  // 商店物品
  @override
  @JsonKey()
  List<String> get shopItemIds {
    if (_shopItemIds is EqualUnmodifiableListView) return _shopItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shopItemIds);
  }

  @override
  String toString() {
    return 'Npc(id: $id, name: $name, title: $title, description: $description, type: $type, locationId: $locationId, dialogueIds: $dialogueIds, teachableSkillIds: $teachableSkillIds, shopItemIds: $shopItemIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NpcImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            const DeepCollectionEquality().equals(
              other._dialogueIds,
              _dialogueIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._teachableSkillIds,
              _teachableSkillIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._shopItemIds,
              _shopItemIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    title,
    description,
    type,
    locationId,
    const DeepCollectionEquality().hash(_dialogueIds),
    const DeepCollectionEquality().hash(_teachableSkillIds),
    const DeepCollectionEquality().hash(_shopItemIds),
  );

  /// Create a copy of Npc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NpcImplCopyWith<_$NpcImpl> get copyWith =>
      __$$NpcImplCopyWithImpl<_$NpcImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NpcImplToJson(this);
  }
}

abstract class _Npc implements Npc {
  const factory _Npc({
    required final String id,
    required final String name,
    required final String title,
    required final String description,
    required final NpcType type,
    required final String locationId,
    final List<String> dialogueIds,
    final List<String> teachableSkillIds,
    final List<String> shopItemIds,
  }) = _$NpcImpl;

  factory _Npc.fromJson(Map<String, dynamic> json) = _$NpcImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get title;
  @override
  String get description;
  @override
  NpcType get type;
  @override
  String get locationId; // 对话 key 列表
  @override
  List<String> get dialogueIds; // 可教技能
  @override
  List<String> get teachableSkillIds; // 商店物品
  @override
  List<String> get shopItemIds;

  /// Create a copy of Npc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NpcImplCopyWith<_$NpcImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DialogueNode _$DialogueNodeFromJson(Map<String, dynamic> json) {
  return _DialogueNode.fromJson(json);
}

/// @nodoc
mixin _$DialogueNode {
  String get id => throw _privateConstructorUsedError;
  String get speaker => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<DialogueChoice> get choices =>
      throw _privateConstructorUsedError; // 自动跳转到下一个节点
  String? get nextId => throw _privateConstructorUsedError; // 触发效果
  int get affectionChange => throw _privateConstructorUsedError;
  int get expReward => throw _privateConstructorUsedError;
  int get silverReward => throw _privateConstructorUsedError;
  String? get rewardItemId => throw _privateConstructorUsedError;
  String? get teachSkillId => throw _privateConstructorUsedError; // 条件
  int? get requiredAffection => throw _privateConstructorUsedError;
  String? get requiredQuestId => throw _privateConstructorUsedError;

  /// Serializes this DialogueNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogueNodeCopyWith<DialogueNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogueNodeCopyWith<$Res> {
  factory $DialogueNodeCopyWith(
    DialogueNode value,
    $Res Function(DialogueNode) then,
  ) = _$DialogueNodeCopyWithImpl<$Res, DialogueNode>;
  @useResult
  $Res call({
    String id,
    String speaker,
    String text,
    List<DialogueChoice> choices,
    String? nextId,
    int affectionChange,
    int expReward,
    int silverReward,
    String? rewardItemId,
    String? teachSkillId,
    int? requiredAffection,
    String? requiredQuestId,
  });
}

/// @nodoc
class _$DialogueNodeCopyWithImpl<$Res, $Val extends DialogueNode>
    implements $DialogueNodeCopyWith<$Res> {
  _$DialogueNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? speaker = null,
    Object? text = null,
    Object? choices = null,
    Object? nextId = freezed,
    Object? affectionChange = null,
    Object? expReward = null,
    Object? silverReward = null,
    Object? rewardItemId = freezed,
    Object? teachSkillId = freezed,
    Object? requiredAffection = freezed,
    Object? requiredQuestId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            speaker: null == speaker
                ? _value.speaker
                : speaker // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            choices: null == choices
                ? _value.choices
                : choices // ignore: cast_nullable_to_non_nullable
                      as List<DialogueChoice>,
            nextId: freezed == nextId
                ? _value.nextId
                : nextId // ignore: cast_nullable_to_non_nullable
                      as String?,
            affectionChange: null == affectionChange
                ? _value.affectionChange
                : affectionChange // ignore: cast_nullable_to_non_nullable
                      as int,
            expReward: null == expReward
                ? _value.expReward
                : expReward // ignore: cast_nullable_to_non_nullable
                      as int,
            silverReward: null == silverReward
                ? _value.silverReward
                : silverReward // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardItemId: freezed == rewardItemId
                ? _value.rewardItemId
                : rewardItemId // ignore: cast_nullable_to_non_nullable
                      as String?,
            teachSkillId: freezed == teachSkillId
                ? _value.teachSkillId
                : teachSkillId // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredAffection: freezed == requiredAffection
                ? _value.requiredAffection
                : requiredAffection // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$DialogueNodeImplCopyWith<$Res>
    implements $DialogueNodeCopyWith<$Res> {
  factory _$$DialogueNodeImplCopyWith(
    _$DialogueNodeImpl value,
    $Res Function(_$DialogueNodeImpl) then,
  ) = __$$DialogueNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String speaker,
    String text,
    List<DialogueChoice> choices,
    String? nextId,
    int affectionChange,
    int expReward,
    int silverReward,
    String? rewardItemId,
    String? teachSkillId,
    int? requiredAffection,
    String? requiredQuestId,
  });
}

/// @nodoc
class __$$DialogueNodeImplCopyWithImpl<$Res>
    extends _$DialogueNodeCopyWithImpl<$Res, _$DialogueNodeImpl>
    implements _$$DialogueNodeImplCopyWith<$Res> {
  __$$DialogueNodeImplCopyWithImpl(
    _$DialogueNodeImpl _value,
    $Res Function(_$DialogueNodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? speaker = null,
    Object? text = null,
    Object? choices = null,
    Object? nextId = freezed,
    Object? affectionChange = null,
    Object? expReward = null,
    Object? silverReward = null,
    Object? rewardItemId = freezed,
    Object? teachSkillId = freezed,
    Object? requiredAffection = freezed,
    Object? requiredQuestId = freezed,
  }) {
    return _then(
      _$DialogueNodeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        speaker: null == speaker
            ? _value.speaker
            : speaker // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        choices: null == choices
            ? _value._choices
            : choices // ignore: cast_nullable_to_non_nullable
                  as List<DialogueChoice>,
        nextId: freezed == nextId
            ? _value.nextId
            : nextId // ignore: cast_nullable_to_non_nullable
                  as String?,
        affectionChange: null == affectionChange
            ? _value.affectionChange
            : affectionChange // ignore: cast_nullable_to_non_nullable
                  as int,
        expReward: null == expReward
            ? _value.expReward
            : expReward // ignore: cast_nullable_to_non_nullable
                  as int,
        silverReward: null == silverReward
            ? _value.silverReward
            : silverReward // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardItemId: freezed == rewardItemId
            ? _value.rewardItemId
            : rewardItemId // ignore: cast_nullable_to_non_nullable
                  as String?,
        teachSkillId: freezed == teachSkillId
            ? _value.teachSkillId
            : teachSkillId // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredAffection: freezed == requiredAffection
            ? _value.requiredAffection
            : requiredAffection // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$DialogueNodeImpl implements _DialogueNode {
  const _$DialogueNodeImpl({
    required this.id,
    required this.speaker,
    required this.text,
    final List<DialogueChoice> choices = const [],
    this.nextId,
    this.affectionChange = 0,
    this.expReward = 0,
    this.silverReward = 0,
    this.rewardItemId,
    this.teachSkillId,
    this.requiredAffection,
    this.requiredQuestId,
  }) : _choices = choices;

  factory _$DialogueNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogueNodeImplFromJson(json);

  @override
  final String id;
  @override
  final String speaker;
  @override
  final String text;
  final List<DialogueChoice> _choices;
  @override
  @JsonKey()
  List<DialogueChoice> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  // 自动跳转到下一个节点
  @override
  final String? nextId;
  // 触发效果
  @override
  @JsonKey()
  final int affectionChange;
  @override
  @JsonKey()
  final int expReward;
  @override
  @JsonKey()
  final int silverReward;
  @override
  final String? rewardItemId;
  @override
  final String? teachSkillId;
  // 条件
  @override
  final int? requiredAffection;
  @override
  final String? requiredQuestId;

  @override
  String toString() {
    return 'DialogueNode(id: $id, speaker: $speaker, text: $text, choices: $choices, nextId: $nextId, affectionChange: $affectionChange, expReward: $expReward, silverReward: $silverReward, rewardItemId: $rewardItemId, teachSkillId: $teachSkillId, requiredAffection: $requiredAffection, requiredQuestId: $requiredQuestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogueNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.nextId, nextId) || other.nextId == nextId) &&
            (identical(other.affectionChange, affectionChange) ||
                other.affectionChange == affectionChange) &&
            (identical(other.expReward, expReward) ||
                other.expReward == expReward) &&
            (identical(other.silverReward, silverReward) ||
                other.silverReward == silverReward) &&
            (identical(other.rewardItemId, rewardItemId) ||
                other.rewardItemId == rewardItemId) &&
            (identical(other.teachSkillId, teachSkillId) ||
                other.teachSkillId == teachSkillId) &&
            (identical(other.requiredAffection, requiredAffection) ||
                other.requiredAffection == requiredAffection) &&
            (identical(other.requiredQuestId, requiredQuestId) ||
                other.requiredQuestId == requiredQuestId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    speaker,
    text,
    const DeepCollectionEquality().hash(_choices),
    nextId,
    affectionChange,
    expReward,
    silverReward,
    rewardItemId,
    teachSkillId,
    requiredAffection,
    requiredQuestId,
  );

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogueNodeImplCopyWith<_$DialogueNodeImpl> get copyWith =>
      __$$DialogueNodeImplCopyWithImpl<_$DialogueNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogueNodeImplToJson(this);
  }
}

abstract class _DialogueNode implements DialogueNode {
  const factory _DialogueNode({
    required final String id,
    required final String speaker,
    required final String text,
    final List<DialogueChoice> choices,
    final String? nextId,
    final int affectionChange,
    final int expReward,
    final int silverReward,
    final String? rewardItemId,
    final String? teachSkillId,
    final int? requiredAffection,
    final String? requiredQuestId,
  }) = _$DialogueNodeImpl;

  factory _DialogueNode.fromJson(Map<String, dynamic> json) =
      _$DialogueNodeImpl.fromJson;

  @override
  String get id;
  @override
  String get speaker;
  @override
  String get text;
  @override
  List<DialogueChoice> get choices; // 自动跳转到下一个节点
  @override
  String? get nextId; // 触发效果
  @override
  int get affectionChange;
  @override
  int get expReward;
  @override
  int get silverReward;
  @override
  String? get rewardItemId;
  @override
  String? get teachSkillId; // 条件
  @override
  int? get requiredAffection;
  @override
  String? get requiredQuestId;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DialogueNodeImplCopyWith<_$DialogueNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DialogueChoice _$DialogueChoiceFromJson(Map<String, dynamic> json) {
  return _DialogueChoice.fromJson(json);
}

/// @nodoc
mixin _$DialogueChoice {
  String get text => throw _privateConstructorUsedError;
  String get nextId => throw _privateConstructorUsedError;
  int get affectionChange => throw _privateConstructorUsedError;

  /// Serializes this DialogueChoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DialogueChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogueChoiceCopyWith<DialogueChoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogueChoiceCopyWith<$Res> {
  factory $DialogueChoiceCopyWith(
    DialogueChoice value,
    $Res Function(DialogueChoice) then,
  ) = _$DialogueChoiceCopyWithImpl<$Res, DialogueChoice>;
  @useResult
  $Res call({String text, String nextId, int affectionChange});
}

/// @nodoc
class _$DialogueChoiceCopyWithImpl<$Res, $Val extends DialogueChoice>
    implements $DialogueChoiceCopyWith<$Res> {
  _$DialogueChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogueChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? nextId = null,
    Object? affectionChange = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            nextId: null == nextId
                ? _value.nextId
                : nextId // ignore: cast_nullable_to_non_nullable
                      as String,
            affectionChange: null == affectionChange
                ? _value.affectionChange
                : affectionChange // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DialogueChoiceImplCopyWith<$Res>
    implements $DialogueChoiceCopyWith<$Res> {
  factory _$$DialogueChoiceImplCopyWith(
    _$DialogueChoiceImpl value,
    $Res Function(_$DialogueChoiceImpl) then,
  ) = __$$DialogueChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String nextId, int affectionChange});
}

/// @nodoc
class __$$DialogueChoiceImplCopyWithImpl<$Res>
    extends _$DialogueChoiceCopyWithImpl<$Res, _$DialogueChoiceImpl>
    implements _$$DialogueChoiceImplCopyWith<$Res> {
  __$$DialogueChoiceImplCopyWithImpl(
    _$DialogueChoiceImpl _value,
    $Res Function(_$DialogueChoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DialogueChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? nextId = null,
    Object? affectionChange = null,
  }) {
    return _then(
      _$DialogueChoiceImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        nextId: null == nextId
            ? _value.nextId
            : nextId // ignore: cast_nullable_to_non_nullable
                  as String,
        affectionChange: null == affectionChange
            ? _value.affectionChange
            : affectionChange // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DialogueChoiceImpl implements _DialogueChoice {
  const _$DialogueChoiceImpl({
    required this.text,
    required this.nextId,
    this.affectionChange = 0,
  });

  factory _$DialogueChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogueChoiceImplFromJson(json);

  @override
  final String text;
  @override
  final String nextId;
  @override
  @JsonKey()
  final int affectionChange;

  @override
  String toString() {
    return 'DialogueChoice(text: $text, nextId: $nextId, affectionChange: $affectionChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogueChoiceImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.nextId, nextId) || other.nextId == nextId) &&
            (identical(other.affectionChange, affectionChange) ||
                other.affectionChange == affectionChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, nextId, affectionChange);

  /// Create a copy of DialogueChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogueChoiceImplCopyWith<_$DialogueChoiceImpl> get copyWith =>
      __$$DialogueChoiceImplCopyWithImpl<_$DialogueChoiceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogueChoiceImplToJson(this);
  }
}

abstract class _DialogueChoice implements DialogueChoice {
  const factory _DialogueChoice({
    required final String text,
    required final String nextId,
    final int affectionChange,
  }) = _$DialogueChoiceImpl;

  factory _DialogueChoice.fromJson(Map<String, dynamic> json) =
      _$DialogueChoiceImpl.fromJson;

  @override
  String get text;
  @override
  String get nextId;
  @override
  int get affectionChange;

  /// Create a copy of DialogueChoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DialogueChoiceImplCopyWith<_$DialogueChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

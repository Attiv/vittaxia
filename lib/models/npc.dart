import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'npc.freezed.dart';
part 'npc.g.dart';

@freezed
class Npc with _$Npc {
  const factory Npc({
    required String id,
    required String name,
    required String title,
    required String description,
    required NpcType type,
    required String locationId,
    // 对话 key 列表
    @Default([]) List<String> dialogueIds,
    // 可教技能
    @Default([]) List<String> teachableSkillIds,
    // 商店物品
    @Default([]) List<String> shopItemIds,
  }) = _Npc;

  factory Npc.fromJson(Map<String, dynamic> json) => _$NpcFromJson(json);
}

@freezed
class DialogueNode with _$DialogueNode {
  const factory DialogueNode({
    required String id,
    required String speaker,
    required String text,
    @Default([]) List<DialogueChoice> choices,
    // 自动跳转到下一个节点
    String? nextId,
    // 触发效果
    @Default(0) int affectionChange,
    @Default(0) int expReward,
    @Default(0) int silverReward,
    String? rewardItemId,
    String? teachSkillId,
    // 条件
    int? requiredAffection,
    String? requiredQuestId,
  }) = _DialogueNode;

  factory DialogueNode.fromJson(Map<String, dynamic> json) =>
      _$DialogueNodeFromJson(json);
}

@freezed
class DialogueChoice with _$DialogueChoice {
  const factory DialogueChoice({
    required String text,
    required String nextId,
    @Default(0) int affectionChange,
  }) = _DialogueChoice;

  factory DialogueChoice.fromJson(Map<String, dynamic> json) =>
      _$DialogueChoiceFromJson(json);
}

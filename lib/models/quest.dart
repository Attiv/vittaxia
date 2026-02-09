import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'quest.freezed.dart';
part 'quest.g.dart';

@freezed
class Quest with _$Quest {
  const factory Quest({
    required String id,
    required String name,
    required String description,
    required QuestType type,
    @Default([]) List<QuestObjective> objectives,
    // 奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    @Default(0) int rewardReputation,
    String? rewardItemId,
    String? rewardSkillId,
    // 前置任务
    String? prerequisiteQuestId,
    // 接取地点/NPC
    String? questGiverNpcId,
    String? questLocationId,
  }) = _Quest;

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);
}

@freezed
class QuestObjective with _$QuestObjective {
  const factory QuestObjective({
    required String id,
    required String description,
    required QuestObjectiveType type,
    // 目标 ID（敌人/物品/NPC/地点）
    String? targetId,
    @Default(1) int requiredCount,
  }) = _QuestObjective;

  factory QuestObjective.fromJson(Map<String, dynamic> json) =>
      _$QuestObjectiveFromJson(json);
}

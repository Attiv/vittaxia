import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'sect.freezed.dart';
part 'sect.g.dart';

/// 师门/门派
@freezed
class Sect with _$Sect {
  const factory Sect({
    required String id,
    required String name,
    required String description,
    required SectType type,
    // 入门要求
    @Default(RealmTier.houTian) RealmTier requiredRealm,
    @Default(0) int requiredReputation,
    String? requiredQuestId,
    // 师门特色
    @Default([]) List<String> specialtySkills,
    @Default([]) List<String> teacherNpcIds,
    // 师门任务
    @Default([]) List<String> sectQuestIds,
    // 师门加成
    @Default(0) int atkBonus,
    @Default(0) int defBonus,
    @Default(0) int speedBonus,
  }) = _Sect;

  factory Sect.fromJson(Map<String, dynamic> json) => _$SectFromJson(json);
}

/// 师门任务
@freezed
class SectQuest with _$SectQuest {
  const factory SectQuest({
    required String id,
    required String sectId,
    required String name,
    required String description,
    required List<SectQuestObjective> objectives,
    // 奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    @Default(0) int rewardContribution, // 师门贡献度
    String? rewardSkillId,
    String? rewardItemId,
    // 要求
    @Default(0) int requiredContribution,
    @Default(RealmTier.houTian) RealmTier requiredRealm,
    // 可重复
    @Default(false) bool repeatable,
    @Default(0) int cooldownHours,
  }) = _SectQuest;

  factory SectQuest.fromJson(Map<String, dynamic> json) =>
      _$SectQuestFromJson(json);
}

@freezed
class SectQuestObjective with _$SectQuestObjective {
  const factory SectQuestObjective({
    required String id,
    required String description,
    required QuestObjectiveType type,
    String? targetId,
    @Default(1) int requiredCount,
  }) = _SectQuestObjective;

  factory SectQuestObjective.fromJson(Map<String, dynamic> json) =>
      _$SectQuestObjectiveFromJson(json);
}

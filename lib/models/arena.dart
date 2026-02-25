import 'package:freezed_annotation/freezed_annotation.dart';

part 'arena.freezed.dart';
part 'arena.g.dart';

/// 论剑台类型
enum ArenaType {
  daily('每日挑战'),
  ranked('排位赛'),
  tournament('武林大会');

  final String label;
  const ArenaType(this.label);
}

/// 论剑台对手
@freezed
class ArenaOpponent with _$ArenaOpponent {
  const factory ArenaOpponent({
    required String id,
    required String name,
    required String title,
    required int level,
    required int hp,
    required int atk,
    required int def,
    required int speed,
    @Default([]) List<String> skillIds,
    String? weaponId,
    String? armorId,
    // 奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    @Default(0) int rewardRanking,
    String? rewardItemId,
  }) = _ArenaOpponent;

  factory ArenaOpponent.fromJson(Map<String, dynamic> json) =>
      _$ArenaOpponentFromJson(json);
}

/// 排行榜类型
enum LeaderboardType {
  power('战力榜'),
  wealth('财富榜'),
  reputation('声望榜'),
  arena('论剑榜'),
  sect('师门榜');

  final String label;
  const LeaderboardType(this.label);
}

/// 排行榜条目
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required int rank,
    required String characterId,
    required String characterName,
    required int value,
    String? sectName,
    String? title,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

/// 成就系统
enum AchievementCategory {
  combat('战斗'),
  exploration('探索'),
  social('社交'),
  wealth('财富'),
  cultivation('修炼');

  final String label;
  const AchievementCategory(this.label);
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String name,
    required String description,
    required AchievementCategory category,
    required int targetValue,
    // 奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    String? rewardItemId,
    String? rewardTitle,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

/// 称号系统
@freezed
class Title with _$Title {
  const factory Title({
    required String id,
    required String name,
    required String description,
    // 属性加成
    @Default(0) int atkBonus,
    @Default(0) int defBonus,
    @Default(0) int hpBonus,
    @Default(0) int speedBonus,
    @Default(0) int luckBonus,
    // 获取条件
    String? achievementId,
    int? requiredRanking,
  }) = _Title;

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

/// 结义系统
@freezed
class Brotherhood with _$Brotherhood {
  const factory Brotherhood({
    required String id,
    required String name,
    required List<String> memberIds,
    required DateTime createdAt,
    @Default(0) int level,
    @Default(0) int exp,
    // 结义加成
    @Default(0) int atkBonus,
    @Default(0) int defBonus,
    @Default(0) int expBonus,
  }) = _Brotherhood;

  factory Brotherhood.fromJson(Map<String, dynamic> json) =>
      _$BrotherhoodFromJson(json);
}

extension BrotherhoodX on Brotherhood {
  /// 到下一等级所需经验
  int get expToNextLevel => level * 1000;

  /// 当前等级进度
  double get levelProgress {
    final required = expToNextLevel;
    if (required == 0) return 1.0;
    return (exp / required).clamp(0, 1);
  }
}

/// 传承系统
@freezed
class Legacy with _$Legacy {
  const factory Legacy({
    required String id,
    required String fromCharacterId,
    required String fromCharacterName,
    required DateTime retiredAt,
    // 可继承的内容
    @Default(0) int inheritedExp,
    @Default(0) int inheritedSilver,
    @Default([]) List<String> inheritedSkillIds,
    @Default([]) List<String> inheritedItemIds,
    @Default(0) int inheritedReputation,
  }) = _Legacy;

  factory Legacy.fromJson(Map<String, dynamic> json) =>
      _$LegacyFromJson(json);
}

/// 江湖录（成就记录）
@freezed
class JianghuRecord with _$JianghuRecord {
  const factory JianghuRecord({
    required String id,
    required String characterId,
    required String eventType,
    required String description,
    required DateTime timestamp,
    @Default(false) bool isLegendary,
  }) = _JianghuRecord;

  factory JianghuRecord.fromJson(Map<String, dynamic> json) =>
      _$JianghuRecordFromJson(json);
}

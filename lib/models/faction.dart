import 'package:freezed_annotation/freezed_annotation.dart';

part 'faction.freezed.dart';
part 'faction.g.dart';

/// 江湖势力类型
enum FactionType {
  righteous('正派'),
  evil('邪派'),
  neutral('中立');

  final String label;
  const FactionType(this.label);
}

/// 江湖势力
@freezed
class Faction with _$Faction {
  const factory Faction({
    required String id,
    required String name,
    required String description,
    required FactionType type,
    // 势力关系（其他势力ID -> 关系值，-100到100）
    @Default({}) Map<String, int> relations,
    // 势力特色
    @Default([]) List<String> specialties,
    // 势力据点
    @Default([]) List<String> territoryIds,
  }) = _Faction;

  factory Faction.fromJson(Map<String, dynamic> json) =>
      _$FactionFromJson(json);
}

/// 势力声望等级
enum ReputationLevel {
  hated('仇恨', -1000, -500),
  hostile('敌对', -500, -100),
  unfriendly('冷淡', -100, 0),
  neutral('中立', 0, 100),
  friendly('友好', 100, 500),
  honored('尊敬', 500, 1000),
  revered('崇敬', 1000, 2000),
  exalted('崇拜', 2000, 9999);

  final String label;
  final int minReputation;
  final int maxReputation;

  const ReputationLevel(this.label, this.minReputation, this.maxReputation);

  static ReputationLevel fromReputation(int reputation) {
    for (final level in ReputationLevel.values.reversed) {
      if (reputation >= level.minReputation) return level;
    }
    return hated;
  }
}

/// 玩家与势力的关系
class FactionReputation {
  final String factionId;
  final int reputation;
  final ReputationLevel level;

  FactionReputation({
    required this.factionId,
    required this.reputation,
  }) : level = ReputationLevel.fromReputation(reputation);

  /// 到下一等级还需要的声望
  int get reputationToNextLevel {
    final currentIndex = ReputationLevel.values.indexOf(level);
    if (currentIndex >= ReputationLevel.values.length - 1) return 0;
    final nextLevel = ReputationLevel.values[currentIndex + 1];
    return nextLevel.minReputation - reputation;
  }

  /// 当前等级进度百分比
  double get levelProgress {
    final range = level.maxReputation - level.minReputation;
    final current = reputation - level.minReputation;
    return (current / range).clamp(0, 1);
  }
}

/// 势力事件类型
enum FactionEventType {
  war('势力战争'),
  alliance('结盟'),
  betrayal('背叛'),
  invasion('入侵'),
  festival('庆典');

  final String label;
  const FactionEventType(this.label);
}

/// 势力事件
@freezed
class FactionEvent with _$FactionEvent {
  const factory FactionEvent({
    required String id,
    required String name,
    required String description,
    required FactionEventType type,
    required List<String> involvedFactionIds,
    required DateTime startTime,
    required DateTime endTime,
    // 玩家可以选择的阵营
    @Default([]) List<String> availableSides,
    // 奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    @Default(0) int rewardReputation,
    String? rewardItemId,
  }) = _FactionEvent;

  factory FactionEvent.fromJson(Map<String, dynamic> json) =>
      _$FactionEventFromJson(json);
}

extension FactionEventX on FactionEvent {
  /// 是否正在进行中
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// 剩余时间（小时）
  int get remainingHours {
    if (!isActive) return 0;
    return endTime.difference(DateTime.now()).inHours;
  }
}

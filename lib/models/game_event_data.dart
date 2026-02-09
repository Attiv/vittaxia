import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'game_event_data.freezed.dart';
part 'game_event_data.g.dart';

/// 随机事件模板
@freezed
class GameEventData with _$GameEventData {
  const factory GameEventData({
    required String id,
    required String name,
    required String description,
    required GameEventType type,
    @Default(10) int weight,
    @Default(0) int minDangerLevel,
    @Default(10) int maxDangerLevel,
    // 战斗事件的敌人 ID
    String? enemyId,
    // 宝物事件的物品 ID 和数量
    String? rewardItemId,
    @Default(1) int rewardItemCount,
    // 经验/银两奖励
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    // 选项
    @Default([]) List<EventChoice> choices,
  }) = _GameEventData;

  factory GameEventData.fromJson(Map<String, dynamic> json) =>
      _$GameEventDataFromJson(json);
}

@freezed
class EventChoice with _$EventChoice {
  const factory EventChoice({
    required String text,
    required String resultText,
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    String? rewardItemId,
    @Default(0) int hpChange,
    // 是否触发战斗
    @Default(false) bool triggerBattle,
    String? enemyId,
  }) = _EventChoice;

  factory EventChoice.fromJson(Map<String, dynamic> json) =>
      _$EventChoiceFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultivation.freezed.dart';
part 'cultivation.g.dart';

/// 修炼类型
enum CultivationType {
  meditation('打坐修炼'),
  practice('武技修炼'),
  adventure('历练探索');

  final String label;
  const CultivationType(this.label);
}

/// 修炼状态
enum CultivationStatus {
  idle('空闲'),
  cultivating('修炼中'),
  completed('已完成');

  final String label;
  const CultivationStatus(this.label);
}

/// 修炼记录
@freezed
class CultivationSession with _$CultivationSession {
  const factory CultivationSession({
    required String id,
    required String characterId,
    required CultivationType type,
    required CultivationStatus status,
    // 修炼配置
    String? skillId, // 修炼的技能ID（武技修炼时使用）
    String? locationId, // 历练地点（历练探索时使用）
    // 时间
    required DateTime startTime,
    required int durationMinutes, // 预计修炼时长（分钟）
    DateTime? completedTime,
    // 奖励（完成后填充）
    @Default(0) int rewardExp,
    @Default(0) int rewardSilver,
    @Default({}) Map<String, int> rewardItems,
    String? rewardSkillId,
  }) = _CultivationSession;

  factory CultivationSession.fromJson(Map<String, dynamic> json) =>
      _$CultivationSessionFromJson(json);
}

extension CultivationSessionX on CultivationSession {
  /// 是否已完成
  bool get isCompleted => status == CultivationStatus.completed;

  /// 是否可以收取
  bool get canCollect {
    if (status != CultivationStatus.cultivating) return false;
    final now = DateTime.now();
    final endTime = startTime.add(Duration(minutes: durationMinutes));
    return now.isAfter(endTime);
  }

  /// 剩余时间（分钟）
  int get remainingMinutes {
    if (status != CultivationStatus.cultivating) return 0;
    final now = DateTime.now();
    final endTime = startTime.add(Duration(minutes: durationMinutes));
    if (now.isAfter(endTime)) return 0;
    return endTime.difference(now).inMinutes;
  }

  /// 进度百分比
  double get progress {
    if (status == CultivationStatus.completed) return 1.0;
    if (status == CultivationStatus.idle) return 0.0;
    final now = DateTime.now();
    final elapsed = now.difference(startTime).inMinutes;
    if (elapsed >= durationMinutes) return 1.0;
    return elapsed / durationMinutes;
  }
}

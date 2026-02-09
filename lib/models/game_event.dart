import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_event.freezed.dart';
part 'game_event.g.dart';

/// 游戏日志条目
@freezed
class GameLog with _$GameLog {
  const factory GameLog({
    required String message,
    required DateTime timestamp,
    @Default(LogType.system) LogType type,
  }) = _GameLog;

  factory GameLog.fromJson(Map<String, dynamic> json) =>
      _$GameLogFromJson(json);
}

enum LogType {
  system('系统'),
  combat('战斗'),
  explore('探索'),
  quest('任务'),
  dialogue('对话'),
  item('物品');

  final String label;
  const LogType(this.label);
}

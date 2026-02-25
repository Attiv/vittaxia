import 'package:freezed_annotation/freezed_annotation.dart';

part 'storyline_progress.freezed.dart';
part 'storyline_progress.g.dart';

/// 剧情线类型
enum StorylineType {
  corrupt('贪官系列'),
  protection('保护系列'),
  revenge('复仇系列'),
  palace('宫斗系列'),
  sect('门派系列'),
  martial('武林盟主'),
  demon('正邪之战'),
  romance('爱情线'),
  master('师徒情深'),
  ancient('上古秘境');

  final String label;
  const StorylineType(this.label);
}

/// 剧情分支选择记录
@freezed
class StorylineChoice with _$StorylineChoice {
  const factory StorylineChoice({
    required String questId,
    required String branchId,
    required String choiceName,
    required DateTime chosenAt,
  }) = _StorylineChoice;

  factory StorylineChoice.fromJson(Map<String, dynamic> json) =>
      _$StorylineChoiceFromJson(json);
}

/// 剧情线进度
@freezed
class StorylineProgress with _$StorylineProgress {
  const factory StorylineProgress({
    required String characterId,
    required StorylineType type,
    required int currentChapter, // 当前章节（从1开始）
    required int totalChapters, // 总章节数
    required List<String> completedQuestIds, // 已完成的任务ID
    required List<StorylineChoice> choices, // 玩家的选择记录
    required bool isCompleted, // 是否完成整条剧情线
    String? endingType, // 结局类型（如果有多个结局）
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _StorylineProgress;

  factory StorylineProgress.fromJson(Map<String, dynamic> json) =>
      _$StorylineProgressFromJson(json);
}

/// 剧情结局类型
enum EndingType {
  // 贪官线
  corruptDirect('直接揭发'),
  corruptReport('上报朝廷'),

  // 保护线
  protectTower('送往望月楼'),
  protectCapital('送往京城'),

  // 复仇线
  revengeDuel('正面决斗'),
  revengeStrategy('智取'),

  // 宫斗线
  palaceBattle('正面迎战'),
  palaceStrategy('智取'),

  // 武林盟主
  martialRighteous('支持正道'),
  martialEvil('支持邪道'),
  martialSelf('自立为王'),

  // 正邪线
  demonJoin('加入魔教'),
  demonRefuse('坚守正道'),

  // 爱情线
  romanceSu('与苏晚吟结为道侣'),
  romanceLiu('与柳如烟结为道侣'),
  romancePrincessElope('与公主私奔'),
  romancePrincessMerit('立功迎娶公主'),

  // 师徒线
  masterLegacy('传承衣钵'),

  // 上古秘境
  ancientPower('获得上古神功');

  final String label;
  const EndingType(this.label);
}

/// 剧情线状态
enum StorylineStatus {
  locked('未解锁'),
  available('可开始'),
  inProgress('进行中'),
  completed('已完成');

  final String label;
  const StorylineStatus(this.label);
}

/// 剧情线信息（用于UI显示）
@freezed
class StorylineInfo with _$StorylineInfo {
  const factory StorylineInfo({
    required StorylineType type,
    required String name,
    required String description,
    required int totalChapters,
    required List<String> questIds,
    required StorylineStatus status,
    int? currentChapter,
    String? unlockCondition, // 解锁条件描述
    List<String>? rewards, // 奖励列表
  }) = _StorylineInfo;

  factory StorylineInfo.fromJson(Map<String, dynamic> json) =>
      _$StorylineInfoFromJson(json);
}

/// 剧情线配置
class StorylineConfig {
  static const Map<StorylineType, List<String>> questSequence = {
    StorylineType.corrupt: [
      'corrupt_01',
      'corrupt_02',
      'corrupt_03',
      'corrupt_04',
      'corrupt_05',
      'corrupt_06',
    ],
    StorylineType.protection: [
      'protect_01',
      'protect_02',
      'protect_03',
      'protect_04',
      'protect_05',
    ],
    StorylineType.revenge: [
      'revenge_01',
      'revenge_02',
      'revenge_03',
      'revenge_04',
      'revenge_05',
      'revenge_06',
    ],
    StorylineType.palace: [
      'palace_01',
      'palace_02',
      'palace_03',
      'palace_04',
      'palace_05',
      'palace_06',
      'palace_07',
    ],
    StorylineType.sect: [
      'sect_01',
      'sect_02',
      'sect_03',
      'sect_04',
      'sect_05',
      'sect_06',
    ],
    StorylineType.martial: [
      'martial_01',
      'martial_02',
      'martial_03',
    ],
    StorylineType.demon: [
      'demon_01',
      'demon_02',
      'demon_03',
      'demon_04',
    ],
    StorylineType.romance: [
      'romance_01_su',
      'romance_02_su',
      'romance_03_su',
      'romance_04_su',
    ],
    StorylineType.master: [
      'master_01',
      'master_02',
      'master_03',
      'master_04',
    ],
    StorylineType.ancient: [
      'ancient_01',
      'ancient_02',
      'ancient_03',
      'ancient_04',
    ],
  };

  static const Map<StorylineType, String> descriptions = {
    StorylineType.corrupt: '清风镇的赵知县贪赃枉法，鱼肉百姓。你能否铲除这个贪官，还百姓一个清白？',
    StorylineType.protection: '小翠是个可怜的孤女，被恶人觊觎。你愿意保护她，对抗强权吗？',
    StorylineType.revenge: '十年前师傅被人杀害，凶手至今逍遥法外。是时候为师傅报仇了！',
    StorylineType.palace: '京城暗流涌动，魏公公权倾朝野，想要谋害皇帝。你能否拯救朝廷？',
    StorylineType.sect: '天剑门内出现叛徒，掌门遇袭。你能否力挽狂澜，继任掌门？',
    StorylineType.martial: '武林大会即将召开，各派争夺盟主之位。你会支持谁？',
    StorylineType.demon: '魔教现世，正邪对立。你会加入魔教还是坚守正道？',
    StorylineType.romance: '江湖儿女情长，你会与谁共度余生？',
    StorylineType.master: '你的武功已登峰造极，是时候寻找传人，传承衣钵了。',
    StorylineType.ancient: '古玉中隐藏着上古秘境的入口，里面有什么秘密？',
  };

  static const Map<StorylineType, int> unlockLevel = {
    StorylineType.corrupt: 5,
    StorylineType.protection: 5,
    StorylineType.revenge: 10,
    StorylineType.palace: 15,
    StorylineType.sect: 20,
    StorylineType.martial: 25,
    StorylineType.demon: 25,
    StorylineType.romance: 10,
    StorylineType.master: 30,
    StorylineType.ancient: 35,
  };
}

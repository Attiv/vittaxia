import '../models/enums.dart';
import '../models/quest.dart';

/// 8个主线 + 5个支线任务
final quests = <String, Quest>{
  // ===== 主线：第一章「初出茅庐」=====
  'main_01': const Quest(
    id: 'main_01',
    name: '黑衣人遗物',
    description: '一个受伤的黑衣人将一个锦盒交到你手中后便咽了气。盒中是一块刻有奇异符文的古玉。张大叔建议你去清风镇打听消息。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_01_1',
        description: '与张大叔对话',
        type: QuestObjectiveType.talk,
        targetId: 'zhang_dashu',
      ),
    ],
    rewardExp: 20,
    rewardSilver: 10,
    rewardItemId: 'ancient_jade',
    questGiverNpcId: 'zhang_dashu',
    questLocationId: 'qingyun_village',
  ),
  'main_02': const Quest(
    id: 'main_02',
    name: '初入江湖',
    description: '前往清风镇，打听关于古玉的线索。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_02_1',
        description: '到达清风镇',
        type: QuestObjectiveType.explore,
        targetId: 'qingfeng_town',
      ),
    ],
    rewardExp: 15,
    prerequisiteQuestId: 'main_01',
  ),
  'main_03': const Quest(
    id: 'main_03',
    name: '醉仙楼消息',
    description: '在醉仙楼找到说书先生白无常，向他打听古玉的来历。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_03_1',
        description: '与白无常对话',
        type: QuestObjectiveType.talk,
        targetId: 'bai_wuchang',
      ),
    ],
    rewardExp: 30,
    rewardSilver: 20,
    prerequisiteQuestId: 'main_02',
    questGiverNpcId: 'bai_wuchang',
  ),
  'main_04': const Quest(
    id: 'main_04',
    name: '月下疑云',
    description: '白无常提到望月楼的苏晚吟可能知道古玉的秘密。前往望月楼拜访她。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_04_1',
        description: '到达望月楼',
        type: QuestObjectiveType.explore,
        targetId: 'wangyue_tower',
      ),
      QuestObjective(
        id: 'main_04_2',
        description: '与苏晚吟对话',
        type: QuestObjectiveType.talk,
        targetId: 'su_wanyin',
      ),
    ],
    rewardExp: 40,
    rewardSilver: 30,
    prerequisiteQuestId: 'main_03',
  ),
  'main_05': const Quest(
    id: 'main_05',
    name: '望月楼秘密',
    description: '苏晚吟告诉你，古玉与一个尘封已久的秘密有关。要解开谜团，必须穿越落霞山脉。但山脉被山贼盘踞，你需要先清剿他们。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_05_1',
        description: '到达落霞山脉',
        type: QuestObjectiveType.explore,
        targetId: 'luoxia_mountains',
      ),
    ],
    rewardExp: 30,
    prerequisiteQuestId: 'main_04',
  ),
  'main_06': const Quest(
    id: 'main_06',
    name: '山贼阻路',
    description: '击败落霞山脉的山贼头子，打通前往迷雾谷的道路。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_06_1',
        description: '击败山贼头子',
        type: QuestObjectiveType.kill,
        targetId: 'bandit_leader',
      ),
    ],
    rewardExp: 60,
    rewardSilver: 50,
    rewardReputation: 10,
    prerequisiteQuestId: 'main_05',
  ),
  'main_07': const Quest(
    id: 'main_07',
    name: '迷雾指引',
    description: '穿越迷雾谷。据说谷中危机四伏，需要先天境界以上的实力才能通过。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_07_1',
        description: '到达迷雾谷',
        type: QuestObjectiveType.explore,
        targetId: 'miwu_valley',
      ),
    ],
    rewardExp: 50,
    rewardSilver: 30,
    prerequisiteQuestId: 'main_06',
  ),
  'main_08': const Quest(
    id: 'main_08',
    name: '天剑门前',
    description: '到达天剑门，寻找古玉秘密的最终答案。',
    type: QuestType.main,
    objectives: [
      QuestObjective(
        id: 'main_08_1',
        description: '到达天剑门外',
        type: QuestObjectiveType.explore,
        targetId: 'tianjian_gate',
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    rewardReputation: 20,
    prerequisiteQuestId: 'main_07',
  ),

  // ===== 支线任务 =====
  'side_01': const Quest(
    id: 'side_01',
    name: '药婆的心事',
    description: '李药婆需要碧心草来炮制新药。帮她在青竹林采集碧心草吧。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'side_01_1',
        description: '收集碧心草',
        type: QuestObjectiveType.collect,
        targetId: 'bixin_herb',
        requiredCount: 3,
      ),
    ],
    rewardExp: 25,
    rewardSilver: 30,
    rewardItemId: 'healing_pill',
    questGiverNpcId: 'li_yaopo',
    questLocationId: 'qingyun_village',
  ),
  'side_02': const Quest(
    id: 'side_02',
    name: '棋翁的考验',
    description: '陈老头说如果你能找到天星石，他就教你一些"特别的东西"。天星石据说在青竹林深处。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'side_02_1',
        description: '收集天星石',
        type: QuestObjectiveType.collect,
        targetId: 'tianxing_stone',
      ),
    ],
    rewardExp: 40,
    rewardSkillId: 'chess_insight',
    questGiverNpcId: 'chen_laotou',
    questLocationId: 'qingyun_village',
  ),
  'side_03': const Quest(
    id: 'side_03',
    name: '醉仙楼的麻烦',
    description: '醉仙楼来了几个喝醉了闹事的家伙，柳如烟请你帮忙赶走他们。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'side_03_1',
        description: '击败醉汉',
        type: QuestObjectiveType.kill,
        targetId: 'drunkard',
        requiredCount: 2,
      ),
    ],
    rewardExp: 20,
    rewardSilver: 25,
    questGiverNpcId: 'liu_ruyan',
    questLocationId: 'qingfeng_town',
  ),
  'side_04': const Quest(
    id: 'side_04',
    name: '铸剑师的心愿',
    description: '铸剑师秦铸一生都在寻找寒铁矿，帮他找到这种稀有矿石，他承诺会为你打造一把好剑。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'side_04_1',
        description: '收集寒铁矿',
        type: QuestObjectiveType.collect,
        targetId: 'cold_iron',
      ),
    ],
    rewardExp: 50,
    rewardItemId: 'qingzhu_sword',
    questGiverNpcId: 'qin_zhu',
    questLocationId: 'luoxia_mountains',
  ),
  'side_05': const Quest(
    id: 'side_05',
    name: '月下的琴声',
    description: '苏晚吟想要一朵月见花。月见花只在月圆之夜的望月楼附近盛开。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'side_05_1',
        description: '收集月见花',
        type: QuestObjectiveType.collect,
        targetId: 'moonflower',
      ),
    ],
    rewardExp: 35,
    rewardSkillId: 'moongazing_art',
    questGiverNpcId: 'su_wanyin',
    questLocationId: 'wangyue_tower',
  ),
};

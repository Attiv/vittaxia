import '../models/quest.dart';
import '../models/enums.dart';

/// 剧情分支系统 - 玩家选择影响剧情走向

// ===== 剧情线6：江湖恩怨「武林盟主之争」=====
final martialLeaderQuestline = <String, Quest>{
  'martial_01': const Quest(
    id: 'martial_01',
    name: '武林大会',
    description: '江湖各派齐聚，准备选出新一任武林盟主。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'martial_01_1',
        description: '参加武林大会',
        type: QuestObjectiveType.explore,
        targetId: 'martial_arena',
      ),
    ],
    rewardExp: 150,
    rewardSilver: 100,
    questLocationId: 'martial_arena',
  ),

  'martial_02': const Quest(
    id: 'martial_02',
    name: '各派争斗',
    description: '各派为了盟主之位明争暗斗，你必须选择支持哪一方。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'martial_02_a',
        name: '支持天剑门',
        description: '支持天剑门掌门成为盟主，维护正道。',
        objectives: [
          QuestObjective(
            id: 'martial_02_a_1',
            description: '击败挑战者',
            type: QuestObjectiveType.defeat,
            targetId: 'challenger',
            targetCount: 3,
          ),
        ],
        rewardExp: 200,
        rewardSilver: 150,
      ),
      QuestBranch(
        id: 'martial_02_b',
        name: '支持魔教',
        description: '支持魔教教主，打破正邪之分。',
        objectives: [
          QuestObjective(
            id: 'martial_02_b_1',
            description: '击败正道高手',
            type: QuestObjectiveType.defeat,
            targetId: 'righteous_master',
            targetCount: 3,
          ),
        ],
        rewardExp: 200,
        rewardSilver: 150,
      ),
      QuestBranch(
        id: 'martial_02_c',
        name: '自立为王',
        description: '凭借自己的实力，争夺盟主之位。',
        objectives: [
          QuestObjective(
            id: 'martial_02_c_1',
            description: '击败所有挑战者',
            type: QuestObjectiveType.defeat,
            targetId: 'all_challengers',
            targetCount: 10,
          ),
        ],
        rewardExp: 300,
        rewardSilver: 200,
      ),
    ],
    prerequisiteQuestId: 'martial_01',
  ),

  'martial_03': const Quest(
    id: 'martial_03',
    name: '盟主之位',
    description: '经过激烈的争斗，盟主之位终于有了归属。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'martial_03_1',
        description: '见证盟主诞生',
        type: QuestObjectiveType.interact,
        targetId: 'alliance_ceremony',
        targetCount: 1,
      ),
    ],
    rewardExp: 250,
    rewardSilver: 180,
    rewardItemId: 'alliance_token',
    prerequisiteQuestId: 'martial_02',
  ),
};

// ===== 剧情线7：魔教崛起「正邪之战」=====
final demonSectQuestline = <String, Quest>{
  'demon_01': const Quest(
    id: 'demon_01',
    name: '魔教现世',
    description: '沉寂多年的魔教突然现世，在江湖中掀起腥风血雨。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'demon_01_1',
        description: '调查魔教踪迹',
        type: QuestObjectiveType.collect,
        targetId: 'demon_clue',
        targetCount: 5,
      ),
    ],
    rewardExp: 120,
    rewardSilver: 100,
    questLocationId: 'demon_sect_ruins',
  ),

  'demon_02': const Quest(
    id: 'demon_02',
    name: '魔教教主',
    description: '魔教教主是一位绝世高手，武功深不可测。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'demon_02_1',
        description: '与魔教教主对话',
        type: QuestObjectiveType.talk,
        targetId: 'demon_lord',
      ),
    ],
    rewardExp: 150,
    rewardSilver: 120,
    prerequisiteQuestId: 'demon_01',
  ),

  'demon_03': const Quest(
    id: 'demon_03',
    name: '正邪抉择',
    description: '魔教教主邀请你加入魔教，承诺传授绝世武功。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'demon_03_a',
        name: '加入魔教',
        description: '加入魔教，学习魔功。',
        objectives: [
          QuestObjective(
            id: 'demon_03_a_1',
            description: '接受魔教传承',
            type: QuestObjectiveType.interact,
            targetId: 'demon_inheritance',
            targetCount: 1,
          ),
        ],
        rewardExp: 300,
        rewardSilver: 200,
        rewardItemId: 'demon_manual',
      ),
      QuestBranch(
        id: 'demon_03_b',
        name: '拒绝魔教',
        description: '拒绝魔教，坚守正道。',
        objectives: [
          QuestObjective(
            id: 'demon_03_b_1',
            description: '击退魔教教主',
            type: QuestObjectiveType.defeat,
            targetId: 'demon_lord',
            targetCount: 1,
          ),
        ],
        rewardExp: 250,
        rewardSilver: 180,
        rewardItemId: 'righteous_medal',
      ),
    ],
    prerequisiteQuestId: 'demon_02',
  ),

  'demon_04': const Quest(
    id: 'demon_04',
    name: '正邪大战',
    description: '正道与魔教的最终决战即将开始。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'demon_04_1',
        description: '参加正邪大战',
        type: QuestObjectiveType.explore,
        targetId: 'battle_field',
      ),
    ],
    rewardExp: 400,
    rewardSilver: 300,
    prerequisiteQuestId: 'demon_03',
  ),
};

// ===== 剧情线8：爱情线「红颜知己」=====
final romanceQuestline = <String, Quest>{
  'romance_01_su': const Quest(
    id: 'romance_01_su',
    name: '月下琴音',
    description: '苏晚吟的琴声让你心动，你想更了解她。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_01_su_1',
        description: '与苏晚吟对话10次',
        type: QuestObjectiveType.talk,
        targetId: 'su_wanyin',
        targetCount: 10,
      ),
      QuestObjective(
        id: 'romance_01_su_2',
        description: '送礼给苏晚吟',
        type: QuestObjectiveType.collect,
        targetId: 'moonflower',
        targetCount: 5,
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    questGiverNpcId: 'su_wanyin',
    questLocationId: 'wangyue_tower',
  ),

  'romance_02_su': const Quest(
    id: 'romance_02_su',
    name: '苏晚吟的秘密',
    description: '苏晚吟终于愿意向你敞开心扉，讲述她的过去。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_02_su_1',
        description: '倾听苏晚吟的故事',
        type: QuestObjectiveType.talk,
        targetId: 'su_wanyin',
      ),
    ],
    rewardExp: 150,
    rewardSilver: 100,
    prerequisiteQuestId: 'romance_01_su',
  ),

  'romance_03_su': const Quest(
    id: 'romance_03_su',
    name: '仇人现身',
    description: '苏晚吟的仇人找上门来，你必须保护她。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_03_su_1',
        description: '击败仇人',
        type: QuestObjectiveType.defeat,
        targetId: 'su_enemy',
        targetCount: 1,
      ),
    ],
    rewardExp: 200,
    rewardSilver: 150,
    prerequisiteQuestId: 'romance_02_su',
  ),

  'romance_04_su': const Quest(
    id: 'romance_04_su',
    name: '终身相许',
    description: '苏晚吟对你芳心暗许，愿意与你共度余生。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_04_su_1',
        description: '与苏晚吟结为道侣',
        type: QuestObjectiveType.interact,
        targetId: 'marriage_ceremony',
        targetCount: 1,
      ),
    ],
    rewardExp: 300,
    rewardSilver: 200,
    rewardItemId: 'couple_jade',
    prerequisiteQuestId: 'romance_03_su',
  ),

  'romance_01_liu': const Quest(
    id: 'romance_01_liu',
    name: '醉仙楼情缘',
    description: '柳如烟的笑容如春风拂面，你想更接近她。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_01_liu_1',
        description: '与柳如烟对话10次',
        type: QuestObjectiveType.talk,
        targetId: 'liu_ruyan',
        targetCount: 10,
      ),
      QuestObjective(
        id: 'romance_01_liu_2',
        description: '帮助柳如烟经营酒楼',
        type: QuestObjectiveType.collect,
        targetId: 'rare_wine',
        targetCount: 3,
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    questGiverNpcId: 'liu_ruyan',
    questLocationId: 'qingfeng_town',
  ),

  'romance_02_liu': const Quest(
    id: 'romance_02_liu',
    name: '柳如烟的心事',
    description: '柳如烟似乎有心事，你想帮她分忧。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_02_liu_1',
        description: '与柳如烟深入交谈',
        type: QuestObjectiveType.talk,
        targetId: 'liu_ruyan',
      ),
    ],
    rewardExp: 150,
    rewardSilver: 100,
    prerequisiteQuestId: 'romance_01_liu',
  ),

  'romance_01_princess': const Quest(
    id: 'romance_01_princess',
    name: '公主芳心',
    description: '明珠公主对你心生好感，但你们的身份差距太大。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'romance_01_princess_1',
        description: '与明珠公主对话10次',
        type: QuestObjectiveType.talk,
        targetId: 'princess_mingzhu',
        targetCount: 10,
      ),
    ],
    rewardExp: 150,
    rewardSilver: 120,
    questGiverNpcId: 'princess_mingzhu',
    questLocationId: 'capital_city',
  ),

  'romance_02_princess': const Quest(
    id: 'romance_02_princess',
    name: '皇室阻挠',
    description: '皇帝不同意公主与你交往，派人阻挠。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'romance_02_princess_a',
        name: '私奔',
        description: '带公主私奔，远离皇宫。',
        objectives: [
          QuestObjective(
            id: 'romance_02_princess_a_1',
            description: '逃离京城',
            type: QuestObjectiveType.explore,
            targetId: 'jiangnan',
          ),
        ],
        rewardExp: 250,
        rewardSilver: 180,
      ),
      QuestBranch(
        id: 'romance_02_princess_b',
        name: '立功',
        description: '立下大功，获得皇帝认可。',
        objectives: [
          QuestObjective(
            id: 'romance_02_princess_b_1',
            description: '完成皇帝任务',
            type: QuestObjectiveType.interact,
            targetId: 'emperor_quest',
            targetCount: 1,
          ),
        ],
        rewardExp: 300,
        rewardSilver: 200,
      ),
    ],
    prerequisiteQuestId: 'romance_01_princess',
  ),
};

// ===== 剧情线9：师徒情深「传承之路」=====
final masterApprenticeQuestline = <String, Quest>{
  'master_01': const Quest(
    id: 'master_01',
    name: '寻找传人',
    description: '你的武功已经登峰造极，是时候寻找传人了。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'master_01_1',
        description: '寻找有潜力的弟子',
        type: QuestObjectiveType.interact,
        targetId: 'potential_disciple',
        targetCount: 3,
      ),
    ],
    rewardExp: 200,
    rewardSilver: 150,
    questLocationId: 'qingyun_village',
  ),

  'master_02': const Quest(
    id: 'master_02',
    name: '收徒仪式',
    description: '举行正式的收徒仪式，将毕生所学传授给弟子。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'master_02_1',
        description: '完成收徒仪式',
        type: QuestObjectiveType.interact,
        targetId: 'apprentice_ceremony',
        targetCount: 1,
      ),
    ],
    rewardExp: 250,
    rewardSilver: 180,
    prerequisiteQuestId: 'master_01',
  ),

  'master_03': const Quest(
    id: 'master_03',
    name: '弟子成长',
    description: '培养弟子，让他们在江湖中闯出名堂。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'master_03_1',
        description: '指导弟子修炼',
        type: QuestObjectiveType.interact,
        targetId: 'teach_disciple',
        targetCount: 10,
      ),
    ],
    rewardExp: 300,
    rewardSilver: 200,
    prerequisiteQuestId: 'master_02',
  ),

  'master_04': const Quest(
    id: 'master_04',
    name: '弟子出师',
    description: '弟子学成出师，在江湖中独当一面。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'master_04_1',
        description: '见证弟子出师',
        type: QuestObjectiveType.interact,
        targetId: 'graduation_ceremony',
        targetCount: 1,
      ),
    ],
    rewardExp: 400,
    rewardSilver: 300,
    rewardItemId: 'master_legacy',
    prerequisiteQuestId: 'master_03',
  ),
};

// ===== 剧情线10：隐藏剧情「上古秘境」=====
final ancientSecretQuestline = <String, Quest>{
  'ancient_01': const Quest(
    id: 'ancient_01',
    name: '古玉之谜',
    description: '古玉中隐藏着上古秘境的入口，但需要集齐七块碎片。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'ancient_01_1',
        description: '收集古玉碎片',
        type: QuestObjectiveType.collect,
        targetId: 'jade_fragment',
        targetCount: 7,
      ),
    ],
    rewardExp: 300,
    rewardSilver: 200,
    questLocationId: 'qingyun_village',
  ),

  'ancient_02': const Quest(
    id: 'ancient_02',
    name: '秘境开启',
    description: '集齐七块碎片，古玉发出耀眼光芒，秘境之门开启。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'ancient_02_1',
        description: '进入上古秘境',
        type: QuestObjectiveType.explore,
        targetId: 'ancient_realm',
      ),
    ],
    rewardExp: 400,
    rewardSilver: 300,
    prerequisiteQuestId: 'ancient_01',
  ),

  'ancient_03': const Quest(
    id: 'ancient_03',
    name: '上古传承',
    description: '秘境中有上古大能留下的传承，但也有强大的守护者。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'ancient_03_1',
        description: '击败守护者',
        type: QuestObjectiveType.defeat,
        targetId: 'ancient_guardian',
        targetCount: 1,
      ),
    ],
    rewardExp: 500,
    rewardSilver: 400,
    prerequisiteQuestId: 'ancient_02',
  ),

  'ancient_04': const Quest(
    id: 'ancient_04',
    name: '神功大成',
    description: '获得上古传承，武功突破至前所未有的境界。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'ancient_04_1',
        description: '吸收上古传承',
        type: QuestObjectiveType.interact,
        targetId: 'ancient_inheritance',
        targetCount: 1,
      ),
    ],
    rewardExp: 1000,
    rewardSilver: 500,
    rewardItemId: 'ancient_divine_skill',
    prerequisiteQuestId: 'ancient_03',
  ),
};

/// 合并所有额外剧情线
final additionalStorylines = <String, Quest>{
  ...martialLeaderQuestline,
  ...demonSectQuestline,
  ...romanceQuestline,
  ...masterApprenticeQuestline,
  ...ancientSecretQuestline,
};

import '../models/enums.dart';
import '../models/quest.dart';

/// 长线剧情系统 - 多章节连续剧情

// ===== 剧情线1：贪官系列「清风镇风云」=====
final corruptOfficialQuestline = <String, Quest>{
  'corrupt_01': const Quest(
    id: 'corrupt_01',
    name: '民不聊生',
    description: '清风镇的百姓生活困苦，赋税沉重。张彩凤向你诉说赵知县的恶行。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'corrupt_01_1',
        description: '与张彩凤对话',
        type: QuestObjectiveType.talk,
        targetId: 'zhang_caifeng',
      ),
    ],
    rewardExp: 50,
    rewardSilver: 30,
    questGiverNpcId: 'zhang_caifeng',
    questLocationId: 'qingfeng_town',
  ),

  'corrupt_02': const Quest(
    id: 'corrupt_02',
    name: '暗中调查',
    description: '向小二打听赵知县的底细，收集他贪污的证据。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'corrupt_02_1',
        description: '与小二对话',
        type: QuestObjectiveType.talk,
        targetId: 'xiao_er',
      ),
      QuestObjective(
        id: 'corrupt_02_2',
        description: '与钱老板对话',
        type: QuestObjectiveType.talk,
        targetId: 'qian_laoban',
      ),
    ],
    rewardExp: 60,
    rewardSilver: 40,
    prerequisiteQuestId: 'corrupt_01',
  ),

  'corrupt_03': const Quest(
    id: 'corrupt_03',
    name: '山贼勾结',
    description: '发现赵知县与落霞山脉的山贼勾结。前往山脉调查。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'corrupt_03_1',
        description: '到达落霞山脉',
        type: QuestObjectiveType.explore,
        targetId: 'luoxia_mountains',
      ),
      QuestObjective(
        id: 'corrupt_03_2',
        description: '与二当家对话',
        type: QuestObjectiveType.talk,
        targetId: 'er_dangjia',
      ),
    ],
    rewardExp: 80,
    rewardSilver: 60,
    prerequisiteQuestId: 'corrupt_02',
  ),

  'corrupt_04': const Quest(
    id: 'corrupt_04',
    name: '卧底身份',
    description: '二当家透露自己是朝廷卧底，愿意配合你铲除山贼和贪官。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'corrupt_04_1',
        description: '击败黑风',
        type: QuestObjectiveType.defeat,
        targetId: 'hei_feng',
        targetCount: 1,
      ),
    ],
    rewardExp: 150,
    rewardSilver: 100,
    rewardItemId: 'evidence_letter',
    prerequisiteQuestId: 'corrupt_03',
  ),

  'corrupt_05': const Quest(
    id: 'corrupt_05',
    name: '捕头阻挠',
    description: '准备揭发赵知县时，李捕头带人前来阻拦。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'corrupt_05_1',
        description: '击败李捕头',
        type: QuestObjectiveType.defeat,
        targetId: 'li_butou',
        targetCount: 1,
      ),
    ],
    rewardExp: 120,
    rewardSilver: 80,
    prerequisiteQuestId: 'corrupt_04',
  ),

  'corrupt_06': const Quest(
    id: 'corrupt_06',
    name: '公堂对质',
    description: '在公堂上出示证据，揭发赵知县的罪行。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'corrupt_06_a',
        name: '直接揭发',
        description: '当场揭发赵知县，但他可能狗急跳墙。',
        objectives: [
          QuestObjective(
            id: 'corrupt_06_a_1',
            description: '与赵知县对话',
            type: QuestObjectiveType.talk,
            targetId: 'zhao_zhixian',
          ),
        ],
        rewardExp: 200,
        rewardSilver: 150,
        rewardItemId: 'justice_medal',
      ),
      QuestBranch(
        id: 'corrupt_06_b',
        name: '暗中上报',
        description: '将证据送往京城，请朝廷派人处理。',
        objectives: [
          QuestObjective(
            id: 'corrupt_06_b_1',
            description: '到达京城',
            type: QuestObjectiveType.explore,
            targetId: 'capital_city',
          ),
        ],
        rewardExp: 180,
        rewardSilver: 120,
        rewardItemId: 'official_seal',
      ),
    ],
    prerequisiteQuestId: 'corrupt_05',
  ),
};

// ===== 剧情线2：保护系列「守护小翠」=====
final protectionQuestline = <String, Quest>{
  'protect_01': const Quest(
    id: 'protect_01',
    name: '孤女求助',
    description: '小翠的母亲病重，需要昂贵的药材。她向你求助。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'protect_01_1',
        description: '与小翠对话',
        type: QuestObjectiveType.talk,
        targetId: 'xiao_cui',
      ),
      QuestObjective(
        id: 'protect_01_2',
        description: '收集灵芝',
        type: QuestObjectiveType.collect,
        targetId: 'lingzhi',
        targetCount: 1,
      ),
    ],
    rewardExp: 40,
    rewardSilver: 20,
    questGiverNpcId: 'xiao_cui',
    questLocationId: 'qingyun_village',
  ),

  'protect_02': const Quest(
    id: 'protect_02',
    name: '山贼威胁',
    description: '山贼得知小翠家有钱治病，前来勒索。你必须保护她。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'protect_02_1',
        description: '击败山贼',
        type: QuestObjectiveType.defeat,
        targetId: 'bandit',
        targetCount: 3,
      ),
    ],
    rewardExp: 80,
    rewardSilver: 50,
    prerequisiteQuestId: 'protect_01',
  ),

  'protect_03': const Quest(
    id: 'protect_03',
    name: '赵知县觊觎',
    description: '赵知县看上了小翠的美貌，派人前来抓她进府。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'protect_03_1',
        description: '击败衙役',
        type: QuestObjectiveType.defeat,
        targetId: 'yamen_guard',
        targetCount: 5,
      ),
    ],
    rewardExp: 100,
    rewardSilver: 70,
    prerequisiteQuestId: 'protect_02',
  ),

  'protect_04': const Quest(
    id: 'protect_04',
    name: '逃离清风镇',
    description: '得罪了赵知县，必须带小翠逃离清风镇。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'protect_04_a',
        name: '送往望月楼',
        description: '将小翠送到望月楼，请苏晚吟庇护。',
        objectives: [
          QuestObjective(
            id: 'protect_04_a_1',
            description: '护送小翠到望月楼',
            type: QuestObjectiveType.explore,
            targetId: 'wangyue_tower',
          ),
        ],
        rewardExp: 120,
        rewardSilver: 80,
      ),
      QuestBranch(
        id: 'protect_04_b',
        name: '送往京城',
        description: '带小翠前往京城，远离赵知县的势力范围。',
        objectives: [
          QuestObjective(
            id: 'protect_04_b_1',
            description: '护送小翠到京城',
            type: QuestObjectiveType.explore,
            targetId: 'capital_city',
          ),
        ],
        rewardExp: 150,
        rewardSilver: 100,
      ),
    ],
    prerequisiteQuestId: 'protect_03',
  ),

  'protect_05': const Quest(
    id: 'protect_05',
    name: '追兵来袭',
    description: '赵知县派李捕头追杀你们。必须击退追兵。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'protect_05_1',
        description: '击败李捕头',
        type: QuestObjectiveType.defeat,
        targetId: 'li_butou',
        targetCount: 1,
      ),
    ],
    rewardExp: 180,
    rewardSilver: 120,
    prerequisiteQuestId: 'protect_04',
  ),
};

// ===== 剧情线3：复仇系列「血债血偿」=====
final revengeQuestline = <String, Quest>{
  'revenge_01': const Quest(
    id: 'revenge_01',
    name: '师傅遗物',
    description: '整理师傅遗物时，发现一封信，记载着杀害他的凶手线索。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'revenge_01_1',
        description: '与王秀才对话',
        type: QuestObjectiveType.talk,
        targetId: 'wang_xiucai',
      ),
    ],
    rewardExp: 50,
    rewardSilver: 30,
    questGiverNpcId: 'wang_xiucai',
    questLocationId: 'qingyun_village',
  ),

  'revenge_02': const Quest(
    id: 'revenge_02',
    name: '追查线索',
    description: '王秀才告诉你，凶手"血手"曾在清风镇出现过。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'revenge_02_1',
        description: '与白无常对话',
        type: QuestObjectiveType.talk,
        targetId: 'bai_wuchang',
      ),
    ],
    rewardExp: 60,
    rewardSilver: 40,
    prerequisiteQuestId: 'revenge_01',
  ),

  'revenge_03': const Quest(
    id: 'revenge_03',
    name: '血手踪迹',
    description: '白无常说血手现在是魏公公的手下，在京城活动。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'revenge_03_1',
        description: '到达京城',
        type: QuestObjectiveType.explore,
        targetId: 'capital_city',
      ),
    ],
    rewardExp: 80,
    rewardSilver: 60,
    prerequisiteQuestId: 'revenge_02',
  ),

  'revenge_04': const Quest(
    id: 'revenge_04',
    name: '潜入调查',
    description: '在京城打听血手的下落，发现他住在魏公公府中。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'revenge_04_1',
        description: '收集情报',
        type: QuestObjectiveType.collect,
        targetId: 'intelligence_scroll',
        targetCount: 3,
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    prerequisiteQuestId: 'revenge_03',
  ),

  'revenge_05': const Quest(
    id: 'revenge_05',
    name: '夜探魏府',
    description: '夜晚潜入魏府，寻找血手。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'revenge_05_1',
        description: '击败影卫',
        type: QuestObjectiveType.defeat,
        targetId: 'shadow_guard',
        targetCount: 3,
      ),
    ],
    rewardExp: 150,
    rewardSilver: 100,
    prerequisiteQuestId: 'revenge_04',
  ),

  'revenge_06': const Quest(
    id: 'revenge_06',
    name: '血手现身',
    description: '终于找到血手，但他的武功远超你的想象。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'revenge_06_a',
        name: '正面决斗',
        description: '与血手正面决斗，为师傅报仇。',
        objectives: [
          QuestObjective(
            id: 'revenge_06_a_1',
            description: '击败血手',
            type: QuestObjectiveType.defeat,
            targetId: 'blood_hand',
            targetCount: 1,
          ),
        ],
        rewardExp: 300,
        rewardSilver: 200,
        rewardItemId: 'master_sword',
      ),
      QuestBranch(
        id: 'revenge_06_b',
        name: '智取',
        description: '利用魏府的机关陷阱，智取血手。',
        objectives: [
          QuestObjective(
            id: 'revenge_06_b_1',
            description: '触发机关',
            type: QuestObjectiveType.interact,
            targetId: 'trap_mechanism',
            targetCount: 1,
          ),
        ],
        rewardExp: 250,
        rewardSilver: 180,
        rewardItemId: 'master_manual',
      ),
    ],
    prerequisiteQuestId: 'revenge_05',
  ),
};

// ===== 剧情线4：宫斗系列「京城暗流」=====
final palaceIntrigueQuestline = <String, Quest>{
  'palace_01': const Quest(
    id: 'palace_01',
    name: '初入京城',
    description: '来到京城，发现这里暗流涌动，危机四伏。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_01_1',
        description: '到达京城',
        type: QuestObjectiveType.explore,
        targetId: 'capital_city',
      ),
    ],
    rewardExp: 50,
    rewardSilver: 30,
    questLocationId: 'capital_city',
  ),

  'palace_02': const Quest(
    id: 'palace_02',
    name: '公主遇险',
    description: '偶然救下被刺客追杀的明珠公主。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_02_1',
        description: '击败刺客',
        type: QuestObjectiveType.defeat,
        targetId: 'assassin',
        targetCount: 3,
      ),
      QuestObjective(
        id: 'palace_02_2',
        description: '与明珠公主对话',
        type: QuestObjectiveType.talk,
        targetId: 'princess_mingzhu',
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    prerequisiteQuestId: 'palace_01',
  ),

  'palace_03': const Quest(
    id: 'palace_03',
    name: '魏公公的阴谋',
    description: '公主告诉你，魏公公想要谋害皇帝，夺取大权。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_03_1',
        description: '与李丞相对话',
        type: QuestObjectiveType.talk,
        targetId: 'prime_minister',
      ),
    ],
    rewardExp: 120,
    rewardSilver: 100,
    prerequisiteQuestId: 'palace_02',
  ),

  'palace_04': const Quest(
    id: 'palace_04',
    name: '收集证据',
    description: '李丞相请你帮忙收集魏公公谋反的证据。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_04_1',
        description: '收集密信',
        type: QuestObjectiveType.collect,
        targetId: 'secret_letter',
        targetCount: 5,
      ),
    ],
    rewardExp: 150,
    rewardSilver: 120,
    prerequisiteQuestId: 'palace_03',
  ),

  'palace_05': const Quest(
    id: 'palace_05',
    name: '刺杀行动',
    description: '魏公公派影卫刺杀李丞相，你必须保护他。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_05_1',
        description: '击败影卫',
        type: QuestObjectiveType.defeat,
        targetId: 'shadow_guard',
        targetCount: 5,
      ),
    ],
    rewardExp: 180,
    rewardSilver: 150,
    prerequisiteQuestId: 'palace_04',
  ),

  'palace_06': const Quest(
    id: 'palace_06',
    name: '面见圣上',
    description: '在公主的安排下，秘密面见皇帝，呈上证据。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'palace_06_1',
        description: '与皇帝对话',
        type: QuestObjectiveType.talk,
        targetId: 'young_emperor',
      ),
    ],
    rewardExp: 200,
    rewardSilver: 180,
    prerequisiteQuestId: 'palace_05',
  ),

  'palace_07': const Quest(
    id: 'palace_07',
    name: '最终对决',
    description: '魏公公狗急跳墙，发动政变。你必须保护皇帝。',
    type: QuestType.side,
    branches: [
      QuestBranch(
        id: 'palace_07_a',
        name: '正面迎战',
        description: '率领禁军正面迎战魏公公的党羽。',
        objectives: [
          QuestObjective(
            id: 'palace_07_a_1',
            description: '击败魏公公',
            type: QuestObjectiveType.defeat,
            targetId: 'eunuch_wei',
            targetCount: 1,
          ),
        ],
        rewardExp: 500,
        rewardSilver: 300,
        rewardItemId: 'imperial_sword',
      ),
      QuestBranch(
        id: 'palace_07_b',
        name: '智取',
        description: '利用魏公公的党羽内讧，分化瓦解。',
        objectives: [
          QuestObjective(
            id: 'palace_07_b_1',
            description: '说服叛徒弟子',
            type: QuestObjectiveType.talk,
            targetId: 'traitor_disciple',
          ),
        ],
        rewardExp: 450,
        rewardSilver: 280,
        rewardItemId: 'imperial_jade',
      ),
    ],
    prerequisiteQuestId: 'palace_06',
  ),
};

// ===== 剧情线5：门派系列「天剑门危机」=====
final sectCrisisQuestline = <String, Quest>{
  'sect_01': const Quest(
    id: 'sect_01',
    name: '拜入天剑门',
    description: '经过考验，成功拜入江湖第一大派天剑门。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_01_1',
        description: '到达天剑门',
        type: QuestObjectiveType.explore,
        targetId: 'tianjian_gate',
      ),
      QuestObjective(
        id: 'sect_01_2',
        description: '与掌门对话',
        type: QuestObjectiveType.talk,
        targetId: 'sect_master_tian',
      ),
    ],
    rewardExp: 100,
    rewardSilver: 80,
    questLocationId: 'tianjian_gate',
  ),

  'sect_02': const Quest(
    id: 'sect_02',
    name: '门中异象',
    description: '发现门中有人行为诡异，似乎在密谋什么。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_02_1',
        description: '调查可疑弟子',
        type: QuestObjectiveType.interact,
        targetId: 'suspicious_disciple',
        targetCount: 3,
      ),
    ],
    rewardExp: 120,
    rewardSilver: 100,
    prerequisiteQuestId: 'sect_01',
  ),

  'sect_03': const Quest(
    id: 'sect_03',
    name: '叛徒现身',
    description: '发现叛徒弟子勾结魏公公，想要夺取掌门之位。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_03_1',
        description: '与叛徒弟子对话',
        type: QuestObjectiveType.talk,
        targetId: 'traitor_disciple',
      ),
    ],
    rewardExp: 150,
    rewardSilver: 120,
    prerequisiteQuestId: 'sect_02',
  ),

  'sect_04': const Quest(
    id: 'sect_04',
    name: '掌门遇袭',
    description: '叛徒弟子暗算掌门，掌门身受重伤。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_04_1',
        description: '击败叛徒弟子',
        type: QuestObjectiveType.defeat,
        targetId: 'traitor_disciple',
        targetCount: 1,
      ),
    ],
    rewardExp: 200,
    rewardSilver: 150,
    prerequisiteQuestId: 'sect_03',
  ),

  'sect_05': const Quest(
    id: 'sect_05',
    name: '寻找灵药',
    description: '掌门需要千年雪莲才能疗伤，必须前往雪山寻找。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_05_1',
        description: '收集千年雪莲',
        type: QuestObjectiveType.collect,
        targetId: 'millennium_snow_lotus',
        targetCount: 1,
      ),
    ],
    rewardExp: 250,
    rewardSilver: 200,
    prerequisiteQuestId: 'sect_04',
  ),

  'sect_06': const Quest(
    id: 'sect_06',
    name: '继任掌门',
    description: '掌门康复后，决定退隐。你成为新一代掌门。',
    type: QuestType.side,
    objectives: [
      QuestObjective(
        id: 'sect_06_1',
        description: '接受掌门之位',
        type: QuestObjectiveType.talk,
        targetId: 'sect_master_tian',
      ),
    ],
    rewardExp: 500,
    rewardSilver: 300,
    rewardItemId: 'sect_master_token',
    prerequisiteQuestId: 'sect_05',
  ),
};

/// 合并所有长线剧情
final allStorylines = <String, Quest>{
  ...corruptOfficialQuestline,
  ...protectionQuestline,
  ...revengeQuestline,
  ...palaceIntrigueQuestline,
  ...sectCrisisQuestline,
};

import '../models/enums.dart';
import '../models/npc.dart';

/// 扩展的NPC数据 - 包含各种身份和性格的角色
final extendedNpcs = <String, Npc>{
  // ===== 青云村 =====
  'wang_xiucai': const Npc(
    id: 'wang_xiucai',
    name: '王秀才',
    title: '落魄书生',
    description: '曾是京城的举人，因得罪权贵被贬到青云村教书。满腹经纶却报国无门，常借酒消愁。',
    type: NpcType.questGiver,
    locationId: 'qingyun_village',
    dialogueIds: ['wang_greet', 'wang_story', 'wang_revenge_start'],
  ),

  'xiao_cui': const Npc(
    id: 'xiao_cui',
    name: '小翠',
    title: '村姑',
    description: '青云村的姑娘，天真烂漫。父亲被山贼杀害，母亲重病在床，生活艰难。',
    type: NpcType.companion,
    locationId: 'qingyun_village',
    dialogueIds: ['cui_greet', 'cui_help', 'cui_protect_start'],
  ),

  // ===== 清风镇 =====
  'zhao_zhixian': const Npc(
    id: 'zhao_zhixian',
    name: '赵知县',
    title: '清风镇知县',
    description: '清风镇的父母官，表面清廉实则贪婪。与山贼勾结，鱼肉百姓。',
    type: NpcType.enemy,
    locationId: 'qingfeng_town',
    dialogueIds: ['zhao_greet', 'zhao_corrupt'],
  ),

  'li_butou': const Npc(
    id: 'li_butou',
    name: '李捕头',
    title: '清风镇捕头',
    description: '赵知县的走狗，帮助知县欺压百姓。武功不弱，手段狠辣。',
    type: NpcType.enemy,
    locationId: 'qingfeng_town',
    dialogueIds: ['li_butou_greet', 'li_butou_threat'],
  ),

  'zhang_caifeng': const Npc(
    id: 'zhang_caifeng',
    name: '张彩凤',
    title: '布庄老板娘',
    description: '清风镇布庄的老板娘，丈夫早逝独自经营。被赵知县看上，屡次骚扰。',
    type: NpcType.questGiver,
    locationId: 'qingfeng_town',
    dialogueIds: ['zhang_cf_greet', 'zhang_cf_help'],
  ),

  'qian_laoban': const Npc(
    id: 'qian_laoban',
    name: '钱老板',
    title: '钱庄掌柜',
    description: '清风镇钱庄的掌柜，精明世故。知道很多秘密，但只对有钱人说话。',
    type: NpcType.merchant,
    locationId: 'qingfeng_town',
    dialogueIds: ['qian_greet', 'qian_info'],
    shopItemIds: ['silver_note_100', 'silver_note_500'],
  ),

  'xiao_er': const Npc(
    id: 'xiao_er',
    name: '小二',
    title: '醉仙楼伙计',
    description: '醉仙楼的小伙计，机灵活泼。柳如烟的得力助手，对镇上的事情了如指掌。',
    type: NpcType.story,
    locationId: 'qingfeng_town',
    dialogueIds: ['xiaoer_greet', 'xiaoer_gossip'],
  ),

  // ===== 望月楼 =====
  'yue_niang': const Npc(
    id: 'yue_niang',
    name: '月娘',
    title: '望月楼侍女',
    description: '苏晚吟的贴身侍女，忠心耿耿。知道一些苏晚吟的秘密。',
    type: NpcType.story,
    locationId: 'wangyue_tower',
    dialogueIds: ['yue_greet', 'yue_secret'],
  ),

  // ===== 落霞山脉 =====
  'hei_feng': const Npc(
    id: 'hei_feng',
    name: '黑风',
    title: '山贼头目',
    description: '落霞山脉的山贼头目，凶狠残暴。与赵知县勾结，劫掠过往商旅。',
    type: NpcType.enemy,
    locationId: 'luoxia_mountains',
    dialogueIds: ['hei_feng_greet', 'hei_feng_fight'],
  ),

  'er_dangjia': const Npc(
    id: 'er_dangjia',
    name: '二当家',
    title: '山贼副手',
    description: '黑风的副手，实则是朝廷派来的卧底。想要铲除山贼但力不从心。',
    type: NpcType.companion,
    locationId: 'luoxia_mountains',
    dialogueIds: ['er_greet', 'er_secret', 'er_help'],
  ),

  // ===== 荒野营地 =====
  'lao_bing': const Npc(
    id: 'lao_bing',
    name: '老兵',
    title: '退伍老兵',
    description: '曾经的边关守将，因战败被贬为平民。在荒野营地靠打猎为生。',
    type: NpcType.master,
    locationId: 'wilderness_camp',
    dialogueIds: ['laobing_greet', 'laobing_story'],
    teachableSkillIds: ['army_spear', 'shield_bash'],
  ),

  'liu_langzhong': const Npc(
    id: 'liu_langzhong',
    name: '刘郎中',
    title: '游医',
    description: '四处游历的郎中，医术高明。似乎在躲避什么人。',
    type: NpcType.merchant,
    locationId: 'wilderness_camp',
    dialogueIds: ['liu_lz_greet', 'liu_lz_past'],
    shopItemIds: ['great_healing_pill', 'detox_pill', 'qi_pill'],
  ),

  // ===== 迷雾谷 =====
  'gui_po': const Npc(
    id: 'gui_po',
    name: '鬼婆',
    title: '迷雾谷隐者',
    description: '住在迷雾谷深处的老妪，精通毒术和蛊术。性格古怪，但不是坏人。',
    type: NpcType.master,
    locationId: 'miwu_valley',
    dialogueIds: ['gui_po_greet', 'gui_po_teach'],
    teachableSkillIds: ['poison_palm', 'gu_control'],
  ),

  // ===== 京城（新地点）=====
  'princess_mingzhu': const Npc(
    id: 'princess_mingzhu',
    name: '明珠公主',
    title: '当朝公主',
    description: '皇帝最宠爱的公主，聪慧美丽。但宫中暗流涌动，她的处境并不安全。',
    type: NpcType.companion,
    locationId: 'capital_city',
    dialogueIds: ['princess_greet', 'princess_danger'],
  ),

  'eunuch_wei': const Npc(
    id: 'eunuch_wei',
    name: '魏公公',
    title: '司礼监掌印太监',
    description: '权倾朝野的大太监，阴险狡诈。暗中操控朝政，培植党羽。',
    type: NpcType.enemy,
    locationId: 'capital_city',
    dialogueIds: ['wei_greet', 'wei_scheme'],
  ),

  'prime_minister': const Npc(
    id: 'prime_minister',
    name: '李丞相',
    title: '当朝丞相',
    description: '朝廷重臣，正直清廉。与魏公公势不两立，处境艰难。',
    type: NpcType.questGiver,
    locationId: 'capital_city',
    dialogueIds: ['pm_greet', 'pm_request'],
  ),

  'young_emperor': const Npc(
    id: 'young_emperor',
    name: '皇帝',
    title: '当今天子',
    description: '年轻的皇帝，聪明但缺乏经验。被魏公公架空，想要夺回权力。',
    type: NpcType.questGiver,
    locationId: 'capital_city',
    dialogueIds: ['emperor_greet', 'emperor_secret'],
  ),

  'shadow_guard': const Npc(
    id: 'shadow_guard',
    name: '影卫',
    title: '神秘刺客',
    description: '魏公公的死士，武功高强。专门负责暗杀魏公公的敌人。',
    type: NpcType.enemy,
    locationId: 'capital_city',
    dialogueIds: ['shadow_greet', 'shadow_attack'],
  ),

  // ===== 江湖门派 =====
  'sect_master_tian': const Npc(
    id: 'sect_master_tian',
    name: '天剑门掌门',
    title: '剑圣',
    description: '天剑门的掌门，江湖第一剑客。为人正直，但门中暗藏叛徒。',
    type: NpcType.master,
    locationId: 'tianjian_gate',
    dialogueIds: ['tian_greet', 'tian_teach'],
    teachableSkillIds: ['heaven_sword', 'sword_intent'],
  ),

  'traitor_disciple': const Npc(
    id: 'traitor_disciple',
    name: '叛徒弟子',
    title: '天剑门叛徒',
    description: '天剑门的叛徒，暗中投靠魏公公。想要夺取掌门之位。',
    type: NpcType.enemy,
    locationId: 'tianjian_gate',
    dialogueIds: ['traitor_greet', 'traitor_betray'],
  ),

  // ===== 复仇线NPC =====
  'old_master': const Npc(
    id: 'old_master',
    name: '老师傅',
    title: '已故恩师',
    description: '你的师傅，十年前被仇人杀害。临终前留下线索，让你为他报仇。',
    type: NpcType.story,
    locationId: 'qingyun_village',
    dialogueIds: ['master_memory'],
  ),

  'blood_hand': const Npc(
    id: 'blood_hand',
    name: '血手',
    title: '杀师仇人',
    description: '杀害你师傅的凶手，武功高强，手段残忍。现在是魏公公的手下。',
    type: NpcType.enemy,
    locationId: 'capital_city',
    dialogueIds: ['blood_greet', 'blood_taunt'],
  ),
};

/// 合并所有NPC
final allNpcs = <String, Npc>{
  ...npcs,
  ...extendedNpcs,
};

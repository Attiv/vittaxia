import '../models/arena.dart';
import '../models/enums.dart';

/// 论剑台对手数据
final arenaOpponents = <String, ArenaOpponent>{
  // 初级对手
  'rookie_swordsman': const ArenaOpponent(
    id: 'rookie_swordsman',
    name: '新手剑客',
    title: '初出茅庐',
    level: 1,
    hp: 150,
    atk: 15,
    def: 8,
    speed: 10,
    skillIds: ['basic_attack'],
    rewardExp: 50,
    rewardSilver: 30,
    rewardRanking: 10,
  ),
  'village_guard': const ArenaOpponent(
    id: 'village_guard',
    name: '村卫兵',
    title: '守护者',
    level: 2,
    hp: 200,
    atk: 20,
    def: 12,
    speed: 12,
    skillIds: ['basic_attack', 'basic_fist'],
    rewardExp: 80,
    rewardSilver: 50,
    rewardRanking: 15,
  ),

  // 中级对手
  'wandering_warrior': const ArenaOpponent(
    id: 'wandering_warrior',
    name: '游侠',
    title: '浪迹天涯',
    level: 5,
    hp: 350,
    atk: 35,
    def: 20,
    speed: 18,
    skillIds: ['basic_attack', 'gale_sword', 'basic_fist'],
    weaponId: 'iron_sword',
    rewardExp: 150,
    rewardSilver: 100,
    rewardRanking: 30,
    rewardItemId: 'healing_pill',
  ),
  'sect_disciple': const ArenaOpponent(
    id: 'sect_disciple',
    name: '门派弟子',
    title: '外门精英',
    level: 8,
    hp: 500,
    atk: 50,
    def: 30,
    speed: 25,
    skillIds: ['basic_attack', 'tianjian_basic', 'gale_sword'],
    weaponId: 'fine_steel_sword',
    armorId: 'leather_armor',
    rewardExp: 250,
    rewardSilver: 180,
    rewardRanking: 50,
    rewardItemId: 'spirit_pill',
  ),

  // 高级对手
  'elite_warrior': const ArenaOpponent(
    id: 'elite_warrior',
    name: '精英武者',
    title: '江湖好手',
    level: 12,
    hp: 800,
    atk: 80,
    def: 50,
    speed: 35,
    skillIds: ['basic_attack', 'tianjian_basic', 'luoxia_blade_basic', 'iron_body'],
    weaponId: 'cold_moon_blade',
    armorId: 'iron_mail',
    rewardExp: 400,
    rewardSilver: 300,
    rewardRanking: 80,
    rewardItemId: 'fine_iron',
  ),
  'master_swordsman': const ArenaOpponent(
    id: 'master_swordsman',
    name: '剑道宗师',
    title: '一剑封喉',
    level: 15,
    hp: 1200,
    atk: 120,
    def: 70,
    speed: 50,
    skillIds: ['basic_attack', 'tianjian_advanced', 'gale_sword', 'mist_step'],
    weaponId: 'qingzhu_sword',
    armorId: 'cloud_robe',
    rewardExp: 600,
    rewardSilver: 500,
    rewardRanking: 120,
    rewardItemId: 'mystic_ore',
  ),

  // 传奇对手
  'legendary_hero': const ArenaOpponent(
    id: 'legendary_hero',
    name: '传奇英雄',
    title: '名震江湖',
    level: 20,
    hp: 2000,
    atk: 180,
    def: 100,
    speed: 70,
    skillIds: ['basic_attack', 'tianjian_ultimate', 'luoxia_blade_advanced', 'moongazing_art'],
    weaponId: 'qingzhu_sword',
    armorId: 'cloud_robe',
    rewardExp: 1000,
    rewardSilver: 800,
    rewardRanking: 200,
    rewardItemId: 'star_iron',
  ),
};

/// 成就数据
final achievements = <String, Achievement>{
  // 战斗成就
  'first_blood': const Achievement(
    id: 'first_blood',
    name: '初战告捷',
    description: '赢得第一场战斗',
    category: AchievementCategory.combat,
    targetValue: 1,
    rewardExp: 50,
    rewardSilver: 30,
    rewardTitle: '新手战士',
  ),
  'hundred_victories': const Achievement(
    id: 'hundred_victories',
    name: '百战百胜',
    description: '赢得100场战斗',
    category: AchievementCategory.combat,
    targetValue: 100,
    rewardExp: 500,
    rewardSilver: 300,
    rewardTitle: '百战勇士',
  ),
  'arena_champion': const Achievement(
    id: 'arena_champion',
    name: '论剑冠军',
    description: '在论剑台获得第一名',
    category: AchievementCategory.combat,
    targetValue: 1,
    rewardExp: 1000,
    rewardSilver: 800,
    rewardTitle: '论剑冠军',
  ),

  // 探索成就
  'world_traveler': const Achievement(
    id: 'world_traveler',
    name: '行万里路',
    description: '探索所有地点',
    category: AchievementCategory.exploration,
    targetValue: 10,
    rewardExp: 300,
    rewardSilver: 200,
    rewardTitle: '行者',
  ),
  'treasure_hunter': const Achievement(
    id: 'treasure_hunter',
    name: '寻宝大师',
    description: '获得100件物品',
    category: AchievementCategory.exploration,
    targetValue: 100,
    rewardExp: 400,
    rewardSilver: 300,
    rewardTitle: '寻宝者',
  ),

  // 社交成就
  'friend_maker': const Achievement(
    id: 'friend_maker',
    name: '广结善缘',
    description: '与5个NPC达到友好关系',
    category: AchievementCategory.social,
    targetValue: 5,
    rewardExp: 200,
    rewardSilver: 150,
    rewardTitle: '善缘者',
  ),
  'brotherhood': const Achievement(
    id: 'brotherhood',
    name: '结义兄弟',
    description: '与NPC结拜',
    category: AchievementCategory.social,
    targetValue: 1,
    rewardExp: 300,
    rewardSilver: 200,
    rewardTitle: '义士',
  ),

  // 财富成就
  'first_fortune': const Achievement(
    id: 'first_fortune',
    name: '初有积蓄',
    description: '拥有1000银两',
    category: AchievementCategory.wealth,
    targetValue: 1000,
    rewardExp: 100,
    rewardSilver: 100,
  ),
  'wealthy_merchant': const Achievement(
    id: 'wealthy_merchant',
    name: '富甲一方',
    description: '拥有10000银两',
    category: AchievementCategory.wealth,
    targetValue: 10000,
    rewardExp: 500,
    rewardSilver: 500,
    rewardTitle: '富豪',
  ),

  // 修炼成就
  'cultivation_beginner': const Achievement(
    id: 'cultivation_beginner',
    name: '修炼入门',
    description: '完成10次修炼',
    category: AchievementCategory.cultivation,
    targetValue: 10,
    rewardExp: 200,
    rewardSilver: 100,
  ),
  'cultivation_master': const Achievement(
    id: 'cultivation_master',
    name: '修炼大师',
    description: '完成100次修炼',
    category: AchievementCategory.cultivation,
    targetValue: 100,
    rewardExp: 1000,
    rewardSilver: 500,
    rewardTitle: '修炼者',
  ),
};

/// 称号数据
final titles = <String, Title>{
  'rookie': const Title(
    id: 'rookie',
    name: '新手战士',
    description: '刚刚踏入江湖的新人',
    atkBonus: 5,
    achievementId: 'first_blood',
  ),
  'hundred_warrior': const Title(
    id: 'hundred_warrior',
    name: '百战勇士',
    description: '经历过无数战斗的勇士',
    atkBonus: 20,
    defBonus: 10,
    achievementId: 'hundred_victories',
  ),
  'arena_king': const Title(
    id: 'arena_king',
    name: '论剑冠军',
    description: '论剑台的王者',
    atkBonus: 30,
    defBonus: 20,
    speedBonus: 10,
    achievementId: 'arena_champion',
  ),
  'traveler': const Title(
    id: 'traveler',
    name: '行者',
    description: '走遍天下的旅人',
    speedBonus: 15,
    luckBonus: 5,
    achievementId: 'world_traveler',
  ),
  'treasure_seeker': const Title(
    id: 'treasure_seeker',
    name: '寻宝者',
    description: '善于发现宝物的人',
    luckBonus: 10,
    achievementId: 'treasure_hunter',
  ),
  'friend': const Title(
    id: 'friend',
    name: '善缘者',
    description: '广结善缘的侠士',
    luckBonus: 8,
    achievementId: 'friend_maker',
  ),
  'brother': const Title(
    id: 'brother',
    name: '义士',
    description: '重情重义的好汉',
    atkBonus: 15,
    defBonus: 15,
    achievementId: 'brotherhood',
  ),
  'rich': const Title(
    id: 'rich',
    name: '富豪',
    description: '富甲一方的商人',
    luckBonus: 15,
    achievementId: 'wealthy_merchant',
  ),
  'cultivator': const Title(
    id: 'cultivator',
    name: '修炼者',
    description: '勤于修炼的武者',
    hpBonus: 100,
    achievementId: 'cultivation_master',
  ),
  'top_ten': const Title(
    id: 'top_ten',
    name: '江湖十杰',
    description: '排名前十的高手',
    atkBonus: 25,
    defBonus: 25,
    hpBonus: 150,
    requiredRanking: 10,
  ),
  'top_three': const Title(
    id: 'top_three',
    name: '三甲高手',
    description: '排名前三的绝顶高手',
    atkBonus: 40,
    defBonus: 40,
    hpBonus: 250,
    speedBonus: 15,
    requiredRanking: 3,
  ),
  'number_one': const Title(
    id: 'number_one',
    name: '天下第一',
    description: '江湖第一高手',
    atkBonus: 60,
    defBonus: 60,
    hpBonus: 400,
    speedBonus: 25,
    luckBonus: 15,
    requiredRanking: 1,
  ),
};

/// 传承规则
class LegacyRules {
  /// 可继承的经验百分比
  static const expInheritPercent = 0.3;

  /// 可继承的银两百分比
  static const silverInheritPercent = 0.5;

  /// 可继承的声望百分比
  static const reputationInheritPercent = 0.2;

  /// 可继承的技能数量
  static const maxInheritSkills = 3;

  /// 可继承的物品数量
  static const maxInheritItems = 5;

  /// 创建传承
  static Legacy createLegacy({
    required String characterId,
    required String characterName,
    required int totalExp,
    required int totalSilver,
    required int totalReputation,
    required List<String> learnedSkillIds,
    required List<String> ownedItemIds,
  }) {
    // 选择最高级的技能
    final inheritSkills = learnedSkillIds.take(maxInheritSkills).toList();

    // 选择最稀有的物品
    final inheritItems = ownedItemIds.take(maxInheritItems).toList();

    return Legacy(
      id: '${characterId}_legacy',
      fromCharacterId: characterId,
      fromCharacterName: characterName,
      retiredAt: DateTime.now(),
      inheritedExp: (totalExp * expInheritPercent).round(),
      inheritedSilver: (totalSilver * silverInheritPercent).round(),
      inheritedReputation: (totalReputation * reputationInheritPercent).round(),
      inheritedSkillIds: inheritSkills,
      inheritedItemIds: inheritItems,
    );
  }
}

/// 江湖录事件类型
class JianghuRecordTypes {
  static const firstKill = 'first_kill';
  static const bossKill = 'boss_kill';
  static const questComplete = 'quest_complete';
  static const realmBreakthrough = 'realm_breakthrough';
  static const joinSect = 'join_sect';
  static const arenaVictory = 'arena_victory';
  static const treasureFound = 'treasure_found';
  static const npcBefriend = 'npc_befriend';
  static const brotherhood = 'brotherhood';
  static const legendary = 'legendary';
}

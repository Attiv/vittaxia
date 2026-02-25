import '../models/faction.dart';

/// 江湖势力数据
final factions = <String, Faction>{
  'tianjian_sect': const Faction(
    id: 'tianjian_sect',
    name: '天剑门',
    description: '江湖第一大派，以剑法闻名天下。门规森严，弟子众多，是正道的中流砥柱。',
    type: FactionType.righteous,
    relations: {
      'luoxia_blade': 80,
      'qingfeng_fist': 70,
      'wangyue_scholar': 60,
      'blood_shadow': -80,
      'dark_moon': -90,
    },
    specialties: ['剑法精湛', '内功深厚', '弟子众多'],
    territoryIds: ['tianjian_gate', 'tianjian_inner'],
  ),
  'luoxia_blade': const Faction(
    id: 'luoxia_blade',
    name: '落霞刀派',
    description: '以刀法称雄一方的门派，刀势如落霞般绚烂凌厉。门中弟子性格豪爽，重情重义。',
    type: FactionType.righteous,
    relations: {
      'tianjian_sect': 80,
      'qingfeng_fist': 90,
      'blood_shadow': -70,
      'mountain_bandits': -100,
    },
    specialties: ['刀法凌厉', '豪爽义气', '铸造精良'],
    territoryIds: ['luoxia_mountains'],
  ),
  'qingfeng_fist': const Faction(
    id: 'qingfeng_fist',
    name: '清风拳门',
    description: '以拳法和内功见长的门派，讲究刚柔并济，以柔克刚。门中弟子多为侠义之士。',
    type: FactionType.righteous,
    relations: {
      'tianjian_sect': 70,
      'luoxia_blade': 90,
      'wangyue_scholar': 80,
      'blood_shadow': -60,
    },
    specialties: ['拳法刚柔', '侠义为先', '医术精通'],
    territoryIds: ['qingyun_village', 'qingfeng_town'],
  ),
  'wangyue_scholar': const Faction(
    id: 'wangyue_scholar',
    name: '望月文士',
    description: '以琴棋书画和内功心法闻名的隐世门派。门中弟子多为文人雅士，但内功修为深不可测。',
    type: FactionType.neutral,
    relations: {
      'tianjian_sect': 60,
      'qingfeng_fist': 80,
      'blood_shadow': -40,
      'dark_moon': -30,
    },
    specialties: ['琴棋书画', '内功深厚', '隐世不出'],
    territoryIds: ['wangyue_tower'],
  ),
  'blood_shadow': const Faction(
    id: 'blood_shadow',
    name: '血影教',
    description: '邪派势力，以诡异的血功和暗杀术闻名。行事狠辣，视人命如草芥。',
    type: FactionType.evil,
    relations: {
      'tianjian_sect': -80,
      'luoxia_blade': -70,
      'qingfeng_fist': -60,
      'dark_moon': 70,
      'mountain_bandits': 50,
    },
    specialties: ['血功诡异', '暗杀精通', '行事狠辣'],
    territoryIds: ['blood_shadow_lair'],
  ),
  'dark_moon': const Faction(
    id: 'dark_moon',
    name: '暗月宫',
    description: '神秘的邪派组织，擅长毒术和暗器。据说宫主是一位绝世美女，但无人见过其真容。',
    type: FactionType.evil,
    relations: {
      'tianjian_sect': -90,
      'wangyue_scholar': -30,
      'blood_shadow': 70,
      'mountain_bandits': 60,
    },
    specialties: ['毒术精湛', '暗器无双', '神秘莫测'],
    territoryIds: ['dark_moon_palace'],
  ),
  'mountain_bandits': const Faction(
    id: 'mountain_bandits',
    name: '落霞山贼',
    description: '盘踞在落霞山脉的山贼团伙，打家劫舍，无恶不作。',
    type: FactionType.evil,
    relations: {
      'luoxia_blade': -100,
      'qingfeng_fist': -80,
      'blood_shadow': 50,
      'dark_moon': 60,
    },
    specialties: ['人多势众', '熟悉地形', '劫掠为生'],
    territoryIds: ['luoxia_mountains'],
  ),
  'merchant_guild': const Faction(
    id: 'merchant_guild',
    name: '商盟',
    description: '江湖中最大的商业组织，掌控着大部分的货物流通。虽然不参与江湖争斗，但财力雄厚。',
    type: FactionType.neutral,
    relations: {
      'tianjian_sect': 50,
      'luoxia_blade': 60,
      'qingfeng_fist': 70,
      'wangyue_scholar': 40,
      'mountain_bandits': -80,
    },
    specialties: ['财力雄厚', '情报灵通', '中立不偏'],
    territoryIds: ['qingfeng_town'],
  ),
};

/// 势力声望奖励
class FactionReputationReward {
  final ReputationLevel requiredLevel;
  final String description;
  final int? discountPercent; // 商店折扣
  final List<String>? unlockItemIds; // 解锁商品
  final List<String>? unlockSkillIds; // 解锁技能
  final List<String>? unlockQuestIds; // 解锁任务

  const FactionReputationReward({
    required this.requiredLevel,
    required this.description,
    this.discountPercent,
    this.unlockItemIds,
    this.unlockSkillIds,
    this.unlockQuestIds,
  });
}

/// 各势力的声望奖励
final factionRewards = <String, List<FactionReputationReward>>{
  'tianjian_sect': [
    const FactionReputationReward(
      requiredLevel: ReputationLevel.friendly,
      description: '可以进入天剑门外门',
      unlockQuestIds: ['tianjian_outer_quest_01'],
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.honored,
      description: '商店9折优惠',
      discountPercent: 10,
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.revered,
      description: '可以学习天剑门高级剑法',
      unlockSkillIds: ['tianjian_advanced'],
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.exalted,
      description: '可以进入藏剑阁',
      unlockQuestIds: ['tianjian_inner_quest_01'],
      unlockSkillIds: ['tianjian_ultimate'],
    ),
  ],
  'luoxia_blade': [
    const FactionReputationReward(
      requiredLevel: ReputationLevel.friendly,
      description: '商店9折优惠',
      discountPercent: 10,
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.honored,
      description: '可以学习落霞刀法',
      unlockSkillIds: ['luoxia_blade_basic'],
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.revered,
      description: '可以购买寒铁武器',
      unlockItemIds: ['cold_moon_blade'],
    ),
  ],
  'merchant_guild': [
    const FactionReputationReward(
      requiredLevel: ReputationLevel.friendly,
      description: '商店9折优惠',
      discountPercent: 10,
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.honored,
      description: '商店8折优惠',
      discountPercent: 20,
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.revered,
      description: '可以购买稀有材料',
      unlockItemIds: ['star_iron', 'mystic_ore'],
    ),
    const FactionReputationReward(
      requiredLevel: ReputationLevel.exalted,
      description: '商店7折优惠，解锁拍卖行',
      discountPercent: 30,
    ),
  ],
};

/// 势力行为对声望的影响
class FactionAction {
  final String actionId;
  final String description;
  final Map<String, int> reputationChanges; // 势力ID -> 声望变化

  const FactionAction({
    required this.actionId,
    required this.description,
    required this.reputationChanges,
  });
}

/// 常见行为对声望的影响
final factionActions = <String, FactionAction>{
  'kill_bandit': const FactionAction(
    actionId: 'kill_bandit',
    description: '击败山贼',
    reputationChanges: {
      'luoxia_blade': 10,
      'qingfeng_fist': 5,
      'merchant_guild': 8,
      'mountain_bandits': -20,
    },
  ),
  'kill_blood_shadow': const FactionAction(
    actionId: 'kill_blood_shadow',
    description: '击败血影教徒',
    reputationChanges: {
      'tianjian_sect': 15,
      'luoxia_blade': 10,
      'qingfeng_fist': 10,
      'blood_shadow': -30,
    },
  ),
  'help_merchant': const FactionAction(
    actionId: 'help_merchant',
    description: '帮助商人',
    reputationChanges: {
      'merchant_guild': 20,
      'qingfeng_fist': 5,
    },
  ),
  'complete_sect_quest': const FactionAction(
    actionId: 'complete_sect_quest',
    description: '完成师门任务',
    reputationChanges: {
      // 动态计算，根据所属师门
    },
  ),
};

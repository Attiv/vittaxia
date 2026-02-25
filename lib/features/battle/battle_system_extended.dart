import 'dart:math';

import '../../models/enums.dart';

/// 战斗状态效果
enum BattleStatus {
  normal('正常'),
  poisoned('中毒'),
  bleeding('流血'),
  stunned('眩晕'),
  weakened('虚弱'),
  strengthened('强化'),
  shielded('护盾'),
  berserk('狂暴'),
  frozen('冰冻'),
  burning('燃烧');

  final String label;
  const BattleStatus(this.label);
}

/// 状态效果数据
class StatusEffect {
  final BattleStatus status;
  final int duration; // 持续回合数
  final int? damagePerTurn; // 每回合伤害
  final double? atkMultiplier; // 攻击倍率
  final double? defMultiplier; // 防御倍率
  final double? speedMultiplier; // 速度倍率
  final bool canAct; // 是否能行动

  const StatusEffect({
    required this.status,
    required this.duration,
    this.damagePerTurn,
    this.atkMultiplier,
    this.defMultiplier,
    this.speedMultiplier,
    this.canAct = true,
  });

  StatusEffect decreaseDuration() {
    return StatusEffect(
      status: status,
      duration: duration - 1,
      damagePerTurn: damagePerTurn,
      atkMultiplier: atkMultiplier,
      defMultiplier: defMultiplier,
      speedMultiplier: speedMultiplier,
      canAct: canAct,
    );
  }
}

/// 预定义状态效果
class StatusEffects {
  static const poisoned = StatusEffect(
    status: BattleStatus.poisoned,
    duration: 3,
    damagePerTurn: 10,
  );

  static const bleeding = StatusEffect(
    status: BattleStatus.bleeding,
    duration: 2,
    damagePerTurn: 15,
  );

  static const stunned = StatusEffect(
    status: BattleStatus.stunned,
    duration: 1,
    canAct: false,
  );

  static const weakened = StatusEffect(
    status: BattleStatus.weakened,
    duration: 2,
    atkMultiplier: 0.7,
    defMultiplier: 0.8,
  );

  static const strengthened = StatusEffect(
    status: BattleStatus.strengthened,
    duration: 3,
    atkMultiplier: 1.3,
  );

  static const shielded = StatusEffect(
    status: BattleStatus.shielded,
    duration: 2,
    defMultiplier: 1.5,
  );

  static const berserk = StatusEffect(
    status: BattleStatus.berserk,
    duration: 3,
    atkMultiplier: 1.5,
    defMultiplier: 0.7,
    speedMultiplier: 1.2,
  );

  static const frozen = StatusEffect(
    status: BattleStatus.frozen,
    duration: 1,
    canAct: false,
    speedMultiplier: 0.5,
  );

  static const burning = StatusEffect(
    status: BattleStatus.burning,
    duration: 3,
    damagePerTurn: 12,
  );
}

/// 技能连招系统
class SkillCombo {
  final String id;
  final String name;
  final String description;
  final List<String> skillSequence; // 技能ID序列
  final int bonusDamagePercent; // 额外伤害百分比
  final StatusEffect? applyStatus; // 施加状态

  const SkillCombo({
    required this.id,
    required this.name,
    required this.description,
    required this.skillSequence,
    this.bonusDamagePercent = 0,
    this.applyStatus,
  });
}

/// 预定义连招
final skillCombos = <String, SkillCombo>{
  'swift_strike_combo': const SkillCombo(
    id: 'swift_strike_combo',
    name: '疾风连斩',
    description: '快速连续攻击，造成额外伤害',
    skillSequence: ['basic_attack', 'basic_attack', 'basic_attack'],
    bonusDamagePercent: 30,
  ),
  'power_break_combo': const SkillCombo(
    id: 'power_break_combo',
    name: '破甲重击',
    description: '先削弱防御，再重击',
    skillSequence: ['basic_attack', 'heavy_strike'],
    bonusDamagePercent: 50,
    applyStatus: StatusEffects.weakened,
  ),
  'poison_blade_combo': const SkillCombo(
    id: 'poison_blade_combo',
    name: '毒刃连击',
    description: '连续攻击并施加中毒',
    skillSequence: ['basic_attack', 'poison_strike'],
    applyStatus: StatusEffects.poisoned,
  ),
};

/// 武器特性系统
enum WeaponType {
  sword('剑', 1.0, 1.0, 1.0),
  blade('刀', 1.2, 0.9, 0.95),
  fist('拳', 0.8, 1.1, 1.2),
  hidden('暗器', 0.9, 0.8, 1.3);

  final String label;
  final double damageMultiplier;
  final double defenseMultiplier;
  final double speedMultiplier;

  const WeaponType(
    this.label,
    this.damageMultiplier,
    this.defenseMultiplier,
    this.speedMultiplier,
  );
}

/// 武器特殊效果
class WeaponEffect {
  final String name;
  final String description;
  final double triggerChance; // 触发概率
  final int? bonusDamage;
  final StatusEffect? applyStatus;
  final bool? ignoreDefense;

  const WeaponEffect({
    required this.name,
    required this.description,
    required this.triggerChance,
    this.bonusDamage,
    this.applyStatus,
    this.ignoreDefense,
  });
}

/// 预定义武器效果
final weaponEffects = <String, WeaponEffect>{
  'bleeding_edge': const WeaponEffect(
    name: '嗜血',
    description: '攻击有概率造成流血',
    triggerChance: 0.2,
    applyStatus: StatusEffects.bleeding,
  ),
  'frost_bite': const WeaponEffect(
    name: '寒冰',
    description: '攻击有概率冰冻敌人',
    triggerChance: 0.15,
    applyStatus: StatusEffects.frozen,
  ),
  'armor_pierce': const WeaponEffect(
    name: '破甲',
    description: '攻击有概率无视防御',
    triggerChance: 0.25,
    ignoreDefense: true,
  ),
  'critical_strike': const WeaponEffect(
    name: '暴击',
    description: '攻击有概率造成额外伤害',
    triggerChance: 0.3,
    bonusDamage: 50,
  ),
};

/// 战斗感悟系统
class BattleInsight {
  final String id;
  final String name;
  final String description;
  final double triggerChance; // 触发概率
  final int skillExpBonus; // 技能经验加成
  final int expBonus; // 角色经验加成

  const BattleInsight({
    required this.id,
    required this.name,
    required this.description,
    required this.triggerChance,
    this.skillExpBonus = 0,
    this.expBonus = 0,
  });
}

/// 战斗感悟计算器
class BattleInsightCalculator {
  static final _random = Random();

  /// 检查是否触发感悟
  static BattleInsight? checkInsight({
    required int comprehension,
    required RealmTier realmTier,
    required bool isVictory,
  }) {
    // 基础触发率
    var baseChance = 0.1;

    // 悟性加成
    baseChance += comprehension * 0.005;

    // 境界加成
    baseChance += realmTier.rank * 0.02;

    // 胜利加成
    if (isVictory) baseChance += 0.05;

    if (_random.nextDouble() < baseChance) {
      return _generateInsight(comprehension, realmTier);
    }

    return null;
  }

  static BattleInsight _generateInsight(int comprehension, RealmTier realmTier) {
    final insights = [
      BattleInsight(
        id: 'basic_insight',
        name: '略有所悟',
        description: '在战斗中对武技有了新的理解',
        triggerChance: 1.0,
        skillExpBonus: 10 + comprehension,
        expBonus: 5,
      ),
      BattleInsight(
        id: 'deep_insight',
        name: '豁然开朗',
        description: '战斗中突然灵光一闪，对武道有了更深的领悟',
        triggerChance: 0.3,
        skillExpBonus: 30 + comprehension * 2,
        expBonus: 20,
      ),
      BattleInsight(
        id: 'profound_insight',
        name: '醍醐灌顶',
        description: '在生死之间，你对武道的理解达到了新的高度',
        triggerChance: 0.1,
        skillExpBonus: 50 + comprehension * 3,
        expBonus: 50,
      ),
    ];

    // 根据悟性和境界选择感悟等级
    final roll = _random.nextDouble();
    if (roll < 0.1 && comprehension >= 15) {
      return insights[2]; // 醍醐灌顶
    } else if (roll < 0.3 && comprehension >= 10) {
      return insights[1]; // 豁然开朗
    } else {
      return insights[0]; // 略有所悟
    }
  }
}

/// Boss战特殊机制
class BossMechanic {
  final String id;
  final String name;
  final String description;
  final int triggerHpPercent; // 触发血量百分比
  final BossMechanicType type;
  final dynamic data;

  const BossMechanic({
    required this.id,
    required this.name,
    required this.description,
    required this.triggerHpPercent,
    required this.type,
    this.data,
  });
}

enum BossMechanicType {
  enrage, // 狂暴
  summon, // 召唤
  heal, // 治疗
  shield, // 护盾
  aoe, // 范围攻击
  transform, // 变身
}

/// Boss数据
class BossData {
  final String id;
  final String name;
  final List<BossMechanic> mechanics;
  final Map<String, dynamic> rewards;

  const BossData({
    required this.id,
    required this.name,
    required this.mechanics,
    required this.rewards,
  });
}

/// 预定义Boss
final bosses = <String, BossData>{
  'bandit_king': const BossData(
    id: 'bandit_king',
    name: '山贼王',
    mechanics: [
      BossMechanic(
        id: 'bandit_enrage',
        name: '狂暴',
        description: '血量低于50%时进入狂暴状态',
        triggerHpPercent: 50,
        type: BossMechanicType.enrage,
      ),
      BossMechanic(
        id: 'bandit_summon',
        name: '召唤小弟',
        description: '血量低于30%时召唤两个小弟',
        triggerHpPercent: 30,
        type: BossMechanicType.summon,
        data: {'count': 2, 'enemyId': 'bandit'},
      ),
    ],
    rewards: {
      'exp': 500,
      'silver': 300,
      'items': {'cold_iron': 2, 'fine_iron': 3},
    },
  ),
  'ghost_lord': const BossData(
    id: 'ghost_lord',
    name: '幽魂领主',
    mechanics: [
      BossMechanic(
        id: 'ghost_heal',
        name: '吸魂',
        description: '每3回合吸取生命恢复自身',
        triggerHpPercent: 100,
        type: BossMechanicType.heal,
        data: {'healPercent': 20, 'interval': 3},
      ),
      BossMechanic(
        id: 'ghost_aoe',
        name: '怨灵之啸',
        description: '血量低于40%时释放范围攻击',
        triggerHpPercent: 40,
        type: BossMechanicType.aoe,
        data: {'damageMultiplier': 1.5},
      ),
    ],
    rewards: {
      'exp': 800,
      'silver': 400,
      'items': {'tianxing_stone': 1, 'spirit_pill': 3},
    },
  ),
};

/// 战斗难度系统
enum BattleDifficulty {
  easy('简单', 0.7, 1.0, 0.8),
  normal('普通', 1.0, 1.0, 1.0),
  hard('困难', 1.3, 1.2, 1.2),
  nightmare('噩梦', 1.6, 1.5, 1.5);

  final String label;
  final double enemyHpMultiplier;
  final double enemyDamageMultiplier;
  final double rewardMultiplier;

  const BattleDifficulty(
    this.label,
    this.enemyHpMultiplier,
    this.enemyDamageMultiplier,
    this.rewardMultiplier,
  );
}

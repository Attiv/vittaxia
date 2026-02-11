/// 游戏核心数值常量
class GameConstants {
  // 挂机
  static const maxIdleHours = 12;
  static const idleExpMultiplier = 0.5; // 悟性 × 此值 × 分钟

  // 战斗
  static const defenseMultiplier = 0.5;
  static const baseCritRate = 0.05;
  static const critDamageMultiplier = 1.5;

  // 角色初始属性
  static const initialHp = 100;
  static const initialMp = 50;
  static const initialAtk = 10;
  static const initialDef = 5;
  static const initialSpeed = 8;
  static const initialLuck = 5;
  static const initialComprehension = 10;
  static const initialSilver = 100;

  // 境界升级经验需求（基础值，实际 = base × tier × stage）
  static const realmExpBase = 100;

  // 境界突破属性成长（每次突破固定增长）
  static const realmUpgradeHp = 15;
  static const realmUpgradeMp = 8;
  static const realmUpgradeAtk = 2;
  static const realmUpgradeDef = 1;
  static const realmUpgradeSpeed = 1;

  // 好感度
  static const maxAffection = 100;
  static const affectionLevels = [
    '陌生',   // 0~19
    '相识',   // 20~39
    '友善',   // 40~59
    '亲近',   // 60~79
    '信赖',   // 80~94
    '知己',   // 95~100
  ];

  // 技能
  static const maxEquippedSkills = 4;
  static const skillLevelBonusRate = 0.05; // 每级 +5%
  static const skillProficiencyPerLevel = 100; // 每级所需熟练度

  /// 技能等级 → 伤害/回复倍率
  static double skillLevelMultiplier(int level) {
    return 1.0 + (level - 1) * skillLevelBonusRate;
  }

  // 探索间隔（秒）
  static const exploreIntervalSeconds = 30;
}

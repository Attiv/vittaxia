import 'dart:math';

import '../../models/enums.dart';
import '../../models/item.dart';

/// 装备套装效果
class EquipmentSet {
  final String id;
  final String name;
  final String description;
  final List<String> itemIds;
  final Map<int, SetBonus> bonuses; // 件数 -> 套装效果

  const EquipmentSet({
    required this.id,
    required this.name,
    required this.description,
    required this.itemIds,
    required this.bonuses,
  });
}

/// 套装加成
class SetBonus {
  final int requiredPieces;
  final String description;
  final int atkBonus;
  final int defBonus;
  final int hpBonus;
  final int mpBonus;
  final int speedBonus;
  final int luckBonus;

  const SetBonus({
    required this.requiredPieces,
    required this.description,
    this.atkBonus = 0,
    this.defBonus = 0,
    this.hpBonus = 0,
    this.mpBonus = 0,
    this.speedBonus = 0,
    this.luckBonus = 0,
  });
}

/// 套装激活状态
class EquipmentSetActivation {
  final EquipmentSet set;
  final int equippedPieces;
  final SetBonus? activeBonus;

  const EquipmentSetActivation({
    required this.set,
    required this.equippedPieces,
    required this.activeBonus,
  });

  bool get isActive => activeBonus != null;
}

/// 装备套装数据
final equipmentSets = <String, EquipmentSet>{
  'iron_warrior': const EquipmentSet(
    id: 'iron_warrior',
    name: '铁甲战士',
    description: '基础的铁制装备套装，适合新手使用。',
    itemIds: ['iron_sword', 'iron_mail', 'straw_sandals'],
    bonuses: {
      2: SetBonus(
        requiredPieces: 2,
        description: '2件套：攻击+5，防御+5',
        atkBonus: 5,
        defBonus: 5,
      ),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：生命+50，攻击+10，防御+10',
        hpBonus: 50,
        atkBonus: 10,
        defBonus: 10,
      ),
    },
  ),
  'wind_shadow': const EquipmentSet(
    id: 'wind_shadow',
    name: '风影',
    description: '轻盈的装备套装，强化速度和闪避。',
    itemIds: ['qingzhu_sword', 'cloud_boots', 'jade_pendant'],
    bonuses: {
      2: SetBonus(requiredPieces: 2, description: '2件套：速度+8', speedBonus: 8),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：速度+15，运气+5',
        speedBonus: 15,
        luckBonus: 5,
      ),
    },
  ),
  'cold_moon': const EquipmentSet(
    id: 'cold_moon',
    name: '寒月',
    description: '寒气逼人的装备套装，攻击力强大。',
    itemIds: ['cold_moon_blade', 'dark_robe', 'wind_shadow_boots'],
    bonuses: {
      2: SetBonus(requiredPieces: 2, description: '2件套：攻击+15', atkBonus: 15),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：攻击+30，速度+10',
        atkBonus: 30,
        speedBonus: 10,
      ),
    },
  ),
  'steel_frontier': const EquipmentSet(
    id: 'steel_frontier',
    name: '钢锋卫',
    description: '攻守平衡的实战套装，适合中期稳定推进。',
    itemIds: ['fine_steel_sword', 'leather_armor', 'cloud_boots'],
    bonuses: {
      2: SetBonus(
        requiredPieces: 2,
        description: '2件套：攻击+8，防御+8',
        atkBonus: 8,
        defBonus: 8,
      ),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：生命+80，防御+18，速度+4',
        hpBonus: 80,
        defBonus: 18,
        speedBonus: 4,
      ),
    },
  ),
  'night_veil': const EquipmentSet(
    id: 'night_veil',
    name: '夜幕行者',
    description: '偏向突袭与机动的暗战套装。',
    itemIds: ['bandit_saber', 'dark_robe', 'jade_pendant'],
    bonuses: {
      2: SetBonus(
        requiredPieces: 2,
        description: '2件套：攻击+12，速度+6',
        atkBonus: 12,
        speedBonus: 6,
      ),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：攻击+20，速度+12，运气+6',
        atkBonus: 20,
        speedBonus: 12,
        luckBonus: 6,
      ),
    },
  ),
  'heaven_pulse': const EquipmentSet(
    id: 'heaven_pulse',
    name: '天脉',
    description: '高阶全面强化套装，兼具爆发、韧性与续航。',
    itemIds: ['dragon_soul_spear', 'cloud_scale_robe', 'heaven_mirror_ring'],
    bonuses: {
      2: SetBonus(
        requiredPieces: 2,
        description: '2件套：攻击+18，防御+18，内力+40',
        atkBonus: 18,
        defBonus: 18,
        mpBonus: 40,
      ),
      3: SetBonus(
        requiredPieces: 3,
        description: '3件套：生命+120，内力+80，攻+35，防+28，速+10，运+8',
        hpBonus: 120,
        mpBonus: 80,
        atkBonus: 35,
        defBonus: 28,
        speedBonus: 10,
        luckBonus: 8,
      ),
    },
  ),
};

/// 计算当前装备的套装激活情况（同一套只取已达成的最高档位）
List<EquipmentSetActivation> evaluateEquipmentSetActivations({
  String? weaponId,
  String? armorId,
  String? shoesId,
  String? accessoryId,
}) {
  final equippedItemIds = <String>{
    if (weaponId != null && weaponId.isNotEmpty) weaponId,
    if (armorId != null && armorId.isNotEmpty) armorId,
    if (shoesId != null && shoesId.isNotEmpty) shoesId,
    if (accessoryId != null && accessoryId.isNotEmpty) accessoryId,
  };

  final states = <EquipmentSetActivation>[];
  for (final set in equipmentSets.values) {
    final pieces = set.itemIds.where(equippedItemIds.contains).length;
    SetBonus? active;
    for (final bonus in set.bonuses.values) {
      if (pieces < bonus.requiredPieces) continue;
      if (active == null || bonus.requiredPieces > active.requiredPieces) {
        active = bonus;
      }
    }
    states.add(
      EquipmentSetActivation(
        set: set,
        equippedPieces: pieces,
        activeBonus: active,
      ),
    );
  }

  states.sort((a, b) {
    if (a.isActive != b.isActive) return a.isActive ? -1 : 1;
    if (a.equippedPieces != b.equippedPieces) {
      return b.equippedPieces.compareTo(a.equippedPieces);
    }
    return a.set.name.compareTo(b.set.name);
  });
  return states;
}

/// 装备强化系统
class EquipmentEnhanceSystem {
  static final _random = Random();

  /// 计算强化后的属性加成
  static int calculateEnhancedBonus(int baseBonus, int enhanceLevel) {
    if (enhanceLevel == 0) return baseBonus;
    // 每级增加基础属性的10%
    return (baseBonus * (1 + enhanceLevel * 0.1)).round();
  }

  /// 计算强化成功率（带幸运加成）
  static double calculateSuccessRate(double baseRate, int luck) {
    // 运气每点增加0.5%成功率，最多+10%
    final luckBonus = (luck * 0.005).clamp(0, 0.1);
    return (baseRate + luckBonus).clamp(0, 1);
  }

  /// 尝试强化
  static bool tryEnhance(double successRate) {
    return _random.nextDouble() < successRate;
  }

  /// 强化失败惩罚
  static EnhanceFailurePenalty getFailurePenalty(int currentLevel) {
    if (currentLevel <= 3) {
      return EnhanceFailurePenalty.none;
    } else if (currentLevel <= 6) {
      return EnhanceFailurePenalty.stayLevel;
    } else {
      return EnhanceFailurePenalty.downgrade;
    }
  }
}

enum EnhanceFailurePenalty {
  none, // 不掉级
  stayLevel, // 保持等级
  downgrade, // 掉一级
}

/// 装备品质升级系统
class EquipmentQualitySystem {
  /// 升级装备品质所需材料
  static Map<ItemRarity, QualityUpgradeRecipe> get upgradeRecipes => {
    ItemRarity.common: const QualityUpgradeRecipe(
      fromRarity: ItemRarity.common,
      toRarity: ItemRarity.uncommon,
      materialId: 'fine_iron',
      materialCount: 5,
      silverCost: 200,
      successRate: 0.8,
    ),
    ItemRarity.uncommon: const QualityUpgradeRecipe(
      fromRarity: ItemRarity.uncommon,
      toRarity: ItemRarity.rare,
      materialId: 'mystic_ore',
      materialCount: 3,
      silverCost: 500,
      successRate: 0.6,
    ),
    ItemRarity.rare: const QualityUpgradeRecipe(
      fromRarity: ItemRarity.rare,
      toRarity: ItemRarity.epic,
      materialId: 'star_iron',
      materialCount: 2,
      silverCost: 1000,
      successRate: 0.4,
    ),
  };

  /// 品质升级后的属性提升
  static Item upgradeQuality(Item item, ItemRarity newRarity) {
    final multiplier = _getQualityMultiplier(newRarity);

    return item.copyWith(
      rarity: newRarity,
      atkBonus: (item.atkBonus * multiplier).round(),
      defBonus: (item.defBonus * multiplier).round(),
      hpBonus: (item.hpBonus * multiplier).round(),
      mpBonus: (item.mpBonus * multiplier).round(),
      speedBonus: (item.speedBonus * multiplier).round(),
      luckBonus: (item.luckBonus * multiplier).round(),
    );
  }

  static double _getQualityMultiplier(ItemRarity rarity) {
    switch (rarity) {
      case ItemRarity.common:
        return 1.0;
      case ItemRarity.uncommon:
        return 1.3;
      case ItemRarity.rare:
        return 1.6;
      case ItemRarity.epic:
        return 2.0;
      case ItemRarity.legendary:
        return 2.5;
    }
  }
}

class QualityUpgradeRecipe {
  final ItemRarity fromRarity;
  final ItemRarity toRarity;
  final String materialId;
  final int materialCount;
  final int silverCost;
  final double successRate;

  const QualityUpgradeRecipe({
    required this.fromRarity,
    required this.toRarity,
    required this.materialId,
    required this.materialCount,
    required this.silverCost,
    required this.successRate,
  });
}

/// 装备镶嵌系统
class EquipmentGemSystem {
  /// 宝石类型
  static const gems = {
    'ruby': Gem(
      id: 'ruby',
      name: '红宝石',
      description: '增加攻击力',
      atkBonus: 10,
      rarity: ItemRarity.rare,
    ),
    'sapphire': Gem(
      id: 'sapphire',
      name: '蓝宝石',
      description: '增加防御力',
      defBonus: 10,
      rarity: ItemRarity.rare,
    ),
    'emerald': Gem(
      id: 'emerald',
      name: '绿宝石',
      description: '增加生命值',
      hpBonus: 50,
      rarity: ItemRarity.rare,
    ),
    'topaz': Gem(
      id: 'topaz',
      name: '黄宝石',
      description: '增加速度',
      speedBonus: 5,
      rarity: ItemRarity.rare,
    ),
    'amethyst': Gem(
      id: 'amethyst',
      name: '紫宝石',
      description: '增加运气',
      luckBonus: 5,
      rarity: ItemRarity.rare,
    ),
  };
}

class Gem {
  final String id;
  final String name;
  final String description;
  final int atkBonus;
  final int defBonus;
  final int hpBonus;
  final int mpBonus;
  final int speedBonus;
  final int luckBonus;
  final ItemRarity rarity;

  const Gem({
    required this.id,
    required this.name,
    required this.description,
    this.atkBonus = 0,
    this.defBonus = 0,
    this.hpBonus = 0,
    this.mpBonus = 0,
    this.speedBonus = 0,
    this.luckBonus = 0,
    required this.rarity,
  });
}

/// 装备重铸系统
class EquipmentReforgeSystem {
  static final _random = Random();

  /// 重铸装备，随机改变属性
  static Item reforge(Item item) {
    final variance = 0.2; // ±20%变化

    return item.copyWith(
      atkBonus: _varyAttribute(item.atkBonus, variance),
      defBonus: _varyAttribute(item.defBonus, variance),
      hpBonus: _varyAttribute(item.hpBonus, variance),
      mpBonus: _varyAttribute(item.mpBonus, variance),
      speedBonus: _varyAttribute(item.speedBonus, variance),
      luckBonus: _varyAttribute(item.luckBonus, variance),
    );
  }

  static int _varyAttribute(int base, double variance) {
    if (base == 0) return 0;
    final change = (base * variance * (_random.nextDouble() * 2 - 1)).round();
    return (base + change).clamp(0, 9999);
  }

  /// 重铸成本
  static int getReforgeCost(ItemRarity rarity) {
    switch (rarity) {
      case ItemRarity.common:
        return 50;
      case ItemRarity.uncommon:
        return 100;
      case ItemRarity.rare:
        return 200;
      case ItemRarity.epic:
        return 400;
      case ItemRarity.legendary:
        return 800;
    }
  }
}

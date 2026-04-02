import 'dart:math';

import '../../data/enemy_data.dart';

const int bountyStaminaBase = 8;
const int escortStaminaCost = 12;
const int patrolStaminaCost = 9;
const int chainHuntStaminaCost = 30;

class BountyRuleResult {
  final int staminaCost;
  final int bonusExp;
  final int bonusSilver;
  final String? bonusItemId;

  const BountyRuleResult({
    required this.staminaCost,
    required this.bonusExp,
    required this.bonusSilver,
    this.bonusItemId,
  });
}

class EscortOutcome {
  final bool success;
  final int expDelta;
  final int silverDelta;
  final String? rewardItemId;
  final int hpLoss;

  const EscortOutcome({
    required this.success,
    required this.expDelta,
    required this.silverDelta,
    this.rewardItemId,
    this.hpLoss = 0,
  });
}

class PatrolOutcome {
  final bool requiresBattle;
  final bool autoSuccess;
  final String? enemyId;
  final int successExp;
  final int successSilver;
  final String? successItemId;
  final int failureHpLoss;
  final int failureSilverLoss;

  const PatrolOutcome({
    required this.requiresBattle,
    required this.autoSuccess,
    this.enemyId,
    required this.successExp,
    required this.successSilver,
    this.successItemId,
    required this.failureHpLoss,
    required this.failureSilverLoss,
  });
}

class ChainHuntPlan {
  final String firstEnemyId;
  final String secondEnemyId;
  final int stageOneExp;
  final int stageOneSilver;
  final int finalExp;
  final int finalSilver;
  final String? finalItemId;

  const ChainHuntPlan({
    required this.firstEnemyId,
    required this.secondEnemyId,
    required this.stageOneExp,
    required this.stageOneSilver,
    required this.finalExp,
    required this.finalSilver,
    this.finalItemId,
  });
}

class BlackMarketOffer {
  final String id;
  final String title;
  final String brief;
  final int silverCost;
  final String rewardItemId;
  final int rewardCount;
  final String? bonusItemId;
  final int bonusCount;
  final double bonusBaseRate;

  const BlackMarketOffer({
    required this.id,
    required this.title,
    required this.brief,
    required this.silverCost,
    required this.rewardItemId,
    required this.rewardCount,
    this.bonusItemId,
    this.bonusCount = 0,
    this.bonusBaseRate = 0,
  });
}

List<String> selectBountyEnemyPool(int tierIndex) {
  if (tierIndex <= 1) {
    return const [
      'wild_dog',
      'drunkard',
      'wild_boar',
      'mine_bat',
      'cave_snake',
    ];
  }
  if (tierIndex <= 3) {
    return const [
      'bandit',
      'shadow_assassin',
      'rogue_swordsman',
      'mountain_hunter',
      'corrupted_monk',
    ];
  }
  if (tierIndex <= 5) {
    return const ['ghost', 'blood_wolf', 'tomb_warrior', 'iron_golem'];
  }
  return const [
    'bandit_leader',
    'tianjian_disciple',
    'phantom_lord',
    'iron_golem',
  ];
}

BountyRuleResult buildBountyRule({
  required EnemyTemplate enemy,
  required int tier,
  required Random rng,
}) {
  final normalizedTier = tier.clamp(1, 3);
  final staminaCost = bountyStaminaBase + normalizedTier * 3;
  final bonusExp = (enemy.expReward * (0.42 + normalizedTier * 0.2)).round();
  final bonusSilver =
      (enemy.silverReward * (0.55 + normalizedTier * 0.24)).round() +
      normalizedTier * 10;

  String? extraItemId;
  if (normalizedTier >= 3) {
    extraItemId =
        enemy.dropItemId ??
        (rng.nextDouble() < 0.55 ? 'fine_iron' : 'mystic_ore');
  }

  return BountyRuleResult(
    staminaCost: staminaCost,
    bonusExp: bonusExp,
    bonusSilver: bonusSilver,
    bonusItemId: extraItemId,
  );
}

double escortSuccessRate({
  required int speed,
  required int luck,
  required int defense,
}) {
  final raw = 0.42 + speed * 0.0048 + luck * 0.0036 + defense * 0.0018;
  return raw.clamp(0.48, 0.9);
}

EscortOutcome rollEscortOutcome({
  required int speed,
  required int luck,
  required int defense,
  required int currentSilver,
  required Random rng,
}) {
  final successRate = escortSuccessRate(
    speed: speed,
    luck: luck,
    defense: defense,
  );
  final success = rng.nextDouble() < successRate;

  if (success) {
    final silverGain = 58 + rng.nextInt(70) + luck + defense ~/ 3;
    final expGain = 20 + rng.nextInt(26) + max(0, speed - 10) ~/ 2;
    final itemChance = (0.2 + luck * 0.002 + speed * 0.0015).clamp(0.2, 0.46);
    final itemId = rng.nextDouble() < itemChance
        ? (rng.nextDouble() < 0.68 ? 'fine_iron' : 'mystic_ore')
        : null;

    return EscortOutcome(
      success: true,
      expDelta: expGain,
      silverDelta: silverGain,
      rewardItemId: itemId,
    );
  }

  final defenseOffset = defense >= 16 ? 0 : 8 - defense ~/ 2;
  final hpLoss = 10 + rng.nextInt(20) + defenseOffset;
  final silverLoss = min(currentSilver, 16 + rng.nextInt(34));
  return EscortOutcome(
    success: false,
    expDelta: 0,
    silverDelta: -silverLoss,
    hpLoss: hpLoss,
  );
}

double patrolSuccessRate({
  required int dangerLevel,
  required int speed,
  required int luck,
  required int defense,
}) {
  final raw =
      0.58 +
      defense * 0.0028 +
      speed * 0.0022 +
      luck * 0.0016 -
      dangerLevel * 0.032;
  return raw.clamp(0.36, 0.88);
}

double patrolAmbushRate(int dangerLevel) {
  return (0.12 + dangerLevel * 0.035).clamp(0.15, 0.45);
}

PatrolOutcome rollPatrolOutcome({
  required int tierIndex,
  required int dangerLevel,
  required int speed,
  required int luck,
  required int defense,
  required int currentSilver,
  required Random rng,
}) {
  final danger = dangerLevel.clamp(1, 9);
  final ambush = rng.nextDouble() < patrolAmbushRate(danger);
  final successExp = 14 + danger * 5 + rng.nextInt(12 + danger * 3);
  final successSilver = 20 + danger * 7 + luck + rng.nextInt(18 + danger * 4);
  final itemRate = (0.16 + danger * 0.026 + luck * 0.0015).clamp(0.2, 0.56);
  final itemId = rng.nextDouble() < itemRate
      ? _rollPatrolItem(danger, rng)
      : null;
  final failureHpLoss = 10 + danger * 3 + rng.nextInt(10 + danger * 2);
  final failureSilverLoss = min(
    currentSilver,
    10 + danger * 2 + rng.nextInt(22),
  );

  if (ambush) {
    final enemyPool = selectBountyEnemyPool(tierIndex + (danger >= 6 ? 1 : 0));
    return PatrolOutcome(
      requiresBattle: true,
      autoSuccess: false,
      enemyId: enemyPool[rng.nextInt(enemyPool.length)],
      successExp: successExp + 10 + danger * 2,
      successSilver: successSilver + 12 + danger * 3,
      successItemId: itemId,
      failureHpLoss: failureHpLoss + 6,
      failureSilverLoss: failureSilverLoss,
    );
  }

  final success =
      rng.nextDouble() <
      patrolSuccessRate(
        dangerLevel: danger,
        speed: speed,
        luck: luck,
        defense: defense,
      );

  return PatrolOutcome(
    requiresBattle: false,
    autoSuccess: success,
    successExp: successExp,
    successSilver: successSilver,
    successItemId: itemId,
    failureHpLoss: failureHpLoss,
    failureSilverLoss: failureSilverLoss,
  );
}

String _rollPatrolItem(int dangerLevel, Random rng) {
  if (dangerLevel >= 7) {
    return rng.nextDouble() < 0.42 ? 'void_crystal' : 'star_iron';
  }
  if (dangerLevel >= 4) {
    return rng.nextDouble() < 0.65 ? 'mystic_ore' : 'fine_iron';
  }
  return 'fine_iron';
}

ChainHuntPlan buildChainHuntPlan({
  required int tierIndex,
  required Random rng,
}) {
  final firstPool = List<String>.from(selectBountyEnemyPool(tierIndex))
    ..shuffle(rng);
  final secondPool = List<String>.from(selectBountyEnemyPool(tierIndex + 1))
    ..shuffle(rng);

  String firstEnemyId = 'bandit';
  for (final enemyId in firstPool) {
    if (enemies.containsKey(enemyId)) {
      firstEnemyId = enemyId;
      break;
    }
  }

  String secondEnemyId = 'iron_golem';
  for (final enemyId in [...secondPool, ...firstPool]) {
    if (enemyId != firstEnemyId && enemies.containsKey(enemyId)) {
      secondEnemyId = enemyId;
      break;
    }
  }

  final firstEnemy = enemies[firstEnemyId]!;
  final secondEnemy = enemies[secondEnemyId]!;
  final stageOneExp = max(8, (firstEnemy.expReward * 0.36).round() + 6);
  final stageOneSilver = max(12, (firstEnemy.silverReward * 0.5).round() + 10);
  final finalExp = max(12, (secondEnemy.expReward * 0.48).round() + 12);
  final finalSilver = max(16, (secondEnemy.silverReward * 0.68).round() + 16);
  final itemRate = tierIndex >= 5 ? 0.56 : 0.42;
  final finalItemId = rng.nextDouble() < itemRate
      ? (secondEnemy.dropItemId ??
            (tierIndex >= 4 ? 'star_iron' : 'mystic_ore'))
      : null;

  return ChainHuntPlan(
    firstEnemyId: firstEnemyId,
    secondEnemyId: secondEnemyId,
    stageOneExp: stageOneExp,
    stageOneSilver: stageOneSilver,
    finalExp: finalExp,
    finalSilver: finalSilver,
    finalItemId: finalItemId,
  );
}

List<BlackMarketOffer> generateBlackMarketOffers({
  required int tierIndex,
  required Random rng,
}) {
  final offers = <BlackMarketOffer>[
    ..._marketTierPool(tierIndex),
    ..._marketTierPool(tierIndex + 1),
  ]..shuffle(rng);
  return offers.take(3).toList();
}

double blackMarketBonusChance({required double baseRate, required int luck}) {
  return (baseRate + luck * 0.003).clamp(baseRate, 0.72);
}

bool rollBlackMarketBonus({
  required BlackMarketOffer offer,
  required int luck,
  required Random rng,
}) {
  if (offer.bonusItemId == null || offer.bonusCount <= 0) return false;
  final chance = blackMarketBonusChance(
    baseRate: offer.bonusBaseRate,
    luck: luck,
  );
  return rng.nextDouble() < chance;
}

List<BlackMarketOffer> _marketTierPool(int tierIndex) {
  if (tierIndex <= 1) {
    return const [
      BlackMarketOffer(
        id: 'starter_medkit',
        title: '急救药箱',
        brief: '常备疗伤药，适合刚入江湖时周转。',
        silverCost: 82,
        rewardItemId: 'healing_pill',
        rewardCount: 3,
        bonusItemId: 'spirit_pill',
        bonusCount: 1,
        bonusBaseRate: 0.32,
      ),
      BlackMarketOffer(
        id: 'starter_iron_pack',
        title: '边角锻料',
        brief: '铁匠铺流出的锻料，胜在量足。',
        silverCost: 108,
        rewardItemId: 'rough_iron',
        rewardCount: 6,
        bonusItemId: 'fine_iron',
        bonusCount: 2,
        bonusBaseRate: 0.22,
      ),
      BlackMarketOffer(
        id: 'starter_stamina_pack',
        title: '行脚补给',
        brief: '跑图常用补给，便宜实用。',
        silverCost: 78,
        rewardItemId: 'stamina_pill',
        rewardCount: 1,
        bonusItemId: 'healing_pill',
        bonusCount: 1,
        bonusBaseRate: 0.36,
      ),
    ];
  }
  if (tierIndex <= 3) {
    return const [
      BlackMarketOffer(
        id: 'mid_forge_box',
        title: '试炼锻材箱',
        brief: '中阶锻造材料，适合冲强化。',
        silverCost: 228,
        rewardItemId: 'fine_iron',
        rewardCount: 5,
        bonusItemId: 'mystic_ore',
        bonusCount: 1,
        bonusBaseRate: 0.3,
      ),
      BlackMarketOffer(
        id: 'mid_recovery_pack',
        title: '镖路补给包',
        brief: '兼顾回血回气和体力，探索更稳。',
        silverCost: 192,
        rewardItemId: 'great_healing_pill',
        rewardCount: 2,
        bonusItemId: 'stamina_pill',
        bonusCount: 1,
        bonusBaseRate: 0.42,
      ),
      BlackMarketOffer(
        id: 'mid_shadow_bag',
        title: '黑市秘袋',
        brief: '袋里多是稀料，运气好还有更高阶收获。',
        silverCost: 214,
        rewardItemId: 'mystic_ore',
        rewardCount: 2,
        bonusItemId: 'star_iron',
        bonusCount: 1,
        bonusBaseRate: 0.12,
      ),
    ];
  }
  return const [
    BlackMarketOffer(
      id: 'late_meteor_box',
      title: '陨铁小箱',
      brief: '高阶锻材打包出售，价格不低。',
      silverCost: 418,
      rewardItemId: 'mystic_ore',
      rewardCount: 4,
      bonusItemId: 'star_iron',
      bonusCount: 1,
      bonusBaseRate: 0.34,
    ),
    BlackMarketOffer(
      id: 'late_void_box',
      title: '幽晶暗匣',
      brief: '偶有幽冥晶流出，错过要再等。',
      silverCost: 462,
      rewardItemId: 'void_crystal',
      rewardCount: 1,
      bonusItemId: 'star_iron',
      bonusCount: 1,
      bonusBaseRate: 0.3,
    ),
    BlackMarketOffer(
      id: 'late_pill_bundle',
      title: '上品丹契',
      brief: '高阶丹药套包，适合连续作战前储备。',
      silverCost: 448,
      rewardItemId: 'nine_turn_pill',
      rewardCount: 2,
      bonusItemId: 'great_healing_pill',
      bonusCount: 2,
      bonusBaseRate: 0.38,
    ),
  ];
}

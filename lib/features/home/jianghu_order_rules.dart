import 'dart:math';

import '../../data/enemy_data.dart';

const int bountyStaminaBase = 8;
const int escortStaminaCost = 12;
const int patrolStaminaCost = 9;

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

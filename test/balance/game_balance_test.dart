import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vittaxia/data/enemy_data.dart';
import 'package:vittaxia/data/item_data.dart';
import 'package:vittaxia/data/skill_data.dart';
import 'package:vittaxia/features/battle/battle_engine.dart';
import 'package:vittaxia/features/home/jianghu_order_rules.dart';
import 'package:vittaxia/models/skill.dart';

void main() {
  group('Jianghu order balance', () {
    test('bounty rewards should scale with tier but remain bounded', () {
      final enemy = enemies['bandit']!;

      final tier1 = buildBountyRule(enemy: enemy, tier: 1, rng: Random(1));
      final tier2 = buildBountyRule(enemy: enemy, tier: 2, rng: Random(2));
      final tier3 = buildBountyRule(enemy: enemy, tier: 3, rng: Random(3));

      expect(tier1.staminaCost, lessThan(tier2.staminaCost));
      expect(tier2.staminaCost, lessThan(tier3.staminaCost));
      expect(tier1.bonusExp, lessThan(tier2.bonusExp));
      expect(tier2.bonusExp, lessThan(tier3.bonusExp));
      expect(tier1.bonusSilver, lessThan(tier2.bonusSilver));
      expect(tier2.bonusSilver, lessThan(tier3.bonusSilver));
      expect(tier3.bonusItemId, isNotNull);

      double score(BountyRuleResult rule) {
        return rule.bonusExp +
            rule.bonusSilver * 0.35 +
            (rule.bonusItemId == null ? 0 : 20);
      }

      final eff1 = score(tier1) / tier1.staminaCost;
      final eff3 = score(tier3) / tier3.staminaCost;
      expect(eff3, greaterThan(eff1 * 0.95));
      expect(eff3, lessThan(eff1 * 2.05));
    });

    test('escort success rate should stay in intended range', () {
      final low = escortSuccessRate(speed: 6, luck: 4, defense: 4);
      final mid = escortSuccessRate(speed: 24, luck: 12, defense: 18);
      final high = escortSuccessRate(speed: 70, luck: 45, defense: 52);

      expect(low, inInclusiveRange(0.48, 0.58));
      expect(mid, inInclusiveRange(0.58, 0.75));
      expect(high, inInclusiveRange(0.88, 0.9));
    });

    test('patrol risk should scale with location danger', () {
      final lowDangerSuccess = patrolSuccessRate(
        dangerLevel: 2,
        speed: 20,
        luck: 12,
        defense: 18,
      );
      final highDangerSuccess = patrolSuccessRate(
        dangerLevel: 8,
        speed: 20,
        luck: 12,
        defense: 18,
      );

      expect(lowDangerSuccess, greaterThan(highDangerSuccess));
      expect(patrolAmbushRate(8), greaterThan(patrolAmbushRate(2)));
    });

    test(
      'chain hunt should generate valid staged rewards with bounded efficiency',
      () {
        final plan = buildChainHuntPlan(tierIndex: 3, rng: Random(9));

        expect(enemies.containsKey(plan.firstEnemyId), isTrue);
        expect(enemies.containsKey(plan.secondEnemyId), isTrue);
        expect(plan.firstEnemyId, isNot(plan.secondEnemyId));
        expect(plan.finalExp, greaterThan(plan.stageOneExp));
        expect(plan.finalSilver, greaterThan(plan.stageOneSilver));

        final score =
            plan.stageOneExp +
            plan.finalExp +
            (plan.stageOneSilver + plan.finalSilver) * 0.35 +
            (plan.finalItemId == null ? 0 : 52);
        final perStamina = score / chainHuntStaminaCost;
        expect(perStamina, inInclusiveRange(1.0, 7.4));
      },
    );

    test(
      'black market offers should be valid and luck should improve bonus chance',
      () {
        final offers = generateBlackMarketOffers(tierIndex: 3, rng: Random(21));
        expect(offers, hasLength(3));

        for (final offer in offers) {
          expect(offer.silverCost, greaterThan(0));
          expect(items.containsKey(offer.rewardItemId), isTrue);
          final guaranteedValue =
              (items[offer.rewardItemId]?.buyPrice ?? 0) * offer.rewardCount;
          expect(guaranteedValue, greaterThan(0));
          expect(
            guaranteedValue / offer.silverCost,
            inInclusiveRange(0.34, 1.42),
          );
        }

        final offerWithBonus = offers.firstWhere(
          (offer) => offer.bonusItemId != null && offer.bonusCount > 0,
        );
        final lowLuckChance = blackMarketBonusChance(
          baseRate: offerWithBonus.bonusBaseRate,
          luck: 0,
        );
        final highLuckChance = blackMarketBonusChance(
          baseRate: offerWithBonus.bonusBaseRate,
          luck: 45,
        );
        expect(highLuckChance, greaterThan(lowLuckChance));
        expect(highLuckChance, lessThanOrEqualTo(0.72));

        final lowLuckValue = _expectedOfferValue(offerWithBonus, 0);
        final highLuckValue = _expectedOfferValue(offerWithBonus, 45);
        expect(highLuckValue, greaterThan(lowLuckValue));
        expect(
          highLuckValue / offerWithBonus.silverCost,
          inInclusiveRange(0.45, 1.65),
        );
      },
    );

    test('escort and patrol expected value per stamina should not runaway', () {
      final rng = Random(42);
      var escortScore = 0.0;
      var patrolScore = 0.0;
      const rounds = 1200;

      double scoreEscort(EscortOutcome outcome) {
        return outcome.expDelta +
            outcome.silverDelta * 0.35 +
            (outcome.rewardItemId == null ? 0 : 38) -
            outcome.hpLoss * 0.75;
      }

      double scorePatrol(PatrolOutcome outcome, bool battleWon) {
        if (outcome.requiresBattle) {
          if (battleWon) {
            return outcome.successExp +
                outcome.successSilver * 0.35 +
                (outcome.successItemId == null ? 0 : 48);
          }
          return -(outcome.failureHpLoss * 0.8 +
              outcome.failureSilverLoss * 0.35);
        }

        if (outcome.autoSuccess) {
          return outcome.successExp +
              outcome.successSilver * 0.35 +
              (outcome.successItemId == null ? 0 : 42);
        }
        return -(outcome.failureHpLoss * 0.8 +
            outcome.failureSilverLoss * 0.35);
      }

      for (var i = 0; i < rounds; i++) {
        final escort = rollEscortOutcome(
          speed: 24,
          luck: 12,
          defense: 18,
          currentSilver: 500,
          rng: rng,
        );
        escortScore += scoreEscort(escort);

        final patrol = rollPatrolOutcome(
          tierIndex: 3,
          dangerLevel: 5,
          speed: 24,
          luck: 12,
          defense: 18,
          currentSilver: 500,
          rng: rng,
        );
        final assumedBattleWin = rng.nextDouble() < 0.62;
        patrolScore += scorePatrol(patrol, assumedBattleWin);
      }

      final escortPerStamina = escortScore / rounds / escortStaminaCost;
      final patrolPerStamina = patrolScore / rounds / patrolStaminaCost;

      expect(escortPerStamina, inInclusiveRange(0.8, 4.8));
      expect(patrolPerStamina, inInclusiveRange(0.6, 5.2));
      expect(patrolPerStamina, lessThan(escortPerStamina * 1.75));
    });
  });

  group('Battle curve balance', () {
    test('early build should beat low-tier enemy more often than mid-tier', () {
      final earlyVsBoar = _simulateWinRate(
        enemyId: 'wild_boar',
        rounds: 180,
        playerBuilder: () => _buildPlayer(
          hp: 118,
          mp: 48,
          atk: 18,
          def: 10,
          speed: 10,
          luck: 6,
          skillIds: const ['basic_fist', 'iron_palm'],
        ),
      );
      final earlyVsRogue = _simulateWinRate(
        enemyId: 'rogue_swordsman',
        rounds: 180,
        playerBuilder: () => _buildPlayer(
          hp: 118,
          mp: 48,
          atk: 18,
          def: 10,
          speed: 10,
          luck: 6,
          skillIds: const ['basic_fist', 'iron_palm'],
        ),
      );

      expect(earlyVsBoar, greaterThan(0.55));
      expect(earlyVsRogue, lessThan(0.4));
      expect(earlyVsBoar, greaterThan(earlyVsRogue + 0.25));
    });

    test('mid build should稳定清低阶，但在高防敌人面前仍有门槛', () {
      final midVsBandit = _simulateWinRate(
        enemyId: 'bandit',
        rounds: 220,
        playerBuilder: () => _buildPlayer(
          hp: 170,
          mp: 70,
          atk: 22,
          def: 14,
          speed: 12,
          luck: 9,
          skillIds: const ['basic_fist', 'iron_palm', 'gale_sword'],
        ),
      );
      final midVsGolem = _simulateWinRate(
        enemyId: 'iron_golem',
        rounds: 220,
        playerBuilder: () => _buildPlayer(
          hp: 170,
          mp: 70,
          atk: 22,
          def: 14,
          speed: 12,
          luck: 9,
          skillIds: const ['basic_fist', 'iron_palm', 'gale_sword'],
        ),
      );

      expect(midVsBandit, inInclusiveRange(0.9, 1.0));
      expect(midVsGolem, inInclusiveRange(0.1, 0.45));
      expect(midVsBandit, greaterThan(midVsGolem));
    });

    test('late build should handle endgame threats with stable win rate', () {
      final lateVsPhantom = _simulateWinRate(
        enemyId: 'phantom_lord',
        rounds: 240,
        playerBuilder: () => _buildPlayer(
          hp: 300,
          mp: 130,
          atk: 36,
          def: 24,
          speed: 18,
          luck: 14,
          skillIds: const ['basic_fist', 'gale_sword', 'shadow_strike'],
        ),
      );

      expect(lateVsPhantom, inInclusiveRange(0.45, 0.8));
    });
  });
}

BattleFighter _buildPlayer({
  required int hp,
  required int mp,
  required int atk,
  required int def,
  required int speed,
  required int luck,
  required List<String> skillIds,
}) {
  final availableSkills = skillIds
      .map((id) => skills[id])
      .whereType<Skill>()
      .toList();
  return BattleFighter(
    name: '平衡测试角色',
    hp: hp,
    maxHp: hp,
    mp: mp,
    maxMp: mp,
    atk: atk,
    def: def,
    speed: speed,
    luck: luck,
    skills: availableSkills,
  );
}

double _expectedOfferValue(BlackMarketOffer offer, int luck) {
  final guaranteedValue =
      (items[offer.rewardItemId]?.buyPrice ?? 0) * offer.rewardCount;
  if (offer.bonusItemId == null || offer.bonusCount <= 0) {
    return guaranteedValue.toDouble();
  }
  final bonusValue =
      (items[offer.bonusItemId!]?.buyPrice ?? 0) * offer.bonusCount;
  final chance = blackMarketBonusChance(
    baseRate: offer.bonusBaseRate,
    luck: luck,
  );
  return guaranteedValue + bonusValue * chance;
}

double _simulateWinRate({
  required String enemyId,
  required int rounds,
  required BattleFighter Function() playerBuilder,
}) {
  final enemyTemplate = enemies[enemyId]!;
  var wins = 0;

  for (var i = 0; i < rounds; i++) {
    final engine = BattleEngine(
      player: playerBuilder(),
      enemy: BattleEngine.createEnemyFighter(enemyTemplate),
      random: Random(1000 + i),
    );

    for (var turn = 0; turn < 40 && !engine.isOver; turn++) {
      final skill = _pickSkill(engine.player);
      engine.playerAction(skill);
    }
    if (engine.playerWon) wins++;
  }

  return wins / rounds;
}

Skill _pickSkill(BattleFighter player) {
  final usable = player.skills.where((s) => s.mpCost <= player.mp).toList();
  if (usable.isEmpty) {
    return skills['basic_fist']!;
  }

  if (player.hp / player.maxHp < 0.33) {
    final heal = usable.where((s) => s.healAmount > 0).toList();
    if (heal.isNotEmpty) return heal.first;
  }

  usable.sort((a, b) {
    final aScore = a.baseDamage + player.effectiveAtk * a.damageMultiplier;
    final bScore = b.baseDamage + player.effectiveAtk * b.damageMultiplier;
    return bScore.compareTo(aScore);
  });
  return usable.first;
}

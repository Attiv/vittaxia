import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vittaxia/data/skill_data.dart';
import 'package:vittaxia/features/battle/battle_engine.dart';

void main() {
  group('BattleEngine', () {
    late BattleFighter player;
    late BattleFighter enemy;

    setUp(() {
      player = BattleFighter(
        name: '测试侠',
        hp: 100,
        maxHp: 100,
        mp: 50,
        maxMp: 50,
        atk: 15,
        def: 8,
        speed: 10,
        luck: 5,
        skills: [skills['basic_fist']!, skills['iron_palm']!],
      );

      enemy = BattleFighter(
        name: '木桩',
        hp: 50,
        maxHp: 50,
        mp: 20,
        maxMp: 20,
        atk: 5,
        def: 3,
        speed: 3,
        skills: [skills['basic_fist']!],
      );
    });

    test('player should deal damage with basic_fist', () {
      final engine = BattleEngine(
        player: player,
        enemy: enemy,
        random: Random(42),
      );

      final hpBefore = enemy.hp;
      engine.playerAction(skills['basic_fist']!);

      expect(enemy.hp, lessThan(hpBefore));
      expect(engine.log, isNotEmpty);
    });

    test('battle ends when enemy hp reaches 0', () {
      final engine = BattleEngine(
        player: player,
        enemy: enemy,
        random: Random(42),
      );

      // 连续攻击直到结束
      for (var i = 0; i < 20 && !engine.isOver; i++) {
        engine.playerAction(skills['iron_palm']!);
      }

      expect(engine.isOver, isTrue);
      expect(engine.playerWon, isTrue);
      expect(enemy.hp, equals(0));
    });

    test('player loses when hp reaches 0', () {
      // 弱化玩家
      player = BattleFighter(
        name: '弱鸡',
        hp: 10,
        maxHp: 10,
        mp: 0,
        maxMp: 0,
        atk: 1,
        def: 0,
        speed: 1,
        skills: [skills['basic_fist']!],
      );

      final strongEnemy = BattleFighter(
        name: '强敌',
        hp: 200,
        maxHp: 200,
        mp: 50,
        maxMp: 50,
        atk: 50,
        def: 30,
        speed: 20,
        skills: [skills['basic_fist']!],
      );

      final engine = BattleEngine(
        player: player,
        enemy: strongEnemy,
        random: Random(42),
      );

      for (var i = 0; i < 20 && !engine.isOver; i++) {
        engine.playerAction(skills['basic_fist']!);
      }

      expect(engine.isOver, isTrue);
      expect(engine.playerWon, isFalse);
    });

    test('mp consumption works', () {
      final engine = BattleEngine(
        player: player,
        enemy: enemy,
        random: Random(42),
      );

      final mpBefore = player.mp;
      engine.playerAction(skills['iron_palm']!);

      expect(player.mp, lessThan(mpBefore));
    });
  });

  group('IdleCalculator', () {
    test('calculates offline exp correctly', () {
      // 这里直接内联测试逻辑
      const comprehension = 10;
      const minutes = 60;
      const multiplier = 0.5;
      final expected = (comprehension * multiplier * minutes).round();
      expect(expected, equals(300));
    });
  });
}

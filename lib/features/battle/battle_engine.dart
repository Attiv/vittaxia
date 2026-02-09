import 'dart:math';

import '../../core/constants/game_constants.dart';
import '../../data/enemy_data.dart';
import '../../data/skill_data.dart';
import '../../models/skill.dart';

/// 战斗中的角色状态
class BattleFighter {
  final String name;
  int hp;
  int maxHp;
  int mp;
  int maxMp;
  int atk;
  int def;
  int speed;
  int luck;
  final List<Skill> skills;
  final Map<String, int> buffs; // buffName -> 剩余回合

  BattleFighter({
    required this.name,
    required this.hp,
    required this.maxHp,
    required this.mp,
    required this.maxMp,
    required this.atk,
    required this.def,
    required this.speed,
    this.luck = 5,
    required this.skills,
  }) : buffs = {};

  bool get isDead => hp <= 0;

  int get effectiveAtk {
    int bonus = 0;
    if (buffs.containsKey('atk')) bonus += 8;
    return atk + bonus;
  }

  int get effectiveDef {
    int bonus = 0;
    if (buffs.containsKey('def')) bonus += 10;
    return def + bonus;
  }

  int get effectiveSpeed {
    int bonus = 0;
    if (buffs.containsKey('speed')) bonus += 8;
    return speed + bonus;
  }
}

/// 战斗日志条目
class BattleLogEntry {
  final String message;
  final bool isPlayerAction;

  BattleLogEntry(this.message, {this.isPlayerAction = true});
}

/// 回合制战斗引擎
class BattleEngine {
  final BattleFighter player;
  final BattleFighter enemy;
  final List<BattleLogEntry> log = [];
  final Random _random;
  bool isOver = false;
  bool playerWon = false;

  BattleEngine({
    required this.player,
    required this.enemy,
    Random? random,
  }) : _random = random ?? Random();

  /// 从角色数据创建玩家 BattleFighter
  static BattleFighter createPlayerFighter({
    required String name,
    required int hp,
    required int maxHp,
    required int mp,
    required int maxMp,
    required int atk,
    required int def,
    required int speed,
    required int luck,
    required List<String> equippedSkillIds,
  }) {
    final playerSkills = <Skill>[];
    for (final id in equippedSkillIds) {
      final s = skills[id];
      if (s != null) playerSkills.add(s);
    }
    // 至少有普通攻击
    if (playerSkills.isEmpty) {
      playerSkills.add(skills['basic_fist']!);
    }
    return BattleFighter(
      name: name,
      hp: hp,
      maxHp: maxHp,
      mp: mp,
      maxMp: maxMp,
      atk: atk,
      def: def,
      speed: speed,
      luck: luck,
      skills: playerSkills,
    );
  }

  /// 从敌人模板创建
  static BattleFighter createEnemyFighter(EnemyTemplate template) {
    final enemySkills = <Skill>[];
    for (final id in template.skillIds) {
      final s = skills[id];
      if (s != null) enemySkills.add(s);
    }
    if (enemySkills.isEmpty) {
      enemySkills.add(skills['basic_fist']!);
    }
    return BattleFighter(
      name: template.name,
      hp: template.hp,
      maxHp: template.hp,
      mp: template.mp,
      maxMp: template.mp,
      atk: template.atk,
      def: template.def,
      speed: template.speed,
      skills: enemySkills,
    );
  }

  /// 玩家执行一个技能
  void playerAction(Skill skill) {
    if (isOver) return;

    // 先手判定
    if (player.effectiveSpeed >= enemy.effectiveSpeed) {
      _executeSkill(player, enemy, skill, isPlayer: true);
      if (!isOver) _enemyTurn();
    } else {
      _enemyTurn();
      if (!isOver) _executeSkill(player, enemy, skill, isPlayer: true);
    }

    _tickBuffs(player);
    _tickBuffs(enemy);
    _checkBattleEnd();
  }

  void _enemyTurn() {
    if (isOver || enemy.isDead) return;

    // AI: 血量低于 30% 且有回复技能 → 回复；内力不足 → 普攻；否则随机
    Skill chosen;
    final healSkills = enemy.skills.where(
        (s) => s.healAmount > 0 && s.mpCost <= enemy.mp);
    if (enemy.hp < enemy.maxHp * 0.3 && healSkills.isNotEmpty) {
      chosen = healSkills.first;
    } else {
      final usable = enemy.skills.where((s) => s.mpCost <= enemy.mp).toList();
      if (usable.isEmpty) {
        chosen = skills['basic_fist']!;
      } else {
        chosen = usable[_random.nextInt(usable.length)];
      }
    }
    _executeSkill(enemy, player, chosen, isPlayer: false);
  }

  void _executeSkill(
    BattleFighter attacker,
    BattleFighter defender,
    Skill skill, {
    required bool isPlayer,
  }) {
    if (attacker.isDead) return;

    // 消耗内力
    attacker.mp = (attacker.mp - skill.mpCost).clamp(0, attacker.maxMp);

    // 回复技能
    if (skill.healAmount > 0) {
      final heal = skill.healAmount;
      attacker.hp = (attacker.hp + heal).clamp(0, attacker.maxHp);
      log.add(BattleLogEntry(
        '${attacker.name}使用【${skill.name}】，恢复了$heal点气血',
        isPlayerAction: isPlayer,
      ));
    }

    // 攻击伤害
    if (skill.baseDamage > 0) {
      final isCrit = _rollCrit(attacker, defender);
      var damage = (skill.baseDamage +
              attacker.effectiveAtk * skill.damageMultiplier -
              defender.effectiveDef * GameConstants.defenseMultiplier)
          .round();
      damage = damage.clamp(1, 9999);

      if (isCrit) {
        damage = (damage * GameConstants.critDamageMultiplier).round();
        log.add(BattleLogEntry(
          '${attacker.name}使用【${skill.name}】！暴击！造成$damage点伤害',
          isPlayerAction: isPlayer,
        ));
      } else {
        log.add(BattleLogEntry(
          '${attacker.name}使用【${skill.name}】，造成$damage点伤害',
          isPlayerAction: isPlayer,
        ));
      }
      defender.hp = (defender.hp - damage).clamp(0, defender.maxHp);
    }

    // buff 效果
    if (skill.buffAtk > 0) {
      attacker.buffs['atk'] = skill.buffDuration;
    }
    if (skill.buffDef > 0) {
      attacker.buffs['def'] = skill.buffDuration;
    }
    if (skill.buffSpeed > 0) {
      attacker.buffs['speed'] = skill.buffDuration;
    }

    _checkBattleEnd();
  }

  bool _rollCrit(BattleFighter attacker, BattleFighter defender) {
    final speedDiff = attacker.effectiveSpeed - defender.effectiveSpeed;
    final critRate = GameConstants.baseCritRate + speedDiff * 0.005 + attacker.luck * 0.003;
    return _random.nextDouble() < critRate.clamp(0.01, 0.5);
  }

  void _tickBuffs(BattleFighter fighter) {
    fighter.buffs.updateAll((key, value) => value - 1);
    fighter.buffs.removeWhere((key, value) => value <= 0);
  }

  void _checkBattleEnd() {
    if (enemy.isDead && !isOver) {
      isOver = true;
      playerWon = true;
      log.add(BattleLogEntry('${enemy.name}被击败了！', isPlayerAction: true));
    } else if (player.isDead && !isOver) {
      isOver = true;
      playerWon = false;
      log.add(BattleLogEntry('你被${enemy.name}击败了…', isPlayerAction: false));
    }
  }
}

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
  final Map<String, int> skillLevels; // skillId -> 等级
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
    Map<String, int>? skillLevels,
  })  : skillLevels = skillLevels ?? {},
        buffs = {};

  int getSkillLevel(String skillId) => skillLevels[skillId] ?? 1;

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
    Map<String, int> skillLevels = const {},
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
      skillLevels: Map.of(skillLevels),
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
    if (skill.mpCost > 0) {
      log.add(BattleLogEntry(
        '${attacker.name}运起内力，消耗${skill.mpCost}点真气。',
        isPlayerAction: isPlayer,
      ));
    }

    final skillLevel = attacker.getSkillLevel(skill.id);
    final levelMult = GameConstants.skillLevelMultiplier(skillLevel);

    // 回复技能
    if (skill.healAmount > 0) {
      final heal = (skill.healAmount * levelMult).round();
      final before = attacker.hp;
      attacker.hp = (attacker.hp + heal).clamp(0, attacker.maxHp);
      final actual = attacker.hp - before;
      log.add(BattleLogEntry(
        '${attacker.name}施展【${skill.name}】调息运气，恢复了$actual点气血。'
        '（${attacker.hp}/${attacker.maxHp}）',
        isPlayerAction: isPlayer,
      ));
    }

    // 攻击伤害
    if (skill.baseDamage > 0) {
      // 闪避判定：基于速度差
      final dodgeRate = (defender.effectiveSpeed - attacker.effectiveSpeed) * 0.008
          + defender.luck * 0.002;
      if (_random.nextDouble() < dodgeRate.clamp(0.0, 0.25)) {
        log.add(BattleLogEntry(
          '${attacker.name}使用【${skill.name}】攻向${defender.name}——'
          '${defender.name}身形一闪，巧妙躲开了！',
          isPlayerAction: isPlayer,
        ));
      } else {
        final isCrit = _rollCrit(attacker, defender);
        var damage = ((skill.baseDamage +
                    attacker.effectiveAtk * skill.damageMultiplier) *
                levelMult -
                defender.effectiveDef * GameConstants.defenseMultiplier)
            .round();
        damage = damage.clamp(1, 9999);

        final defReduction = (defender.effectiveDef * GameConstants.defenseMultiplier).round();

        if (isCrit) {
          damage = (damage * GameConstants.critDamageMultiplier).round();
          log.add(BattleLogEntry(
            '${attacker.name}使用【${skill.name}】攻向${defender.name}——'
            '击中要害！暴击！造成$damage点伤害！',
            isPlayerAction: isPlayer,
          ));
        } else if (defReduction > skill.baseDamage ~/ 2) {
          log.add(BattleLogEntry(
            '${attacker.name}使用【${skill.name}】攻向${defender.name}，'
            '${defender.name}硬扛了一击，防御抵消了$defReduction点，'
            '受到$damage点伤害。',
            isPlayerAction: isPlayer,
          ));
        } else {
          log.add(BattleLogEntry(
            '${attacker.name}使用【${skill.name}】攻向${defender.name}，'
            '造成$damage点伤害。',
            isPlayerAction: isPlayer,
          ));
        }
        defender.hp = (defender.hp - damage).clamp(0, defender.maxHp);

        // HP 状态播报
        if (!defender.isDead) {
          final hpRatio = defender.hp / defender.maxHp;
          if (hpRatio < 0.15) {
            log.add(BattleLogEntry(
              '${defender.name}摇摇欲坠，已经快撑不住了！'
              '（${defender.hp}/${defender.maxHp}）',
              isPlayerAction: isPlayer,
            ));
          } else if (hpRatio < 0.3) {
            log.add(BattleLogEntry(
              '${defender.name}气息紊乱，伤势不轻。'
              '（${defender.hp}/${defender.maxHp}）',
              isPlayerAction: isPlayer,
            ));
          }
        }
      }
    }

    // buff 效果
    final buffParts = <String>[];
    if (skill.buffAtk > 0) {
      attacker.buffs['atk'] = skill.buffDuration;
      buffParts.add('攻击力提升');
    }
    if (skill.buffDef > 0) {
      attacker.buffs['def'] = skill.buffDuration;
      buffParts.add('防御力提升');
    }
    if (skill.buffSpeed > 0) {
      attacker.buffs['speed'] = skill.buffDuration;
      buffParts.add('身法提升');
    }
    if (buffParts.isNotEmpty) {
      log.add(BattleLogEntry(
        '${attacker.name}${buffParts.join("、")}，持续${skill.buffDuration}回合！',
        isPlayerAction: isPlayer,
      ));
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

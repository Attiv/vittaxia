import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/enemy_data.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/skill.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../skill/skill_provider.dart';
import 'battle_engine.dart';
import '../quest/quest_provider.dart';

class BattlePage extends ConsumerStatefulWidget {
  final String enemyId;

  const BattlePage({super.key, required this.enemyId});

  @override
  ConsumerState<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends ConsumerState<BattlePage> {
  BattleEngine? _engine;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initBattle();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initBattle() {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    final template = enemies[widget.enemyId];
    if (character == null || template == null) return;

    final equipped = ref.read(equippedSkillsProvider);
    final equippedSkillIds = equipped.map((ls) => ls.skillId).toList();
    final skillLevels = {for (final ls in equipped) ls.skillId: ls.level};

    // 加载已学的被动技能
    final allLearned = ref.read(learnedSkillsProvider).valueOrNull ?? [];
    final passiveEntries = allLearned.where((ls) {
      final s = skills[ls.skillId];
      return s != null && s.type == SkillType.passive;
    }).toList();
    final passiveSkillIds = passiveEntries.map((ls) => ls.skillId).toList();
    final passiveSkillLevels = {
      for (final ls in passiveEntries) ls.skillId: ls.level,
    };

    final player = BattleEngine.createPlayerFighter(
      name: character.name,
      hp: character.currentHp,
      maxHp: totalMaxHp(character),
      mp: character.currentMp,
      maxMp: totalMaxMp(character),
      atk: totalAtk(character),
      def: totalDef(character),
      speed: totalSpeed(character),
      luck: character.baseLuck,
      equippedSkillIds: equippedSkillIds,
      skillLevels: skillLevels,
      passiveSkillIds: passiveSkillIds,
      passiveSkillLevels: passiveSkillLevels,
    );
    final enemy = BattleEngine.createEnemyFighter(template);

    setState(() {
      _engine = BattleEngine(player: player, enemy: enemy);
    });
  }

  void _useSkill(Skill skill) {
    final engine = _engine;
    if (engine == null || engine.isOver) return;

    setState(() {
      engine.playerAction(skill);
    });

    // 滚到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    if (engine.isOver) {
      _resolveBattle();
    }
  }

  Future<void> _resolveBattle() async {
    final engine = _engine;
    if (engine == null) return;

    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    // 同步战后 HP/MP
    charNotifier.updateStats(
      characterId: character.id,
      currentHp: engine.player.hp.clamp(1, totalMaxHp(character)),
      currentMp: engine.player.mp.clamp(0, totalMaxMp(character)),
    );

    if (engine.playerWon) {
      final template = enemies[widget.enemyId]!;
      charNotifier.updateStats(
        characterId: character.id,
        silver: character.silver + template.silverReward,
      );
      final newRealm = await charNotifier.addExp(character.id, template.expReward);
      logNotifier.addLog(
        '击败了${template.name}！获得${template.expReward}经验、${template.silverReward}银两',
        type: LogType.combat,
      );
      if (newRealm != null) {
        logNotifier.addLog('突破！境界提升至$newRealm', type: LogType.system);
      }

      // 掉落判定
      if (template.dropItemId != null) {
        if (Random().nextDouble() < template.dropRate) {
          ref.read(inventoryNotifierProvider.notifier)
              .addItem(character.id, template.dropItemId!);
          final itemName = template.dropItemId!;
          logNotifier.addLog('获得了物品: $itemName', type: LogType.item);
        }
      }

      // 增加技能熟练度
      final equipped = ref.read(equippedSkillsProvider);
      final skillNotifier = ref.read(skillNotifierProvider.notifier);
      for (final ls in equipped) {
        skillNotifier.upgradeProficiency(ls.id, 5);
      }

      // 更新击杀类任务目标
      ref.read(questNotifierProvider.notifier).checkAndUpdateObjectives(
            character.id,
            QuestObjectiveType.kill,
            widget.enemyId,
          );
    } else {
      logNotifier.addLog('战斗失败，你勉强逃了出来。', type: LogType.combat);
      // 保底1血
      charNotifier.updateStats(
        characterId: character.id,
        currentHp: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = _engine;

    if (engine == null) {
      return const Scaffold(
        body: Center(child: Text('战斗初始化中…')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('战斗 - ${engine.enemy.name}'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // 双方状态条
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: _fighterStatus(engine.player, true)),
                const SizedBox(width: 12),
                const Text('VS',
                    style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Expanded(child: _fighterStatus(engine.enemy, false)),
              ],
            ),
          ),
          // 战斗日志
          Expanded(
            child: Container(
              color: AppColors.background,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: engine.log.length,
                itemBuilder: (_, i) {
                  final entry = engine.log[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      entry.message,
                      style: TextStyle(
                        color: entry.isPlayerAction
                            ? AppColors.exp
                            : AppColors.hp,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // 技能按钮区
          if (!engine.isOver)
            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.surface,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: engine.player.skills.map((skill) {
                  final canUse = skill.mpCost <= engine.player.mp;
                  return ElevatedButton(
                    onPressed: canUse ? () => _useSkill(skill) : null,
                    child: Text(
                      '${skill.name}${skill.mpCost > 0 ? " (${skill.mpCost})" : ""}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
              ),
            ),
          // 战斗结束
          if (engine.isOver)
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surface,
              child: Column(
                children: [
                  Text(
                    engine.playerWon ? '战斗胜利！' : '战斗失败…',
                    style: TextStyle(
                      color: engine.playerWon
                          ? AppColors.success
                          : AppColors.danger,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(engine.playerWon),
                    child: const Text('返回'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _fighterStatus(BattleFighter fighter, bool isPlayer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fighter.name,
              style: TextStyle(
                color: isPlayer ? AppColors.accent : AppColors.hp,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            _miniBar('HP', fighter.hp, fighter.maxHp, AppColors.hp),
            const SizedBox(height: 4),
            _miniBar('MP', fighter.mp, fighter.maxMp, AppColors.mp),
          ],
        ),
      ),
    );
  }

  Widget _miniBar(String label, int current, int max, Color color) {
    final ratio = max > 0 ? current / max : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: color, fontSize: 10)),
            Text('$current/$max',
                style: TextStyle(color: color, fontSize: 10)),
          ],
        ),
        const SizedBox(height: 2),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            backgroundColor: AppColors.progressTrack,
            color: color,
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}

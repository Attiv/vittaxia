import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/enemy_data.dart';
import '../../data/item_data.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/skill.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../skill/skill_provider.dart';
import 'battle_animation.dart';
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
  final _arenaController = BattleArenaController();
  bool _isAnimating = false;
  String? _battleInitSnapshot;
  ProviderSubscription<AsyncValue<dynamic>>? _characterSub;
  ProviderSubscription<AsyncValue<dynamic>>? _learnedSkillsSub;

  @override
  void initState() {
    super.initState();
    _characterSub = ref.listenManual(currentCharacterProvider, (_, __) {
      _tryInitBattle();
    });
    _learnedSkillsSub = ref.listenManual(learnedSkillsProvider, (_, __) {
      _tryInitBattle();
    });
    _tryInitBattle(force: true);
  }

  @override
  void dispose() {
    _characterSub?.close();
    _learnedSkillsSub?.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _tryInitBattle({bool force = false}) {
    if (!force && _engine != null) return;

    final character = ref.read(currentCharacterProvider).valueOrNull;
    final template = enemies[widget.enemyId];
    final allLearned = ref.read(learnedSkillsProvider).valueOrNull;
    if (character == null || template == null || allLearned == null) return;

    final equipped = allLearned.where((ls) => ls.isEquipped).toList()
      ..sort((a, b) => a.skillId.compareTo(b.skillId));
    final equippedSkillIds = equipped.map((ls) => ls.skillId).toList();
    final skillLevels = {for (final ls in equipped) ls.skillId: ls.level};

    // 加载已学的被动技能
    final passiveEntries = allLearned.where((ls) {
      final s = skills[ls.skillId];
      return s != null && s.type == SkillType.passive;
    }).toList()..sort((a, b) => a.skillId.compareTo(b.skillId));
    final passiveSkillIds = passiveEntries.map((ls) => ls.skillId).toList();
    final passiveSkillLevels = {
      for (final ls in passiveEntries) ls.skillId: ls.level,
    };

    final snapshot = [
      character.id,
      character.currentHp,
      character.currentMp,
      widget.enemyId,
      for (final ls in equipped) '${ls.skillId}:${ls.level}',
      '|',
      for (final ls in passiveEntries) '${ls.skillId}:${ls.level}',
    ].join(';');
    if (!force && snapshot == _battleInitSnapshot) return;

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

    if (!mounted) return;
    setState(() {
      _battleInitSnapshot = snapshot;
      _engine = BattleEngine(player: player, enemy: enemy);
    });
  }

  Future<void> _useSkill(Skill skill) async {
    final engine = _engine;
    if (engine == null || engine.isOver || _isAnimating) return;
    HapticFeedback.mediumImpact();

    final playerActionType = _resolvePlayerActionType(skill);

    // 先计算结果
    engine.playerAction(skill);

    // 标记动画中（禁用按钮）
    setState(() => _isAnimating = true);

    // 按先后手顺序播放动画
    await _playRoundAnimations(engine, playerActionType, skill.id);

    // 动画结束，更新 UI
    setState(() => _isAnimating = false);

    _scrollToBottom();

    if (engine.isOver) {
      _resolveBattle();
    }
  }

  BattleActionType _resolvePlayerActionType(Skill skill) {
    final baseType = skillToActionType(skill.id);
    if (baseType != BattleActionType.fist) return baseType;

    return _resolveEquippedWeaponType() ?? baseType;
  }

  BattleActionType? _resolveEquippedWeaponType() {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    final weaponId = character?.weaponId;
    if (weaponId == null || weaponId.isEmpty) return null;

    final weapon = items[weaponId];
    if (weapon == null || weapon.type != ItemType.weapon) return null;

    final weaponHint = '${weapon.name} ${weapon.id}'.toLowerCase();
    if (weaponHint.contains('blade') ||
        weaponHint.contains('saber') ||
        weaponHint.contains('刀')) {
      return BattleActionType.blade;
    }
    // 没有明确标注刀型时，统一按剑型展示，保证持武器时有明显武器动作/待机展示。
    return BattleActionType.sword;
  }

  Future<void> _playRoundAnimations(
    BattleEngine engine,
    BattleActionType playerType,
    String playerSkillId,
  ) async {
    final ctrl = _arenaController;

    Future<void> playerAnim() => ctrl.playAction(
      isPlayer: true,
      type: playerType,
      skillId: playerSkillId,
      crit: engine.lastPlayerAttackCrit,
      dodged: engine.lastPlayerAttackDodged,
      damage: engine.lastPlayerDamage,
      healAmount: engine.lastPlayerHeal,
      defenderDefeated: engine.lastPlayerKilled,
    );

    Future<void> enemyAnim() {
      if (!engine.lastEnemyActed || engine.lastEnemySkillId == null) {
        return Future.value();
      }
      return ctrl.playAction(
        isPlayer: false,
        type: skillToActionType(engine.lastEnemySkillId!),
        skillId: engine.lastEnemySkillId,
        crit: engine.lastEnemyAttackCrit,
        dodged: engine.lastEnemyAttackDodged,
        damage: engine.lastEnemyDamage,
        healAmount: engine.lastEnemyHeal,
        defenderDefeated: engine.lastEnemyKilled,
      );
    }

    if (engine.lastPlayerFirst) {
      await playerAnim();
      await enemyAnim();
    } else {
      await enemyAnim();
      await playerAnim();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
      final newRealm = await charNotifier.addExp(
        character.id,
        template.expReward,
      );
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
          ref
              .read(inventoryNotifierProvider.notifier)
              .addItem(character.id, template.dropItemId!);
          final itemName =
              items[template.dropItemId]?.name ?? template.dropItemId!;
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
      ref
          .read(questNotifierProvider.notifier)
          .checkAndUpdateObjectives(
            character.id,
            QuestObjectiveType.kill,
            widget.enemyId,
          );
    } else {
      logNotifier.addLog('战斗失败，你勉强逃了出来。', type: LogType.combat);
      // 保底1血
      charNotifier.updateStats(characterId: character.id, currentHp: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = _engine;

    if (engine == null) {
      return const Scaffold(body: Center(child: Text('战斗初始化中…')));
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
                const Text(
                  'VS',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: _fighterStatus(engine.enemy, false)),
              ],
            ),
          ),
          // 战斗动画区
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.5),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF201C18), Color(0xFF151312)],
              ),
            ),
            child: BattleArenaWidget(
              controller: _arenaController,
              idlePlayerWeaponType: _resolveEquippedWeaponType(),
              height: 220,
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
                  final canUse =
                      skill.mpCost <= engine.player.mp && !_isAnimating;
                  return Tooltip(
                    message:
                        '${skill.description}\n消耗内力: ${skill.mpCost}  当前: ${engine.player.mp}',
                    child: ElevatedButton(
                      onPressed: canUse ? () => _useSkill(skill) : null,
                      child: Text(
                        '${skill.name}${skill.mpCost > 0 ? " (${skill.mpCost})" : ""}',
                        style: const TextStyle(fontSize: 13),
                      ),
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
                    onPressed: () =>
                        Navigator.of(context).pop(engine.playerWon),
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
            Text('$current/$max', style: TextStyle(color: color, fontSize: 10)),
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

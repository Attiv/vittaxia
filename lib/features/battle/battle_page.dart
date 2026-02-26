import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/battle_speed_settings.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/game_audio.dart';
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
import '../sect/sect_provider.dart';

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
  bool _isAutoBattle = false; // 自动战斗开关
  bool _battleResolved = false;
  String? _battleInitSnapshot;
  ProviderSubscription<AsyncValue<dynamic>>? _characterSub;
  ProviderSubscription<AsyncValue<dynamic>>? _learnedSkillsSub;

  @override
  void initState() {
    super.initState();
    // 从全局设置恢复自动战斗状态
    _isAutoBattle = BattleSpeedSettings.autoEnabled;
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
    // 保存自动战斗状态到全局设置
    BattleSpeedSettings.autoEnabled = _isAutoBattle;
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
      luck: totalLuck(character),
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
      _battleResolved = false;
    });

    // 如果开启了自动战斗，立即开始
    if (_isAutoBattle && !_isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isAutoBattle && !_isAnimating) {
          _autoSelectAndUseSkill();
        }
      });
    }
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
    } else if (_isAutoBattle) {
      // 自动战斗模式：继续下一回合
      // 根据动画速度调整延迟
      final delay = BattleSpeedSettings.skipAnimation
          ? const Duration(milliseconds: 100)
          : BattleSpeedSettings.currentSpeed == BattleSpeed.fast
          ? const Duration(milliseconds: 200)
          : const Duration(milliseconds: 400);
      await Future.delayed(delay);
      if (mounted && _isAutoBattle) {
        _autoSelectAndUseSkill();
      }
    }
  }

  /// 自动选择并使用技能
  void _autoSelectAndUseSkill() {
    final engine = _engine;
    if (engine == null || engine.isOver || _isAnimating) return;

    // 智能选择技能
    final skill = _selectBestSkill(engine);
    if (skill != null) {
      _useSkill(skill);
    }
  }

  /// 智能选择最佳技能
  Skill? _selectBestSkill(BattleEngine engine) {
    final player = engine.player;
    final usableSkills = player.skills
        .where((s) => s.mpCost <= player.mp)
        .toList();

    if (usableSkills.isEmpty) return null;

    // 策略：血量低于30%优先回复，否则优先高伤害技能
    final hpRatio = player.hp / player.maxHp;

    if (hpRatio < 0.3) {
      // 寻找回复技能
      final healSkills = usableSkills.where((s) => s.healAmount > 0).toList();
      if (healSkills.isNotEmpty) {
        return healSkills.first;
      }
    }

    // 优先使用高伤害技能
    usableSkills.sort((a, b) {
      final aDmg = a.baseDamage + player.effectiveAtk * a.damageMultiplier;
      final bDmg = b.baseDamage + player.effectiveAtk * b.damageMultiplier;
      return bDmg.compareTo(aDmg);
    });

    return usableSkills.first;
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
      _playActionSfx(
        acted: true,
        crit: engine.lastPlayerAttackCrit,
        dodged: engine.lastPlayerAttackDodged,
        damage: engine.lastPlayerDamage,
        heal: engine.lastPlayerHeal,
      );
      await playerAnim();
      _playActionSfx(
        acted: engine.lastEnemyActed,
        crit: engine.lastEnemyAttackCrit,
        dodged: engine.lastEnemyAttackDodged,
        damage: engine.lastEnemyDamage,
        heal: engine.lastEnemyHeal,
      );
      await enemyAnim();
    } else {
      _playActionSfx(
        acted: engine.lastEnemyActed,
        crit: engine.lastEnemyAttackCrit,
        dodged: engine.lastEnemyAttackDodged,
        damage: engine.lastEnemyDamage,
        heal: engine.lastEnemyHeal,
      );
      await enemyAnim();
      _playActionSfx(
        acted: true,
        crit: engine.lastPlayerAttackCrit,
        dodged: engine.lastPlayerAttackDodged,
        damage: engine.lastPlayerDamage,
        heal: engine.lastPlayerHeal,
      );
      await playerAnim();
    }
  }

  void _playActionSfx({
    required bool acted,
    required bool crit,
    required bool dodged,
    required int damage,
    required int heal,
  }) {
    if (!acted) return;
    if (dodged) {
      GameAudio.battleDodge();
      return;
    }
    if (crit) {
      GameAudio.battleCrit();
      return;
    }
    if (damage > 0 || heal > 0) {
      GameAudio.battleHit();
      return;
    }
    GameAudio.tap();
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
    if (_battleResolved) return;
    _battleResolved = true;

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
      GameAudio.battleWin();
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
          final droppedItem = items[template.dropItemId];
          final itemName = droppedItem?.name ?? template.dropItemId!;
          final isRareDrop =
              template.dropRate <= 0.2 ||
              droppedItem?.rarity == ItemRarity.epic ||
              droppedItem?.rarity == ItemRarity.legendary;
          if (isRareDrop) {
            GameAudio.rareDrop();
          } else {
            GameAudio.success();
          }
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
      ref
          .read(sectNotifierProvider.notifier)
          .checkAndUpdateSectObjectives(
            character.id,
            QuestObjectiveType.kill,
            widget.enemyId,
          );
    } else {
      GameAudio.battleLose();
      logNotifier.addLog('战斗失败，你勉强逃了出来。', type: LogType.combat);
      // 保底1血
      charNotifier.updateStats(characterId: character.id, currentHp: 1);
    }

    if (BattleSpeedSettings.autoEnabled) {
      Future<void>.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.of(context).pop(engine.playerWon);
      });
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
        actions: [
          // 自动战斗按钮
          IconButton(
            icon: Icon(
              _isAutoBattle ? Icons.pause_circle : Icons.play_circle,
              color: _isAutoBattle ? AppColors.success : AppColors.accent,
            ),
            tooltip: _isAutoBattle ? '停止自动' : '自动战斗',
            onPressed: engine.isOver
                ? null
                : () {
                    setState(() {
                      _isAutoBattle = !_isAutoBattle;
                    });
                    BattleSpeedSettings.autoEnabled = _isAutoBattle;
                    if (_isAutoBattle && !_isAnimating) {
                      _autoSelectAndUseSkill();
                    }
                  },
          ),
          PopupMenuButton<BattleAnimationStyle>(
            icon: Icon(Icons.animation, color: AppColors.accent),
            tooltip: '动画风格',
            onSelected: (style) {
              setState(() {
                BattleSpeedSettings.setAnimationStyle(style);
              });
            },
            itemBuilder: (context) => [
              for (final style in battleAnimationStyleOrder)
                PopupMenuItem(
                  value: style,
                  child: Row(
                    children: [
                      if (BattleSpeedSettings.animationStyle == style)
                        const Icon(Icons.check, size: 18),
                      if (BattleSpeedSettings.animationStyle != style)
                        const SizedBox(width: 18),
                      const SizedBox(width: 8),
                      Text('${style.label} · ${style.subtitle}'),
                    ],
                  ),
                ),
            ],
          ),
          // 战斗速度切换按钮
          PopupMenuButton<BattleSpeed>(
            icon: Icon(
              BattleSpeedSettings.skipAnimation
                  ? Icons.fast_forward
                  : Icons.speed,
              color: AppColors.accent,
            ),
            tooltip: '战斗速度',
            onSelected: (speed) {
              setState(() {
                BattleSpeedSettings.setSpeed(speed);
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: BattleSpeed.normal,
                child: Row(
                  children: [
                    if (BattleSpeedSettings.currentSpeed == BattleSpeed.normal)
                      Icon(Icons.check, size: 18),
                    if (BattleSpeedSettings.currentSpeed != BattleSpeed.normal)
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    const Text('正常速度 (1x)'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: BattleSpeed.fast,
                child: Row(
                  children: [
                    if (BattleSpeedSettings.currentSpeed == BattleSpeed.fast)
                      Icon(Icons.check, size: 18),
                    if (BattleSpeedSettings.currentSpeed != BattleSpeed.fast)
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    const Text('快速 (2x)'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: BattleSpeed.skip,
                child: Row(
                  children: [
                    if (BattleSpeedSettings.currentSpeed == BattleSpeed.skip)
                      Icon(Icons.check, size: 18),
                    if (BattleSpeedSettings.currentSpeed != BattleSpeed.skip)
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    const Text('跳过动画'),
                  ],
                ),
              ),
            ],
          ),
        ],
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
                Text(
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
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
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
              height: 182,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 自动战斗状态提示
                  if (_isAutoBattle)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.autorenew,
                            size: 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '自动战斗中...',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: engine.player.skills.map((skill) {
                      final canUse =
                          skill.mpCost <= engine.player.mp &&
                          !_isAnimating &&
                          !_isAutoBattle;
                      return Tooltip(
                        message:
                            '${skill.description}\n消耗内力: ${skill.mpCost}  当前: ${engine.player.mp}',
                        child: ElevatedButton(
                          onPressed: canUse ? () => _useSkill(skill) : null,
                          child: Text(
                            '${skill.name}${skill.mpCost > 0 ? " (${skill.mpCost})" : ""}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
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
                  if (BattleSpeedSettings.autoEnabled) ...[
                    const SizedBox(height: 8),
                    Text(
                      '自动战斗已开启，2秒后自动返回',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
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

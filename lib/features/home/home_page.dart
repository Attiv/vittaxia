import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vittaxia/core/theme/app_theme.dart';

import '../../core/constants/game_constants.dart';
import '../../core/database/database_provider.dart';
import '../../core/utils/game_audio.dart';
import '../../data/item_data.dart';
import '../../data/mine_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/game_event_data.dart';
import '../battle/battle_page.dart';
import '../character/character_create_page.dart';
import '../character/character_detail_page.dart';
import '../character/character_provider.dart';
import '../dialogue/npc_list_page.dart';
import '../dungeon/dungeon_list_page.dart';
import '../dungeon/dungeon_provider.dart';
import '../explore/event_rewards.dart';
import '../explore/explore_provider.dart';
import '../guide/guide_page.dart';
import '../idle/idle_calculator.dart';
import '../idle/idle_reward_dialog.dart';
import '../inventory/inventory_page.dart';
import '../inventory/inventory_provider.dart';
import '../map/map_page.dart';
import '../mine/mine_page.dart';
import '../quest/quest_page.dart';
import '../quest/quest_provider.dart';
import '../sect/sect_page.dart';
import '../sect/sect_provider.dart';
import '../skill/skill_page.dart';
import '../../shared/widgets/status_panel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _cheatUnlockPassword = 'attiv';
  static const _titleTapThreshold = 5;

  bool _checkedIdleReward = false;
  bool _restoredCharacter = false;
  int _titleTapCount = 0;
  bool _cheatUnlocked = false;
  bool _cheatMenuOpen = false;
  // 悬浮按钮拖动位置（右下角偏移）
  double _fabRight = 16;
  double _fabBottom = 90;
  // 在线体力恢复定时器
  Timer? _staminaTimer;

  @override
  void initState() {
    super.initState();
    _startStaminaTimer();
  }

  @override
  void dispose() {
    _staminaTimer?.cancel();
    super.dispose();
  }

  void _startStaminaTimer() {
    // 每2分钟恢复1点体力，与离线恢复速率一致
    _staminaTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      final character = ref.read(currentCharacterProvider).valueOrNull;
      final maxStamina = character == null ? 0 : totalMaxStamina(character);
      if (character == null || character.stamina >= maxStamina) return;
      ref
          .read(characterNotifierProvider.notifier)
          .updateStats(
            characterId: character.id,
            stamina: (character.stamina + 1).clamp(0, maxStamina),
            lastStaminaRegenTime: DateTime.now(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final characterAsync = ref.watch(currentCharacterProvider);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _onTitleTap,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text('维 塔 侠'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(GameAudio.enabled ? Icons.volume_up : Icons.volume_off),
            tooltip: '声音设置',
            onPressed: _openAudioSettings,
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: '新手攻略',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const GuidePage()));
            },
          ),
        ],
      ),
      body: _wrapWithCheatOverlay(
        characterAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('出错了: $e')),
          data: (character) {
            if (character == null) {
              // 尝试从数据库恢复已有角色
              if (!_restoredCharacter) {
                _restoredCharacter = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _tryRestoreCharacter();
                });
              }
              return _buildWelcome(context, theme);
            }
            // 首次加载角色时检测离线收益
            if (!_checkedIdleReward) {
              _checkedIdleReward = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _checkIdleReward(character);
              });
            }
            return _buildGameMain(context, theme, character);
          },
        ),
      ),
    );
  }

  Future<void> _tryRestoreCharacter() async {
    final db = ref.read(databaseProvider);
    final characters = await db.getAllCharacters();
    if (characters.isNotEmpty && mounted) {
      final id = characters.first.id;
      ref.read(currentCharacterIdProvider.notifier).state = id;
      // 恢复角色后补接可能遗漏的主线任务
      await ref.read(questNotifierProvider.notifier).autoAcceptMainQuests(id);
    }
  }

  Future<void> _checkIdleReward(dynamic character) async {
    if (character.lastOnlineTime == null) return;

    // 离线体力恢复
    await ref
        .read(characterNotifierProvider.notifier)
        .regenStamina(character.id);

    final reward = IdleCalculator.calculate(
      comprehension: character.baseComprehension,
      lastOnline: character.lastOnlineTime!,
    );

    if (!reward.hasAny) return;

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final invNotifier = ref.read(inventoryNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    if (reward.exp > 0) {
      final newRealm = await charNotifier.addExp(character.id, reward.exp);
      if (newRealm != null) {
        logNotifier.addLog('突破！境界提升至$newRealm', type: LogType.system);
      }
    }

    if (reward.silver > 0) {
      await charNotifier.updateStats(
        characterId: character.id,
        silver: character.silver + reward.silver,
      );
    }

    if (reward.items.isNotEmpty) {
      for (final entry in reward.items.entries) {
        await invNotifier.addItem(character.id, entry.key, count: entry.value);
      }
    }

    final parts = <String>[];
    if (reward.exp > 0) {
      parts.add('${reward.exp}经验');
    }
    if (reward.silver > 0) {
      parts.add('${reward.silver}银两');
    }
    if (reward.items.isNotEmpty) {
      final itemText = reward.items.entries
          .map((entry) {
            final itemName = items[entry.key]?.name ?? entry.key;
            return '$itemName x${entry.value}';
          })
          .join('、');
      parts.add(itemText);
    }
    logNotifier.addLog(
      '离线修炼 ${IdleCalculator.formatDuration(reward.minutesIdle)}，获得 ${parts.join("、")}',
      type: LogType.system,
    );
    if (!mounted) return;
    await IdleRewardDialog.show(context, reward);
  }

  Future<void> _openAudioSettings() async {
    var soundEnabled = GameAudio.enabled;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '声音设置',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      value: soundEnabled,
                      onChanged: (value) async {
                        await GameAudio.setEnabled(value);
                        setSheetState(() {
                          soundEnabled = value;
                        });
                        if (mounted) {
                          setState(() {});
                          _showActionTip(value ? '音效已开启' : '音效已关闭');
                        }
                        if (value) {
                          GameAudio.success();
                        }
                      },
                      title: const Text('系统音效'),
                      subtitle: const Text('按钮反馈、战斗提示、掉落提示'),
                      activeColor: AppColors.accent,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openQuestPanel() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.92;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: SizedBox(height: maxHeight, child: const QuestPage()),
        );
      },
    );
  }

  Widget _buildWelcome(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('⚔', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text('侠', style: theme.textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text('江湖路远，且行且珍惜', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                final created = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => const CharacterCreatePage(),
                  ),
                );
                if (created == true) {
                  ref.invalidate(characterListProvider);
                }
              },
              child: const Text('开始游戏'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameMain(
    BuildContext context,
    ThemeData theme,
    dynamic character,
  ) {
    final logs = ref.watch(gameLogProvider);
    final location = ref.watch(currentLocationProvider);
    final mineSpot = getMineSpotByLocation(character.locationId);

    return Column(
      children: [
        StatusPanel(
          character: character,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CharacterDetailPage(character: character),
              ),
            );
          },
        ),
        if (location != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.surfaceLight,
            child: Text(
              '📍 ${location.name}',
              style: TextStyle(
                color: AppColors.textAccent.withValues(alpha: 0.8),
                fontSize: 13,
              ),
            ),
          ),
        Expanded(
          child: Container(
            color: AppColors.background,
            child: logs.isEmpty
                ? Center(
                    child: Text(
                      '探索江湖，书写你的传奇',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: logs.length,
                    itemBuilder: (_, i) => _logEntry(logs[i], theme),
                  ),
          ),
        ),
        // 操作区 (两行四列)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(
                color: AppColors.primaryLight.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _actionButton(
                    Icons.explore,
                    '探索',
                    () {
                      _doExplore(character);
                    },
                    staminaCost: 5,
                    currentStamina: character.stamina,
                    hint: '随机事件',
                  ),
                  _actionButton(
                    Icons.hardware,
                    '挖矿',
                    () {
                      final spot = mineSpot;
                      if (spot == null) {
                        _showActionTip('此处无矿脉');
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MinePage()),
                      );
                    },
                    staminaCost: mineSpot?.staminaCost,
                    currentStamina: character.stamina,
                    hint: mineSpot == null ? '此地无矿脉' : null,
                  ),
                  _actionButton(Icons.terrain, '探险', () {
                    final dungeons = ref.read(availableDungeonsProvider);
                    if (dungeons.isEmpty) {
                      _showActionTip('此处无洞府');
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const DungeonListPage(),
                      ),
                    );
                  }, hint: '洞府挑战'),
                  _actionButton(Icons.people, '交谈', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NpcListPage()),
                    );
                  }, hint: 'NPC互动'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _actionButton(Icons.inventory_2, '背包', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const InventoryPage()),
                    );
                  }, hint: '物品/装备'),
                  _actionButton(Icons.auto_stories, '技能', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SkillPage()),
                    );
                  }, hint: '修炼与装备'),
                  _actionButton(Icons.assignment, '任务', () {
                    _openQuestPanel();
                  }, hint: '主线与支线'),
                  _actionButton(Icons.temple_buddhist, '师门', () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => const SectPage()));
                  }, hint: '拜师学艺'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _actionButton(Icons.map, '地图', () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => const MapPage()));
                  }, hint: '切换地点'),
                  _actionButton(
                    Icons.self_improvement,
                    '打坐',
                    () {
                      _doMeditate(character);
                    },
                    onLongPress: () => _doBatchRecover(isMeditate: true),
                    staminaCost: GameConstants.meditateStaminaCost,
                    currentStamina: character.stamina,
                    hint: '长按连续恢复',
                  ),
                  _actionButton(
                    Icons.hotel,
                    '休息',
                    () {
                      _doRest(character);
                    },
                    onLongPress: () => _doBatchRecover(isMeditate: false),
                    staminaCost: GameConstants.restStaminaCost,
                    currentStamina: character.stamina,
                    hint: '长按连续恢复',
                  ),
                  _actionButton(Icons.info_outline, '帮助', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GuidePage()),
                    );
                  }, hint: '新手攻略'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onTitleTap() {
    if (_cheatUnlocked) return;

    _titleTapCount += 1;
    if (_titleTapCount < _titleTapThreshold) return;

    _titleTapCount = 0;
    _tryUnlockCheat();
  }

  Future<void> _tryUnlockCheat() async {
    final controller = TextEditingController();
    final password = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('暗号验证'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: '请输入暗号'),
            onSubmitted: (value) {
              Navigator.of(dialogContext).pop(value.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text.trim()),
              child: const Text('解锁'),
            ),
          ],
        );
      },
    );
    // 等 dialog 关闭动画结束后再 dispose，避免 TextField 引用已销毁的 controller
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.dispose());

    if (!mounted || password == null || password.isEmpty) return;

    if (password == _cheatUnlockPassword) {
      setState(() {
        _cheatUnlocked = true;
      });
      _showActionTip('作弊工具已解锁');
      ref
          .read(gameLogProvider.notifier)
          .addLog('你轻叩匾额五次，暗门缓缓开启。', type: LogType.system);
      return;
    }

    _showActionTip('暗号错误');
  }

  Widget _wrapWithCheatOverlay(Widget child) {
    if (!_cheatUnlocked) return child;

    return Stack(
      children: [
        child,
        Positioned(
          right: _fabRight,
          bottom: _fabBottom,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _fabRight -= details.delta.dx;
                _fabBottom -= details.delta.dy;
                // 限制在屏幕范围内
                final size = MediaQuery.of(context).size;
                _fabRight = _fabRight.clamp(0, size.width - 48);
                _fabBottom = _fabBottom.clamp(0, size.height - 160);
              });
            },
            child: AnimatedScale(
              scale: _cheatMenuOpen ? 1.1 : 1,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutBack,
              child: Material(
                elevation: 4,
                shape: const CircleBorder(),
                color: AppColors.primaryDark,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _openCheatPanel,
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: Icon(
                      _cheatMenuOpen ? Icons.close : Icons.auto_awesome,
                      color: AppColors.accent,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openCheatPanel() async {
    if (_cheatMenuOpen) return;

    setState(() {
      _cheatMenuOpen = true;
    });

    final action = await showModalBottomSheet<_CheatAction>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _CheatActionSheet(
          onSelected: (action) {
            Navigator.of(sheetContext).pop(action);
          },
        );
      },
    );

    if (!mounted) return;
    setState(() {
      _cheatMenuOpen = false;
    });

    if (action != null) {
      // 延迟到下一帧执行，避免 sheet dispose 期间触发 provider 更新导致断言失败
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _runCheatAction(action);
      });
    }
  }

  Future<void> _runCheatAction(_CheatAction action) async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) {
      _showActionTip('当前没有可操作角色');
      return;
    }

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final inventoryNotifier = ref.read(inventoryNotifierProvider.notifier);

    switch (action) {
      case _CheatAction.addSilver:
        await charNotifier.updateStats(
          characterId: character.id,
          silver: character.silver + 99999,
        );
      case _CheatAction.addEnhanceMaterials:
        for (final itemId in [
          'rough_iron',
          'fine_iron',
          'mystic_ore',
          'star_iron',
        ]) {
          await inventoryNotifier.addItem(character.id, itemId, count: 99999);
        }
      case _CheatAction.addConsumables:
        await inventoryNotifier.addItem(
          character.id,
          'healing_pill',
          count: 999,
        );
        await inventoryNotifier.addItem(
          character.id,
          'spirit_pill',
          count: 999,
        );
        await inventoryNotifier.addItem(
          character.id,
          'stamina_pill',
          count: 999,
        );
        await inventoryNotifier.addItem(
          character.id,
          'great_healing_pill',
          count: 999,
        );
      case _CheatAction.restoreHp:
        await charNotifier.updateStats(
          characterId: character.id,
          currentHp: totalMaxHp(character),
        );
      case _CheatAction.restoreMp:
        await charNotifier.updateStats(
          characterId: character.id,
          currentMp: totalMaxMp(character),
        );
      case _CheatAction.restoreStamina:
        await charNotifier.updateStats(
          characterId: character.id,
          stamina: totalMaxStamina(character),
          lastStaminaRegenTime: DateTime.now(),
        );
      case _CheatAction.restoreAll:
        await charNotifier.updateStats(
          characterId: character.id,
          currentHp: totalMaxHp(character),
          currentMp: totalMaxMp(character),
          stamina: totalMaxStamina(character),
          lastStaminaRegenTime: DateTime.now(),
        );
      case _CheatAction.addExp:
        await charNotifier.addExp(character.id, 50000);
      case _CheatAction.addReputation:
        await charNotifier.updateStats(
          characterId: character.id,
          reputation: character.reputation + 999,
        );
    }

    final doneText = _cheatActionDoneText(action);
    if (!mounted) return;
    ref
        .read(gameLogProvider.notifier)
        .addLog('作弊指令：$doneText', type: LogType.system);
    _showActionTip(doneText);
  }

  String _cheatActionDoneText(_CheatAction action) {
    return switch (action) {
      _CheatAction.addSilver => '金币 +99999',
      _CheatAction.addEnhanceMaterials => '强化矿石 +99999（全套）',
      _CheatAction.addConsumables => '补给丹药 +999',
      _CheatAction.restoreHp => '气血已恢复',
      _CheatAction.restoreMp => '内力已恢复',
      _CheatAction.restoreStamina => '体力已恢复',
      _CheatAction.restoreAll => '气血/内力/体力已全满',
      _CheatAction.addExp => '经验 +50000',
      _CheatAction.addReputation => '声望 +999',
    };
  }

  void _showActionTip(String message) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<bool> _doMeditate(dynamic character, {bool showTip = true}) async {
    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    final maxMp = totalMaxMp(character);
    final currentMp = character.currentMp as int;
    if (currentMp >= maxMp) {
      if (showTip) _showActionTip('内力已满，无需打坐');
      return false;
    }

    final ok = await charNotifier.consumeStamina(
      character.id,
      GameConstants.meditateStaminaCost,
    );
    if (!ok) {
      if (showTip) _showActionTip('体力不足');
      return false;
    }

    final recover = (GameConstants.meditateMpRecover).clamp(
      0,
      maxMp - currentMp,
    );
    // 打坐附带少量 HP 恢复
    final maxHp = totalMaxHp(character);
    final currentHp = character.currentHp as int;
    final hpRecover = (GameConstants.meditateHpRecover).clamp(
      0,
      maxHp - currentHp,
    );
    await charNotifier.updateStats(
      characterId: character.id,
      currentMp: currentMp + recover,
      currentHp: hpRecover > 0 ? currentHp + hpRecover : null,
    );
    final hpMsg = hpRecover > 0 ? '，顺带调养了气血（+$hpRecover）' : '';
    logNotifier.addLog('盘膝打坐，吐纳调息，恢复了$recover点内力$hpMsg。', type: LogType.system);
    if (showTip) {
      _showActionTip('恢复了$recover点内力${hpRecover > 0 ? "、$hpRecover点气血" : ""}');
    }
    return true;
  }

  Future<bool> _doRest(dynamic character, {bool showTip = true}) async {
    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    final maxHp = totalMaxHp(character);
    final currentHp = character.currentHp as int;
    if (currentHp >= maxHp) {
      if (showTip) _showActionTip('气血充盈，无需休息');
      return false;
    }

    final ok = await charNotifier.consumeStamina(
      character.id,
      GameConstants.restStaminaCost,
    );
    if (!ok) {
      if (showTip) _showActionTip('体力不足');
      return false;
    }

    final recover = (GameConstants.restHpRecover).clamp(0, maxHp - currentHp);
    await charNotifier.updateStats(
      characterId: character.id,
      currentHp: currentHp + recover,
    );
    logNotifier.addLog('寻一处清净之地歇息片刻，恢复了$recover点气血。', type: LogType.system);
    if (showTip) _showActionTip('恢复了$recover点气血');
    return true;
  }

  void _doExplore(dynamic character) async {
    // 消耗5点体力
    final ok = await ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(character.id, 5);
    if (!ok) {
      if (mounted) {
        GameAudio.warning();
        _showActionTip('体力不足');
      }
      return;
    }

    // 探索成功执行一次，按当前位置更新探索类任务
    ref
        .read(questNotifierProvider.notifier)
        .checkAndUpdateObjectives(
          character.id,
          QuestObjectiveType.explore,
          character.locationId,
        );
    ref
        .read(sectNotifierProvider.notifier)
        .checkAndUpdateSectObjectives(
          character.id,
          QuestObjectiveType.explore,
          character.locationId,
        );

    final engine = ref.read(eventEngineProvider);
    final logNotifier = ref.read(gameLogProvider.notifier);
    final event = engine.rollEvent(character.locationId);

    if (event == null) {
      logNotifier.addLog('四下无事，一切平静。', type: LogType.explore);
      return;
    }

    logNotifier.addLog('${event.name}...', type: LogType.explore);

    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _EventBottomSheet(event: event),
    );
  }

  Future<void> _doBatchRecover({required bool isMeditate}) async {
    var done = 0;
    for (var i = 0; i < 3; i++) {
      final latestCharacter = ref.read(currentCharacterProvider).valueOrNull;
      if (latestCharacter == null) break;
      final ok = isMeditate
          ? await _doMeditate(latestCharacter, showTip: false)
          : await _doRest(latestCharacter, showTip: false);
      if (!ok) break;
      done++;
      await Future<void>.delayed(const Duration(milliseconds: 80));
    }
    if (done <= 0) {
      _showActionTip(isMeditate ? '内力已满或体力不足' : '气血已满或体力不足');
      return;
    }
    _showActionTip('连续${isMeditate ? "打坐" : "休息"} $done 次');
  }

  Widget _logEntry(GameLog log, ThemeData theme) {
    final color = switch (log.type) {
      LogType.combat => AppColors.hp,
      LogType.explore => AppColors.exp,
      LogType.quest => AppColors.accent,
      LogType.item => AppColors.accent,
      LogType.dialogue => AppColors.mp,
      _ => AppColors.textSecondary,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        log.message,
        style: TextStyle(color: color, fontSize: 14, height: 1.6),
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    VoidCallback? onLongPress,
    int? staminaCost,
    int? currentStamina,
    String? hint,
    bool enabled = true,
  }) {
    final enoughStamina =
        staminaCost == null ||
        currentStamina == null ||
        currentStamina >= staminaCost;
    final canTap = enabled && enoughStamina;
    final tooltip = [
      label,
      if (staminaCost != null) '消耗体力: $staminaCost',
      if (hint != null) hint,
      if (onLongPress != null) '长按可连续执行',
    ].join('\n');
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: TextButton(
          onLongPress: canTap ? onLongPress : null,
          onPressed: canTap
              ? () {
                  GameAudio.tap();
                  HapticFeedback.selectionClick();
                  onTap();
                }
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: canTap
                    ? AppColors.accent
                    : AppColors.textSecondary.withValues(alpha: 0.45),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: canTap
                      ? AppColors.textSecondary
                      : AppColors.textSecondary.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _CheatAction {
  addSilver,
  addEnhanceMaterials,
  addConsumables,
  restoreHp,
  restoreMp,
  restoreStamina,
  restoreAll,
  addExp,
  addReputation,
}

class _CheatActionSheet extends StatelessWidget {
  final ValueChanged<_CheatAction> onSelected;

  const _CheatActionSheet({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (_CheatAction.addSilver, '增加 99999 金币', Icons.attach_money),
      (_CheatAction.addEnhanceMaterials, '强化矿石各 +99999', Icons.hardware),
      (_CheatAction.addConsumables, '补给丹药各 +999', Icons.medication),
      (_CheatAction.restoreAll, '恢复全部状态', Icons.favorite),
      (_CheatAction.restoreHp, '恢复血量', Icons.health_and_safety),
      (_CheatAction.restoreMp, '恢复内力', Icons.waves),
      (_CheatAction.restoreStamina, '恢复体力', Icons.bolt),
      (_CheatAction.addExp, '增加 50000 经验', Icons.school),
      (_CheatAction.addReputation, '增加 999 声望', Icons.emoji_events),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.9, end: 1),
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(opacity: value.clamp(0, 1), child: child),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryLight.withValues(alpha: 0.6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '江湖秘技',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: AppColors.primaryLight),
                    const SizedBox(height: 10),
                    ...actions.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            foregroundColor: AppColors.textPrimary,
                            backgroundColor: AppColors.primaryDark.withValues(
                              alpha: 0.35,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 11,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => onSelected(item.$1),
                          icon: Icon(
                            item.$3,
                            color: AppColors.accent,
                            size: 20,
                          ),
                          label: Text(item.$2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 探索事件底部弹窗，减少页面跳转
class _EventBottomSheet extends ConsumerStatefulWidget {
  final GameEventData event;

  const _EventBottomSheet({required this.event});

  @override
  ConsumerState<_EventBottomSheet> createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends ConsumerState<_EventBottomSheet> {
  String? _resultText;
  EventChoice? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 标题
          Text(
            event.name,
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            event.description,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),

          if (_resultText != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _resultText!,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                  if (_selectedChoice != null) ...[
                    const SizedBox(height: 8),
                    if (_selectedChoice!.rewardExp > 0)
                      _rewardLine(
                        '经验 +${_selectedChoice!.rewardExp}',
                        AppColors.exp,
                      ),
                    if (_selectedChoice!.rewardSilver > 0)
                      _rewardLine(
                        '银两 +${_selectedChoice!.rewardSilver}',
                        AppColors.accent,
                      ),
                    if (_selectedChoice!.hpChange != 0)
                      _rewardLine(
                        '气血 ${_selectedChoice!.hpChange > 0 ? "+" : ""}${_selectedChoice!.hpChange}',
                        _selectedChoice!.hpChange > 0
                            ? AppColors.success
                            : AppColors.danger,
                      ),
                    if (_selectedChoice!.rewardItemId != null)
                      _rewardLine(
                        '获得物品: ${items[_selectedChoice!.rewardItemId]?.name ?? _selectedChoice!.rewardItemId}',
                        AppColors.accent,
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('确定'),
            ),
          ] else ...[
            // 选项按钮
            if (event.choices.isNotEmpty)
              ...event.choices.map(
                (choice) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () => _resolveChoice(choice),
                    child: Text(choice.text),
                  ),
                ),
              ),
            if (event.choices.isEmpty) ...[
              ElevatedButton(
                onPressed: () {
                  applyEventRewards(
                    ref,
                    exp: event.rewardExp,
                    silver: event.rewardSilver,
                    itemId: event.rewardItemId,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('继续'),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _resolveChoice(EventChoice choice) {
    // 战斗选项：关闭弹窗后跳转战斗页
    if (choice.triggerBattle && choice.enemyId != null) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => BattlePage(enemyId: choice.enemyId!)),
      );
      return;
    }

    // 非战斗：结算奖励并显示结果
    applyEventRewards(
      ref,
      exp: choice.rewardExp,
      silver: choice.rewardSilver,
      itemId: choice.rewardItemId,
      hpChange: choice.hpChange != 0 ? choice.hpChange : null,
    );

    setState(() {
      _resultText = choice.resultText;
      _selectedChoice = choice;
    });
  }

  Widget _rewardLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text, style: TextStyle(color: color, fontSize: 13)),
    );
  }
}

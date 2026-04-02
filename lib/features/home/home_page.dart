import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vittaxia/core/theme/app_theme.dart';
import 'package:vittaxia/core/theme/theme_settings.dart';

import '../../core/constants/battle_speed_settings.dart';
import '../../core/constants/game_constants.dart';
import '../../core/database/database_provider.dart';
import '../../core/router/page_transition.dart';
import '../../core/utils/game_audio.dart';
import '../../data/event_data.dart';
import '../../data/enemy_data.dart';
import '../../data/item_data.dart';
import '../../data/map_data.dart';
import '../../data/mine_data.dart';
import '../../data/npc_data.dart';
import '../../data/quest_data.dart';
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
import 'jianghu_order_rules.dart';
import '../map/map_page.dart';
import '../mine/mine_page.dart';
import '../quest/quest_page.dart';
import '../quest/quest_provider.dart';
import '../sect/sect_page.dart';
import '../sect/sect_provider.dart';
import '../skill/skill_page.dart';
import '../../shared/widgets/status_panel.dart';

final Map<String, String> _enemyObjectiveLocationHints =
    _buildEnemyObjectiveLocationHints();
final Map<String, String> _itemObjectiveLocationHints =
    _buildItemObjectiveLocationHints();

Map<String, String> _buildEnemyObjectiveLocationHints() {
  final hints = <String, String>{};
  for (final location in mapLocations.values) {
    for (final eventId in location.eventIds) {
      final event = gameEvents[eventId];
      if (event == null) continue;
      for (final choice in event.choices) {
        final enemyId = choice.enemyId;
        if (enemyId == null || enemyId.isEmpty) continue;
        hints.putIfAbsent(enemyId, () => location.id);
      }
    }
  }
  return hints;
}

Map<String, String> _buildItemObjectiveLocationHints() {
  final hints = <String, String>{};
  for (final location in mapLocations.values) {
    for (final eventId in location.eventIds) {
      final event = gameEvents[eventId];
      if (event == null) continue;
      final fixedItemId = event.rewardItemId;
      if (fixedItemId != null && fixedItemId.isNotEmpty) {
        hints.putIfAbsent(fixedItemId, () => location.id);
      }
      for (final choice in event.choices) {
        final itemId = choice.rewardItemId;
        if (itemId == null || itemId.isEmpty) continue;
        hints.putIfAbsent(itemId, () => location.id);
      }
    }
  }
  return hints;
}

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
  final Random _rng = Random();
  // 悬浮按钮拖动位置（右下角偏移）
  double _fabRight = 16;
  double _fabBottom = 90;
  // 在线体力恢复定时器
  Timer? _staminaTimer;
  OverlayEntry? _actionTipOverlay;
  Timer? _actionTipTimer;

  @override
  void initState() {
    super.initState();
    _startStaminaTimer();
  }

  @override
  void dispose() {
    _staminaTimer?.cancel();
    _removeActionTipOverlay();
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
            icon: Icon(Icons.palette_outlined),
            tooltip: '系统设置',
            onPressed: _openSettingsPanel,
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: '新手攻略',
            onPressed: () {
              pushSmoothPage(context, const GuidePage());
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

  Future<void> _openSettingsPanel() async {
    var soundEnabled = GameAudio.enabled;
    var selectedTheme = ThemeSettings.current;
    var selectedBattleStyle = BattleSpeedSettings.animationStyle;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor:
          Theme.of(context).bottomSheetTheme.modalBackgroundColor ??
          Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        final sheetTheme = Theme.of(sheetContext);
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '系统设置',
                      textAlign: TextAlign.center,
                      style: sheetTheme.textTheme.titleLarge?.copyWith(
                        color: AppColors.accent,
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
                    const SizedBox(height: 6),
                    Divider(
                      color: AppColors.primaryLight.withValues(alpha: 0.45),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '主题外观',
                      style: sheetTheme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '当前：${uiThemeSpecs[selectedTheme]!.label} · ${uiThemeSpecs[selectedTheme]!.subtitle}',
                      style: sheetTheme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = (constraints.maxWidth - 8) / 2;
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final preset in uiThemePresetOrder)
                              SizedBox(
                                width: width,
                                child: _buildThemePresetButton(
                                  preset: preset,
                                  selectedTheme: selectedTheme,
                                  onSelected: (nextTheme) async {
                                    if (nextTheme == selectedTheme) return;
                                    await ThemeSettings.setTheme(nextTheme);
                                    setSheetState(() {
                                      selectedTheme = nextTheme;
                                    });
                                    if (mounted) {
                                      setState(() {});
                                      _showActionTip(
                                        '已切换为 ${uiThemeSpecs[nextTheme]!.label}',
                                      );
                                    }
                                    GameAudio.tap();
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: AppColors.primaryLight.withValues(alpha: 0.45),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '战斗动画',
                      style: sheetTheme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '当前：${selectedBattleStyle.label} · ${selectedBattleStyle.subtitle}',
                      style: sheetTheme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = (constraints.maxWidth - 8) / 2;
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final style in battleAnimationStyleOrder)
                              SizedBox(
                                width: width,
                                child: _buildBattleAnimationStyleButton(
                                  style: style,
                                  selectedStyle: selectedBattleStyle,
                                  onSelected: (nextStyle) {
                                    if (nextStyle == selectedBattleStyle) {
                                      return;
                                    }
                                    BattleSpeedSettings.setAnimationStyle(
                                      nextStyle,
                                    );
                                    setSheetState(() {
                                      selectedBattleStyle = nextStyle;
                                    });
                                    if (mounted) {
                                      setState(() {});
                                      _showActionTip(
                                        '动画风格已切换为 ${nextStyle.label}',
                                      );
                                    }
                                    GameAudio.tap();
                                  },
                                ),
                              ),
                          ],
                        );
                      },
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

  Widget _buildThemePresetButton({
    required UiThemePreset preset,
    required UiThemePreset selectedTheme,
    required ValueChanged<UiThemePreset> onSelected,
  }) {
    final spec = uiThemeSpecs[preset]!;
    final isSelected = preset == selectedTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onSelected(preset),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                spec.primaryDark.withValues(alpha: 0.94),
                spec.surface.withValues(alpha: 0.94),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? spec.accent.withValues(alpha: 0.95)
                  : spec.primaryLight.withValues(alpha: 0.6),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: spec.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: spec.textPrimary, width: 0.6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spec.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: spec.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      spec.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: spec.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: spec.accent.withValues(alpha: 0.96),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBattleAnimationStyleButton({
    required BattleAnimationStyle style,
    required BattleAnimationStyle selectedStyle,
    required ValueChanged<BattleAnimationStyle> onSelected,
  }) {
    final isSelected = style == selectedStyle;
    final accent = isSelected ? AppColors.accent : AppColors.primaryLight;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onSelected(style),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: accent.withValues(alpha: isSelected ? 0.95 : 0.7),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      style.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      style.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: accent.withValues(alpha: 0.95),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openQuestPanel({int initialTabIndex = 0}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.92;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: SizedBox(
            height: maxHeight,
            child: QuestPage(initialTabIndex: initialTabIndex),
          ),
        );
      },
    );
  }

  Future<void> _openQuestQuickPreview() async {
    final active = ref.read(activeQuestsProvider);
    final available = ref.read(availableQuestsProvider);
    final inventory = ref.read(inventoryProvider).valueOrNull ?? const [];

    final inventoryCountById = <String, int>{};
    for (final inv in inventory) {
      final itemId = inv.itemId as String?;
      final quantity = inv.quantity as int?;
      if (itemId == null) continue;
      inventoryCountById[itemId] =
          (inventoryCountById[itemId] ?? 0) + (quantity ?? 0);
    }

    final activeMain =
        <({dynamic progress, dynamic quest, Map<String, int> objectives})>[];
    for (final progress in active) {
      final quest = quests[progress.questId];
      if (quest == null || quest.type != QuestType.main) continue;
      activeMain.add((
        progress: progress,
        quest: quest,
        objectives: _decodeQuestObjectives(progress.objectivesJson),
      ));
    }
    dynamic nextMain;
    for (final q in available) {
      if (q.type == QuestType.main) {
        nextMain = q;
        break;
      }
    }

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor:
          Theme.of(context).bottomSheetTheme.modalBackgroundColor ??
          Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * 0.72,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '主线速览',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (activeMain.isEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primaryLight.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Text(
                        nextMain == null
                            ? '当前没有进行中的主线，也没有可接主线。'
                            : '当前没有进行中的主线。下一条可接主线如下：',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                    if (nextMain != null) ...[
                      const SizedBox(height: 8),
                      _buildQuickQuestCard(
                        sheetContext: sheetContext,
                        quest: nextMain,
                        objectives: const <String, int>{},
                        inventoryCountById: inventoryCountById,
                        questTabIndex: 1,
                      ),
                    ],
                  ] else ...[
                    for (final entry in activeMain) ...[
                      _buildQuickQuestCard(
                        sheetContext: sheetContext,
                        quest: entry.quest,
                        objectives: entry.objectives,
                        inventoryCountById: inventoryCountById,
                        questTabIndex: 0,
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (nextMain != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '下一条可接主线',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildQuickQuestCard(
                        sheetContext: sheetContext,
                        quest: nextMain,
                        objectives: const <String, int>{},
                        inventoryCountById: inventoryCountById,
                        questTabIndex: 1,
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickQuestCard({
    required BuildContext sheetContext,
    required dynamic quest,
    required Map<String, int> objectives,
    required Map<String, int> inventoryCountById,
    required int questTabIndex,
  }) {
    final guideLocationId = _resolveQuestGuideLocation(
      quest,
      objectives,
      inventoryCountById,
    );
    final guideLocation = guideLocationId == null
        ? null
        : mapLocations[guideLocationId];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quest.name as String,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            quest.description as String,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          ...(quest.objectives as List).map((obj) {
            final current = _quickQuestObjectiveCurrent(
              obj,
              objectives,
              inventoryCountById,
            );
            final required = obj.requiredCount as int;
            final done = current >= required;
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  Icon(
                    done ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 14,
                    color: done ? AppColors.success : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${obj.description} ($current/$required)',
                      style: TextStyle(
                        color: done
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          if (guideLocation != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '推荐地点：${guideLocation.name}',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _openQuestFromQuickPreview(
                  sheetContext,
                  tabIndex: questTabIndex,
                ),
                icon: const Icon(Icons.assignment_outlined, size: 16),
                label: Text(questTabIndex == 1 ? '去任务页接取' : '去任务页'),
              ),
              if (guideLocation != null)
                OutlinedButton.icon(
                  onPressed: () => _openGuidedMapFromQuickPreview(
                    sheetContext,
                    locationId: guideLocation.id,
                    questName: quest.name as String,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.accent.withValues(alpha: 0.5),
                    ),
                    foregroundColor: AppColors.textAccent,
                  ),
                  icon: const Icon(Icons.near_me_outlined, size: 16),
                  label: const Text('地图定位'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openQuestFromQuickPreview(
    BuildContext sheetContext, {
    required int tabIndex,
  }) async {
    Navigator.of(sheetContext).pop();
    await Future<void>.delayed(const Duration(milliseconds: 140));
    if (!mounted) return;
    await _openQuestPanel(initialTabIndex: tabIndex);
  }

  Future<void> _openGuidedMapFromQuickPreview(
    BuildContext sheetContext, {
    required String locationId,
    required String questName,
  }) async {
    Navigator.of(sheetContext).pop();
    await Future<void>.delayed(const Duration(milliseconds: 140));
    if (!mounted) return;
    await pushSmoothPage(
      context,
      MapPage(targetLocationId: locationId, targetQuestName: questName),
    );
  }

  Map<String, int> _decodeQuestObjectives(String objectivesJson) {
    try {
      final decoded = jsonDecode(objectivesJson);
      if (decoded is! Map) return <String, int>{};
      final result = <String, int>{};
      for (final entry in decoded.entries) {
        final key = entry.key.toString();
        final value = entry.value;
        result[key] = value is int ? value : int.tryParse('$value') ?? 0;
      }
      return result;
    } catch (_) {
      return <String, int>{};
    }
  }

  int _quickQuestObjectiveCurrent(
    dynamic objective,
    Map<String, int> objectives,
    Map<String, int> inventoryCountById,
  ) {
    final objectiveId = objective.id as String;
    final recorded = objectives[objectiveId] ?? 0;
    if (objective.type != QuestObjectiveType.collect) return recorded;

    final targetId = objective.targetId as String?;
    if (targetId == null || targetId.isEmpty) return recorded;

    final owned = inventoryCountById[targetId] ?? 0;
    return owned > recorded ? owned : recorded;
  }

  String? _resolveQuestGuideLocation(
    dynamic quest,
    Map<String, int> objectives,
    Map<String, int> inventoryCountById,
  ) {
    final objectiveList = quest.objectives as List;
    for (final objective in objectiveList) {
      final required = objective.requiredCount as int? ?? 1;
      final current = _quickQuestObjectiveCurrent(
        objective,
        objectives,
        inventoryCountById,
      );
      if (current >= required) continue;
      final locationId = _resolveObjectiveGuideLocation(objective, quest);
      if (locationId != null) return locationId;
    }

    final questLocationId = quest.questLocationId as String?;
    if (questLocationId != null && questLocationId.isNotEmpty) {
      return questLocationId;
    }

    for (final objective in objectiveList) {
      final locationId = _resolveObjectiveGuideLocation(objective, quest);
      if (locationId != null) return locationId;
    }
    return null;
  }

  String? _resolveObjectiveGuideLocation(dynamic objective, dynamic quest) {
    final targetId = objective.targetId as String?;
    final objectiveType = objective.type as QuestObjectiveType?;
    if (objectiveType == QuestObjectiveType.explore) {
      if (targetId != null && mapLocations.containsKey(targetId)) {
        return targetId;
      }
    } else if (objectiveType == QuestObjectiveType.talk) {
      if (targetId != null) {
        final locationId = npcs[targetId]?.locationId;
        if (locationId != null && locationId.isNotEmpty) return locationId;
      }
    } else if (objectiveType == QuestObjectiveType.kill) {
      if (targetId != null && targetId.isNotEmpty) {
        final locationId = _enemyObjectiveLocationHints[targetId];
        if (locationId != null) return locationId;
      }
    } else if (objectiveType == QuestObjectiveType.collect) {
      if (targetId != null && targetId.isNotEmpty) {
        final locationId = _itemObjectiveLocationHints[targetId];
        if (locationId != null) return locationId;
      }
    }

    final questLocationId = quest.questLocationId as String?;
    if (questLocationId != null && questLocationId.isNotEmpty) {
      return questLocationId;
    }
    return null;
  }

  Widget _buildWelcome(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('⚔', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text('侠', style: theme.textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text('江湖路远，且行且珍惜', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                final created = await pushSmoothPage<bool>(
                  context,
                  const CharacterCreatePage(),
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
            pushSmoothPage(context, CharacterDetailPage(character: character));
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
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
            color: AppColors.primaryDark.withValues(alpha: 0.28),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
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
                    pushSmoothPage(context, const MinePage());
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
                  pushSmoothPage(context, const DungeonListPage());
                }, hint: '洞府挑战'),
                _actionButton(Icons.people, '交谈', () {
                  pushSmoothPage(context, const NpcListPage());
                }, hint: 'NPC互动'),
                _actionButton(Icons.inventory_2, '背包', () {
                  pushSmoothPage(context, const InventoryPage());
                }, hint: '物品/装备'),
                _actionButton(Icons.auto_stories, '技能', () {
                  pushSmoothPage(context, const SkillPage());
                }, hint: '修炼与装备'),
                _actionButton(
                  Icons.assignment,
                  '任务',
                  () {
                    _openQuestPanel();
                  },
                  onLongPress: _openQuestQuickPreview,
                  hint: '长按看当前主线',
                ),
                _actionButton(Icons.temple_buddhist, '师门', () {
                  pushSmoothPage(context, const SectPage());
                }, hint: '拜师学艺'),
                _actionButton(Icons.map, '地图', () {
                  pushSmoothPage(context, const MapPage());
                }, hint: '切换地点'),
                _actionButton(Icons.assignment_late, '江湖令', () {
                  _openJianghuOrders(character);
                }, hint: '悬赏与押镖'),
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
                  pushSmoothPage(context, const GuidePage());
                }, hint: '新手攻略'),
              ],
            ),
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
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
      return;
    }

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    _removeActionTipOverlay();
    _actionTipOverlay = OverlayEntry(
      builder: (overlayContext) => Positioned(
        left: 16,
        right: 16,
        bottom: 24 + MediaQuery.of(overlayContext).viewInsets.bottom,
        child: IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_actionTipOverlay!);
    _actionTipTimer = Timer(
      const Duration(seconds: 2),
      _removeActionTipOverlay,
    );
  }

  void _removeActionTipOverlay() {
    _actionTipTimer?.cancel();
    _actionTipTimer = null;
    _actionTipOverlay?.remove();
    _actionTipOverlay = null;
  }

  String _itemLabel(String itemId, {int count = 1}) {
    final name = items[itemId]?.name ?? itemId;
    return count > 1 ? '$name x$count' : name;
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

  Future<void> _openJianghuOrders(dynamic character) async {
    var contracts = _generateBountyContracts(character);
    var chainPlan = buildChainHuntPlan(
      tierIndex: character.realmTierIndex,
      rng: _rng,
    );
    var marketOffers = generateBlackMarketOffers(
      tierIndex: character.realmTierIndex,
      rng: _rng,
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final luck = totalLuck(character);
            final firstEnemyName =
                enemies[chainPlan.firstEnemyId]?.name ?? chainPlan.firstEnemyId;
            final secondEnemyName =
                enemies[chainPlan.secondEnemyId]?.name ??
                chainPlan.secondEnemyId;
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                children: [
                  Text(
                    '江湖令',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '单机玩法：接悬赏、跑押镖、巡防缉盗、连环剿匪、黑市奇货。风险越高，收益越高。',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '悬赏榜（随机）',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setSheetState(() {
                            contracts = _generateBountyContracts(character);
                          });
                        },
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('刷新'),
                      ),
                    ],
                  ),
                  ...contracts.map(
                    (contract) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    contract.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning.withValues(
                                      alpha: 0.16,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    contract.tierLabel,
                                    style: TextStyle(
                                      color: AppColors.warning,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              contract.brief,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildMiniTag(
                                  Icons.flash_on,
                                  '奖励经验 +${contract.bonusExp}',
                                ),
                                _buildMiniTag(
                                  Icons.monetization_on,
                                  '奖励银两 +${contract.bonusSilver}',
                                ),
                                if (contract.bonusItemId != null)
                                  _buildMiniTag(
                                    Icons.inventory_2,
                                    '奖励 ${items[contract.bonusItemId]?.name ?? contract.bonusItemId}',
                                  ),
                                _buildMiniTag(
                                  Icons.local_fire_department,
                                  '体力消耗 ${contract.staminaCost}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(sheetContext).pop();
                                  Future<void>.delayed(
                                    const Duration(milliseconds: 120),
                                    () => _startBountyContract(contract),
                                  );
                                },
                                icon: const Icon(Icons.gavel, size: 16),
                                label: const Text('接取悬赏'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '跑镖委托',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '护送商队穿越险路，按速度和运气判定成败。',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildMiniTag(
                                Icons.local_fire_department,
                                '体力消耗 $escortStaminaCost',
                              ),
                              _buildMiniTag(Icons.attach_money, '奖励：银两/经验/矿料'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                                Future<void>.delayed(
                                  const Duration(milliseconds: 120),
                                  _startEscortMission,
                                );
                              },
                              icon: const Icon(Icons.local_shipping, size: 16),
                              label: const Text('开始押镖'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '巡防缉盗',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '按当前地点危险度巡防，可能平稳结案，也可能遭遇伏击。',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildMiniTag(
                                Icons.local_fire_department,
                                '体力消耗 $patrolStaminaCost',
                              ),
                              _buildMiniTag(Icons.security, '奖励：经验/银两/锻造材料'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                                Future<void>.delayed(
                                  const Duration(milliseconds: 120),
                                  _startPatrolMission,
                                );
                              },
                              icon: const Icon(Icons.shield, size: 16),
                              label: const Text('开始巡防'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '连环剿匪',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setSheetState(() {
                            chainPlan = buildChainHuntPlan(
                              tierIndex: character.realmTierIndex,
                              rng: _rng,
                            );
                          });
                        },
                        icon: const Icon(Icons.shuffle, size: 16),
                        label: const Text('换目标'),
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '连续清剿两路匪患，首战得基础赏金，终战领取重赏。',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _buildMiniTag(
                                Icons.sports_martial_arts,
                                '首战：$firstEnemyName',
                              ),
                              _buildMiniTag(
                                Icons.whatshot,
                                '终战：$secondEnemyName',
                              ),
                              _buildMiniTag(
                                Icons.flash_on,
                                '终战奖励经验 +${chainPlan.finalExp}',
                              ),
                              _buildMiniTag(
                                Icons.monetization_on,
                                '终战奖励银两 +${chainPlan.finalSilver}',
                              ),
                              if (chainPlan.finalItemId != null)
                                _buildMiniTag(
                                  Icons.inventory_2,
                                  '终战奖励 ${_itemLabel(chainPlan.finalItemId!)}',
                                ),
                              _buildMiniTag(
                                Icons.local_fire_department,
                                '体力消耗 $chainHuntStaminaCost',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(sheetContext).pop();
                                Future<void>.delayed(
                                  const Duration(milliseconds: 120),
                                  () => _startChainHunt(chainPlan),
                                );
                              },
                              icon: const Icon(Icons.bolt, size: 16),
                              label: const Text('开始连环剿匪'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '黑市奇货',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          setSheetState(() {
                            marketOffers = generateBlackMarketOffers(
                              tierIndex: character.realmTierIndex,
                              rng: _rng,
                            );
                          });
                        },
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('换一批'),
                      ),
                    ],
                  ),
                  ...marketOffers.map((offer) {
                    final bonusChance =
                        (blackMarketBonusChance(
                                  baseRate: offer.bonusBaseRate,
                                  luck: luck,
                                ) *
                                100)
                            .round();
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              offer.brief,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildMiniTag(
                                  Icons.inventory_2,
                                  '保底 ${_itemLabel(offer.rewardItemId, count: offer.rewardCount)}',
                                ),
                                if (offer.bonusItemId != null &&
                                    offer.bonusCount > 0)
                                  _buildMiniTag(
                                    Icons.card_giftcard,
                                    '暗格 ${_itemLabel(offer.bonusItemId!, count: offer.bonusCount)} · 概率$bonusChance%',
                                  ),
                                _buildMiniTag(
                                  Icons.monetization_on,
                                  '售价 ${offer.silverCost} 银两',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(sheetContext).pop();
                                  Future<void>.delayed(
                                    const Duration(milliseconds: 120),
                                    () => _buyBlackMarketOffer(offer),
                                  );
                                },
                                icon: const Icon(Icons.storefront, size: 16),
                                label: const Text('立刻购买'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMiniTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  List<_BountyContract> _generateBountyContracts(dynamic character) {
    final tierIndex = character.realmTierIndex as int;
    final pools = selectBountyEnemyPool(tierIndex);
    final pool = List<String>.from(pools)..shuffle(_rng);
    final takeCount = min(3, pool.length);
    final selected = pool.take(takeCount).toList();

    final contracts = <_BountyContract>[];
    for (var i = 0; i < selected.length; i++) {
      final enemyId = selected[i];
      final enemy = enemies[enemyId];
      if (enemy == null) continue;

      final tier = i + 1;
      final rule = buildBountyRule(enemy: enemy, tier: tier, rng: _rng);

      contracts.add(
        _BountyContract(
          enemyId: enemyId,
          title: '悬赏${enemy.name}',
          brief: '目标：${enemy.name}（威胁阶 ${enemy.atk ~/ 10 + 1}）',
          tierLabel: '令阶$tier',
          staminaCost: rule.staminaCost,
          bonusExp: rule.bonusExp,
          bonusSilver: rule.bonusSilver,
          bonusItemId: rule.bonusItemId,
        ),
      );
    }
    return contracts;
  }

  Future<void> _startBountyContract(_BountyContract contract) async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final consumeOk = await ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(character.id, contract.staminaCost);
    if (!consumeOk) {
      _showActionTip('体力不足，无法接取悬赏');
      return;
    }

    ref
        .read(gameLogProvider.notifier)
        .addLog('你接下了${contract.title}。', type: LogType.quest);

    if (!mounted) return;
    final won = await pushSmoothPage<bool>(
      context,
      BattlePage(enemyId: contract.enemyId),
    );
    if (won != true) {
      ref
          .read(gameLogProvider.notifier)
          .addLog('悬赏行动失利，你暂且退回整理伤势。', type: LogType.quest);
      _showActionTip('悬赏未完成');
      return;
    }

    applyEventRewards(
      ref,
      exp: contract.bonusExp,
      silver: contract.bonusSilver,
      itemId: contract.bonusItemId,
    );
    ref
        .read(gameLogProvider.notifier)
        .addLog(
          '完成${contract.title}，领取悬赏：经验+${contract.bonusExp}，银两+${contract.bonusSilver}'
          '${contract.bonusItemId == null ? '' : '，额外物资已入袋'}。',
          type: LogType.quest,
        );
    _showActionTip('悬赏完成，奖励已结算');
  }

  Future<void> _startEscortMission() async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final consumeOk = await ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(character.id, escortStaminaCost);
    if (!consumeOk) {
      _showActionTip('体力不足，无法押镖');
      return;
    }

    final speed = totalSpeed(character);
    final luck = totalLuck(character);
    final defense = totalDef(character);
    final outcome = rollEscortOutcome(
      speed: speed,
      luck: luck,
      defense: defense,
      currentSilver: character.silver,
      rng: _rng,
    );

    if (outcome.success) {
      applyEventRewards(
        ref,
        exp: outcome.expDelta,
        silver: outcome.silverDelta,
        itemId: outcome.rewardItemId,
      );
      ref
          .read(gameLogProvider.notifier)
          .addLog(
            '押镖顺利抵达，商队当场结清酬金。'
            '${outcome.rewardItemId == null ? '' : ' 你还额外拿到了一份锻材。'}',
            type: LogType.explore,
          );
      _showActionTip('押镖成功：经验+${outcome.expDelta}，银两+${outcome.silverDelta}');
      return;
    }

    final silverLoss = -outcome.silverDelta;
    await ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: character.id,
          currentHp: (character.currentHp - outcome.hpLoss).clamp(
            1,
            totalMaxHp(character),
          ),
          silver: character.silver - silverLoss,
        );
    ref
        .read(gameLogProvider.notifier)
        .addLog('押镖途中遭遇伏击，虽保住性命，但损失了部分财货。', type: LogType.combat);
    _showActionTip('押镖失利：气血-${outcome.hpLoss}，银两-$silverLoss');
  }

  Future<void> _startPatrolMission() async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final consumeOk = await ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(character.id, patrolStaminaCost);
    if (!consumeOk) {
      _showActionTip('体力不足，无法巡防');
      return;
    }

    final location = ref.read(currentLocationProvider);
    final dangerLevel = location?.dangerLevel ?? 3;
    final speed = totalSpeed(character);
    final luck = totalLuck(character);
    final defense = totalDef(character);

    final outcome = rollPatrolOutcome(
      tierIndex: character.realmTierIndex,
      dangerLevel: dangerLevel,
      speed: speed,
      luck: luck,
      defense: defense,
      currentSilver: character.silver,
      rng: _rng,
    );

    if (outcome.requiresBattle && outcome.enemyId != null) {
      final enemyName = enemies[outcome.enemyId!]?.name ?? outcome.enemyId!;
      ref
          .read(gameLogProvider.notifier)
          .addLog('巡防途中发现$enemyName拦路，你当即拔兵器迎战。', type: LogType.combat);

      if (!mounted) return;
      final won = await pushSmoothPage<bool>(
        context,
        BattlePage(enemyId: outcome.enemyId!),
      );
      if (won == true) {
        applyEventRewards(
          ref,
          exp: outcome.successExp,
          silver: outcome.successSilver,
          itemId: outcome.successItemId,
        );
        ref
            .read(gameLogProvider.notifier)
            .addLog('巡防清剿成功，地头行商纷纷送上谢礼。', type: LogType.quest);
        _showActionTip(
          '巡防成功：经验+${outcome.successExp}，银两+${outcome.successSilver}',
        );
      } else {
        await ref
            .read(characterNotifierProvider.notifier)
            .updateStats(
              characterId: character.id,
              currentHp: (character.currentHp - outcome.failureHpLoss).clamp(
                1,
                totalMaxHp(character),
              ),
              silver: character.silver - outcome.failureSilverLoss,
            );
        ref
            .read(gameLogProvider.notifier)
            .addLog('巡防遭伏击失利，你只能先行撤回。', type: LogType.combat);
        _showActionTip(
          '巡防失利：气血-${outcome.failureHpLoss}，银两-${outcome.failureSilverLoss}',
        );
      }
      return;
    }

    if (outcome.autoSuccess) {
      applyEventRewards(
        ref,
        exp: outcome.successExp,
        silver: outcome.successSilver,
        itemId: outcome.successItemId,
      );
      ref
          .read(gameLogProvider.notifier)
          .addLog('巡防顺利结案，沿路商户主动上缴赏金。', type: LogType.quest);
      _showActionTip(
        '巡防成功：经验+${outcome.successExp}，银两+${outcome.successSilver}',
      );
      return;
    }

    await ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: character.id,
          currentHp: (character.currentHp - outcome.failureHpLoss).clamp(
            1,
            totalMaxHp(character),
          ),
          silver: character.silver - outcome.failureSilverLoss,
        );
    ref
        .read(gameLogProvider.notifier)
        .addLog('巡防未能拿下目标，沿途还折损了补给。', type: LogType.combat);
    _showActionTip(
      '巡防失利：气血-${outcome.failureHpLoss}，银两-${outcome.failureSilverLoss}',
    );
  }

  Future<void> _startChainHunt(ChainHuntPlan plan) async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    final consumeOk = await charNotifier.consumeStamina(
      character.id,
      chainHuntStaminaCost,
    );
    if (!consumeOk) {
      _showActionTip('体力不足，无法开启连环剿匪');
      return;
    }

    final firstEnemyName =
        enemies[plan.firstEnemyId]?.name ?? plan.firstEnemyId;
    final secondEnemyName =
        enemies[plan.secondEnemyId]?.name ?? plan.secondEnemyId;
    logNotifier.addLog(
      '你接下连环剿匪：先清剿$firstEnemyName，再追击$secondEnemyName。',
      type: LogType.quest,
    );

    if (!mounted) return;
    final firstWon = await pushSmoothPage<bool>(
      context,
      BattlePage(enemyId: plan.firstEnemyId),
    );
    if (firstWon != true) {
      logNotifier.addLog('连环剿匪首战失利，行动被迫中断。', type: LogType.combat);
      _showActionTip('连环剿匪中断：首战失利');
      return;
    }

    applyEventRewards(ref, exp: plan.stageOneExp, silver: plan.stageOneSilver);
    logNotifier.addLog(
      '首战告捷，先行领取赏金：经验+${plan.stageOneExp}，银两+${plan.stageOneSilver}。',
      type: LogType.quest,
    );

    if (!mounted) return;
    final secondWon = await pushSmoothPage<bool>(
      context,
      BattlePage(enemyId: plan.secondEnemyId),
    );
    if (secondWon != true) {
      final latestCharacter = ref.read(currentCharacterProvider).valueOrNull;
      var silverPenalty = 0;
      if (latestCharacter != null) {
        silverPenalty = min(
          latestCharacter.silver,
          max(12, plan.finalSilver ~/ 4),
        );
        if (silverPenalty > 0) {
          await charNotifier.updateStats(
            characterId: latestCharacter.id,
            silver: latestCharacter.silver - silverPenalty,
          );
        }
      }
      logNotifier.addLog(
        '终战失利，剿匪队伍折损补给${silverPenalty > 0 ? '（银两-$silverPenalty）' : ''}。',
        type: LogType.combat,
      );
      _showActionTip(
        '终战失利：损失补给${silverPenalty > 0 ? '（银两-$silverPenalty）' : ''}',
      );
      return;
    }

    applyEventRewards(
      ref,
      exp: plan.finalExp,
      silver: plan.finalSilver,
      itemId: plan.finalItemId,
    );
    logNotifier.addLog(
      '连环剿匪完成：经验+${plan.finalExp}，银两+${plan.finalSilver}'
      '${plan.finalItemId == null ? '' : '，缴获${_itemLabel(plan.finalItemId!)}'}。',
      type: LogType.quest,
    );
    _showActionTip('连环剿匪完成：经验+${plan.finalExp}，银两+${plan.finalSilver}');
  }

  Future<void> _buyBlackMarketOffer(BlackMarketOffer offer) async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    if (character.silver < offer.silverCost) {
      _showActionTip('银两不足，无法购买${offer.title}');
      return;
    }

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final invNotifier = ref.read(inventoryNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    await charNotifier.updateStats(
      characterId: character.id,
      silver: character.silver - offer.silverCost,
    );
    await invNotifier.addItem(
      character.id,
      offer.rewardItemId,
      count: offer.rewardCount,
    );

    final luck = totalLuck(character);
    final gotBonus = rollBlackMarketBonus(offer: offer, luck: luck, rng: _rng);
    if (gotBonus && offer.bonusItemId != null && offer.bonusCount > 0) {
      await invNotifier.addItem(
        character.id,
        offer.bonusItemId!,
        count: offer.bonusCount,
      );
    }

    final guaranteedText = _itemLabel(
      offer.rewardItemId,
      count: offer.rewardCount,
    );
    final bonusText = gotBonus && offer.bonusItemId != null
        ? '，暗格额外拿到${_itemLabel(offer.bonusItemId!, count: offer.bonusCount)}'
        : '';
    logNotifier.addLog(
      '黑市成交：${offer.title}（银两-${offer.silverCost}），获得$guaranteedText$bonusText。',
      type: LogType.item,
    );
    _showActionTip(
      '黑市成交：$guaranteedText${gotBonus && offer.bonusItemId != null ? ' + 暗格奖励' : ''}',
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

    final labelLen = label.runes.length;
    final width = (70 + labelLen * 12 + (staminaCost != null ? 22 : 0))
        .toDouble()
        .clamp(78.0, 112.0);

    final borderColor = canTap
        ? Colors.white.withValues(alpha: 0.16)
        : Colors.white.withValues(alpha: 0.08);
    final tileSurface = canTap
        ? Colors.white.withValues(alpha: 0.055)
        : Colors.white.withValues(alpha: 0.022);

    return SizedBox(
      width: width,
      child: Tooltip(
        message: tooltip,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 120),
          opacity: canTap ? 1 : 0.78,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onLongPress: canTap ? onLongPress : null,
              onTap: canTap
                  ? () {
                      GameAudio.tap();
                      HapticFeedback.selectionClick();
                      onTap();
                    }
                  : null,
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                  color: tileSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: canTap ? 0.08 : 0.035),
                      Colors.white.withValues(alpha: canTap ? 0.025 : 0.01),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: canTap
                            ? AppColors.accent.withValues(alpha: 0.14)
                            : AppColors.surfaceLight.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: canTap
                              ? AppColors.accent.withValues(alpha: 0.34)
                              : AppColors.primaryLight.withValues(alpha: 0.24),
                        ),
                      ),
                      child: Icon(
                        icon,
                        size: 13.5,
                        color: canTap
                            ? AppColors.textAccent.withValues(alpha: 0.96)
                            : AppColors.textSecondary.withValues(alpha: 0.62),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: canTap
                              ? AppColors.textPrimary
                              : AppColors.textSecondary.withValues(alpha: 0.72),
                          fontSize: 10.8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    if (staminaCost != null) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: canTap
                              ? AppColors.accent.withValues(alpha: 0.2)
                              : AppColors.surface.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '$staminaCost',
                          style: TextStyle(
                            color: canTap
                                ? AppColors.textAccent
                                : AppColors.textSecondary.withValues(
                                    alpha: 0.7,
                                  ),
                            fontSize: 7.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    if (onLongPress != null) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.repeat,
                        size: 9,
                        color: canTap
                            ? AppColors.textSecondary.withValues(alpha: 0.6)
                            : AppColors.textSecondary.withValues(alpha: 0.42),
                      ),
                    ],
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
                    Text(
                      '江湖秘技',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(height: 1, color: AppColors.primaryLight),
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

class _BountyContract {
  final String enemyId;
  final String title;
  final String brief;
  final String tierLabel;
  final int staminaCost;
  final int bonusExp;
  final int bonusSilver;
  final String? bonusItemId;

  const _BountyContract({
    required this.enemyId,
    required this.title,
    required this.brief,
    required this.tierLabel,
    required this.staminaCost,
    required this.bonusExp,
    required this.bonusSilver,
    this.bonusItemId,
  });
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
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            event.description,
            style: TextStyle(
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
                    style: TextStyle(color: AppColors.textPrimary, height: 1.6),
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
      pushSmoothPage(context, BattlePage(enemyId: choice.enemyId!));
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

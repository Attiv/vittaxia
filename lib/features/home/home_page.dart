import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vittaxia/core/theme/app_theme.dart';

import '../../models/game_event.dart';
import '../../models/game_event_data.dart';
import '../battle/battle_page.dart';
import '../character/character_create_page.dart';
import '../character/character_detail_page.dart';
import '../character/character_provider.dart';
import '../dialogue/npc_list_page.dart';
import '../explore/event_rewards.dart';
import '../explore/explore_provider.dart';
import '../idle/idle_calculator.dart';
import '../idle/idle_reward_dialog.dart';
import '../inventory/inventory_page.dart';
import '../map/map_page.dart';
import '../quest/quest_page.dart';
import '../skill/skill_page.dart';
import '../../shared/widgets/status_panel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _checkedIdleReward = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final characterAsync = ref.watch(currentCharacterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('维 塔 侠')),
      body: characterAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('出错了: $e')),
        data: (character) {
          if (character == null) {
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
    );
  }

  void _checkIdleReward(dynamic character) {
    if (character.lastOnlineTime == null) return;

    final reward = IdleCalculator.calculate(
      comprehension: character.baseComprehension,
      lastOnline: character.lastOnlineTime!,
    );

    if (reward.exp > 0) {
      // 发放经验
      ref
          .read(characterNotifierProvider.notifier)
          .updateStats(
            characterId: character.id,
            exp: character.exp + reward.exp,
          );
      ref
          .read(gameLogProvider.notifier)
          .addLog(
            '离线修炼 ${IdleCalculator.formatDuration(reward.minutesIdle)}，获得 ${reward.exp} 经验',
            type: LogType.system,
          );
      IdleRewardDialog.show(context, reward);
    }
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
        // 操作区
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
          child: Row(
            children: [
              _actionButton(Icons.explore, '探索', () {
                _doExplore(character);
              }),
              _actionButton(Icons.people, '交谈', () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const NpcListPage()));
              }),
              _actionButton(Icons.inventory_2, '背包', () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const InventoryPage()),
                );
              }),
              _actionButton(Icons.auto_stories, '技能', () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SkillPage()));
              }),
              _actionButton(Icons.assignment, '任务', () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const QuestPage()));
              }),
              _actionButton(Icons.map, '地图', () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const MapPage()));
              }),
            ],
          ),
        ),
      ],
    );
  }

  void _doExplore(dynamic character) {
    final engine = ref.read(eventEngineProvider);
    final logNotifier = ref.read(gameLogProvider.notifier);
    final event = engine.rollEvent(character.locationId);

    if (event == null) {
      logNotifier.addLog('四下无事，一切平静。', type: LogType.explore);
      return;
    }

    logNotifier.addLog('${event.name}...', type: LogType.explore);

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

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.accent, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
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
                      _rewardLine('经验 +${_selectedChoice!.rewardExp}', AppColors.exp),
                    if (_selectedChoice!.rewardSilver > 0)
                      _rewardLine('银两 +${_selectedChoice!.rewardSilver}', AppColors.accent),
                    if (_selectedChoice!.hpChange != 0)
                      _rewardLine(
                        '气血 ${_selectedChoice!.hpChange > 0 ? "+" : ""}${_selectedChoice!.hpChange}',
                        _selectedChoice!.hpChange > 0 ? AppColors.success : AppColors.danger,
                      ),
                    if (_selectedChoice!.rewardItemId != null)
                      _rewardLine('获得物品', AppColors.accent),
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
              ...event.choices.map((choice) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () => _resolveChoice(choice),
                      child: Text(choice.text),
                    ),
                  )),
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
        MaterialPageRoute(
          builder: (_) => BattlePage(enemyId: choice.enemyId!),
        ),
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

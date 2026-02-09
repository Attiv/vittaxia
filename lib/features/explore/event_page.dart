import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/game_event_data.dart';
import '../battle/battle_page.dart';
import 'event_rewards.dart';

/// 随机事件弹出页面
class EventPage extends ConsumerWidget {
  final GameEventData event;

  const EventPage({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(event.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 事件描述
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  event.description,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 选项
            if (event.choices.isNotEmpty)
              ...event.choices.map((choice) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () =>
                          _resolveChoice(context, ref, choice),
                      child: Text(choice.text),
                    ),
                  )),

            // 无选项时直接关闭
            if (event.choices.isEmpty)
              ElevatedButton(
                onPressed: () {
                  _applyRewards(ref, event.rewardExp, event.rewardSilver,
                      event.rewardItemId, null);
                  Navigator.of(context).pop();
                },
                child: const Text('继续'),
              ),
          ],
        ),
      ),
    );
  }

  void _resolveChoice(
      BuildContext context, WidgetRef ref, EventChoice choice) {
    // 触发战斗的选项直接跳转战斗页
    if (choice.triggerBattle && choice.enemyId != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BattlePage(enemyId: choice.enemyId!),
        ),
      );
      return;
    }

    // 显示结果
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(event.name,
            style: const TextStyle(color: AppColors.accent)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(choice.resultText,
                style: const TextStyle(
                    color: AppColors.textPrimary, height: 1.6)),
            const SizedBox(height: 16),
            if (choice.rewardExp > 0)
              _rewardLine('经验 +${choice.rewardExp}', AppColors.exp),
            if (choice.rewardSilver > 0)
              _rewardLine('银两 +${choice.rewardSilver}', AppColors.accent),
            if (choice.hpChange != 0)
              _rewardLine(
                '气血 ${choice.hpChange > 0 ? "+" : ""}${choice.hpChange}',
                choice.hpChange > 0 ? AppColors.success : AppColors.danger,
              ),
            if (choice.rewardItemId != null)
              _rewardLine('获得物品', AppColors.accent),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _applyRewards(ref, choice.rewardExp, choice.rewardSilver,
                  choice.rewardItemId, choice.hpChange != 0 ? choice.hpChange : null);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  Widget _rewardLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text, style: TextStyle(color: color, fontSize: 14)),
    );
  }

  void _applyRewards(
    WidgetRef ref,
    int exp,
    int silver,
    String? itemId,
    int? hpChange,
  ) {
    applyEventRewards(
      ref,
      exp: exp,
      silver: silver,
      itemId: itemId,
      hpChange: hpChange,
    );
  }
}

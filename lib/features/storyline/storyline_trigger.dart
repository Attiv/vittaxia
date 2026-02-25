import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/storyline_progress.dart';
import '../../core/theme/app_theme.dart';
import 'storyline_provider.dart';
import 'storyline_page.dart';

/// 剧情触发器 - 在特定条件下自动触发剧情
class StorylineTrigger {
  /// 检查并触发剧情（在角色升级时调用）
  static void checkLevelUpTrigger(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    int oldLevel,
    int newLevel,
  ) {
    // 检查是否有新剧情解锁
    for (final type in StorylineType.values) {
      final unlockLevel = StorylineConfig.unlockLevel[type] ?? 0;
      if (oldLevel < unlockLevel && newLevel >= unlockLevel) {
        // 延迟显示，避免与升级提示冲突
        Future.delayed(const Duration(milliseconds: 500), () {
          _showStorylineUnlockDialog(context, ref, characterId, type);
        });
        break; // 一次只提示一个
      }
    }
  }

  /// 检查并触发剧情（在完成任务时调用）
  static void checkQuestCompleteTrigger(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    String questId,
  ) {
    // 检查是否触发新剧情
    switch (questId) {
      case 'main_03': // 完成主线第3章
        _suggestStoryline(context, ref, characterId, StorylineType.corrupt);
        break;
      case 'main_05': // 完成主线第5章
        _suggestStoryline(context, ref, characterId, StorylineType.protection);
        break;
      // 可以添加更多触发条件
    }
  }

  /// 检查并触发剧情（在到达新地点时调用）
  static void checkLocationTrigger(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    String locationId,
  ) {
    switch (locationId) {
      case 'capital_city': // 首次到达京城
        _suggestStoryline(context, ref, characterId, StorylineType.palace);
        break;
      case 'tianjian_gate': // 首次到达天剑门
        _suggestStoryline(context, ref, characterId, StorylineType.sect);
        break;
    }
  }

  /// 检查并触发剧情（在NPC好感度提升时调用）
  static void checkAffectionTrigger(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    String npcId,
    int affection,
  ) {
    // 好感度达到50时触发爱情线
    if (affection >= 50) {
      switch (npcId) {
        case 'su_wanyin':
          _suggestStoryline(context, ref, characterId, StorylineType.romance);
          break;
        case 'liu_ruyan':
          _suggestStoryline(context, ref, characterId, StorylineType.romance);
          break;
        case 'princess_mingzhu':
          _suggestStoryline(context, ref, characterId, StorylineType.romance);
          break;
      }
    }
  }

  /// 显示剧情解锁对话框
  static void _showStorylineUnlockDialog(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    StorylineType type,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lock_open, color: AppColors.success, size: 28),
            const SizedBox(width: 12),
            const Text('剧情解锁'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.2),
                    AppColors.accent.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _getStorylineIcon(type),
                    size: 48,
                    color: AppColors.accent,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    type.label,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              StorylineConfig.descriptions[type] ?? '',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('稍后查看'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StorylinePage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
            ),
            child: const Text('立即查看'),
          ),
        ],
      ),
    );
  }

  /// 建议开始剧情
  static void _suggestStoryline(
    BuildContext context,
    WidgetRef ref,
    String characterId,
    StorylineType type,
  ) {
    // 检查是否已经开始
    final progress = ref.read(storylineProgressProvider(type));
    if (progress != null) return; // 已经开始，不再提示

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.auto_stories, color: AppColors.accent, size: 24),
            const SizedBox(width: 8),
            const Text('触发剧情'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '检测到可以开始新剧情：',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              type.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              StorylineConfig.descriptions[type] ?? '',
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('暂不开始'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(storylineProvider.notifier).startStoryline(
                    characterId,
                    type,
                  );
              // 显示开始提示
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('开始剧情：${type.label}'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            child: const Text('开始剧情'),
          ),
        ],
      ),
    );
  }

  static IconData _getStorylineIcon(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return Icons.gavel;
      case StorylineType.protection:
        return Icons.shield;
      case StorylineType.revenge:
        return Icons.flash_on;
      case StorylineType.palace:
        return Icons.account_balance;
      case StorylineType.sect:
        return Icons.temple_buddhist;
      case StorylineType.martial:
        return Icons.emoji_events;
      case StorylineType.demon:
        return Icons.whatshot;
      case StorylineType.romance:
        return Icons.favorite;
      case StorylineType.master:
        return Icons.school;
      case StorylineType.ancient:
        return Icons.auto_awesome;
    }
  }
}

/// 剧情进度提示组件 - 显示在主页
class StorylineProgressHint extends ConsumerWidget {
  const StorylineProgressHint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    if (character == null) return const SizedBox.shrink();

    final storylines = ref.watch(storylineProvider).valueOrNull ?? [];
    final inProgress = storylines.where(
      (s) => s.characterId == character.id && !s.isCompleted,
    ).toList();

    if (inProgress.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StorylinePage(),
            ),
          );
        },
        child: Row(
          children: [
            Icon(Icons.auto_stories, color: AppColors.accent, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '进行中的剧情',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${inProgress.length}条剧情正在进行',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

/// 剧情快捷入口组件 - 显示最近的剧情任务
class StorylineQuickAccess extends ConsumerWidget {
  const StorylineQuickAccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    if (character == null) return const SizedBox.shrink();

    final storylines = ref.watch(storylineProvider).valueOrNull ?? [];
    final inProgress = storylines.where(
      (s) => s.characterId == character.id && !s.isCompleted,
    ).toList();

    if (inProgress.isEmpty) return const SizedBox.shrink();

    // 显示最近的一条剧情
    final latest = inProgress.first;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StorylinePage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getStorylineIcon(latest.type),
                    color: AppColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      latest.type.label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '进行中',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: latest.currentChapter / latest.totalChapters,
                      backgroundColor: AppColors.surface,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '第${latest.currentChapter}/${latest.totalChapters}章',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getStorylineIcon(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return Icons.gavel;
      case StorylineType.protection:
        return Icons.shield;
      case StorylineType.revenge:
        return Icons.flash_on;
      case StorylineType.palace:
        return Icons.account_balance;
      case StorylineType.sect:
        return Icons.temple_buddhist;
      case StorylineType.martial:
        return Icons.emoji_events;
      case StorylineType.demon:
        return Icons.whatshot;
      case StorylineType.romance:
        return Icons.favorite;
      case StorylineType.master:
        return Icons.school;
      case StorylineType.ancient:
        return Icons.auto_awesome;
    }
  }
}

/// 剧情通知管理器
class StorylineNotificationManager {
  /// 显示章节完成通知
  static void showChapterCompleteNotification(
    BuildContext context,
    StorylineType type,
    int chapter,
    int totalChapters,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text('${type.label} - 第$chapter章完成！'),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: '查看',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StorylinePage(),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 显示剧情完成通知
  static void showStorylineCompleteNotification(
    BuildContext context,
    StorylineType type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '恭喜完成《${type.label}》！',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.warning,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// 显示新剧情可用通知
  static void showNewStorylineNotification(
    BuildContext context,
    StorylineType type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.new_releases, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text('新剧情可用：${type.label}'),
            ),
          ],
        ),
        backgroundColor: AppColors.accent,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: '查看',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StorylinePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

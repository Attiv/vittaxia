import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/storyline_progress.dart';

/// 剧情选择对话框 - 当任务有分支时显示
class StorylineChoiceDialog extends StatefulWidget {
  final String questName;
  final List<StorylineBranchOption> options;
  final Function(String branchId) onChoiceSelected;

  const StorylineChoiceDialog({
    super.key,
    required this.questName,
    required this.options,
    required this.onChoiceSelected,
  });

  @override
  State<StorylineChoiceDialog> createState() => _StorylineChoiceDialogState();
}

class _StorylineChoiceDialogState extends State<StorylineChoiceDialog> {
  String? selectedBranchId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.alt_route, color: AppColors.warning, size: 24),
              const SizedBox(width: 8),
              const Text('剧情分支'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.questName,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: AppColors.warning,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '你的选择将影响剧情走向，请谨慎选择！',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...widget.options.map((option) {
              final isSelected = selectedBranchId == option.branchId;
              return _buildOptionCard(option, isSelected);
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: selectedBranchId == null
              ? null
              : () {
                  widget.onChoiceSelected(selectedBranchId!);
                  Navigator.of(context).pop();
                },
          child: const Text('确认选择'),
        ),
      ],
    );
  }

  Widget _buildOptionCard(StorylineBranchOption option, bool isSelected) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected
          ? AppColors.accent.withValues(alpha: 0.1)
          : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected
              ? AppColors.accent
              : AppColors.primaryLight.withValues(alpha: 0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => selectedBranchId = option.branchId),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isSelected ? AppColors.accent : AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      option.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.accent
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                option.description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              if (option.consequences.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...option.consequences.map((consequence) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          _getConsequenceIcon(consequence.type),
                          size: 14,
                          color: _getConsequenceColor(consequence.type),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            consequence.text,
                            style: TextStyle(
                              fontSize: 11,
                              color: _getConsequenceColor(consequence.type),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getConsequenceIcon(ConsequenceType type) {
    switch (type) {
      case ConsequenceType.reward:
        return Icons.star;
      case ConsequenceType.risk:
        return Icons.warning;
      case ConsequenceType.relationship:
        return Icons.favorite;
      case ConsequenceType.reputation:
        return Icons.trending_up;
    }
  }

  Color _getConsequenceColor(ConsequenceType type) {
    switch (type) {
      case ConsequenceType.reward:
        return AppColors.success;
      case ConsequenceType.risk:
        return AppColors.danger;
      case ConsequenceType.relationship:
        return const Color(0xFFE91E63);
      case ConsequenceType.reputation:
        return AppColors.exp;
    }
  }
}

/// 剧情分支选项
class StorylineBranchOption {
  final String branchId;
  final String name;
  final String description;
  final List<BranchConsequence> consequences;

  const StorylineBranchOption({
    required this.branchId,
    required this.name,
    required this.description,
    this.consequences = const [],
  });
}

/// 分支后果类型
enum ConsequenceType {
  reward, // 奖励
  risk, // 风险
  relationship, // 关系影响
  reputation, // 声望影响
}

/// 分支后果
class BranchConsequence {
  final ConsequenceType type;
  final String text;

  const BranchConsequence({
    required this.type,
    required this.text,
  });
}

/// 剧情完成对话框
class StorylineCompletionDialog extends StatelessWidget {
  final StorylineType type;
  final String endingName;
  final String endingDescription;
  final List<String> rewards;

  const StorylineCompletionDialog({
    super.key,
    required this.type,
    required this.endingName,
    required this.endingDescription,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Icon(
            Icons.emoji_events,
            color: AppColors.warning,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            '剧情完成',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.warning,
                      AppColors.warning.withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '结局：$endingName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              endingDescription,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              '获得奖励',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 12),
            ...rewards.map((reward) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        reward,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
          ),
          child: const Text('太好了！'),
        ),
      ],
    );
  }
}

/// 剧情回顾页面
class StorylineReviewPage extends ConsumerWidget {
  final StorylineType type;

  const StorylineReviewPage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${type.label} - 剧情回顾'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTimelineItem(
            '第一章',
            '民不聊生',
            '了解了赵知县的恶行，决定帮助百姓。',
            true,
            AppColors.success,
          ),
          _buildTimelineItem(
            '第二章',
            '暗中调查',
            '收集了赵知县贪污的证据。',
            true,
            AppColors.success,
          ),
          _buildTimelineItem(
            '第三章',
            '山贼勾结',
            '发现赵知县与山贼勾结。',
            true,
            AppColors.success,
          ),
          _buildTimelineItem(
            '第四章',
            '卧底身份',
            '二当家协助，击败了黑风。',
            false,
            AppColors.textSecondary,
          ),
          _buildTimelineItem(
            '第五章',
            '捕头阻挠',
            '尚未开始',
            false,
            AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String chapter,
    String title,
    String description,
    bool isCompleted,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted
                    ? color
                    : AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      )
                    : Icon(
                        Icons.circle,
                        color: color,
                        size: 12,
                      ),
              ),
            ),
            Container(
              width: 2,
              height: 60,
              color: color.withValues(alpha: 0.3),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chapter,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCompleted
                      ? AppColors.accent
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

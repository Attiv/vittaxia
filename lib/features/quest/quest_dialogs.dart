import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/quest.dart';
import '../../shared/widgets/wuxia_widgets.dart';

/// 任务接取确认弹窗
Future<bool?> showQuestAcceptDialog(BuildContext context, Quest quest) {
  return WuxiaDialog.show<bool>(
    context: context,
    title: quest.name,
    icon: Icons.assignment,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WuxiaTag(
          text: quest.type.label,
          color: _getQuestTypeColor(quest.type),
          icon: Icons.label,
        ),
        const SizedBox(height: 16),
        Text(quest.description, style: TextStyle(fontSize: 14, height: 1.6)),
        const SizedBox(height: 16),
        Text(
          '任务目标',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        ...quest.objectives.map(
          (obj) => Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_right, size: 18, color: AppColors.accent),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${obj.description} ${obj.requiredCount > 1 ? "(${obj.requiredCount})" : ""}',
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildRewardSection(quest),
      ],
    ),
    actions: [
      WuxiaButton(
        text: '取消',
        isOutlined: true,
        color: AppColors.textSecondary,
        onPressed: () => Navigator.of(context).pop(false),
      ),
      const SizedBox(width: 12),
      WuxiaButton(
        text: '接取任务',
        icon: Icons.check,
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  );
}

/// 任务完成奖励弹窗
Future<void> showQuestCompleteDialog(BuildContext context, Quest quest) {
  return WuxiaDialog.show(
    context: context,
    title: '任务完成',
    icon: Icons.check_circle,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 64),
              const SizedBox(height: 12),
              Text(
                quest.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildRewardSection(quest),
      ],
    ),
    actions: [
      WuxiaButton(
        text: '确定',
        icon: Icons.check,
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

Color _getQuestTypeColor(QuestType type) {
  return switch (type) {
    QuestType.main => AppColors.accent,
    QuestType.side => AppColors.mp,
    QuestType.hidden => const Color(0xFFAB47BC),
  };
}

/// 任务进度更新提示（轻量级）
void showQuestProgressSnackBar(
  BuildContext context,
  String questName,
  String objectiveDesc,
  int current,
  int required,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.assignment_turned_in, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(questName, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '$objectiveDesc ($current/$required)',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.accent.withValues(alpha: 0.9),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

Widget _buildRewardSection(Quest quest) {
  final rewards = <Widget>[];

  if (quest.rewardExp > 0) {
    rewards.add(
      _rewardItem(Icons.star, AppColors.exp, '经验', '+${quest.rewardExp}'),
    );
  }

  if (quest.rewardSilver > 0) {
    rewards.add(
      _rewardItem(
        Icons.monetization_on,
        AppColors.warning,
        '银两',
        '+${quest.rewardSilver}',
      ),
    );
  }

  if (quest.rewardReputation > 0) {
    rewards.add(
      _rewardItem(
        Icons.favorite,
        Colors.pink,
        '声望',
        '+${quest.rewardReputation}',
      ),
    );
  }

  if (quest.rewardItemId != null) {
    final item = items[quest.rewardItemId];
    rewards.add(
      _rewardItem(Icons.inventory_2, AppColors.accent, item?.name ?? '物品', ''),
    );
  }

  if (quest.rewardSkillId != null) {
    final skill = skills[quest.rewardSkillId];
    rewards.add(
      _rewardItem(Icons.auto_awesome, AppColors.mp, skill?.name ?? '技能', ''),
    );
  }

  if (rewards.isEmpty) {
    return const SizedBox.shrink();
  }

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '任务奖励',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 12, runSpacing: 8, children: rewards),
      ],
    ),
  );
}

Widget _rewardItem(IconData icon, Color color, String label, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 13)),
      if (value.isNotEmpty) ...[
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ],
  );
}

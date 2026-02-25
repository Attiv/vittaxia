import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/storyline_progress.dart';
import '../character/character_provider.dart';

/// 剧情线页面 - 显示所有可用的长线剧情
class StorylinePage extends ConsumerStatefulWidget {
  const StorylinePage({super.key});

  @override
  ConsumerState<StorylinePage> createState() => _StorylinePageState();
}

class _StorylinePageState extends ConsumerState<StorylinePage> {
  @override
  Widget build(BuildContext context) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    if (character == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('江湖剧情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showStorylineGuide(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('主要剧情'),
          _buildStorylineCard(
            context,
            StorylineType.corrupt,
            Icons.gavel,
            AppColors.danger,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.protection,
            Icons.shield,
            AppColors.success,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.revenge,
            Icons.flash_on,
            AppColors.warning,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.palace,
            Icons.account_balance,
            AppColors.accent,
            character,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('门派与江湖'),
          _buildStorylineCard(
            context,
            StorylineType.sect,
            Icons.temple_buddhist,
            AppColors.mp,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.martial,
            Icons.emoji_events,
            AppColors.warning,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.demon,
            Icons.whatshot,
            AppColors.danger,
            character,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('特殊剧情'),
          _buildStorylineCard(
            context,
            StorylineType.romance,
            Icons.favorite,
            const Color(0xFFE91E63),
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.master,
            Icons.school,
            AppColors.exp,
            character,
          ),
          _buildStorylineCard(
            context,
            StorylineType.ancient,
            Icons.auto_awesome,
            const Color(0xFF9C27B0),
            character,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
        ),
      ),
    );
  }

  Widget _buildStorylineCard(
    BuildContext context,
    StorylineType type,
    IconData icon,
    Color color,
    dynamic character,
  ) {
    final questIds = StorylineConfig.questSequence[type] ?? [];
    final totalChapters = questIds.length;
    final description = StorylineConfig.descriptions[type] ?? '';
    final unlockLevel = StorylineConfig.unlockLevel[type] ?? 0;

    // 简化：根据等级判断是否解锁
    final characterLevel = _getCharacterLevel(character);
    final isLocked = characterLevel < unlockLevel;

    // TODO: 从数据库读取实际进度
    final currentChapter = 0;
    final isCompleted = false;
    final isInProgress = currentChapter > 0 && !isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: isLocked
            ? null
            : () => _showStorylineDetail(context, type, color),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isLocked
                          ? AppColors.surface
                          : color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isLocked
                            ? AppColors.textSecondary.withValues(alpha: 0.3)
                            : color.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: isLocked ? AppColors.textSecondary : color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              type.label,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isLocked
                                    ? AppColors.textSecondary
                                    : AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isLocked)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.textSecondary
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Lv.$unlockLevel解锁',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            else if (isCompleted)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '已完成',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.success,
                                  ),
                                ),
                              )
                            else if (isInProgress)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '进行中',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: color,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalChapters章',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLocked)
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    )
                  else
                    Icon(
                      Icons.lock,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: isLocked
                      ? AppColors.textSecondary.withValues(alpha: 0.6)
                      : AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (isInProgress) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: currentChapter / totalChapters,
                        backgroundColor: AppColors.surface,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$currentChapter/$totalChapters',
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  int _getCharacterLevel(dynamic character) {
    // 简化：根据境界计算等级
    final realmTier = character.realmTierIndex;
    final realmStage = character.realmStageIndex;
    return realmTier * 10 + realmStage * 2;
  }

  void _showStorylineDetail(
    BuildContext context,
    StorylineType type,
    Color color,
  ) {
    final questIds = StorylineConfig.questSequence[type] ?? [];
    final description = StorylineConfig.descriptions[type] ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getStorylineIcon(type),
                      color: color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.label,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                        Text(
                          '共${questIds.length}章',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '剧情简介',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '章节列表',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(questIds.length, (index) {
                return _buildChapterItem(
                  index + 1,
                  _getChapterName(type, index),
                  color,
                  false, // TODO: 从数据库读取完成状态
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: 开始剧情
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('开始剧情：${type.label}'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  '开始剧情',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterItem(
    int chapter,
    String name,
    Color color,
    bool isCompleted,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? color.withValues(alpha: 0.1)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted
              ? color.withValues(alpha: 0.3)
              : AppColors.primaryLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted
                  ? color
                  : AppColors.textSecondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    )
                  : Text(
                      '$chapter',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                color: isCompleted
                    ? AppColors.accent
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ],
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

  String _getChapterName(StorylineType type, int index) {
    // 简化：返回通用章节名
    final chapterNames = {
      StorylineType.corrupt: [
        '民不聊生',
        '暗中调查',
        '山贼勾结',
        '卧底身份',
        '捕头阻挠',
        '公堂对质',
      ],
      StorylineType.protection: [
        '孤女求助',
        '山贼威胁',
        '赵知县觊觎',
        '逃离清风镇',
        '追兵来袭',
      ],
      StorylineType.revenge: [
        '师傅遗物',
        '追查线索',
        '血手踪迹',
        '潜入调查',
        '夜探魏府',
        '血手现身',
      ],
      StorylineType.palace: [
        '初入京城',
        '公主遇险',
        '魏公公的阴谋',
        '收集证据',
        '刺杀行动',
        '面见圣上',
        '最终对决',
      ],
      StorylineType.sect: [
        '拜入天剑门',
        '门中异象',
        '叛徒现身',
        '掌门遇袭',
        '寻找灵药',
        '继任掌门',
      ],
      StorylineType.martial: [
        '武林大会',
        '各派争斗',
        '盟主之位',
      ],
      StorylineType.demon: [
        '魔教现世',
        '魔教教主',
        '正邪抉择',
        '正邪大战',
      ],
      StorylineType.romance: [
        '月下琴音',
        '苏晚吟的秘密',
        '仇人现身',
        '终身相许',
      ],
      StorylineType.master: [
        '寻找传人',
        '收徒仪式',
        '弟子成长',
        '弟子出师',
      ],
      StorylineType.ancient: [
        '古玉之谜',
        '秘境开启',
        '上古传承',
        '神功大成',
      ],
    };

    final names = chapterNames[type] ?? [];
    return index < names.length ? names[index] : '第${index + 1}章';
  }

  void _showStorylineGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.accent),
            const SizedBox(width: 8),
            const Text('剧情系统说明'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '什么是剧情线？',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '剧情线是由多个章节组成的连续故事，每条剧情线都有独特的故事情节和结局。',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                '如何开始剧情？',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '1. 达到解锁等级\n2. 点击剧情卡片查看详情\n3. 点击"开始剧情"按钮\n4. 按照任务提示完成章节',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                '剧情分支',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '某些章节会有分支选择，你的选择会影响剧情走向和最终结局。请谨慎选择！',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 16),
              Text(
                '剧情奖励',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '完成剧情章节可以获得经验、银两、特殊物品、技能传授等丰厚奖励。',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/game_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../../models/skill.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import 'skill_provider.dart';

class SkillPage extends ConsumerWidget {
  const SkillPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final learnedAsync = ref.watch(learnedSkillsProvider);
    final equipped = ref.watch(equippedSkillsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('武功')),
      body: learnedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (learned) {
          if (learned.isEmpty) {
            return Center(
              child: Text('尚未习得任何武功', style: theme.textTheme.bodyMedium),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Text(
                '已装备 (${equipped.length}/${GameConstants.maxEquippedSkills})',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (equipped.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('未装备任何技能', style: theme.textTheme.bodyMedium),
                ),
              ...equipped.map((ls) => _buildSkillTile(context, ref, ls, true)),
              const Divider(height: 24),
              Text('已学技能', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...learned
                  .where((ls) => !ls.isEquipped)
                  .map((ls) => _buildSkillTile(context, ref, ls, false)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSkillTile(
    BuildContext context,
    WidgetRef ref,
    dynamic ls,
    bool isEquipped,
  ) {
    final skill = skills[ls.skillId];
    if (skill == null) return const SizedBox.shrink();

    final equipped = ref.read(equippedSkillsProvider);

    return Card(
      child: InkWell(
        onTap: () => _showPracticeSheet(context, ref, ls, skill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _skillTypeIcon(skill.type),
                    color: _qualityColor(skill.quality),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              skill.name,
                              style: TextStyle(
                                color: _qualityColor(skill.quality),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Lv.${ls.level}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          skill.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  isEquipped
                      ? TextButton(
                          onPressed: () => ref
                              .read(skillNotifierProvider.notifier)
                              .unequipSkill(ls.id),
                          child: const Text(
                            '卸下',
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      : TextButton(
                          onPressed:
                              equipped.length < GameConstants.maxEquippedSkills
                              ? () => ref
                                    .read(skillNotifierProvider.notifier)
                                    .equipSkill(ls.id, equipped)
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('装备栏已满，请先卸下一个技能'),
                                    ),
                                  );
                                },
                          child: Text(
                            equipped.length < GameConstants.maxEquippedSkills
                                ? '装备'
                                : '已满',
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  equipped.length <
                                      GameConstants.maxEquippedSkills
                                  ? null
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 6),
              // 熟练度进度条
              Row(
                children: [
                  Text(
                    '熟练',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: ls.proficiency / 100.0,
                        backgroundColor: AppColors.progressTrack,
                        color: AppColors.exp,
                        minHeight: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${ls.proficiency}/100',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _buildSkillStats(skill, ls.level),
            ],
          ),
        ),
      ),
    );
  }

  void _showPracticeSheet(
    BuildContext context,
    WidgetRef ref,
    dynamic ls,
    Skill skill,
  ) {
    // 被动技能不能修炼
    if (skill.type == SkillType.passive) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('被动技能无法修炼')));
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _PracticeSheet(learnedSkill: ls, skill: skill),
    );
  }

  Widget _buildSkillStats(Skill skill, int level) {
    final mult = GameConstants.skillLevelMultiplier(level);
    final parts = <String>[];
    if (skill.baseDamage > 0) {
      final effective = (skill.baseDamage * mult).round();
      if (effective > skill.baseDamage) {
        parts.add('伤害$effective(+${effective - skill.baseDamage})');
      } else {
        parts.add('伤害${skill.baseDamage}');
      }
    }
    if (skill.mpCost > 0) parts.add('耗内${skill.mpCost}');
    if (skill.healAmount > 0) {
      final effective = (skill.healAmount * mult).round();
      if (effective > skill.healAmount) {
        parts.add('回复$effective(+${effective - skill.healAmount})');
      } else {
        parts.add('回复${skill.healAmount}');
      }
    }
    if (skill.buffAtk > 0) parts.add('攻+${skill.buffAtk}');
    if (skill.buffDef > 0) parts.add('防+${skill.buffDef}');
    if (skill.buffSpeed > 0) parts.add('速+${skill.buffSpeed}');

    return Text(
      parts.join(' | '),
      style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
    );
  }

  Color _qualityColor(SkillQuality quality) {
    return switch (quality) {
      SkillQuality.crude => AppColors.textSecondary,
      SkillQuality.refined => const Color(0xFF4CAF50),
      SkillQuality.superior => const Color(0xFF42A5F5),
      SkillQuality.ultimate => const Color(0xFFAB47BC),
      SkillQuality.divine => const Color(0xFFFF9800),
    };
  }

  IconData _skillTypeIcon(SkillType type) {
    return switch (type) {
      SkillType.attack => Icons.flash_on,
      SkillType.innerForce => Icons.self_improvement,
      SkillType.movement => Icons.directions_run,
      SkillType.hidden => Icons.visibility_off,
      SkillType.passive => Icons.auto_fix_high,
    };
  }
}

/// 技能修炼面板
class _PracticeSheet extends ConsumerStatefulWidget {
  final dynamic learnedSkill;
  final Skill skill;

  const _PracticeSheet({required this.learnedSkill, required this.skill});

  @override
  ConsumerState<_PracticeSheet> createState() => _PracticeSheetState();
}

class _PracticeSheetState extends ConsumerState<_PracticeSheet> {
  String? _resultMsg;

  // 每次修炼消耗 10 点内力，获得 15 点熟练度
  static const _mpCost = 10;
  static const _profGain = 15;

  void _doPractice() {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    if (character.currentMp < _mpCost) {
      setState(() => _resultMsg = '内力不足，无法修炼。');
      return;
    }

    // 扣内力
    ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: character.id,
          currentMp: character.currentMp - _mpCost,
        );

    // 加熟练度
    ref
        .read(skillNotifierProvider.notifier)
        .upgradeProficiency(widget.learnedSkill.id, _profGain);

    ref
        .read(gameLogProvider.notifier)
        .addLog(
          '修炼【${widget.skill.name}】，熟练度 +$_profGain',
          type: LogType.system,
        );

    setState(() => _resultMsg = '你凝神修炼${widget.skill.name}，感觉又精进了几分。');
  }

  @override
  Widget build(BuildContext context) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    final canPractice = character != null && character.currentMp >= _mpCost;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '修炼 · ${widget.skill.name}',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.skill.description,
            style: TextStyle(color: AppColors.textPrimary, height: 1.5),
          ),
          const SizedBox(height: 12),
          Text(
            '当前等级: Lv.${widget.learnedSkill.level}  '
            '熟练度: ${widget.learnedSkill.proficiency}/100',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            '消耗 $_mpCost 内力 → 熟练度 +$_profGain'
            '${character != null ? "  (当前内力: ${character.currentMp})" : ""}',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 16),
          if (_resultMsg != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _resultMsg!,
                style: TextStyle(color: AppColors.textPrimary, height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: canPractice ? _doPractice : null,
                  child: const Text('修炼一次'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceLight,
                  ),
                  child: const Text('关闭'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/game_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/skill_data.dart';
import '../../models/enums.dart';
import '../../models/skill.dart';
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
              child: Text('尚未习得任何武功',
                  style: theme.textTheme.bodyMedium),
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
      BuildContext context, WidgetRef ref, dynamic ls, bool isEquipped) {
    final skill = skills[ls.skillId];
    if (skill == null) return const SizedBox.shrink();

    final equipped = ref.read(equippedSkillsProvider);

    return Card(
      child: ListTile(
        leading: Icon(
          _skillTypeIcon(skill.type),
          color: _qualityColor(skill.quality),
        ),
        title: Row(
          children: [
            Text(
              skill.name,
              style: TextStyle(color: _qualityColor(skill.quality)),
            ),
            const SizedBox(width: 6),
            Text(
              'Lv.${ls.level}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            _buildSkillStats(skill),
          ],
        ),
        trailing: isEquipped
            ? TextButton(
                onPressed: () => ref
                    .read(skillNotifierProvider.notifier)
                    .unequipSkill(ls.id),
                child: const Text('卸下', style: TextStyle(fontSize: 12)),
              )
            : TextButton(
                onPressed: equipped.length < GameConstants.maxEquippedSkills
                    ? () => ref
                        .read(skillNotifierProvider.notifier)
                        .equipSkill(ls.id, equipped)
                    : null,
                child: const Text('装备', style: TextStyle(fontSize: 12)),
              ),
      ),
    );
  }

  Widget _buildSkillStats(Skill skill) {
    final parts = <String>[];
    if (skill.baseDamage > 0) parts.add('伤害${skill.baseDamage}');
    if (skill.mpCost > 0) parts.add('耗内${skill.mpCost}');
    if (skill.healAmount > 0) parts.add('回复${skill.healAmount}');
    if (skill.buffAtk > 0) parts.add('攻+${skill.buffAtk}');
    if (skill.buffDef > 0) parts.add('防+${skill.buffDef}');
    if (skill.buffSpeed > 0) parts.add('速+${skill.buffSpeed}');

    return Text(
      parts.join(' | '),
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 11,
      ),
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

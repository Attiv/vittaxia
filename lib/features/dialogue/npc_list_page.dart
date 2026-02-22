import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';
import '../../models/npc.dart';
import 'dialogue_page.dart';
import 'npc_provider.dart';
import 'shop_page.dart';

/// 当前位置 NPC 列表页
class NpcListPage extends ConsumerWidget {
  const NpcListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final npcsHere = ref.watch(locationNpcsProvider);
    final relationsAsync = ref.watch(npcRelationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('附近的人')),
      body: npcsHere.isEmpty
          ? Center(
              child: Text('此处无人', style: theme.textTheme.bodyMedium),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: npcsHere.map((npc) {
                final relations = relationsAsync.valueOrNull ?? [];
                final aff = getAffection(relations, npc.id);
                final label = affectionLabel(aff);

                return Card(
                  child: ListTile(
                    leading: Icon(
                      _npcTypeIcon(npc.type),
                      color: AppColors.accent,
                    ),
                    title: Row(
                      children: [
                        Text(npc.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Text(
                          npc.title,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(npc.description,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(
                          '好感: $aff ($label)',
                          style: TextStyle(
                            color: _affectionColor(aff),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: _npcActions(context, npc),
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _npcActions(BuildContext context, Npc npc) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (npc.dialogueIds.isNotEmpty)
          IconButton(
            icon: Icon(Icons.chat, color: AppColors.accent, size: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DialoguePage(npcId: npc.id, npc: npc),
                ),
              );
            },
            tooltip: '对话',
          ),
        if (npc.shopItemIds.isNotEmpty)
          IconButton(
            icon: Icon(Icons.store, color: AppColors.accent, size: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShopPage(npc: npc),
                ),
              );
            },
            tooltip: '商店',
          ),
      ],
    );
  }

  IconData _npcTypeIcon(NpcType type) {
    return switch (type) {
      NpcType.story => Icons.auto_stories,
      NpcType.merchant => Icons.store,
      NpcType.master => Icons.school,
      NpcType.questGiver => Icons.assignment,
      NpcType.companion => Icons.people,
      NpcType.hostile => Icons.warning,
    };
  }

  Color _affectionColor(int value) {
    if (value >= 80) return AppColors.success;
    if (value >= 40) return AppColors.accent;
    if (value >= 20) return AppColors.textSecondary;
    return AppColors.textSecondary;
  }
}

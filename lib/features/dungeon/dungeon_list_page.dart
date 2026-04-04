import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/dungeon_data.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';
import 'dungeon_explore_page.dart';
import 'dungeon_provider.dart';

class DungeonListPage extends ConsumerWidget {
  const DungeonListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dungeons = ref.watch(availableDungeonsProvider);
    final progressAsync = ref.watch(dungeonProgressProvider);
    final inventory = ref.watch(inventoryProvider).valueOrNull ?? const [];
    final ownedItemIds = inventory.map((inv) => inv.itemId).toSet();
    final collectibleDungeons = storyChapterDungeons;
    final collectedCount = collectibleDungeons
        .where((dungeon) => ownedItemIds.contains(dungeon.collectibleItemId))
        .length;

    return Scaffold(
      appBar: AppBar(title: const Text('探险')),
      body: dungeons.isEmpty
          ? Center(
              child: Text(
                '此处无洞府',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : progressAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (progressList) {
                return Column(
                  children: [
                    if (collectibleDungeons.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: _collectionProgressCard(
                          collectedCount,
                          collectibleDungeons.length,
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: dungeons.length,
                        itemBuilder: (_, i) {
                          final dungeon = dungeons[i];
                          final progress = progressList
                              .where((p) => p.dungeonId == dungeon.id)
                              .firstOrNull;
                          final locked = !isDungeonUnlocked(
                            dungeon,
                            progressList,
                          );
                          final collected =
                              dungeon.collectibleItemId != null &&
                              ownedItemIds.contains(dungeon.collectibleItemId);
                          final requiredDungeon =
                              dungeon.requiredDungeonId == null
                              ? null
                              : dungeonTemplates[dungeon.requiredDungeonId!];
                          final curFloor = progress?.currentFloor ?? 0;
                          final bestFloor = progress?.bestFloor ?? 0;
                          final status = progress?.status ?? 0;
                          final description =
                              dungeon.storyLead ?? dungeon.description;

                          return Card(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (dungeon.chapterLabel != null) ...[
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.accent.withValues(
                                              alpha: 0.16,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                          ),
                                          child: Text(
                                            dungeon.chapterLabel!,
                                            style: TextStyle(
                                              color: AppColors.accent,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (dungeon.subtitle != null)
                                          Text(
                                            dungeon.subtitle!,
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 11,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          dungeon.name,
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (collected)
                                        _statusBadge(
                                          '藏品已收录',
                                          AppColors.warning,
                                        ),
                                      if (locked)
                                        _statusBadge('未解锁', AppColors.warning)
                                      else if (status == 2)
                                        _statusBadge('已通关', AppColors.success),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12, height: 1.4),
                                  ),
                                  const SizedBox(height: 4),
                                  if (locked && requiredDungeon != null) ...[
                                    Text(
                                      '解锁条件: 通关${requiredDungeon.chapterLabel ?? ''} ${requiredDungeon.name}'
                                          .trim(),
                                      style: TextStyle(
                                        color: AppColors.warning,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                  Text(
                                    '层数: ${dungeon.totalFloors}  进度: $curFloor/${dungeon.totalFloors}  最深: $bestFloor',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: TextButton(
                                onPressed: locked
                                    ? null
                                    : () async {
                                        if (status == 2) {
                                          final characterId = ref.read(
                                            currentCharacterIdProvider,
                                          );
                                          if (characterId != null) {
                                            await ref
                                                .read(
                                                  dungeonNotifierProvider
                                                      .notifier,
                                                )
                                                .resetDungeon(
                                                  characterId,
                                                  dungeon.id,
                                                );
                                          }
                                        }
                                        if (!context.mounted) return;
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => DungeonExplorePage(
                                              dungeonId: dungeon.id,
                                            ),
                                          ),
                                        );
                                      },
                                child: Text(
                                  locked
                                      ? '未解锁'
                                      : status == 2
                                      ? '重探'
                                      : (curFloor > 0 ? '继续' : '进入'),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _collectionProgressCard(int collectedCount, int totalCount) {
    final progress = totalCount == 0 ? 0.0 : collectedCount / totalCount;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.collections_bookmark, color: AppColors.warning),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '章节藏品',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$collectedCount/$totalCount',
                  style: TextStyle(
                    color: AppColors.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '每章首次通关可收录一件专属藏品，重复重探不会重复掉落。',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 10)),
    );
  }
}

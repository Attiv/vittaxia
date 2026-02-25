import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../character/character_provider.dart';
import 'dungeon_explore_page.dart';
import 'dungeon_provider.dart';

class DungeonListPage extends ConsumerWidget {
  const DungeonListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dungeons = ref.watch(availableDungeonsProvider);
    final progressAsync = ref.watch(dungeonProgressProvider);

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
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: dungeons.length,
                  itemBuilder: (_, i) {
                    final dungeon = dungeons[i];
                    final progress = progressList
                        .where((p) => p.dungeonId == dungeon.id)
                        .firstOrNull;
                    final curFloor = progress?.currentFloor ?? 0;
                    final bestFloor = progress?.bestFloor ?? 0;
                    final status = progress?.status ?? 0;

                    return Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              dungeon.name,
                              style: TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (status == 2)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '已通关',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              dungeon.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
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
                          onPressed: () async {
                            // 如果已通关，先重置进度
                            if (status == 2) {
                              final characterId = ref.read(currentCharacterIdProvider);
                              if (characterId != null) {
                                await ref
                                    .read(dungeonNotifierProvider.notifier)
                                    .resetDungeon(characterId, dungeon.id);
                              }
                            }
                            if (!context.mounted) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    DungeonExplorePage(dungeonId: dungeon.id),
                              ),
                            );
                          },
                          child: Text(
                            status == 2 ? '重探' : (curFloor > 0 ? '继续' : '进入'),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

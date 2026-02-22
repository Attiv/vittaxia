import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/map_data.dart';
import '../../models/enums.dart';
import '../../models/map_location.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../../models/game_event.dart';
import '../quest/quest_provider.dart';
import '../sect/sect_provider.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    final currentLoc = ref.watch(currentLocationProvider);
    final questProgress = ref.watch(questProgressProvider).valueOrNull ?? [];
    final completedQuestIds = questProgress
        .where((p) => p.status == 2)
        .map((p) => p.questId)
        .toSet();

    if (character == null || currentLoc == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('江湖地图')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 当前位置
          Card(
            color: AppColors.surfaceLight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.accent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '当前: ${currentLoc.name}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _dangerBadge(currentLoc.dangerLevel),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentLoc.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text('可前往', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),

          // 可达地点
          ...currentLoc.adjacentIds.map((id) {
            final loc = mapLocations[id];
            if (loc == null) return const SizedBox.shrink();
            return _buildLocationTile(
              context,
              ref,
              loc,
              character,
              completedQuestIds,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLocationTile(
    BuildContext context,
    WidgetRef ref,
    MapLocation loc,
    dynamic character,
    Set<String> completedQuestIds,
  ) {
    final canEnter = _canEnter(loc, character, completedQuestIds);
    final reason = _blockReason(loc, character, completedQuestIds);

    return Card(
      child: ListTile(
        leading: Icon(
          _locationIcon(loc.type),
          color: canEnter ? AppColors.textPrimary : AppColors.textSecondary,
        ),
        title: Row(
          children: [
            Text(
              loc.name,
              style: TextStyle(
                color: canEnter
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            _dangerBadge(loc.dangerLevel),
          ],
        ),
        subtitle: Text(
          canEnter ? loc.description : '[$reason]',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: canEnter
                ? AppColors.textSecondary
                : AppColors.danger.withValues(alpha: 0.7),
          ),
        ),
        trailing: canEnter
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.accent,
              )
            : Icon(Icons.lock, size: 16, color: AppColors.textSecondary),
        onTap: canEnter ? () => _moveTo(context, ref, loc, character) : null,
      ),
    );
  }

  bool _canEnter(
    MapLocation loc,
    dynamic character,
    Set<String> completedQuestIds,
  ) {
    if (loc.requiredRealm != null) {
      final charTier = RealmTier.values[character.realmTierIndex];
      if (charTier.rank < loc.requiredRealm!.rank) return false;
    }
    if (loc.requiredQuestId != null &&
        !completedQuestIds.contains(loc.requiredQuestId)) {
      return false;
    }
    return true;
  }

  String _blockReason(
    MapLocation loc,
    dynamic character,
    Set<String> completedQuestIds,
  ) {
    if (loc.requiredRealm != null) {
      final charTier = RealmTier.values[character.realmTierIndex];
      if (charTier.rank < loc.requiredRealm!.rank) {
        return '需要${loc.requiredRealm!.label}境界';
      }
    }
    if (loc.requiredQuestId != null &&
        !completedQuestIds.contains(loc.requiredQuestId)) {
      return '需要完成前置任务';
    }
    return '';
  }

  void _moveTo(
    BuildContext context,
    WidgetRef ref,
    MapLocation loc,
    dynamic character,
  ) {
    ref
        .read(characterNotifierProvider.notifier)
        .updateStats(characterId: character.id, locationId: loc.id);
    ref
        .read(gameLogProvider.notifier)
        .addLog('你来到了${loc.name}。${loc.description}', type: LogType.explore);

    // 更新探索类任务目标
    ref
        .read(questNotifierProvider.notifier)
        .checkAndUpdateObjectives(
          character.id,
          QuestObjectiveType.explore,
          loc.id,
        );
    ref
        .read(sectNotifierProvider.notifier)
        .checkAndUpdateSectObjectives(
          character.id,
          QuestObjectiveType.explore,
          loc.id,
        );

    Navigator.of(context).pop();
  }

  Widget _dangerBadge(int level) {
    Color color;
    if (level <= 1) {
      color = AppColors.success;
    } else if (level <= 3) {
      color = AppColors.warning;
    } else {
      color = AppColors.danger;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text('危险$level', style: TextStyle(color: color, fontSize: 10)),
    );
  }

  IconData _locationIcon(LocationType type) {
    return switch (type) {
      LocationType.village => Icons.home,
      LocationType.city => Icons.location_city,
      LocationType.wilderness => Icons.forest,
      LocationType.dungeon => Icons.cloud,
      LocationType.sect => Icons.temple_buddhist,
      LocationType.special => Icons.star,
    };
  }
}

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
  final String? targetLocationId;
  final String? targetQuestName;

  const MapPage({super.key, this.targetLocationId, this.targetQuestName});

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
    final guideTarget = targetLocationId == null
        ? null
        : mapLocations[targetLocationId!];
    final nextHopId = (guideTarget == null || currentLoc == null)
        ? null
        : _nextHopToward(currentLoc.id, guideTarget.id);
    final nextHop = nextHopId == null ? null : mapLocations[nextHopId];

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
          if (guideTarget != null) ...[
            const SizedBox(height: 10),
            _buildGuideCard(
              context,
              currentLoc,
              guideTarget,
              nextHop,
              nextHopId,
            ),
          ],
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
              highlighted: nextHopId == loc.id,
              isGuideTarget: guideTarget?.id == loc.id,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context,
    MapLocation currentLoc,
    MapLocation guideTarget,
    MapLocation? nextHop,
    String? nextHopId,
  ) {
    final questName = targetQuestName?.trim();
    final hasQuestName = questName != null && questName.isNotEmpty;

    String statusText;
    if (currentLoc.id == guideTarget.id) {
      statusText = '你已到达目标地点，可直接推进任务。';
    } else if (nextHop != null) {
      statusText = '建议先前往 ${nextHop.name}，沿路继续接近目标。';
    } else {
      statusText = '当前地图无法计算可达路径，请先尝试切换到邻近地点。';
    }

    final statusColor = currentLoc.id == guideTarget.id
        ? AppColors.success
        : nextHopId == null
        ? AppColors.warning
        : AppColors.accent;

    return Card(
      color: AppColors.surfaceLight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assistant_navigation, size: 18, color: statusColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    hasQuestName ? '任务指引：$questName' : '任务指引',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '目标地点：${guideTarget.name}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _nextHopToward(String fromId, String toId) {
    if (fromId == toId) return toId;
    if (!mapLocations.containsKey(fromId) || !mapLocations.containsKey(toId)) {
      return null;
    }

    final queue = <String>[fromId];
    final visited = <String>{fromId};
    final parent = <String, String>{};

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      final location = mapLocations[current];
      if (location == null) continue;
      for (final next in location.adjacentIds) {
        if (!mapLocations.containsKey(next) || visited.contains(next)) continue;
        visited.add(next);
        parent[next] = current;
        if (next == toId) {
          var step = toId;
          while (parent[step] != fromId) {
            final previous = parent[step];
            if (previous == null) return null;
            step = previous;
          }
          return step;
        }
        queue.add(next);
      }
    }
    return null;
  }

  Widget _buildLocationTile(
    BuildContext context,
    WidgetRef ref,
    MapLocation loc,
    dynamic character,
    Set<String> completedQuestIds, {
    required bool highlighted,
    required bool isGuideTarget,
  }) {
    final canEnter = _canEnter(loc, character, completedQuestIds);
    final reason = _blockReason(loc, character, completedQuestIds);
    final borderColor = highlighted
        ? AppColors.accent.withValues(alpha: 0.9)
        : isGuideTarget
        ? AppColors.mp.withValues(alpha: 0.75)
        : Colors.transparent;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor, width: highlighted ? 1.4 : 1),
      ),
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
            if (isGuideTarget) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.mp.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.mp.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  '任务目标',
                  style: TextStyle(color: AppColors.mp, fontSize: 10),
                ),
              ),
            ],
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
            ? Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.accent)
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

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
import 'visual_map_widget.dart';

class MapPage extends ConsumerStatefulWidget {
  final String? targetLocationId;
  final String? targetQuestName;

  const MapPage({super.key, this.targetLocationId, this.targetQuestName});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  bool _showListView = false;
  bool _isTraveling = false;
  String? _travelingTarget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    final currentLoc = ref.watch(currentLocationProvider);
    final questProgress = ref.watch(questProgressProvider).valueOrNull ?? [];
    final completedQuestIds = questProgress
        .where((p) => p.status == 2)
        .map((p) => p.questId)
        .toSet();
    final guideTarget = widget.targetLocationId == null
        ? null
        : mapLocations[widget.targetLocationId!];
    final nextHopId = (guideTarget == null || currentLoc == null)
        ? null
        : _nextHopToward(currentLoc.id, guideTarget.id);
    final nextHop = nextHopId == null ? null : mapLocations[nextHopId];

    if (character == null || currentLoc == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 计算已解锁的地点
    final unlockedLocationIds = _getUnlockedLocations(
      character,
      completedQuestIds,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('江湖地图'),
        actions: [
          IconButton(
            icon: Icon(_showListView ? Icons.map : Icons.list),
            tooltip: _showListView ? '地图视图' : '列表视图',
            onPressed: () => setState(() => _showListView = !_showListView),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0.06, 0),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: _showListView
                ? _buildListView(
                    context,
                    theme,
                    currentLoc,
                    character,
                    completedQuestIds,
                    guideTarget,
                    nextHop,
                    nextHopId,
                    key: const ValueKey('map_list_view'),
                  )
                : _buildMapView(
                    context,
                    currentLoc,
                    character,
                    completedQuestIds,
                    unlockedLocationIds,
                    guideTarget,
                    nextHop,
                    key: const ValueKey('map_visual_view'),
                  ),
          ),
          if (_isTraveling) _buildTravelingOverlay(),
        ],
      ),
    );
  }

  Widget _buildMapView(
    BuildContext context,
    MapLocation currentLoc,
    dynamic character,
    Set<String> completedQuestIds,
    Set<String> unlockedLocationIds,
    MapLocation? guideTarget,
    MapLocation? nextHop, {
    Key? key,
  }) {
    return Column(
      key: key,
      children: [
        // 顶部信息栏
        Container(
          padding: const EdgeInsets.all(12),
          color: AppColors.surface,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.accent, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '当前位置: ${currentLoc.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  _dangerBadge(currentLoc.dangerLevel),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                currentLoc.description,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
              if (guideTarget != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.assistant_navigation,
                        size: 16,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          currentLoc.id == guideTarget.id
                              ? '已到达任务目标: ${guideTarget.name}'
                              : nextHop != null
                              ? '任务指引: ${guideTarget.name} (建议前往 ${nextHop.name})'
                              : '任务目标: ${guideTarget.name}',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        // 可视化地图
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.background, AppColors.surface],
              ),
            ),
            child: VisualMapWidget(
              locations: mapLocations,
              currentLocationId: currentLoc.id,
              unlockedLocationIds: unlockedLocationIds,
              onLocationTap: (locationId) {
                final targetLoc = mapLocations[locationId];
                if (targetLoc == null || _isTraveling) return;
                if (_canEnter(targetLoc, character, completedQuestIds)) {
                  _moveTo(targetLoc, character);
                } else {
                  _showLocationDetail(
                    context,
                    targetLoc,
                    character,
                    completedQuestIds,
                  );
                }
              },
            ),
          ),
        ),
        // 底部提示
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: AppColors.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                '点击地点即可前往 · 双指缩放移动地图',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView(
    BuildContext context,
    ThemeData theme,
    MapLocation currentLoc,
    dynamic character,
    Set<String> completedQuestIds,
    MapLocation? guideTarget,
    MapLocation? nextHop,
    String? nextHopId, {
    Key? key,
  }) {
    final allLocations =
        mapLocations.values.where((loc) => loc.id != currentLoc.id).toList()
          ..sort((a, b) {
            final aCan = _canEnter(a, character, completedQuestIds);
            final bCan = _canEnter(b, character, completedQuestIds);
            if (aCan != bCan) return aCan ? -1 : 1;
            if (nextHopId == a.id && nextHopId != b.id) return -1;
            if (nextHopId == b.id && nextHopId != a.id) return 1;
            final dangerComp = a.dangerLevel.compareTo(b.dangerLevel);
            if (dangerComp != 0) return dangerComp;
            return a.name.compareTo(b.name);
          });

    return ListView(
      key: key,
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
                    Icon(Icons.location_on, color: AppColors.accent, size: 20),
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
                Text(currentLoc.description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
        if (guideTarget != null) ...[
          const SizedBox(height: 10),
          _buildGuideCard(context, currentLoc, guideTarget, nextHop, nextHopId),
        ],
        const SizedBox(height: 16),

        Text('地点列表（已解锁可直达）', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),

        ...allLocations.map(
          (loc) => _buildLocationTile(
            context,
            loc,
            character,
            completedQuestIds,
            highlighted: nextHopId == loc.id,
            isGuideTarget: guideTarget?.id == loc.id,
          ),
        ),
      ],
    );
  }

  Set<String> _getUnlockedLocations(
    dynamic character,
    Set<String> completedQuestIds,
  ) {
    final unlocked = <String>{};
    for (final entry in mapLocations.entries) {
      if (_canEnter(entry.value, character, completedQuestIds)) {
        unlocked.add(entry.key);
      }
    }
    return unlocked;
  }

  void _showLocationDetail(
    BuildContext context,
    MapLocation location,
    dynamic character,
    Set<String> completedQuestIds,
  ) {
    final canEnter = _canEnter(location, character, completedQuestIds);
    final reason = _blockReason(location, character, completedQuestIds);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Icon(
                    _locationIcon(location.type),
                    size: 32,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                        Row(
                          children: [
                            _dangerBadge(location.dangerLevel),
                            const SizedBox(width: 8),
                            Text(
                              location.type.label,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                location.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              if (!canEnter) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: AppColors.danger, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          reason,
                          style: TextStyle(
                            color: AppColors.danger,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              if (canEnter)
                ElevatedButton.icon(
                  onPressed: _isTraveling
                      ? null
                      : () {
                          Navigator.of(context).pop();
                          _moveTo(location, character);
                        },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('前往此地'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
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
    final questName = widget.targetQuestName?.trim();
    final hasQuestName = questName != null && questName.isNotEmpty;

    String statusText;
    if (currentLoc.id == guideTarget.id) {
      statusText = '你已到达目标地点，可直接推进任务。';
    } else if (nextHop != null) {
      statusText = '可直接前往 ${guideTarget.name}，或先经 ${nextHop.name} 继续推进。';
    } else {
      statusText = '目标地点已解锁后可直接前往。';
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
        onTap: canEnter && !_isTraveling ? () => _moveTo(loc, character) : null,
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

  Future<void> _moveTo(MapLocation loc, dynamic character) async {
    if (_isTraveling) return;

    final currentLoc = ref.read(currentLocationProvider);
    if (currentLoc?.id == loc.id) {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      return;
    }

    setState(() {
      _isTraveling = true;
      _travelingTarget = loc.name;
    });

    try {
      await ref
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

      await Future<void>.delayed(const Duration(milliseconds: 120));
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTraveling = false;
          _travelingTarget = null;
        });
      }
    }
  }

  Widget _buildTravelingOverlay() {
    return ColoredBox(
      color: AppColors.background.withValues(alpha: 0.75),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _travelingTarget == null
                    ? '正在赶路...'
                    : '正在赶往$_travelingTarget...',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

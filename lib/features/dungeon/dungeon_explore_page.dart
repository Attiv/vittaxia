import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/dungeon_data.dart';
import '../../data/enemy_data.dart';
import '../../data/item_data.dart';
import '../../data/skill_data.dart';
import '../../models/dungeon.dart';
import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../battle/battle_page.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';
import '../quest/quest_provider.dart';
import '../sect/sect_provider.dart';
import '../skill/skill_provider.dart';
import 'dungeon_provider.dart';

class DungeonExplorePage extends ConsumerStatefulWidget {
  final String dungeonId;
  const DungeonExplorePage({super.key, required this.dungeonId});

  @override
  ConsumerState<DungeonExplorePage> createState() => _DungeonExplorePageState();
}

class _DungeonExplorePageState extends ConsumerState<DungeonExplorePage> {
  DungeonFloor? _currentFloor;
  bool _floorResolved = false;
  String? _message;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _enterNextFloor();
  }

  Future<void> _enterNextFloor() async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    setState(() => _loading = true);
    final floor = await ref
        .read(dungeonNotifierProvider.notifier)
        .enterFloor(character.id, widget.dungeonId);
    setState(() {
      _currentFloor = floor;
      _floorResolved = false;
      _message = null;
      _loading = false;
    });

    if (floor == null && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('体力不足或已通关')));
      Navigator.of(context).pop();
    }
  }

  Future<void> _resolveFloor() async {
    final floor = _currentFloor;
    if (floor == null) return;
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);
    final invNotifier = ref.read(inventoryNotifierProvider.notifier);

    switch (floor.eventType) {
      case DungeonEventType.trap:
        final newHp = (character.currentHp + floor.hpChange).clamp(
          1,
          totalMaxHp(character),
        );
        await charNotifier.updateStats(
          characterId: character.id,
          currentHp: newHp,
        );
        setState(() => _message = '受到陷阱伤害 ${floor.hpChange}');

      case DungeonEventType.rest:
        final newHp = (character.currentHp + floor.healHp).clamp(
          0,
          totalMaxHp(character),
        );
        await charNotifier.updateStats(
          characterId: character.id,
          currentHp: newHp,
        );
        setState(() => _message = '恢复气血 +${floor.healHp}');

      case DungeonEventType.treasure:
        setState(() => _message = '发现宝藏！');

      case DungeonEventType.battle:
      case DungeonEventType.boss:
        // 战斗通过 BattlePage 处理
        return;
    }

    // 发放通用奖励
    await _grantRewards(
      floor,
      character,
      charNotifier,
      invNotifier,
      logNotifier,
    );
    setState(() => _floorResolved = true);
  }

  Future<void> _grantRewards(
    DungeonFloor floor,
    dynamic character,
    CharacterNotifier charNotifier,
    InventoryNotifier invNotifier,
    GameLogNotifier logNotifier,
  ) async {
    if (floor.rewardExp > 0 || floor.rewardSilver > 0) {
      await charNotifier.updateStats(
        characterId: character.id,
        exp: floor.rewardExp > 0 ? character.exp + floor.rewardExp : null,
        silver: floor.rewardSilver > 0
            ? character.silver + floor.rewardSilver
            : null,
      );
    }
    if (floor.rewardItemId != null) {
      await invNotifier.addItem(
        character.id,
        floor.rewardItemId!,
        count: floor.rewardItemCount,
      );
      final name = items[floor.rewardItemId]?.name ?? floor.rewardItemId!;
      logNotifier.addLog(
        '洞府获得 $name x${floor.rewardItemCount}',
        type: LogType.item,
      );
      // 更新收集类任务目标
      ref
          .read(questNotifierProvider.notifier)
          .checkAndUpdateObjectives(
            character.id,
            QuestObjectiveType.collect,
            floor.rewardItemId!,
            delta: floor.rewardItemCount,
          );
      ref
          .read(sectNotifierProvider.notifier)
          .checkAndUpdateSectObjectives(
            character.id,
            QuestObjectiveType.collect,
            floor.rewardItemId!,
            delta: floor.rewardItemCount,
          );
    }
    if (floor.rewardSkillId != null) {
      await ref
          .read(skillNotifierProvider.notifier)
          .learnSkill(character.id, floor.rewardSkillId!);
      final name = skills[floor.rewardSkillId]?.name ?? floor.rewardSkillId!;
      logNotifier.addLog('领悟了 $name', type: LogType.explore);
    }
  }

  Future<void> _onBattleComplete(bool won) async {
    final floor = _currentFloor;
    if (floor == null) return;
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    if (!won) {
      ref
          .read(gameLogProvider.notifier)
          .addLog('洞府战斗失败，被迫撤退', type: LogType.combat);
      if (mounted) Navigator.of(context).pop();
      return;
    }

    final charNotifier = ref.read(characterNotifierProvider.notifier);
    final invNotifier = ref.read(inventoryNotifierProvider.notifier);
    final logNotifier = ref.read(gameLogProvider.notifier);

    await _grantRewards(
      floor,
      character,
      charNotifier,
      invNotifier,
      logNotifier,
    );
    setState(() {
      _message = '战斗胜利！';
      _floorResolved = true;
    });
  }

  Future<void> _completeAndContinue() async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    await ref
        .read(dungeonNotifierProvider.notifier)
        .completeFloor(character.id, widget.dungeonId);

    final template = dungeonTemplates[widget.dungeonId];
    final progressList = ref.read(dungeonProgressProvider).valueOrNull ?? [];
    final progress = progressList
        .where((p) => p.dungeonId == widget.dungeonId)
        .firstOrNull;
    final curFloor = progress != null ? progress.currentFloor + 1 : 1;

    if (template != null && curFloor >= template.totalFloors) {
      ref
          .read(gameLogProvider.notifier)
          .addLog('通关 ${template.name}！', type: LogType.explore);
      if (mounted) Navigator.of(context).pop();
      return;
    }

    await _enterNextFloor();
  }

  @override
  Widget build(BuildContext context) {
    final template = dungeonTemplates[widget.dungeonId];
    if (template == null) {
      return const Scaffold(body: Center(child: Text('洞府不存在')));
    }

    final character = ref.watch(currentCharacterProvider).valueOrNull;
    final progressList = ref.watch(dungeonProgressProvider).valueOrNull ?? [];
    final progress = progressList
        .where((p) => p.dungeonId == widget.dungeonId)
        .firstOrNull;
    final curFloor = progress?.currentFloor ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('${template.name} ${curFloor + 1}/${template.totalFloors}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (character != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  '体力 ${character.stamina}/${totalMaxStamina(character)}',
                  style: const TextStyle(
                    color: AppColors.warning,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _currentFloor == null
          ? const Center(child: Text('加载中...'))
          : _buildFloorContent(template),
    );
  }

  Widget _buildFloorContent(DungeonTemplate template) {
    final floor = _currentFloor!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _eventIcon(floor.eventType),
                        color: _eventColor(floor.eventType),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        floor.name,
                        style: TextStyle(
                          color: _eventColor(floor.eventType),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    floor.description,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_message != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _message!,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),
          if (_message != null) const SizedBox(height: 16),
          // 奖励预览
          if (_floorResolved) ...[
            _rewardPreview(floor),
            const SizedBox(height: 16),
          ],
          const Spacer(),
          if (!_floorResolved) _actionButton(floor),
          if (_floorResolved)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _completeAndContinue(),
                    child: const Text('继续深入'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final character = ref
                          .read(currentCharacterProvider)
                          .valueOrNull;
                      if (character != null) {
                        await ref
                            .read(dungeonNotifierProvider.notifier)
                            .completeFloor(character.id, widget.dungeonId);
                      }
                      if (mounted) Navigator.of(context).pop();
                    },
                    child: const Text('撤退'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _actionButton(DungeonFloor floor) {
    switch (floor.eventType) {
      case DungeonEventType.battle:
      case DungeonEventType.boss:
        final enemy = enemies[floor.enemyId];
        return ElevatedButton(
          onPressed: () async {
            if (floor.enemyId == null) return;
            final won = await Navigator.of(context).push<bool>(
              MaterialPageRoute(
                builder: (_) => BattlePage(enemyId: floor.enemyId!),
              ),
            );
            await _onBattleComplete(won ?? false);
          },
          child: Text('迎战${enemy != null ? " - ${enemy.name}" : ""}'),
        );
      case DungeonEventType.treasure:
        return ElevatedButton(
          onPressed: () => _resolveFloor(),
          child: const Text('开启宝箱'),
        );
      case DungeonEventType.trap:
        return ElevatedButton(
          onPressed: () => _resolveFloor(),
          child: const Text('闯过去'),
        );
      case DungeonEventType.rest:
        return ElevatedButton(
          onPressed: () => _resolveFloor(),
          child: const Text('休息'),
        );
    }
  }

  Widget _rewardPreview(DungeonFloor floor) {
    final parts = <String>[];
    if (floor.rewardExp > 0) parts.add('经验 +${floor.rewardExp}');
    if (floor.rewardSilver > 0) parts.add('银两 +${floor.rewardSilver}');
    if (floor.rewardItemId != null) {
      final name = items[floor.rewardItemId]?.name ?? floor.rewardItemId!;
      parts.add('$name x${floor.rewardItemCount}');
    }
    if (floor.rewardSkillId != null) {
      final name = skills[floor.rewardSkillId]?.name ?? floor.rewardSkillId!;
      parts.add('习得 $name');
    }
    if (parts.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts
          .map(
            (p) => Text(
              p,
              style: const TextStyle(color: AppColors.exp, fontSize: 13),
            ),
          )
          .toList(),
    );
  }

  IconData _eventIcon(DungeonEventType type) {
    return switch (type) {
      DungeonEventType.battle => Icons.sports_martial_arts,
      DungeonEventType.boss => Icons.whatshot,
      DungeonEventType.treasure => Icons.card_giftcard,
      DungeonEventType.trap => Icons.warning_amber,
      DungeonEventType.rest => Icons.spa,
    };
  }

  Color _eventColor(DungeonEventType type) {
    return switch (type) {
      DungeonEventType.battle => AppColors.hp,
      DungeonEventType.boss => AppColors.danger,
      DungeonEventType.treasure => AppColors.accent,
      DungeonEventType.trap => AppColors.warning,
      DungeonEventType.rest => AppColors.success,
    };
  }
}

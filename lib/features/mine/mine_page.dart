import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../character/character_provider.dart';
import 'mine_provider.dart';

class MinePage extends ConsumerStatefulWidget {
  const MinePage({super.key});

  @override
  ConsumerState<MinePage> createState() => _MinePageState();
}

class _MinePageState extends ConsumerState<MinePage> {
  bool _mining = false;

  @override
  Widget build(BuildContext context) {
    final spot = ref.watch(currentMineSpotProvider);
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('挖矿')),
      body: spot == null
          ? const Center(
              child: Text('此处无矿脉',
                  style: TextStyle(color: AppColors.textSecondary)),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 矿点信息
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(spot.name,
                              style: const TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('消耗体力: ${spot.staminaCost}',
                              style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13)),
                          const SizedBox(height: 12),
                          const Text('可能产出:',
                              style: TextStyle(
                                  color: AppColors.textPrimary, fontSize: 13)),
                          const SizedBox(height: 4),
                          ...spot.drops.map((drop) {
                            final item = items[drop.itemId];
                            final name = item?.name ?? drop.itemId;
                            final countText = drop.maxCount > drop.minCount
                                ? '${drop.minCount}~${drop.maxCount}'
                                : '${drop.minCount}';
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text('  $name x$countText',
                                  style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12)),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: (_mining ||
                            character == null ||
                            character.stamina < spot.staminaCost)
                        ? null
                        : () => _doMine(character.id),
                    child: Text(_mining
                        ? '挖掘中...'
                        : character != null &&
                                character.stamina < spot.staminaCost
                            ? '体力不足'
                            : '开始挖矿'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _doMine(String characterId) async {
    setState(() => _mining = true);
    final result =
        await ref.read(mineNotifierProvider.notifier).doMine(characterId);
    setState(() => _mining = false);

    if (result == null) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('体力不足')));
      }
      return;
    }

    if (mounted) {
      final itemName = items[result.itemId]?.name ?? result.itemId;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('挖矿成果',
              style: TextStyle(color: AppColors.accent)),
          content: Text('获得 $itemName x${result.count}',
              style: const TextStyle(color: AppColors.textPrimary)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('好的'),
            ),
          ],
        ),
      );
    }
  }
}

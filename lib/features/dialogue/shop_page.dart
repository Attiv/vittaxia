import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../../models/npc.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';

/// 商店页面
class ShopPage extends ConsumerWidget {
  final Npc npc;

  const ShopPage({super.key, required this.npc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: Text('${npc.name}的商店')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (character != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '银两: ${character.silver}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ...npc.shopItemIds.map((itemId) {
            final item = items[itemId];
            if (item == null) return const SizedBox.shrink();
            final canBuy =
                character != null && character.silver >= item.buyPrice;

            return Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(item.description,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${item.buyPrice}两',
                      style: TextStyle(
                        color: canBuy ? AppColors.accent : AppColors.danger,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: canBuy
                          ? () => _buy(ref, character, itemId, item.buyPrice)
                          : null,
                      child: const Text('购买', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _buy(WidgetRef ref, dynamic character, String itemId, int price) {
    ref.read(characterNotifierProvider.notifier).updateStats(
          characterId: character.id,
          silver: character.silver - price,
        );
    ref.read(inventoryNotifierProvider.notifier).addItem(character.id, itemId);
  }
}

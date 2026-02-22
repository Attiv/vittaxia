import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../../models/enums.dart';
import '../../models/item.dart';
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
    final grouped = _groupShopItems();

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
          ..._buildGroupedShopItems(context, ref, grouped, character),
        ],
      ),
    );
  }

  Map<ItemType, List<Item>> _groupShopItems() {
    final grouped = <ItemType, List<Item>>{};
    for (final itemId in npc.shopItemIds) {
      final item = items[itemId];
      if (item == null) continue;
      grouped.putIfAbsent(item.type, () => []).add(item);
    }
    return grouped;
  }

  List<Widget> _buildGroupedShopItems(
    BuildContext context,
    WidgetRef ref,
    Map<ItemType, List<Item>> grouped,
    dynamic character,
  ) {
    const order = [
      ItemType.weapon,
      ItemType.armor,
      ItemType.shoes,
      ItemType.accessory,
      ItemType.consumable,
      ItemType.material,
      ItemType.questItem,
    ];

    final widgets = <Widget>[];
    for (final type in order) {
      final group = grouped[type];
      if (group == null || group.isEmpty) continue;
      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 4, 2, 6),
          child: Text(
            '${type.label} (${group.length})',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
      for (final item in group) {
        final canBuy =
            character != null &&
            (item.buyPrice <= 0 || character.silver >= item.buyPrice);
        widgets.add(
          Card(
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
                        ? () =>
                              _showBulkBuyDialog(context, ref, character, item)
                        : null,
                    child: const Text('购买', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      widgets.add(const SizedBox(height: 8));
    }
    return widgets;
  }

  Future<void> _showBulkBuyDialog(
    BuildContext context,
    WidgetRef ref,
    dynamic character,
    Item item,
  ) async {
    if (character == null) return;

    final int maxQty;
    if (item.buyPrice <= 0) {
      maxQty = 99;
    } else {
      maxQty = (character.silver ~/ item.buyPrice).clamp(0, 99);
    }
    if (maxQty <= 0 && item.buyPrice > 0) return;

    int qty = 1;
    final confirmed = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setState) {
            final totalCost = item.buyPrice * qty;
            return AlertDialog(
              title: Text('购买 ${item.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('单价: ${item.buyPrice}两'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: qty > 1 ? () => setState(() => qty--) : null,
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$qty',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: qty < maxQty
                            ? () => setState(() => qty++)
                            : null,
                        icon: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '总价: $totalCost两',
                    style: TextStyle(
                      color: totalCost <= character.silver
                          ? AppColors.accent
                          : AppColors.danger,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '最多可买 $maxQty 个',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(qty),
                  child: const Text('确认购买'),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed == null || confirmed <= 0) return;
    final ok = await _buy(ref, item.id, item.buyPrice, confirmed);
    if (!context.mounted) return;
    final msg = ok ? '购买成功：${item.name} x$confirmed' : '银两不足，购买失败';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool> _buy(
    WidgetRef ref,
    String itemId,
    int unitPrice,
    int quantity,
  ) async {
    if (quantity <= 0) return false;
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return false;

    final totalPrice = unitPrice * quantity;
    if (totalPrice > 0 && character.silver < totalPrice) {
      return false;
    }

    await ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: character.id,
          silver: character.silver - totalPrice,
        );
    await ref
        .read(inventoryNotifierProvider.notifier)
        .addItem(character.id, itemId, count: quantity);
    return true;
  }
}

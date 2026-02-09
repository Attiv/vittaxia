import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../../models/enums.dart';
import '../../models/item.dart';
import '../character/character_provider.dart';
import 'inventory_provider.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final inventoryAsync = ref.watch(inventoryProvider);
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('背包')),
      body: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (inventory) {
          if (inventory.isEmpty) {
            return Center(
              child: Text('背包空空如也',
                  style: theme.textTheme.bodyMedium),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // 装备区
              if (character != null) ...[
                Text('当前装备', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                _equipSlot(context, ref, '武器', character.weaponId, EquipSlot.weapon, character),
                _equipSlot(context, ref, '防具', character.armorId, EquipSlot.armor, character),
                _equipSlot(context, ref, '鞋子', character.shoesId, EquipSlot.shoes, character),
                _equipSlot(context, ref, '饰品', character.accessoryId, EquipSlot.accessory, character),
                const Divider(height: 24),
              ],
              Text('物品 (${inventory.length})', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...inventory.map((inv) => _buildItemTile(context, ref, inv, character)),
            ],
          );
        },
      ),
    );
  }

  Widget _equipSlot(BuildContext context, WidgetRef ref, String label,
      String? itemId, EquipSlot slot, dynamic character) {
    final item = (itemId != null && itemId.isNotEmpty) ? items[itemId] : null;
    return Card(
      child: ListTile(
        dense: true,
        leading: Icon(
          _slotIcon(slot),
          color: item != null ? _rarityColor(item.rarity) : AppColors.textSecondary,
          size: 20,
        ),
        title: Text(
          item != null ? item.name : '-- 空 --',
          style: TextStyle(
            color: item != null ? _rarityColor(item.rarity) : AppColors.textSecondary,
          ),
        ),
        subtitle: item != null ? Text(_itemBonusText(item), style: const TextStyle(fontSize: 11)) : null,
        trailing: item != null
            ? TextButton(
                onPressed: () {
                  ref.read(inventoryNotifierProvider.notifier)
                      .unequipSlot(character.id, slot);
                },
                child: const Text('卸下', style: TextStyle(fontSize: 12)),
              )
            : null,
      ),
    );
  }

  Widget _buildItemTile(
      BuildContext context, WidgetRef ref, dynamic inv, dynamic character) {
    final item = items[inv.itemId];
    if (item == null) return const SizedBox.shrink();

    return Card(
      child: ListTile(
        leading: Icon(
          _typeIcon(item.type),
          color: _rarityColor(item.rarity),
        ),
        title: Row(
          children: [
            Text(
              item.name,
              style: TextStyle(color: _rarityColor(item.rarity)),
            ),
            if (inv.quantity > 1) ...[
              const SizedBox(width: 4),
              Text('x${inv.quantity}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ],
        ),
        subtitle: Text(
          item.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: _itemActions(context, ref, inv, item, character),
      ),
    );
  }

  Widget? _itemActions(BuildContext context, WidgetRef ref, dynamic inv,
      Item item, dynamic character) {
    if (character == null) return null;
    final notifier = ref.read(inventoryNotifierProvider.notifier);

    if (_isEquipable(item.type)) {
      return TextButton(
        onPressed: () => notifier.equipItem(character.id, item.id),
        child: const Text('装备', style: TextStyle(fontSize: 12)),
      );
    }
    if (item.type == ItemType.consumable) {
      return TextButton(
        onPressed: () =>
            notifier.useConsumable(character.id, inv.id, item.id),
        child: const Text('使用', style: TextStyle(fontSize: 12)),
      );
    }
    return null;
  }

  bool _isEquipable(ItemType type) {
    return type == ItemType.weapon ||
        type == ItemType.armor ||
        type == ItemType.shoes ||
        type == ItemType.accessory;
  }

  String _itemBonusText(Item item) {
    final parts = <String>[];
    if (item.atkBonus > 0) parts.add('攻+${item.atkBonus}');
    if (item.defBonus > 0) parts.add('防+${item.defBonus}');
    if (item.hpBonus > 0) parts.add('血+${item.hpBonus}');
    if (item.mpBonus > 0) parts.add('内+${item.mpBonus}');
    if (item.speedBonus > 0) parts.add('速+${item.speedBonus}');
    if (item.luckBonus > 0) parts.add('运+${item.luckBonus}');
    return parts.join(' ');
  }

  Color _rarityColor(ItemRarity rarity) {
    return switch (rarity) {
      ItemRarity.common => AppColors.textSecondary,
      ItemRarity.uncommon => const Color(0xFF4CAF50),
      ItemRarity.rare => const Color(0xFF42A5F5),
      ItemRarity.epic => const Color(0xFFAB47BC),
      ItemRarity.legendary => const Color(0xFFFF9800),
    };
  }

  IconData _typeIcon(ItemType type) {
    return switch (type) {
      ItemType.weapon => Icons.gavel,
      ItemType.armor => Icons.shield,
      ItemType.shoes => Icons.directions_run,
      ItemType.accessory => Icons.auto_awesome,
      ItemType.consumable => Icons.local_pharmacy,
      ItemType.material => Icons.diamond,
      ItemType.questItem => Icons.star,
    };
  }

  IconData _slotIcon(EquipSlot slot) {
    return switch (slot) {
      EquipSlot.weapon => Icons.gavel,
      EquipSlot.armor => Icons.shield,
      EquipSlot.shoes => Icons.directions_run,
      EquipSlot.accessory => Icons.auto_awesome,
    };
  }
}

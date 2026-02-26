import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/item_data.dart';
import '../../models/enums.dart';
import '../../models/item.dart';
import '../character/character_provider.dart';
import 'enhance_sheet.dart';
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
              child: Text('背包空空如也', style: theme.textTheme.bodyMedium),
            );
          }
          final equipGroups = _groupByType(inventory, equipmentOnly: true);
          final itemGroups = _groupByType(inventory, equipmentOnly: false);
          final equipCount = equipGroups.values.fold<int>(
            0,
            (sum, list) => sum + list.length,
          );
          final itemCount = itemGroups.values.fold<int>(
            0,
            (sum, list) => sum + list.length,
          );

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // 装备区
              if (character != null) ...[
                Text('当前装备', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                _equipSlot(
                  context,
                  ref,
                  '武器',
                  character.weaponId,
                  EquipSlot.weapon,
                  character,
                  inventory,
                ),
                _equipSlot(
                  context,
                  ref,
                  '防具',
                  character.armorId,
                  EquipSlot.armor,
                  character,
                  inventory,
                ),
                _equipSlot(
                  context,
                  ref,
                  '鞋子',
                  character.shoesId,
                  EquipSlot.shoes,
                  character,
                  inventory,
                ),
                _equipSlot(
                  context,
                  ref,
                  '饰品',
                  character.accessoryId,
                  EquipSlot.accessory,
                  character,
                  inventory,
                ),
                _activeSetPanel(theme, character),
                const Divider(height: 24),
              ],
              if (equipCount > 0) ...[
                Text('装备分类 ($equipCount)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ..._buildGroupedItems(context, ref, equipGroups, character),
                const SizedBox(height: 12),
              ],
              if (itemCount > 0) ...[
                Text('物品分类 ($itemCount)', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ..._buildGroupedItems(context, ref, itemGroups, character),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _activeSetPanel(ThemeData theme, dynamic character) {
    final states = activeEquipmentSetStates(
      character,
    ).where((s) => s.equippedPieces > 0).toList();
    if (states.isEmpty) return const SizedBox.shrink();

    return Card(
      color: AppColors.surfaceLight,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('套装状态', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            for (final state in states)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  state.activeBonus != null
                      ? '${state.set.name} (${state.equippedPieces}/${state.set.itemIds.length}) · ${state.activeBonus!.description}'
                      : '${state.set.name} (${state.equippedPieces}/${state.set.itemIds.length}) · 未激活',
                  style: TextStyle(
                    fontSize: 12,
                    color: state.activeBonus != null
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _equipSlot(
    BuildContext context,
    WidgetRef ref,
    String label,
    String? itemId,
    EquipSlot slot,
    dynamic character,
    List<dynamic> inventory,
  ) {
    final item = (itemId != null && itemId.isNotEmpty) ? items[itemId] : null;
    // 查找装备的强化等级
    int enhLv = 0;
    String? invId;
    if (item != null) {
      for (final inv in inventory) {
        if (inv.itemId == itemId) {
          enhLv = inv.enhanceLevel;
          invId = inv.id;
          break;
        }
      }
    }
    final displayName = item != null
        ? '${item.name}${enhLv > 0 ? " +$enhLv" : ""}'
        : '-- 空 --';
    return Card(
      child: ListTile(
        dense: true,
        leading: Icon(
          _slotIcon(slot),
          color: item != null
              ? _rarityColor(item.rarity)
              : AppColors.textSecondary,
          size: 20,
        ),
        title: Text(
          displayName,
          style: TextStyle(
            color: item != null
                ? _rarityColor(item.rarity)
                : AppColors.textSecondary,
          ),
        ),
        subtitle: item != null
            ? Text(_itemBonusText(item, enhLv), style: TextStyle(fontSize: 11))
            : null,
        trailing: item != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (invId != null)
                    TextButton(
                      onPressed: () =>
                          _showEnhanceSheet(context, invId!, itemId!, enhLv),
                      child: const Text('强化', style: TextStyle(fontSize: 12)),
                    ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(inventoryNotifierProvider.notifier)
                          .unequipSlot(character.id, slot);
                    },
                    child: const Text('卸下', style: TextStyle(fontSize: 12)),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildItemTile(
    BuildContext context,
    WidgetRef ref,
    dynamic inv,
    dynamic character,
  ) {
    final item = items[inv.itemId];
    if (item == null) return const SizedBox.shrink();

    return Card(
      child: ListTile(
        leading: Icon(_typeIcon(item.type), color: _rarityColor(item.rarity)),
        title: Row(
          children: [
            Text(
              inv.enhanceLevel > 0
                  ? '${item.name} +${inv.enhanceLevel}'
                  : item.name,
              style: TextStyle(color: _rarityColor(item.rarity)),
            ),
            if (inv.quantity > 1) ...[
              const SizedBox(width: 4),
              Text(
                'x${inv.quantity}',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ],
        ),
        subtitle: Text(
          _isEquipable(item.type)
              ? _itemBonusText(item, inv.enhanceLevel)
              : item.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12),
        ),
        trailing: _itemActions(context, ref, inv, item, character),
      ),
    );
  }

  Widget? _itemActions(
    BuildContext context,
    WidgetRef ref,
    dynamic inv,
    Item item,
    dynamic character,
  ) {
    if (character == null) return null;
    final notifier = ref.read(inventoryNotifierProvider.notifier);

    final sellBtn = item.sellPrice > 0
        ? TextButton(
            onPressed: () => _confirmSell(context, ref, inv, item, character),
            child: Text(
              '售${item.sellPrice}',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          )
        : null;

    if (_isEquipable(item.type)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inv.enhanceLevel < 10)
            TextButton(
              onPressed: () =>
                  _showEnhanceSheet(context, inv.id, item.id, inv.enhanceLevel),
              child: const Text('强化', style: TextStyle(fontSize: 12)),
            ),
          TextButton(
            onPressed: () => notifier.equipItem(character.id, item.id),
            child: const Text('装备', style: TextStyle(fontSize: 12)),
          ),
          if (sellBtn != null) sellBtn,
        ],
      );
    }
    if (item.type == ItemType.consumable) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () =>
                notifier.useConsumable(character.id, inv.id, item.id),
            child: const Text('使用', style: TextStyle(fontSize: 12)),
          ),
          if (sellBtn != null) sellBtn,
        ],
      );
    }
    // 材料和其他物品也可以出售
    return sellBtn;
  }

  void _confirmSell(
    BuildContext context,
    WidgetRef ref,
    dynamic inv,
    Item item,
    dynamic character,
  ) {
    final name = inv.enhanceLevel > 0
        ? '${item.name} +${inv.enhanceLevel}'
        : item.name;
    final qty = inv.quantity as int;

    // 强化过或数量为1时直接卖
    if (inv.enhanceLevel > 0 || qty <= 1) {
      ref
          .read(inventoryNotifierProvider.notifier)
          .sellItem(character.id, inv.id, item.id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('出售了$name，获得${item.sellPrice}银两')));
      return;
    }
    // 多个时弹确认
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('出售物品'),
          content: Text('出售1个$name？\n获得${item.sellPrice}银两（共有$qty个）'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                ref
                    .read(inventoryNotifierProvider.notifier)
                    .sellItem(character.id, inv.id, item.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('出售了$name，获得${item.sellPrice}银两')),
                );
              },
              child: const Text('确认出售'),
            ),
          ],
        );
      },
    );
  }

  void _showEnhanceSheet(
    BuildContext context,
    String inventoryId,
    String itemId,
    int currentLevel,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => EnhanceSheet(
        inventoryId: inventoryId,
        itemId: itemId,
        currentLevel: currentLevel,
      ),
    );
  }

  bool _isEquipable(ItemType type) {
    return type == ItemType.weapon ||
        type == ItemType.armor ||
        type == ItemType.shoes ||
        type == ItemType.accessory;
  }

  Map<ItemType, List<dynamic>> _groupByType(
    List<dynamic> inventory, {
    required bool equipmentOnly,
  }) {
    final order = [
      ItemType.weapon,
      ItemType.armor,
      ItemType.shoes,
      ItemType.accessory,
      ItemType.consumable,
      ItemType.material,
      ItemType.questItem,
    ];
    final grouped = <ItemType, List<dynamic>>{};
    for (final inv in inventory) {
      final item = items[inv.itemId];
      if (item == null) continue;
      final isEquip = _isEquipable(item.type);
      if (equipmentOnly != isEquip) continue;
      grouped.putIfAbsent(item.type, () => []).add(inv);
    }
    final sorted = <ItemType, List<dynamic>>{};
    for (final type in order) {
      final list = grouped[type];
      if (list == null || list.isEmpty) continue;
      sorted[type] = list;
    }
    return sorted;
  }

  List<Widget> _buildGroupedItems(
    BuildContext context,
    WidgetRef ref,
    Map<ItemType, List<dynamic>> groups,
    dynamic character,
  ) {
    final widgets = <Widget>[];
    for (final entry in groups.entries) {
      final type = entry.key;
      final group = entry.value;
      widgets.add(_groupHeader(type, group.length));
      widgets.add(const SizedBox(height: 6));
      for (final inv in group) {
        widgets.add(_buildItemTile(context, ref, inv, character));
      }
      widgets.add(const SizedBox(height: 8));
    }
    return widgets;
  }

  Widget _groupHeader(ItemType type, int count) {
    return Row(
      children: [
        Icon(_typeIcon(type), size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(
          '${type.label} ($count)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  String _itemBonusText(Item item, [int enhLv = 0]) {
    final parts = <String>[];
    void add(String label, int base) {
      if (base <= 0) return;
      final val = enhLv > 0 ? base + (base * enhLv * 0.1).ceil() : base;
      parts.add('$label+$val');
    }

    add('攻', item.atkBonus);
    add('防', item.defBonus);
    add('血', item.hpBonus);
    add('内', item.mpBonus);
    add('速', item.speedBonus);
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

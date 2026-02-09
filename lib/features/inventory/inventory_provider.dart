import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/item_data.dart';
import '../../models/enums.dart';
import '../character/character_provider.dart';

/// 监听当前角色的背包
final inventoryProvider = StreamProvider<List<InventoryItem>>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return db.watchInventory(id);
});

class InventoryNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  InventoryNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  /// 添加物品到背包
  Future<void> addItem(String characterId, String itemId, {int count = 1}) async {
    // 查找是否已有同物品
    final existing = await (
      _db.select(_db.inventoryItems)
        ..where((t) => t.characterId.equals(characterId) & t.itemId.equals(itemId))
    ).getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.inventoryItems)
            ..where((t) => t.id.equals(existing.id)))
          .write(InventoryItemsCompanion(
        quantity: Value(existing.quantity + count),
      ));
    } else {
      await _db.upsertInventoryItem(InventoryItemsCompanion.insert(
        id: const Uuid().v4(),
        characterId: characterId,
        itemId: itemId,
        quantity: Value(count),
      ));
    }
  }

  /// 移除物品
  Future<void> removeItem(String inventoryId, {int count = 1}) async {
    final existing = await (
      _db.select(_db.inventoryItems)
        ..where((t) => t.id.equals(inventoryId))
    ).getSingleOrNull();
    if (existing == null) return;

    if (existing.quantity <= count) {
      await _db.deleteInventoryItem(inventoryId);
    } else {
      await (_db.update(_db.inventoryItems)
            ..where((t) => t.id.equals(inventoryId)))
          .write(InventoryItemsCompanion(
        quantity: Value(existing.quantity - count),
      ));
    }
  }

  /// 装备物品
  Future<void> equipItem(String characterId, String itemId) async {
    final item = items[itemId];
    if (item == null) return;

    final slot = _itemTypeToSlot(item.type);
    if (slot == null) return;

    final charNotifier = _ref.read(characterNotifierProvider.notifier);
    switch (slot) {
      case EquipSlot.weapon:
        await charNotifier.updateStats(characterId: characterId, weaponId: itemId);
      case EquipSlot.armor:
        await charNotifier.updateStats(characterId: characterId, armorId: itemId);
      case EquipSlot.shoes:
        await charNotifier.updateStats(characterId: characterId, shoesId: itemId);
      case EquipSlot.accessory:
        await charNotifier.updateStats(characterId: characterId, accessoryId: itemId);
    }
  }

  /// 卸下装备
  Future<void> unequipSlot(String characterId, EquipSlot slot) async {
    final charNotifier = _ref.read(characterNotifierProvider.notifier);
    switch (slot) {
      case EquipSlot.weapon:
        await charNotifier.updateStats(characterId: characterId, weaponId: '');
      case EquipSlot.armor:
        await charNotifier.updateStats(characterId: characterId, armorId: '');
      case EquipSlot.shoes:
        await charNotifier.updateStats(characterId: characterId, shoesId: '');
      case EquipSlot.accessory:
        await charNotifier.updateStats(characterId: characterId, accessoryId: '');
    }
  }

  /// 使用消耗品
  Future<void> useConsumable(
      String characterId, String inventoryId, String itemId) async {
    final item = items[itemId];
    if (item == null || item.type != ItemType.consumable) return;

    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    int? newHp, newMp;
    if (item.healHp > 0) {
      newHp = (character.currentHp + item.healHp).clamp(0, character.baseHp);
    }
    if (item.healMp > 0) {
      newMp = (character.currentMp + item.healMp).clamp(0, character.baseMp);
    }

    await _ref.read(characterNotifierProvider.notifier).updateStats(
          characterId: characterId,
          currentHp: newHp,
          currentMp: newMp,
        );
    await removeItem(inventoryId);
  }

  EquipSlot? _itemTypeToSlot(ItemType type) {
    return switch (type) {
      ItemType.weapon => EquipSlot.weapon,
      ItemType.armor => EquipSlot.armor,
      ItemType.shoes => EquipSlot.shoes,
      ItemType.accessory => EquipSlot.accessory,
      _ => null,
    };
  }
}

final inventoryNotifierProvider =
    StateNotifierProvider<InventoryNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return InventoryNotifier(db, ref);
});

/// 计算装备加成后的总属性
int totalAtk(dynamic character) {
  int bonus = 0;
  for (final id in [character.weaponId, character.armorId, character.shoesId, character.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      bonus += items[id]?.atkBonus ?? 0;
    }
  }
  return character.baseAtk + bonus;
}

int totalDef(dynamic character) {
  int bonus = 0;
  for (final id in [character.weaponId, character.armorId, character.shoesId, character.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      bonus += items[id]?.defBonus ?? 0;
    }
  }
  return character.baseDef + bonus;
}

int totalSpeed(dynamic character) {
  int bonus = 0;
  for (final id in [character.weaponId, character.armorId, character.shoesId, character.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      bonus += items[id]?.speedBonus ?? 0;
    }
  }
  return character.baseSpeed + bonus;
}

int totalMaxHp(dynamic character) {
  int bonus = 0;
  for (final id in [character.weaponId, character.armorId, character.shoesId, character.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      bonus += items[id]?.hpBonus ?? 0;
    }
  }
  return character.baseHp + bonus;
}

int totalMaxMp(dynamic character) {
  int bonus = 0;
  for (final id in [character.weaponId, character.armorId, character.shoesId, character.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      bonus += items[id]?.mpBonus ?? 0;
    }
  }
  return character.baseMp + bonus;
}

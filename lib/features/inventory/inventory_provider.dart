import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/character_growth.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/enhance_data.dart';
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
  Future<void> addItem(
    String characterId,
    String itemId, {
    int count = 1,
  }) async {
    // 查找是否已有同物品
    final existing =
        await (_db.select(_db.inventoryItems)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.itemId.equals(itemId),
            ))
            .getSingleOrNull();

    if (existing != null) {
      await (_db.update(
        _db.inventoryItems,
      )..where((t) => t.id.equals(existing.id))).write(
        InventoryItemsCompanion(quantity: Value(existing.quantity + count)),
      );
    } else {
      await _db.upsertInventoryItem(
        InventoryItemsCompanion.insert(
          id: const Uuid().v4(),
          characterId: characterId,
          itemId: itemId,
          quantity: Value(count),
        ),
      );
    }
  }

  /// 移除物品
  Future<void> removeItem(String inventoryId, {int count = 1}) async {
    final existing = await (_db.select(
      _db.inventoryItems,
    )..where((t) => t.id.equals(inventoryId))).getSingleOrNull();
    if (existing == null) return;

    if (existing.quantity <= count) {
      await _db.deleteInventoryItem(inventoryId);
    } else {
      await (_db.update(
        _db.inventoryItems,
      )..where((t) => t.id.equals(inventoryId))).write(
        InventoryItemsCompanion(quantity: Value(existing.quantity - count)),
      );
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
        await charNotifier.updateStats(
          characterId: characterId,
          weaponId: itemId,
        );
      case EquipSlot.armor:
        await charNotifier.updateStats(
          characterId: characterId,
          armorId: itemId,
        );
      case EquipSlot.shoes:
        await charNotifier.updateStats(
          characterId: characterId,
          shoesId: itemId,
        );
      case EquipSlot.accessory:
        await charNotifier.updateStats(
          characterId: characterId,
          accessoryId: itemId,
        );
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
        await charNotifier.updateStats(
          characterId: characterId,
          accessoryId: '',
        );
    }
  }

  /// 使用消耗品
  Future<void> useConsumable(
    String characterId,
    String inventoryId,
    String itemId,
  ) async {
    final item = items[itemId];
    if (item == null || item.type != ItemType.consumable) return;

    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    int? newHp, newMp, newStamina;
    if (item.healHp > 0) {
      newHp = (character.currentHp + item.healHp).clamp(
        0,
        totalMaxHp(character),
      );
    }
    if (item.healMp > 0) {
      newMp = (character.currentMp + item.healMp).clamp(
        0,
        totalMaxMp(character),
      );
    }
    if (item.healStamina > 0) {
      newStamina = (character.stamina + item.healStamina).clamp(
        0,
        totalMaxStamina(character),
      );
    }

    await _ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: characterId,
          currentHp: newHp,
          currentMp: newMp,
          stamina: newStamina,
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

  /// 出售物品，增加银两并移除背包中的一件
  Future<bool> sellItem(
    String characterId,
    String inventoryId,
    String itemId,
  ) async {
    final item = items[itemId];
    if (item == null || item.sellPrice <= 0) return false;

    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return false;

    await _ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: characterId,
          silver: character.silver + item.sellPrice,
        );
    await removeItem(inventoryId);
    return true;
  }

  /// 按 itemId 扣减材料
  Future<bool> removeItemByItemId(
    String characterId,
    String itemId,
    int count,
  ) async {
    final existing =
        await (_db.select(_db.inventoryItems)..where(
              (t) =>
                  t.characterId.equals(characterId) & t.itemId.equals(itemId),
            ))
            .getSingleOrNull();
    if (existing == null || existing.quantity < count) return false;

    if (existing.quantity <= count) {
      await _db.deleteInventoryItem(existing.id);
    } else {
      await (_db.update(
        _db.inventoryItems,
      )..where((t) => t.id.equals(existing.id))).write(
        InventoryItemsCompanion(quantity: Value(existing.quantity - count)),
      );
    }
    return true;
  }

  /// 强化装备，返回 true=成功 false=失败 null=条件不足
  Future<bool?> enhanceItem(String characterId, String inventoryId) async {
    final inv = await (_db.select(
      _db.inventoryItems,
    )..where((t) => t.id.equals(inventoryId))).getSingleOrNull();
    if (inv == null) return null;

    final nextLevel = inv.enhanceLevel + 1;
    final recipe = enhanceRecipes[nextLevel];
    if (recipe == null) return null; // 已满级

    // 检查银两
    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null || character.silver < recipe.silverCost) return null;

    // 检查材料
    final material =
        await (_db.select(_db.inventoryItems)..where(
              (t) =>
                  t.characterId.equals(characterId) &
                  t.itemId.equals(recipe.materialId),
            ))
            .getSingleOrNull();
    if (material == null || material.quantity < recipe.materialCount) {
      return null;
    }

    // 扣减银两和材料
    await _ref
        .read(characterNotifierProvider.notifier)
        .updateStats(
          characterId: characterId,
          silver: character.silver - recipe.silverCost,
        );
    await removeItemByItemId(
      characterId,
      recipe.materialId,
      recipe.materialCount,
    );

    // 判定成功/失败
    final success = Random().nextDouble() < recipe.successRate;
    if (success) {
      await (_db.update(_db.inventoryItems)
            ..where((t) => t.id.equals(inventoryId)))
          .write(InventoryItemsCompanion(enhanceLevel: Value(nextLevel)));
    }
    return success;
  }
}

final inventoryNotifierProvider =
    StateNotifierProvider<InventoryNotifier, AsyncValue<void>>((ref) {
      final db = ref.watch(databaseProvider);
      return InventoryNotifier(db, ref);
    });

/// 计算装备加成后的总属性（含强化加成）
int _enhancedBonus(int baseBonus, int enhanceLevel) {
  if (enhanceLevel <= 0 || baseBonus <= 0) return baseBonus;
  return baseBonus + (baseBonus * enhanceLevel * 0.1).ceil();
}

int _getEnhanceLevel(String? equipItemId, List<InventoryItem>? inventory) {
  if (equipItemId == null || equipItemId.isEmpty || inventory == null) return 0;
  for (final inv in inventory) {
    if (inv.itemId == equipItemId) return inv.enhanceLevel;
  }
  return 0;
}

int totalAtk(dynamic character, [List<InventoryItem>? inventory]) {
  int bonus = 0;
  for (final id in [
    character.weaponId,
    character.armorId,
    character.shoesId,
    character.accessoryId,
  ]) {
    if (id != null && id.isNotEmpty) {
      final base = items[id]?.atkBonus ?? 0;
      bonus += _enhancedBonus(base, _getEnhanceLevel(id, inventory));
    }
  }
  return character.baseAtk + bonus;
}

int totalDef(dynamic character, [List<InventoryItem>? inventory]) {
  int bonus = 0;
  for (final id in [
    character.weaponId,
    character.armorId,
    character.shoesId,
    character.accessoryId,
  ]) {
    if (id != null && id.isNotEmpty) {
      final base = items[id]?.defBonus ?? 0;
      bonus += _enhancedBonus(base, _getEnhanceLevel(id, inventory));
    }
  }
  return character.baseDef + bonus;
}

int totalSpeed(dynamic character, [List<InventoryItem>? inventory]) {
  int bonus = 0;
  for (final id in [
    character.weaponId,
    character.armorId,
    character.shoesId,
    character.accessoryId,
  ]) {
    if (id != null && id.isNotEmpty) {
      final base = items[id]?.speedBonus ?? 0;
      bonus += _enhancedBonus(base, _getEnhanceLevel(id, inventory));
    }
  }
  return character.baseSpeed + bonus;
}

int totalMaxHp(dynamic character, [List<InventoryItem>? inventory]) {
  final c = character as Character;
  int bonus = 0;
  for (final id in [c.weaponId, c.armorId, c.shoesId, c.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      final base = items[id]?.hpBonus ?? 0;
      bonus += _enhancedBonus(base, _getEnhanceLevel(id, inventory));
    }
  }
  return c.levelMaxHp + bonus;
}

int totalMaxMp(dynamic character, [List<InventoryItem>? inventory]) {
  final c = character as Character;
  int bonus = 0;
  for (final id in [c.weaponId, c.armorId, c.shoesId, c.accessoryId]) {
    if (id != null && id.isNotEmpty) {
      final base = items[id]?.mpBonus ?? 0;
      bonus += _enhancedBonus(base, _getEnhanceLevel(id, inventory));
    }
  }
  return c.levelMaxMp + bonus;
}

int totalMaxStamina(dynamic character) {
  final c = character as Character;
  return c.levelMaxStamina;
}

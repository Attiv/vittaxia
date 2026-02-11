import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mine_data.dart';
import '../../models/game_event.dart';
import '../../models/mine_spot.dart';
import '../character/character_provider.dart';
import '../explore/explore_provider.dart';
import '../inventory/inventory_provider.dart';

/// 当前地点的矿点
final currentMineSpotProvider = Provider<MineSpot?>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return null;
  return getMineSpotByLocation(character.locationId);
});

/// 挖矿结果
class MineResult {
  final String itemId;
  final int count;
  MineResult(this.itemId, this.count);
}

class MineNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final Random _random = Random();

  MineNotifier(this._ref) : super(const AsyncValue.data(null));

  /// 执行挖矿
  Future<MineResult?> doMine(String characterId) async {
    final character = _ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return null;

    final spot = getMineSpotByLocation(character.locationId);
    if (spot == null) return null;

    // 扣减体力
    final ok = await _ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(characterId, spot.staminaCost);
    if (!ok) return null;

    // 按权重随机抽取
    final totalWeight = spot.drops.fold<int>(0, (s, d) => s + d.weight);
    var roll = _random.nextInt(totalWeight);
    MineDrop picked = spot.drops.last;
    for (final drop in spot.drops) {
      roll -= drop.weight;
      if (roll < 0) {
        picked = drop;
        break;
      }
    }

    final count = picked.minCount == picked.maxCount
        ? picked.minCount
        : picked.minCount + _random.nextInt(picked.maxCount - picked.minCount + 1);

    // 添加到背包
    await _ref
        .read(inventoryNotifierProvider.notifier)
        .addItem(characterId, picked.itemId, count: count);

    _ref.read(gameLogProvider.notifier).addLog(
          '挖矿获得 ${picked.itemId} x$count',
          type: LogType.item,
        );

    return MineResult(picked.itemId, count);
  }
}

final mineNotifierProvider =
    StateNotifierProvider<MineNotifier, AsyncValue<void>>((ref) {
  return MineNotifier(ref);
});

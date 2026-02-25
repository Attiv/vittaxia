import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/faction_data.dart';
import '../../models/faction.dart';
import '../character/character_provider.dart';

/// 当前角色的所有势力声望
final factionReputationsProvider =
    StreamProvider.autoDispose<Map<String, FactionReputation>>((ref) {
  final db = ref.watch(databaseProvider);
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return Stream.value({});

  // TODO: 需要创建 FactionReputations 表
  // 暂时返回默认值
  return Stream.value({
    for (final faction in factions.values)
      faction.id: FactionReputation(
        factionId: faction.id,
        reputation: 0,
      ),
  });
});

/// 获取指定势力的声望
final factionReputationProvider =
    Provider.autoDispose.family<FactionReputation?, String>((ref, factionId) {
  final reputations = ref.watch(factionReputationsProvider).valueOrNull ?? {};
  return reputations[factionId];
});

/// 势力声望管理器
final factionNotifierProvider =
    NotifierProvider<FactionNotifier, void>(FactionNotifier.new);

class FactionNotifier extends Notifier<void> {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);

  /// 增加声望
  Future<void> increaseReputation(
    String characterId,
    String factionId,
    int amount,
  ) async {
    // TODO: 实现数据库操作
    // 需要先创建 FactionReputations 表
  }

  /// 减少声望
  Future<void> decreaseReputation(
    String characterId,
    String factionId,
    int amount,
  ) async {
    // TODO: 实现数据库操作
  }

  /// 应用行为对声望的影响
  Future<void> applyAction(String characterId, String actionId) async {
    final action = factionActions[actionId];
    if (action == null) return;

    for (final entry in action.reputationChanges.entries) {
      if (entry.value > 0) {
        await increaseReputation(characterId, entry.key, entry.value);
      } else {
        await decreaseReputation(characterId, entry.key, -entry.value);
      }
    }
  }

  /// 获取势力的商店折扣
  int getShopDiscount(String factionId, int reputation) {
    final level = ReputationLevel.fromReputation(reputation);
    final rewards = factionRewards[factionId] ?? [];

    var maxDiscount = 0;
    for (final reward in rewards) {
      if (level.level >= reward.requiredLevel.level &&
          reward.discountPercent != null) {
        maxDiscount = reward.discountPercent!;
      }
    }

    return maxDiscount;
  }

  /// 检查是否解锁了特定物品
  bool isItemUnlocked(String factionId, String itemId, int reputation) {
    final level = ReputationLevel.fromReputation(reputation);
    final rewards = factionRewards[factionId] ?? [];

    for (final reward in rewards) {
      if (level.level >= reward.requiredLevel.level &&
          reward.unlockItemIds?.contains(itemId) == true) {
        return true;
      }
    }

    return false;
  }

  /// 检查是否解锁了特定技能
  bool isSkillUnlocked(String factionId, String skillId, int reputation) {
    final level = ReputationLevel.fromReputation(reputation);
    final rewards = factionRewards[factionId] ?? [];

    for (final reward in rewards) {
      if (level.level >= reward.requiredLevel.level &&
          reward.unlockSkillIds?.contains(skillId) == true) {
        return true;
      }
    }

    return false;
  }
}

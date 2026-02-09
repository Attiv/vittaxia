import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums.dart';
import '../../models/game_event.dart';
import '../character/character_provider.dart';
import '../inventory/inventory_provider.dart';
import '../quest/quest_provider.dart';
import 'explore_provider.dart';

/// 通用事件奖励结算，EventPage 和 home_page 底部弹窗共用
void applyEventRewards(
  WidgetRef ref, {
  int exp = 0,
  int silver = 0,
  String? itemId,
  int? hpChange,
}) {
  final character = ref.read(currentCharacterProvider).valueOrNull;
  if (character == null) return;

  final logNotifier = ref.read(gameLogProvider.notifier);
  final charNotifier = ref.read(characterNotifierProvider.notifier);

  int? newExp = exp > 0 ? character.exp + exp : null;
  int? newSilver = silver > 0 ? character.silver + silver : null;
  int? newHp;
  if (hpChange != null) {
    newHp = (character.currentHp + hpChange).clamp(1, character.baseHp);
  }

  charNotifier.updateStats(
    characterId: character.id,
    exp: newExp,
    silver: newSilver,
    currentHp: newHp,
  );

  if (exp > 0) logNotifier.addLog('获得 $exp 经验', type: LogType.explore);
  if (silver > 0) logNotifier.addLog('获得 $silver 银两', type: LogType.item);
  if (hpChange != null && hpChange != 0) {
    logNotifier.addLog(
      '气血 ${hpChange > 0 ? "+" : ""}$hpChange',
      type: LogType.combat,
    );
  }
  if (itemId != null) {
    ref.read(inventoryNotifierProvider.notifier).addItem(character.id, itemId);
    logNotifier.addLog('获得物品: $itemId', type: LogType.item);
    ref.read(questNotifierProvider.notifier).checkAndUpdateObjectives(
          character.id,
          QuestObjectiveType.collect,
          itemId,
        );
  }
}

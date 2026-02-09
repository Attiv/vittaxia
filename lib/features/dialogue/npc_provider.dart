import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/game_constants.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/npc_data.dart';
import '../../models/npc.dart';
import '../character/character_provider.dart';

/// 当前地点的 NPC 列表
final locationNpcsProvider = Provider<List<Npc>>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return [];
  final locationId = character.locationId;
  return npcs.values.where((n) => n.locationId == locationId).toList();
});

/// NPC 好感度数据
final npcRelationsProvider = StreamProvider<List<NpcRelation>>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return db.watchNpcRelations(id);
});

/// 获取某 NPC 的好感度值
int getAffection(List<NpcRelation> relations, String npcId) {
  for (final r in relations) {
    if (r.npcId == npcId) return r.affection;
  }
  return 0;
}

/// 好感度等级描述
String affectionLabel(int value) {
  if (value >= 95) return GameConstants.affectionLevels[5];
  if (value >= 80) return GameConstants.affectionLevels[4];
  if (value >= 60) return GameConstants.affectionLevels[3];
  if (value >= 40) return GameConstants.affectionLevels[2];
  if (value >= 20) return GameConstants.affectionLevels[1];
  return GameConstants.affectionLevels[0];
}

class NpcNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;

  NpcNotifier(this._db) : super(const AsyncValue.data(null));

  Future<void> changeAffection(
      String characterId, String npcId, int delta) async {
    final existing = await (_db.select(_db.npcRelations)
          ..where((t) =>
              t.characterId.equals(characterId) & t.npcId.equals(npcId)))
        .getSingleOrNull();

    final current = existing?.affection ?? 0;
    final newValue = (current + delta).clamp(0, GameConstants.maxAffection);

    await _db.upsertNpcRelation(NpcRelationsCompanion(
      characterId: Value(characterId),
      npcId: Value(npcId),
      affection: Value(newValue),
    ));
  }
}

final npcNotifierProvider =
    StateNotifierProvider<NpcNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return NpcNotifier(db);
});

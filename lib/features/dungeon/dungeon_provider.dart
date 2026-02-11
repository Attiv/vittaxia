import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../data/dungeon_data.dart';
import '../../models/dungeon.dart';
import '../character/character_provider.dart';

/// 当前角色的洞府进度
final dungeonProgressProvider = StreamProvider<List<DungeonProgressData>>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return db.watchDungeonProgress(id);
});

/// 当前地点可用的洞府
final availableDungeonsProvider = Provider<List<DungeonTemplate>>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return [];
  return dungeonTemplates.values
      .where((d) => d.locationId == character.locationId)
      .toList();
});

class DungeonNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  DungeonNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  /// 获取或创建洞府进度
  Future<DungeonProgressData> _getOrCreateProgress(
      String characterId, String dungeonId) async {
    final existing = await (_db.select(_db.dungeonProgress)
          ..where((t) =>
              t.characterId.equals(characterId) &
              t.dungeonId.equals(dungeonId)))
        .getSingleOrNull();
    if (existing != null) return existing;

    final id = const Uuid().v4();
    final companion = DungeonProgressCompanion.insert(
      id: id,
      characterId: characterId,
      dungeonId: dungeonId,
    );
    await _db.upsertDungeonProgress(companion);
    return (await (_db.select(_db.dungeonProgress)
              ..where((t) => t.id.equals(id)))
            .getSingle());
  }

  /// 进入下一层，返回当前层数据；null 表示体力不足或已通关
  Future<DungeonFloor?> enterFloor(
      String characterId, String dungeonId) async {
    final template = dungeonTemplates[dungeonId];
    if (template == null) return null;

    final progress = await _getOrCreateProgress(characterId, dungeonId);
    if (progress.currentFloor >= template.totalFloors) return null;

    final floor = template.floors[progress.currentFloor];

    // 扣减体力
    final ok = await _ref
        .read(characterNotifierProvider.notifier)
        .consumeStamina(characterId, floor.staminaCost);
    if (!ok) return null;

    // 标记进行中
    if (progress.status == 0) {
      await (_db.update(_db.dungeonProgress)
            ..where((t) => t.id.equals(progress.id)))
          .write(const DungeonProgressCompanion(
        status: Value(1),
      ));
    }

    await (_db.update(_db.dungeonProgress)
          ..where((t) => t.id.equals(progress.id)))
        .write(DungeonProgressCompanion(
      lastAttemptTime: Value(DateTime.now()),
    ));

    return floor;
  }

  /// 完成当前层
  Future<void> completeFloor(String characterId, String dungeonId) async {
    final template = dungeonTemplates[dungeonId];
    if (template == null) return;

    final progress = await _getOrCreateProgress(characterId, dungeonId);
    final nextFloor = progress.currentFloor + 1;
    final newBest =
        nextFloor > progress.bestFloor ? nextFloor : progress.bestFloor;
    final done = nextFloor >= template.totalFloors;

    await (_db.update(_db.dungeonProgress)
          ..where((t) => t.id.equals(progress.id)))
        .write(DungeonProgressCompanion(
      currentFloor: Value(nextFloor),
      bestFloor: Value(newBest),
      status: Value(done ? 2 : 1),
    ));
  }

  /// 重置洞府进度
  Future<void> resetDungeon(String characterId, String dungeonId) async {
    final progress = await _getOrCreateProgress(characterId, dungeonId);
    await (_db.update(_db.dungeonProgress)
          ..where((t) => t.id.equals(progress.id)))
        .write(const DungeonProgressCompanion(
      currentFloor: Value(0),
      status: Value(0),
    ));
  }
}

final dungeonNotifierProvider =
    StateNotifierProvider<DungeonNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return DungeonNotifier(db, ref);
});

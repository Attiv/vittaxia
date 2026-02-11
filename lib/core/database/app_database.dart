import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Characters,
  InventoryItems,
  LearnedSkills,
  NpcRelations,
  QuestProgress,
  DungeonProgress,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(characters, characters.stamina);
            await migrator.addColumn(characters, characters.maxStamina);
            await migrator.addColumn(
                characters, characters.lastStaminaRegenTime);
            await migrator.createTable(dungeonProgress);
          }
        },
      );

  // ========== Character CRUD ==========

  Future<List<Character>> getAllCharacters() => select(characters).get();

  Stream<Character?> watchCharacter(String id) {
    return (select(characters)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<Character?> getCharacter(String id) {
    return (select(characters)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertCharacter(CharactersCompanion entry) {
    return into(characters).insert(entry);
  }

  Future<void> updateCharacter(CharactersCompanion entry) {
    return (update(characters)..where((t) => t.id.equals(entry.id.value)))
        .write(entry);
  }

  // ========== Inventory ==========

  Stream<List<InventoryItem>> watchInventory(String characterId) {
    return (select(inventoryItems)
          ..where((t) => t.characterId.equals(characterId)))
        .watch();
  }

  Future<void> upsertInventoryItem(InventoryItemsCompanion entry) {
    return into(inventoryItems).insertOnConflictUpdate(entry);
  }

  Future<void> deleteInventoryItem(String id) {
    return (delete(inventoryItems)..where((t) => t.id.equals(id))).go();
  }

  // ========== Skills ==========

  Stream<List<LearnedSkill>> watchLearnedSkills(String characterId) {
    return (select(learnedSkills)
          ..where((t) => t.characterId.equals(characterId)))
        .watch();
  }

  Future<void> upsertLearnedSkill(LearnedSkillsCompanion entry) {
    return into(learnedSkills).insertOnConflictUpdate(entry);
  }

  // ========== NPC Relations ==========

  Stream<List<NpcRelation>> watchNpcRelations(String characterId) {
    return (select(npcRelations)
          ..where((t) => t.characterId.equals(characterId)))
        .watch();
  }

  Future<void> upsertNpcRelation(NpcRelationsCompanion entry) {
    return into(npcRelations).insertOnConflictUpdate(entry);
  }

  // ========== Quest Progress ==========

  Stream<List<QuestProgressData>> watchQuestProgress(String characterId) {
    return (select(questProgress)
          ..where((t) => t.characterId.equals(characterId)))
        .watch();
  }

  Future<void> upsertQuestProgress(QuestProgressCompanion entry) {
    return into(questProgress).insertOnConflictUpdate(entry);
  }

  // ========== Dungeon Progress ==========

  Stream<List<DungeonProgressData>> watchDungeonProgress(String characterId) {
    return (select(dungeonProgress)
          ..where((t) => t.characterId.equals(characterId)))
        .watch();
  }

  Future<void> upsertDungeonProgress(DungeonProgressCompanion entry) {
    return into(dungeonProgress).insertOnConflictUpdate(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'vittaxia.db'));
    return NativeDatabase.createInBackground(file);
  });
}

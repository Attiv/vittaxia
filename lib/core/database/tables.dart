import 'package:drift/drift.dart';

/// 角色表
class Characters extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  IntColumn get baseHp => integer().withDefault(const Constant(100))();
  IntColumn get baseMp => integer().withDefault(const Constant(50))();
  IntColumn get baseAtk => integer().withDefault(const Constant(10))();
  IntColumn get baseDef => integer().withDefault(const Constant(5))();
  IntColumn get baseSpeed => integer().withDefault(const Constant(8))();
  IntColumn get baseLuck => integer().withDefault(const Constant(5))();
  IntColumn get baseComprehension => integer().withDefault(const Constant(10))();
  IntColumn get exp => integer().withDefault(const Constant(0))();
  IntColumn get silver => integer().withDefault(const Constant(100))();
  IntColumn get reputation => integer().withDefault(const Constant(0))();
  IntColumn get realmTierIndex => integer().withDefault(const Constant(0))();
  IntColumn get realmStageIndex => integer().withDefault(const Constant(0))();
  IntColumn get currentHp => integer().withDefault(const Constant(100))();
  IntColumn get currentMp => integer().withDefault(const Constant(50))();
  TextColumn get weaponId => text().nullable()();
  TextColumn get armorId => text().nullable()();
  TextColumn get shoesId => text().nullable()();
  TextColumn get accessoryId => text().nullable()();
  TextColumn get locationId => text().withDefault(const Constant('qingyun_village'))();
  DateTimeColumn get lastOnlineTime => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 背包物品表
class InventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get itemId => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get enhanceLevel => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 已学技能表
class LearnedSkills extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get skillId => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get proficiency => integer().withDefault(const Constant(0))();
  BoolColumn get isEquipped => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// NPC 好感度表
class NpcRelations extends Table {
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get npcId => text()();
  IntColumn get affection => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {characterId, npcId};
}

/// 任务进度表
class QuestProgress extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get questId => text()();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0=未接 1=进行中 2=完成
  TextColumn get objectivesJson => text().withDefault(const Constant('{}'))();
  IntColumn get selectedBranch => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

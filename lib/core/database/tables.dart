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
  IntColumn get stamina => integer().withDefault(const Constant(100))();
  IntColumn get maxStamina => integer().withDefault(const Constant(100))();
  DateTimeColumn get lastStaminaRegenTime => dateTime().nullable()();
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

/// 洞府探索进度表
class DungeonProgress extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get dungeonId => text()();
  IntColumn get currentFloor => integer().withDefault(const Constant(0))();
  IntColumn get bestFloor => integer().withDefault(const Constant(0))();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0=未开始 1=进行中 2=已通关
  DateTimeColumn get lastAttemptTime => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 师门成员表
class SectMembers extends Table {
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get sectId => text()();
  IntColumn get contribution => integer().withDefault(const Constant(0))();
  DateTimeColumn get joinedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {characterId};
}

/// 师门任务进度表
class SectQuestProgress extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get questId => text()();
  IntColumn get status => integer().withDefault(const Constant(0))(); // 0=未接 1=进行中 2=完成
  TextColumn get objectivesJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get lastCompletedTime => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 修炼记录表
class CultivationSessions extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  IntColumn get typeIndex => integer()(); // 0=打坐 1=武技 2=历练
  IntColumn get statusIndex => integer().withDefault(const Constant(0))(); // 0=空闲 1=修炼中 2=已完成
  TextColumn get skillId => text().nullable()();
  TextColumn get locationId => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  IntColumn get durationMinutes => integer()();
  DateTimeColumn get completedTime => dateTime().nullable()();
  IntColumn get rewardExp => integer().withDefault(const Constant(0))();
  IntColumn get rewardSilver => integer().withDefault(const Constant(0))();
  TextColumn get rewardItemsJson => text().withDefault(const Constant('{}'))();
  TextColumn get rewardSkillId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 势力声望表
class FactionReputations extends Table {
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get factionId => text()();
  IntColumn get reputation => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUpdated => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {characterId, factionId};
}

/// 成就进度表
class AchievementProgress extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get achievementId => text()();
  IntColumn get currentValue => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 称号表
class CharacterTitles extends Table {
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get titleId => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get obtainedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {characterId, titleId};
}

/// 江湖录表
class JianghuRecords extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get eventType => text()();
  TextColumn get description => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isLegendary => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 剧情线进度表
class StorylineProgressTable extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  IntColumn get typeIndex => integer()(); // StorylineType枚举索引
  IntColumn get currentChapter => integer().withDefault(const Constant(0))();
  IntColumn get totalChapters => integer()();
  TextColumn get completedQuestIdsJson => text().withDefault(const Constant('[]'))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get endingType => text().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 剧情选择记录表
class StorylineChoicesTable extends Table {
  TextColumn get id => text()();
  TextColumn get characterId => text().references(Characters, #id)();
  TextColumn get questId => text()();
  TextColumn get branchId => text()();
  TextColumn get choiceName => text()();
  DateTimeColumn get chosenAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}


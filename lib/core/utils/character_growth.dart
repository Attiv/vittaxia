import '../constants/game_constants.dart';
import '../database/app_database.dart';
import '../../models/enums.dart';

int realmLevelFromIndexes({
  required int realmTierIndex,
  required int realmStageIndex,
}) {
  final safeTier = realmTierIndex.clamp(0, RealmTier.values.length - 1);
  final safeStage = realmStageIndex.clamp(0, RealmStage.values.length - 1);
  return safeTier * GameConstants.realmStageCount + safeStage + 1;
}

int applyLevelGrowth({
  required int baseValue,
  required int level,
  required int growthPerLevel,
}) {
  final safeLevel = level < 1 ? 1 : level;
  return baseValue + (safeLevel - 1) * growthPerLevel;
}

int leveledMaxHp({
  required int baseHp,
  required int realmTierIndex,
  required int realmStageIndex,
}) {
  final level = realmLevelFromIndexes(
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );
  return applyLevelGrowth(
    baseValue: baseHp,
    level: level,
    growthPerLevel: GameConstants.hpGrowthPerLevel,
  );
}

int leveledMaxMp({
  required int baseMp,
  required int realmTierIndex,
  required int realmStageIndex,
}) {
  final level = realmLevelFromIndexes(
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );
  return applyLevelGrowth(
    baseValue: baseMp,
    level: level,
    growthPerLevel: GameConstants.mpGrowthPerLevel,
  );
}

int leveledMaxStamina({
  required int baseStamina,
  required int realmTierIndex,
  required int realmStageIndex,
}) {
  final level = realmLevelFromIndexes(
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );
  return applyLevelGrowth(
    baseValue: baseStamina,
    level: level,
    growthPerLevel: GameConstants.staminaGrowthPerLevel,
  );
}

extension CharacterGrowth on Character {
  int get level => realmLevelFromIndexes(
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );

  int get levelMaxHp => leveledMaxHp(
    baseHp: baseHp,
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );

  int get levelMaxMp => leveledMaxMp(
    baseMp: baseMp,
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );

  int get levelMaxStamina => leveledMaxStamina(
    baseStamina: maxStamina,
    realmTierIndex: realmTierIndex,
    realmStageIndex: realmStageIndex,
  );
}

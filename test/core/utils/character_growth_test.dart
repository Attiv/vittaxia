import 'package:flutter_test/flutter_test.dart';
import 'package:vittaxia/core/utils/character_growth.dart';

void main() {
  group('CharacterGrowth helpers', () {
    test('realmLevelFromIndexes maps tier/stage to linear level', () {
      expect(realmLevelFromIndexes(realmTierIndex: 0, realmStageIndex: 0), 1);
      expect(realmLevelFromIndexes(realmTierIndex: 0, realmStageIndex: 3), 4);
      expect(realmLevelFromIndexes(realmTierIndex: 1, realmStageIndex: 0), 5);
      expect(realmLevelFromIndexes(realmTierIndex: 8, realmStageIndex: 3), 36);
    });

    test('leveled max values include per-level growth', () {
      // 等级 5：额外成长 = 4 级
      expect(
        leveledMaxHp(baseHp: 100, realmTierIndex: 1, realmStageIndex: 0),
        124, // 100 + 4 * 6
      );
      expect(
        leveledMaxMp(baseMp: 50, realmTierIndex: 1, realmStageIndex: 0),
        62, // 50 + 4 * 3
      );
      expect(
        leveledMaxStamina(
          baseStamina: 100,
          realmTierIndex: 1,
          realmStageIndex: 0,
        ),
        108, // 100 + 4 * 2
      );
    });
  });
}

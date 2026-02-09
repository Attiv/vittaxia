import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/game_constants.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../character/character_provider.dart';

/// 监听已学技能
final learnedSkillsProvider = StreamProvider<List<LearnedSkill>>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value([]);
  final db = ref.watch(databaseProvider);
  return db.watchLearnedSkills(id);
});

/// 已装备技能（筛选 isEquipped）
final equippedSkillsProvider = Provider<List<LearnedSkill>>((ref) {
  final skills = ref.watch(learnedSkillsProvider).valueOrNull ?? [];
  return skills.where((s) => s.isEquipped).toList();
});

class SkillNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;

  SkillNotifier(this._db) : super(const AsyncValue.data(null));

  Future<void> learnSkill(String characterId, String skillId) async {
    await _db.upsertLearnedSkill(LearnedSkillsCompanion.insert(
      id: const Uuid().v4(),
      characterId: characterId,
      skillId: skillId,
    ));
  }

  Future<void> equipSkill(String learnedSkillId, List<LearnedSkill> currentEquipped) async {
    if (currentEquipped.length >= GameConstants.maxEquippedSkills) {
      return; // 已满
    }
    await (_db.update(_db.learnedSkills)
          ..where((t) => t.id.equals(learnedSkillId)))
        .write(const LearnedSkillsCompanion(isEquipped: Value(true)));
  }

  Future<void> unequipSkill(String learnedSkillId) async {
    await (_db.update(_db.learnedSkills)
          ..where((t) => t.id.equals(learnedSkillId)))
        .write(const LearnedSkillsCompanion(isEquipped: Value(false)));
  }

  Future<void> upgradeProficiency(String learnedSkillId, int amount) async {
    final skill = await (_db.select(_db.learnedSkills)
          ..where((t) => t.id.equals(learnedSkillId)))
        .getSingleOrNull();
    if (skill == null) return;

    var newProf = skill.proficiency + amount;
    var newLevel = skill.level;

    // 升级检测: 熟练度满 100 升一级
    while (newProf >= 100) {
      newProf -= 100;
      newLevel++;
    }

    await (_db.update(_db.learnedSkills)
          ..where((t) => t.id.equals(learnedSkillId)))
        .write(LearnedSkillsCompanion(
      proficiency: Value(newProf),
      level: Value(newLevel),
    ));
  }
}

final skillNotifierProvider =
    StateNotifierProvider<SkillNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return SkillNotifier(db);
});

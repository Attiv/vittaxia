import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/game_constants.dart';
import '../../core/utils/character_growth.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../models/enums.dart';
import '../inventory/inventory_provider.dart';
import '../quest/quest_provider.dart';

/// 当前选中的角色 ID
final currentCharacterIdProvider = StateProvider<String?>((ref) => null);

/// 监听当前角色数据
final currentCharacterProvider = StreamProvider<Character?>((ref) {
  final id = ref.watch(currentCharacterIdProvider);
  if (id == null) return Stream.value(null);
  final db = ref.watch(databaseProvider);
  return db.watchCharacter(id);
});

/// 角色列表
final characterListProvider = FutureProvider<List<Character>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.getAllCharacters();
});

/// 角色操作
class CharacterNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  CharacterNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  Future<String> createCharacter(String name) async {
    state = const AsyncValue.loading();
    try {
      final id = const Uuid().v4();
      final now = DateTime.now();
      await _db.insertCharacter(
        CharactersCompanion.insert(
          id: id,
          name: name,
          lastOnlineTime: Value(now),
        ),
      );
      _ref.read(currentCharacterIdProvider.notifier).state = id;
      _ref.invalidate(characterListProvider);

      // 新手引导：赠送基础技能
      await _db.upsertLearnedSkill(
        LearnedSkillsCompanion.insert(
          id: const Uuid().v4(),
          characterId: id,
          skillId: 'basic_fist',
          isEquipped: const Value(true),
        ),
      );
      await _db.upsertLearnedSkill(
        LearnedSkillsCompanion.insert(
          id: const Uuid().v4(),
          characterId: id,
          skillId: 'tuna_breathing',
          isEquipped: const Value(true),
        ),
      );
      // 赠送初始被动技能
      await _db.upsertLearnedSkill(
        LearnedSkillsCompanion.insert(
          id: const Uuid().v4(),
          characterId: id,
          skillId: 'passive_follow_fist',
        ),
      );

      // 赠送初始物品
      final invNotifier = _ref.read(inventoryNotifierProvider.notifier);
      await invNotifier.addItem(id, 'wooden_stick');
      await invNotifier.addItem(id, 'cloth_armor');
      await invNotifier.addItem(id, 'healing_pill', count: 3);

      // 自动接取初始主线任务
      await _ref.read(questNotifierProvider.notifier).autoAcceptMainQuests(id);

      state = const AsyncValue.data(null);
      return id;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateStats({
    required String characterId,
    int? exp,
    int? silver,
    int? currentHp,
    int? currentMp,
    int? reputation,
    int? stamina,
    int? maxStamina,
    int? baseHp,
    int? baseMp,
    int? baseAtk,
    int? baseDef,
    int? baseSpeed,
    DateTime? lastStaminaRegenTime,
    RealmTier? realmTier,
    RealmStage? realmStage,
    String? locationId,
    String? weaponId,
    String? armorId,
    String? shoesId,
    String? accessoryId,
  }) async {
    final companion = CharactersCompanion(
      id: Value(characterId),
      exp: exp != null ? Value(exp) : const Value.absent(),
      silver: silver != null ? Value(silver) : const Value.absent(),
      currentHp: currentHp != null ? Value(currentHp) : const Value.absent(),
      currentMp: currentMp != null ? Value(currentMp) : const Value.absent(),
      reputation: reputation != null ? Value(reputation) : const Value.absent(),
      stamina: stamina != null ? Value(stamina) : const Value.absent(),
      maxStamina: maxStamina != null ? Value(maxStamina) : const Value.absent(),
      baseHp: baseHp != null ? Value(baseHp) : const Value.absent(),
      baseMp: baseMp != null ? Value(baseMp) : const Value.absent(),
      baseAtk: baseAtk != null ? Value(baseAtk) : const Value.absent(),
      baseDef: baseDef != null ? Value(baseDef) : const Value.absent(),
      baseSpeed: baseSpeed != null ? Value(baseSpeed) : const Value.absent(),
      lastStaminaRegenTime: lastStaminaRegenTime != null
          ? Value(lastStaminaRegenTime)
          : const Value.absent(),
      realmTierIndex: realmTier != null
          ? Value(realmTier.index)
          : const Value.absent(),
      realmStageIndex: realmStage != null
          ? Value(realmStage.index)
          : const Value.absent(),
      locationId: locationId != null ? Value(locationId) : const Value.absent(),
      weaponId: weaponId != null ? Value(weaponId) : const Value.absent(),
      armorId: armorId != null ? Value(armorId) : const Value.absent(),
      shoesId: shoesId != null ? Value(shoesId) : const Value.absent(),
      accessoryId: accessoryId != null
          ? Value(accessoryId)
          : const Value.absent(),
      lastOnlineTime: Value(DateTime.now()),
    );
    await _db.updateCharacter(companion);
  }

  /// 增加经验并自动检查境界突破，返回突破后的境界名（未突破返回 null）
  Future<String?> addExp(String characterId, int amount) async {
    final character = await _db.getCharacter(characterId);
    if (character == null) return null;

    var exp = character.exp + amount;
    var tierIndex = character.realmTierIndex;
    var stageIndex = character.realmStageIndex;
    var upgraded = false;
    var hpGain = 0, mpGain = 0, atkGain = 0, defGain = 0, speedGain = 0;

    // 循环处理连续突破
    while (true) {
      final tier = RealmTier.values[tierIndex];
      final stage = RealmStage.values[stageIndex];
      if (tier == RealmTier.huaJing && stage == RealmStage.peak) break;

      final required = tier.rank * stage.rank * GameConstants.realmExpBase;
      if (exp < required) break;

      exp -= required;
      upgraded = true;

      if (stage == RealmStage.peak) {
        tierIndex++;
        stageIndex = 0;
      } else {
        stageIndex++;
      }

      hpGain += GameConstants.realmUpgradeHp;
      mpGain += GameConstants.realmUpgradeMp;
      atkGain += GameConstants.realmUpgradeAtk;
      defGain += GameConstants.realmUpgradeDef;
      speedGain += GameConstants.realmUpgradeSpeed;
    }

    if (upgraded) {
      final newTier = RealmTier.values[tierIndex];
      final newStage = RealmStage.values[stageIndex];
      final newBaseHp = character.baseHp + hpGain;
      final newBaseMp = character.baseMp + mpGain;
      final fullHp = leveledMaxHp(
        baseHp: newBaseHp,
        realmTierIndex: tierIndex,
        realmStageIndex: stageIndex,
      );
      final fullMp = leveledMaxMp(
        baseMp: newBaseMp,
        realmTierIndex: tierIndex,
        realmStageIndex: stageIndex,
      );
      await updateStats(
        characterId: characterId,
        exp: exp,
        realmTier: newTier,
        realmStage: newStage,
        baseHp: newBaseHp,
        baseMp: newBaseMp,
        baseAtk: character.baseAtk + atkGain,
        baseDef: character.baseDef + defGain,
        baseSpeed: character.baseSpeed + speedGain,
        currentHp: fullHp,
        currentMp: fullMp,
      );
      return '${newTier.label}${newStage.label}';
    } else {
      await updateStats(characterId: characterId, exp: exp);
      return null;
    }
  }

  /// 消耗体力，返回是否成功
  Future<bool> consumeStamina(String characterId, int amount) async {
    final character = await _db.getCharacter(characterId);
    if (character == null || character.stamina < amount) return false;
    await updateStats(
      characterId: characterId,
      stamina: character.stamina - amount,
      lastStaminaRegenTime: character.lastStaminaRegenTime ?? DateTime.now(),
    );
    return true;
  }

  /// 离线体力恢复：每2分钟恢复1点（提高在线恢复速度）
  Future<void> regenStamina(String characterId) async {
    final character = await _db.getCharacter(characterId);
    if (character == null) return;
    final maxStamina = character.levelMaxStamina;
    final lastRegen = character.lastStaminaRegenTime;
    if (lastRegen == null || character.stamina >= maxStamina) return;

    final elapsed = DateTime.now().difference(lastRegen).inMinutes;
    final regenAmount = elapsed ~/ GameConstants.staminaRegenMinutes;
    if (regenAmount <= 0) return;

    final newStamina = (character.stamina + regenAmount).clamp(0, maxStamina);
    await updateStats(
      characterId: characterId,
      stamina: newStamina,
      lastStaminaRegenTime: DateTime.now(),
    );
  }
}

final characterNotifierProvider =
    StateNotifierProvider<CharacterNotifier, AsyncValue<void>>((ref) {
      final db = ref.watch(databaseProvider);
      return CharacterNotifier(db, ref);
    });

import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    @Default(100) int baseHp,
    @Default(50) int baseMp,
    @Default(10) int baseAtk,
    @Default(5) int baseDef,
    @Default(8) int baseSpeed,
    @Default(5) int baseLuck,
    @Default(10) int baseComprehension,
    @Default(0) int exp,
    @Default(100) int silver,
    @Default(0) int reputation,
    @Default(RealmTier.lianQi) RealmTier realmTier,
    @Default(RealmStage.early) RealmStage realmStage,
    // 当前状态
    @Default(100) int currentHp,
    @Default(50) int currentMp,
    // 装备 ID
    String? weaponId,
    String? armorId,
    String? shoesId,
    String? accessoryId,
    // 位置
    @Default('qingyun_village') String locationId,
    // 时间
    DateTime? lastOnlineTime,
    DateTime? createdAt,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

/// 境界完整描述
extension CharacterRealm on Character {
  String get realmName => '${realmTier.label}${realmStage.label}';

  /// 下一个阶段需要的经验
  int get expToNextStage {
    return realmTier.rank * realmStage.rank * 100;
  }
}

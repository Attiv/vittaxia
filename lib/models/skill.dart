import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

/// 技能模板
@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String name,
    required String description,
    required SkillType type,
    @Default(SkillQuality.crude) SkillQuality quality,
    @Default(10) int baseDamage,
    @Default(1.0) double damageMultiplier,
    @Default(0) int mpCost,
    // buff 效果
    @Default(0) int buffAtk,
    @Default(0) int buffDef,
    @Default(0) int buffSpeed,
    @Default(0) int healAmount,
    @Default(0) int buffDuration,
    // 学习条件
    @Default(0) int requiredLevel,
    @Default(0) int learnCost,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

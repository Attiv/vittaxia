/// 装备强化配方
class EnhanceRecipe {
  final int level; // 目标等级
  final String materialId;
  final int materialCount;
  final int silverCost;
  final double successRate;

  const EnhanceRecipe({
    required this.level,
    required this.materialId,
    required this.materialCount,
    required this.silverCost,
    required this.successRate,
  });
}

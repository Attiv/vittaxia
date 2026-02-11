import '../models/enhance_recipe.dart';

/// 强化配方表 (+1 ~ +10)
final enhanceRecipes = <int, EnhanceRecipe>{
  1: const EnhanceRecipe(level: 1, materialId: 'rough_iron', materialCount: 2, silverCost: 20, successRate: 0.95),
  2: const EnhanceRecipe(level: 2, materialId: 'rough_iron', materialCount: 3, silverCost: 40, successRate: 0.90),
  3: const EnhanceRecipe(level: 3, materialId: 'rough_iron', materialCount: 5, silverCost: 60, successRate: 0.85),
  4: const EnhanceRecipe(level: 4, materialId: 'fine_iron', materialCount: 2, silverCost: 100, successRate: 0.75),
  5: const EnhanceRecipe(level: 5, materialId: 'fine_iron', materialCount: 3, silverCost: 150, successRate: 0.65),
  6: const EnhanceRecipe(level: 6, materialId: 'fine_iron', materialCount: 5, silverCost: 200, successRate: 0.55),
  7: const EnhanceRecipe(level: 7, materialId: 'mystic_ore', materialCount: 2, silverCost: 300, successRate: 0.45),
  8: const EnhanceRecipe(level: 8, materialId: 'mystic_ore', materialCount: 3, silverCost: 400, successRate: 0.35),
  9: const EnhanceRecipe(level: 9, materialId: 'mystic_ore', materialCount: 5, silverCost: 500, successRate: 0.25),
  10: const EnhanceRecipe(level: 10, materialId: 'star_iron', materialCount: 3, silverCost: 800, successRate: 0.15),
};

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/enhance_data.dart';
import '../../data/item_data.dart';
import '../../models/item.dart';
import '../character/character_provider.dart';
import 'inventory_provider.dart';

class EnhanceSheet extends ConsumerStatefulWidget {
  final String inventoryId;
  final String itemId;
  final int currentLevel;

  const EnhanceSheet({
    super.key,
    required this.inventoryId,
    required this.itemId,
    required this.currentLevel,
  });

  @override
  ConsumerState<EnhanceSheet> createState() => _EnhanceSheetState();
}

class _EnhanceSheetState extends ConsumerState<EnhanceSheet> {
  String? _resultText;
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final item = items[widget.itemId];
    if (item == null) return const SizedBox.shrink();

    final nextLevel = widget.currentLevel + 1;
    final recipe = enhanceRecipes[nextLevel];
    final character = ref.watch(currentCharacterProvider).valueOrNull;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '强化 - ${item.name} +${widget.currentLevel}',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _bonusPreview(item, widget.currentLevel, nextLevel),
          const SizedBox(height: 12),
          if (recipe == null)
            Text(
              '已达最高强化等级',
              style: TextStyle(color: AppColors.warning, fontSize: 14),
            )
          else ...[
            _recipeInfo(recipe, character),
            const SizedBox(height: 16),
            if (_resultText != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _resultText!,
                  style: TextStyle(
                    color: _resultText!.contains('成功')
                        ? AppColors.success
                        : AppColors.danger,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('确定'),
              ),
            ] else
              ElevatedButton(
                onPressed: _processing ? null : () => _doEnhance(),
                child: Text(_processing ? '强化中...' : '强化'),
              ),
          ],
        ],
      ),
    );
  }

  Widget _bonusPreview(Item item, int curLv, int nextLv) {
    final lines = <String>[];
    void check(String label, int base) {
      if (base <= 0) return;
      final cur = base + (curLv > 0 ? (base * curLv * 0.1).ceil() : 0);
      final next = base + (base * nextLv * 0.1).ceil();
      lines.add('$label: $cur -> $next');
    }

    check('攻击', item.atkBonus);
    check('防御', item.defBonus);
    check('气血', item.hpBonus);
    check('内力', item.mpBonus);
    check('速度', item.speedBonus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines
          .map(
            (l) => Text(
              l,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
            ),
          )
          .toList(),
    );
  }

  Widget _recipeInfo(dynamic recipe, dynamic character) {
    final materialName = items[recipe.materialId]?.name ?? recipe.materialId;
    final hasEnoughSilver =
        character != null && character.silver >= recipe.silverCost;
    final rate = (recipe.successRate * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '需要: $materialName x${recipe.materialCount}',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        Text(
          '银两: ${recipe.silverCost}',
          style: TextStyle(
            color: hasEnoughSilver ? AppColors.textSecondary : AppColors.danger,
            fontSize: 13,
          ),
        ),
        Text(
          '成功率: $rate%',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  Future<void> _doEnhance() async {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character == null) return;

    setState(() => _processing = true);
    final result = await ref
        .read(inventoryNotifierProvider.notifier)
        .enhanceItem(character.id, widget.inventoryId);
    setState(() => _processing = false);

    if (result == null) {
      setState(() => _resultText = '材料或银两不足');
    } else if (result) {
      setState(() => _resultText = '强化成功！');
    } else {
      setState(() => _resultText = '强化失败，材料已消耗');
    }
  }
}

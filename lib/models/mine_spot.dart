/// 矿点掉落项
class MineDrop {
  final String itemId;
  final int weight;
  final int minCount;
  final int maxCount;

  const MineDrop({
    required this.itemId,
    required this.weight,
    this.minCount = 1,
    this.maxCount = 1,
  });
}

/// 矿点定义
class MineSpot {
  final String id;
  final String name;
  final String locationId;
  final int staminaCost;
  final List<MineDrop> drops;

  const MineSpot({
    required this.id,
    required this.name,
    required this.locationId,
    required this.staminaCost,
    required this.drops,
  });
}

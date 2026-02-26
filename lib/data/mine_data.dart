import '../models/mine_spot.dart';

/// 矿点数据
final mineSpots = <String, MineSpot>{
  'bamboo_mine': const MineSpot(
    id: 'bamboo_mine',
    name: '竹林矿洞',
    locationId: 'qingzhu_forest',
    staminaCost: 15,
    drops: [
      MineDrop(itemId: 'rough_iron', weight: 60, minCount: 1, maxCount: 2),
      MineDrop(itemId: 'fine_iron', weight: 25),
      MineDrop(itemId: 'mystic_ore', weight: 10),
      MineDrop(itemId: 'star_iron', weight: 5),
    ],
  ),
  'luoxia_mine': const MineSpot(
    id: 'luoxia_mine',
    name: '落霞矿脉',
    locationId: 'luoxia_mountains',
    staminaCost: 20,
    drops: [
      MineDrop(itemId: 'rough_iron', weight: 30),
      MineDrop(itemId: 'fine_iron', weight: 45, minCount: 1, maxCount: 2),
      MineDrop(itemId: 'mystic_ore', weight: 20),
      MineDrop(itemId: 'star_iron', weight: 5),
    ],
  ),
  'mist_mine': const MineSpot(
    id: 'mist_mine',
    name: '迷雾深矿',
    locationId: 'miwu_valley',
    staminaCost: 25,
    drops: [
      MineDrop(itemId: 'fine_iron', weight: 25),
      MineDrop(itemId: 'mystic_ore', weight: 45, minCount: 1, maxCount: 2),
      MineDrop(itemId: 'star_iron', weight: 20),
      MineDrop(itemId: 'tianxing_stone', weight: 10),
    ],
  ),
  'marsh_mine': const MineSpot(
    id: 'marsh_mine',
    name: '沼泽黑矿',
    locationId: 'youming_marsh',
    staminaCost: 28,
    drops: [
      MineDrop(itemId: 'mystic_ore', weight: 40, minCount: 1, maxCount: 2),
      MineDrop(itemId: 'star_iron', weight: 28),
      MineDrop(itemId: 'void_crystal', weight: 20),
      MineDrop(itemId: 'tianxing_stone', weight: 12),
    ],
  ),
  'xuanbing_mine': const MineSpot(
    id: 'xuanbing_mine',
    name: '寒潭晶脉',
    locationId: 'xuanbing_lake',
    staminaCost: 32,
    drops: [
      MineDrop(itemId: 'star_iron', weight: 38, minCount: 1, maxCount: 2),
      MineDrop(itemId: 'void_crystal', weight: 32),
      MineDrop(itemId: 'tianxing_stone', weight: 20),
      MineDrop(itemId: 'mystic_ore', weight: 10),
    ],
  ),
};

/// 根据地点查找矿点
MineSpot? getMineSpotByLocation(String locationId) {
  for (final spot in mineSpots.values) {
    if (spot.locationId == locationId) return spot;
  }
  return null;
}

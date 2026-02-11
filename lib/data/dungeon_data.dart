import '../models/dungeon.dart';

/// 洞府数据
final dungeonTemplates = <String, DungeonTemplate>{
  'bamboo_cave': const DungeonTemplate(
    id: 'bamboo_cave',
    name: '青竹秘洞',
    description: '青竹林深处的隐秘洞穴，据说曾有前辈在此闭关。',
    totalFloors: 5,
    requiredDangerLevel: 2,
    locationId: 'qingzhu_forest',
    floors: [
      DungeonFloor(
        floor: 1, name: '蛇窝', description: '洞口盘踞着一条毒蛇，挡住了去路。',
        eventType: DungeonEventType.battle, enemyId: 'cave_snake',
        rewardItemId: 'rough_iron', rewardExp: 15, rewardSilver: 10, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 2, name: '藤蔓机关', description: '脚下的藤蔓突然收紧，暗藏杀机。',
        eventType: DungeonEventType.trap, hpChange: -15,
        rewardItemId: 'bixin_herb', rewardExp: 10, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 3, name: '石室宝箱', description: '一间石室中央放着一个落满灰尘的箱子。',
        eventType: DungeonEventType.treasure,
        rewardItemId: 'fine_iron', rewardItemCount: 2, rewardExp: 10, rewardSilver: 20, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 4, name: '泉眼休息', description: '一处清澈的地下泉眼，泉水甘甜，恢复精力。',
        eventType: DungeonEventType.rest, healHp: 30, staminaCost: 3,
      ),
      DungeonFloor(
        floor: 5, name: '竹林剑客', description: '洞穴最深处，一位剑客负手而立，似乎在等待挑战者。',
        eventType: DungeonEventType.boss, enemyId: 'bamboo_swordsman',
        rewardSkillId: 'jade_bamboo_sword', rewardItemId: 'qingzhu_sword',
        rewardExp: 60, rewardSilver: 50, staminaCost: 8,
      ),
    ],
  ),
  // PLACEHOLDER_LUOXIA
  'luoxia_mine_dungeon': const DungeonTemplate(
    id: 'luoxia_mine_dungeon',
    name: '落霞古矿',
    description: '落霞山脉中废弃已久的矿洞，深处似乎藏着什么秘密。',
    totalFloors: 7,
    requiredDangerLevel: 4,
    locationId: 'luoxia_mountains',
    floors: [
      DungeonFloor(
        floor: 1, name: '矿洞蝙蝠', description: '成群的蝙蝠从黑暗中扑来。',
        eventType: DungeonEventType.battle, enemyId: 'mine_bat',
        rewardItemId: 'rough_iron', rewardItemCount: 2, rewardExp: 15, rewardSilver: 10, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 2, name: '塌方陷阱', description: '脚下一松，碎石从头顶倾泻而下。',
        eventType: DungeonEventType.trap, hpChange: -20, rewardExp: 10, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 3, name: '矿脉宝藏', description: '墙壁上嵌着闪闪发光的矿石。',
        eventType: DungeonEventType.treasure,
        rewardItemId: 'mystic_ore', rewardItemCount: 2, rewardExp: 15, rewardSilver: 30, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 4, name: '地下暗河', description: '一条地下河流过，河水冰凉，可以稍作休息。',
        eventType: DungeonEventType.rest, healHp: 25, staminaCost: 3,
      ),
      DungeonFloor(
        floor: 5, name: '山贼精英', description: '几个山贼在此设了据点，看来是矿洞的常客。',
        eventType: DungeonEventType.battle, enemyId: 'bandit',
        rewardItemId: 'fine_iron', rewardItemCount: 3, rewardExp: 25, rewardSilver: 20, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 6, name: '古矿石室', description: '一间被遗忘的石室，角落里堆着旧物。',
        eventType: DungeonEventType.treasure,
        rewardItemId: 'iron_mail', rewardExp: 20, rewardSilver: 40, staminaCost: 5,
      ),
      DungeonFloor(
        floor: 7, name: '矿洞主人', description: '矿洞深处的主人，一个身材魁梧的壮汉，手持巨锤。',
        eventType: DungeonEventType.boss, enemyId: 'mine_lord',
        rewardSkillId: 'golden_bell', rewardItemId: 'star_iron',
        rewardExp: 80, rewardSilver: 60, staminaCost: 8,
      ),
    ],
  ),
  // PLACEHOLDER_MIST
  'mist_dungeon': const DungeonTemplate(
    id: 'mist_dungeon',
    name: '迷雾幽府',
    description: '迷雾谷深处的古老府邸，传闻是某位绝世高手的埋骨之地。',
    totalFloors: 9,
    requiredDangerLevel: 6,
    locationId: 'miwu_valley',
    floors: [
      DungeonFloor(
        floor: 1, name: '雾中幽影', description: '浓雾中隐约有黑影闪过，杀意凛然。',
        eventType: DungeonEventType.battle, enemyId: 'ghost',
        rewardItemId: 'mystic_ore', rewardExp: 20, rewardSilver: 15, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 2, name: '毒雾走廊', description: '走廊中弥漫着淡紫色的毒雾，令人头晕目眩。',
        eventType: DungeonEventType.trap, hpChange: -25, rewardExp: 15, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 3, name: '灵药宝库', description: '一间密室中整齐摆放着各种灵药。',
        eventType: DungeonEventType.treasure,
        rewardItemId: 'bixin_herb', rewardItemCount: 3, rewardExp: 15, rewardSilver: 25, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 4, name: '灵泉', description: '一汪灵泉散发着柔和的光芒，浸泡其中百骸舒畅。',
        eventType: DungeonEventType.rest, healHp: 40, staminaCost: 4,
      ),
      DungeonFloor(
        floor: 5, name: '守墓武士', description: '身着古甲的武士拦住去路，眼中毫无生气。',
        eventType: DungeonEventType.battle, enemyId: 'tomb_warrior',
        rewardItemId: 'fine_iron', rewardItemCount: 2, rewardExp: 35, rewardSilver: 25, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 6, name: '古阵机关', description: '地面上刻满了奇异的符文，一踏入便触发了阵法。',
        eventType: DungeonEventType.trap, hpChange: -30,
        rewardItemId: 'tianxing_stone', rewardExp: 20, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 7, name: '藏经阁', description: '满墙的竹简和古籍，其中一卷散发着微光。',
        eventType: DungeonEventType.treasure,
        rewardSkillId: 'moongazing_art', rewardExp: 30, rewardSilver: 40, staminaCost: 6,
      ),
      DungeonFloor(
        floor: 8, name: '冥想石台', description: '一方巨大的石台，坐上去便感到心神宁静。',
        eventType: DungeonEventType.rest, healHp: 50, staminaCost: 4,
      ),
      DungeonFloor(
        floor: 9, name: '幽府之主', description: '府邸最深处，一道残影凝聚成形，散发着令人窒息的威压。',
        eventType: DungeonEventType.boss, enemyId: 'phantom_lord',
        rewardItemId: 'golden_silk_vest', rewardExp: 120, rewardSilver: 100, staminaCost: 10,
      ),
    ],
  ),
};

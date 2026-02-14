/// 境界等级
enum RealmTier {
  lianQi('初学', 1),
  lianTi('入门', 2),
  houTian('小成', 3),
  xianTian('大成', 4),
  zhuJi('通脉', 5),
  guiYuan('归元', 6),
  zongShi('宗师', 7),
  wuSheng('武圣', 8),
  huaJing('化境', 9);

  final String label;
  final int rank;
  const RealmTier(this.label, this.rank);
}

/// 境界阶段
enum RealmStage {
  early('初期', 1),
  mid('中期', 2),
  late_('后期', 3),
  peak('巅峰', 4);

  final String label;
  final int rank;
  const RealmStage(this.label, this.rank);
}

/// 装备槽位
enum EquipSlot {
  weapon('武器'),
  armor('防具'),
  shoes('鞋子'),
  accessory('饰品');

  final String label;
  const EquipSlot(this.label);
}

/// 物品类型
enum ItemType {
  weapon('武器'),
  armor('防具'),
  shoes('鞋子'),
  accessory('饰品'),
  consumable('消耗品'),
  material('材料'),
  questItem('任务道具');

  final String label;
  const ItemType(this.label);
}

/// 物品品质
enum ItemRarity {
  common('普通', 1),
  uncommon('良品', 2),
  rare('精品', 3),
  epic('极品', 4),
  legendary('传说', 5);

  final String label;
  final int rank;
  const ItemRarity(this.label, this.rank);
}

/// 技能类型
enum SkillType {
  attack('招式'),
  innerForce('内功'),
  movement('轻功'),
  hidden('暗器'),
  passive('被动');

  final String label;
  const SkillType(this.label);
}

/// 技能品质
enum SkillQuality {
  crude('粗浅', 1),
  refined('精妙', 2),
  superior('上乘', 3),
  ultimate('绝学', 4),
  divine('神功', 5);

  final String label;
  final int rank;
  const SkillQuality(this.label, this.rank);
}

/// NPC 类型
enum NpcType {
  story('剧情关键'),
  merchant('商人'),
  master('师傅'),
  questGiver('任务发布'),
  companion('伙伴'),
  hostile('敌对');

  final String label;
  const NpcType(this.label);
}

/// 地图地点类型
enum LocationType {
  village('村镇'),
  city('城市'),
  wilderness('野外'),
  dungeon('秘境'),
  sect('门派'),
  special('特殊');

  final String label;
  const LocationType(this.label);
}

/// 任务类型
enum QuestType {
  main('主线'),
  side('支线'),
  hidden('隐藏');

  final String label;
  const QuestType(this.label);
}

/// 任务目标类型
enum QuestObjectiveType {
  kill('击败'),
  collect('收集'),
  talk('对话'),
  explore('探索');

  final String label;
  const QuestObjectiveType(this.label);
}

/// 随机事件类型
enum GameEventType {
  battle('战斗'),
  treasure('宝物'),
  npcEncounter('NPC遭遇'),
  trap('陷阱'),
  scenery('风景'),
  adventure('奇遇'),
  merchant('商人');

  final String label;
  const GameEventType(this.label);
}

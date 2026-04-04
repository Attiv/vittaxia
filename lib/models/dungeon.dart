/// 洞府层事件类型
enum DungeonEventType { battle, treasure, trap, rest, boss }

/// 洞府单层定义
class DungeonFloor {
  final int floor;
  final String name;
  final String description;
  final DungeonEventType eventType;
  final String? enemyId;
  final String? rewardItemId;
  final int rewardItemCount;
  final String? rewardSkillId;
  final int rewardExp;
  final int rewardSilver;
  final int hpChange;
  final int healHp;
  final int staminaCost;

  const DungeonFloor({
    required this.floor,
    required this.name,
    required this.description,
    required this.eventType,
    this.enemyId,
    this.rewardItemId,
    this.rewardItemCount = 1,
    this.rewardSkillId,
    this.rewardExp = 0,
    this.rewardSilver = 0,
    this.hpChange = 0,
    this.healHp = 0,
    this.staminaCost = 5,
  });
}

/// 洞府模板
class DungeonTemplate {
  final String id;
  final String name;
  final String description;
  final int totalFloors;
  final int requiredDangerLevel;
  final String locationId;
  final int? storyOrder;
  final String? chapterLabel;
  final String? subtitle;
  final String? storyLead;
  final String? storyIntro;
  final String? storyOutro;
  final String? requiredDungeonId;
  final String? collectibleItemId;
  final List<DungeonFloor> floors;

  const DungeonTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.totalFloors,
    required this.requiredDangerLevel,
    required this.locationId,
    this.storyOrder,
    this.chapterLabel,
    this.subtitle,
    this.storyLead,
    this.storyIntro,
    this.storyOutro,
    this.requiredDungeonId,
    this.collectibleItemId,
    required this.floors,
  });
}

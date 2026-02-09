/// 敌人模板
class EnemyTemplate {
  final String id;
  final String name;
  final int hp;
  final int mp;
  final int atk;
  final int def;
  final int speed;
  final List<String> skillIds;
  final int expReward;
  final int silverReward;
  final String? dropItemId;
  final double dropRate;

  const EnemyTemplate({
    required this.id,
    required this.name,
    required this.hp,
    required this.mp,
    required this.atk,
    required this.def,
    required this.speed,
    this.skillIds = const [],
    this.expReward = 10,
    this.silverReward = 5,
    this.dropItemId,
    this.dropRate = 0.3,
  });
}

final enemies = <String, EnemyTemplate>{
  'wild_dog': const EnemyTemplate(
    id: 'wild_dog',
    name: '野狗',
    hp: 40,
    mp: 0,
    atk: 6,
    def: 2,
    speed: 6,
    skillIds: ['basic_fist'],
    expReward: 6,
    silverReward: 2,
  ),
  'drunkard': const EnemyTemplate(
    id: 'drunkard',
    name: '醉汉',
    hp: 60,
    mp: 10,
    atk: 8,
    def: 3,
    speed: 4,
    skillIds: ['basic_fist'],
    expReward: 10,
    silverReward: 5,
  ),
  'wild_boar': const EnemyTemplate(
    id: 'wild_boar',
    name: '野猪',
    hp: 80,
    mp: 0,
    atk: 12,
    def: 6,
    speed: 5,
    skillIds: ['basic_fist'],
    expReward: 15,
    silverReward: 3,
  ),
  'bandit': const EnemyTemplate(
    id: 'bandit',
    name: '山贼',
    hp: 100,
    mp: 20,
    atk: 15,
    def: 8,
    speed: 7,
    skillIds: ['basic_fist', 'basic_kick'],
    expReward: 25,
    silverReward: 15,
    dropItemId: 'bandit_saber',
    dropRate: 0.15,
  ),
  'bandit_leader': const EnemyTemplate(
    id: 'bandit_leader',
    name: '山贼头子',
    hp: 180,
    mp: 40,
    atk: 22,
    def: 12,
    speed: 9,
    skillIds: ['iron_palm', 'basic_kick'],
    expReward: 50,
    silverReward: 40,
    dropItemId: 'cold_moon_blade',
    dropRate: 0.1,
  ),
  'tianjian_disciple': const EnemyTemplate(
    id: 'tianjian_disciple',
    name: '天剑门弟子',
    hp: 150,
    mp: 60,
    atk: 20,
    def: 15,
    speed: 12,
    skillIds: ['gale_sword', 'golden_bell'],
    expReward: 60,
    silverReward: 0,
  ),
  'shadow_assassin': const EnemyTemplate(
    id: 'shadow_assassin',
    name: '暗影刺客',
    hp: 120,
    mp: 30,
    atk: 18,
    def: 8,
    speed: 14,
    skillIds: ['basic_fist', 'basic_kick'],
    expReward: 35,
    silverReward: 20,
    dropItemId: 'healing_pill',
    dropRate: 0.2,
  ),
  'ghost': const EnemyTemplate(
    id: 'ghost',
    name: '怨灵',
    hp: 130,
    mp: 50,
    atk: 16,
    def: 5,
    speed: 10,
    skillIds: ['basic_fist'],
    expReward: 40,
    silverReward: 0,
    dropItemId: 'bixin_herb',
    dropRate: 0.25,
  ),
};

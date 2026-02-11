import '../models/enums.dart';
import '../models/map_location.dart';

/// 游戏地图数据
/// 地图结构:
///            [落霞山脉] (4)
///                |
///   [青云村]---+---[清风镇] (1)
///   (起始,1)       |
///      |       [望月楼] (3)
///   [青竹林]
///   (2)        [迷雾谷] (6, 先天)
///                |
///           [天剑门外] (5, 主线)
final mapLocations = <String, MapLocation>{
  'qingyun_village': const MapLocation(
    id: 'qingyun_village',
    name: '青云村',
    description: '一座宁静的小山村，四面环山，民风淳朴。村口的老槐树下常有孩童嬉戏，是你成长的地方。',
    type: LocationType.village,
    dangerLevel: 1,
    adjacentIds: ['qingfeng_town', 'qingzhu_forest'],
    npcIds: ['zhang_dashu', 'li_yaopo', 'chen_laotou'],
    eventIds: [
      'qy_herb_picking',
      'qy_old_man_story',
      'qy_chicken_chase',
      'qy_mysterious_traveler',
      'qy_wild_dog',
    ],
    explorationSeconds: 20,
  ),
  'qingfeng_town': const MapLocation(
    id: 'qingfeng_town',
    name: '清风镇',
    description: '江湖人来人往的小镇，酒楼茶馆林立，是消息汇聚之地。醉仙楼的酒香飘出半条街。',
    type: LocationType.city,
    dangerLevel: 1,
    adjacentIds: ['qingyun_village', 'wangyue_tower', 'luoxia_mountains'],
    npcIds: ['liu_ruyan', 'bai_wuchang', 'sun_yishou'],
    eventIds: [
      'qf_street_fight',
      'qf_merchant_deal',
      'qf_rumor',
      'qf_pickpocket',
      'qf_wine_contest',
      'qf_night_patrol',
      'qf_story_fragment',
      'qf_blacksmith_invoice',
      'qf_gate_rumor_update',
    ],
    explorationSeconds: 25,
  ),
  'qingzhu_forest': const MapLocation(
    id: 'qingzhu_forest',
    name: '青竹林',
    description: '村子东边的茂密竹林，幽深静谧。林中偶有野兽出没，但也生长着不少珍贵药材。',
    type: LocationType.wilderness,
    dangerLevel: 2,
    adjacentIds: ['qingyun_village'],
    npcIds: [],
    eventIds: [
      'qz_wild_boar',
      'qz_herb_find',
      'qz_bamboo_training',
      'qz_hidden_cave',
      'qz_snake_encounter',
      'qz_starfall_fragment',
    ],
    explorationSeconds: 30,
  ),
  'wangyue_tower': const MapLocation(
    id: 'wangyue_tower',
    name: '望月楼',
    description: '清风镇外的一座古塔，传闻是某位前辈高人修行之所。月圆之夜，楼上常传出悠扬琴声。',
    type: LocationType.special,
    dangerLevel: 3,
    adjacentIds: ['qingfeng_town'],
    npcIds: ['su_wanyin'],
    eventIds: [
      'wy_moonlight_practice',
      'wy_ancient_scroll',
      'wy_spirit_test',
      'wy_shadow_duel',
      'wy_moonflower_bloom',
    ],
    explorationSeconds: 35,
  ),
  'luoxia_mountains': const MapLocation(
    id: 'luoxia_mountains',
    name: '落霞山脉',
    description: '绵延数十里的山脉，山势险峻。近来有山贼盘踞，往来客商苦不堪言。',
    type: LocationType.wilderness,
    dangerLevel: 4,
    adjacentIds: ['qingfeng_town', 'miwu_valley'],
    npcIds: ['qin_zhu'],
    eventIds: [
      'lx_bandit_ambush',
      'lx_cliff_treasure',
      'lx_eagle_encounter',
      'lx_hermit_hut',
      'lx_bandit_camp',
      'lx_cold_iron_vein',
      'lx_mine_trail_cleanup',
      'lx_forge_supply_cache',
    ],
    explorationSeconds: 40,
  ),
  'miwu_valley': const MapLocation(
    id: 'miwu_valley',
    name: '迷雾谷',
    description: '常年弥漫浓雾的山谷，据说是通往天剑门的必经之路。雾中时有怪声，令人毛骨悚然。',
    type: LocationType.dungeon,
    dangerLevel: 6,
    adjacentIds: ['luoxia_mountains', 'tianjian_gate'],
    npcIds: ['lin_feng'],
    eventIds: [
      'mw_fog_illusion',
      'mw_ghost_encounter',
      'mw_ancient_tomb',
      'mw_poison_trap',
      'mw_waymarker_trace',
    ],
    explorationSeconds: 50,
    requiredRealm: RealmTier.xianTian,
  ),
  'tianjian_gate': const MapLocation(
    id: 'tianjian_gate',
    name: '天剑门外',
    description: '天剑门是江湖第一大派，门派坐落于云雾缭绕的山巅。门外石阶千级，气势恢宏。',
    type: LocationType.sect,
    dangerLevel: 5,
    adjacentIds: ['miwu_valley'],
    npcIds: [],
    eventIds: [
      'tj_disciple_challenge',
      'tj_sword_intent',
      'tj_gate_resonance',
    ],
    explorationSeconds: 45,
    requiredQuestId: 'main_07',
  ),
};

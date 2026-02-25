import '../models/map_location.dart';
import '../models/enums.dart';

/// 新增地图位置 - 京城及周边

final extendedMapLocations = <String, MapLocation>{
  // 京城
  'capital_city': const MapLocation(
    id: 'capital_city',
    name: '京城',
    description: '大周王朝的都城，繁华热闹。但在繁华的表面下，暗流涌动，权力斗争从未停止。',
    type: LocationType.city,
    dangerLevel: 7,
    adjacentIds: ['miwu_valley', 'imperial_palace', 'prime_minister_mansion'],
    npcIds: [
      'qian_laoban',
      'liu_langzhong',
      'shadow_guard',
      'blood_hand',
    ],
    eventIds: [
      'capital_street_patrol',
      'capital_merchant',
      'capital_beggar_info',
      'capital_assassin',
      'capital_noble_carriage',
    ],
    explorationSeconds: 60,
    requiredRealm: RealmTier.xianTian,
  ),

  // 皇宫
  'imperial_palace': const MapLocation(
    id: 'imperial_palace',
    name: '皇宫',
    description: '戒备森严的皇宫，金碧辉煌。只有得到许可的人才能进入。',
    type: LocationType.special,
    dangerLevel: 9,
    adjacentIds: ['capital_city'],
    npcIds: [
      'young_emperor',
      'princess_mingzhu',
      'eunuch_wei',
    ],
    eventIds: [
      'palace_guard_patrol',
      'palace_intrigue',
      'palace_banquet',
    ],
    explorationSeconds: 45,
    requiredQuestId: 'palace_06',
  ),

  // 丞相府
  'prime_minister_mansion': const MapLocation(
    id: 'prime_minister_mansion',
    name: '丞相府',
    description: '李丞相的府邸，书香门第。府中藏书万卷，常有文人雅士来访。',
    type: LocationType.special,
    dangerLevel: 6,
    adjacentIds: ['capital_city'],
    npcIds: ['prime_minister'],
    eventIds: [
      'pm_mansion_study',
      'pm_mansion_garden',
      'pm_mansion_threat',
    ],
    explorationSeconds: 40,
    requiredQuestId: 'palace_03',
  ),

  // 魏府
  'wei_mansion': const MapLocation(
    id: 'wei_mansion',
    name: '魏府',
    description: '魏公公的府邸，阴森恐怖。据说府中有密道通往皇宫。',
    type: LocationType.dungeon,
    dangerLevel: 8,
    adjacentIds: ['capital_city'],
    npcIds: ['eunuch_wei', 'shadow_guard'],
    eventIds: [
      'wei_mansion_trap',
      'wei_mansion_secret',
      'wei_mansion_dungeon',
    ],
    explorationSeconds: 50,
    requiredQuestId: 'revenge_04',
  ),

  // 雪山
  'snow_mountain': const MapLocation(
    id: 'snow_mountain',
    name: '雪山',
    description: '终年积雪的高山，寒风刺骨。传说山顶生长着千年雪莲。',
    type: LocationType.wilderness,
    dangerLevel: 10,
    adjacentIds: ['capital_city'],
    npcIds: [],
    eventIds: [
      'snow_avalanche',
      'snow_beast',
      'snow_lotus_find',
      'snow_hermit',
    ],
    explorationSeconds: 70,
    requiredRealm: RealmTier.jinDan,
  ),

  // 江南水乡
  'jiangnan': const MapLocation(
    id: 'jiangnan',
    name: '江南水乡',
    description: '风景秀丽的江南，小桥流水人家。但也是各方势力暗中角力的地方。',
    type: LocationType.city,
    dangerLevel: 5,
    adjacentIds: ['qingfeng_town', 'capital_city'],
    npcIds: [],
    eventIds: [
      'jiangnan_boat',
      'jiangnan_poetry',
      'jiangnan_merchant',
      'jiangnan_spy',
    ],
    explorationSeconds: 45,
  ),

  // 边关
  'border_fortress': const MapLocation(
    id: 'border_fortress',
    name: '边关要塞',
    description: '大周王朝的边关重镇，常年与北方蛮族交战。军营森严，战意高昂。',
    type: LocationType.special,
    dangerLevel: 8,
    adjacentIds: ['capital_city'],
    npcIds: ['lao_bing'],
    eventIds: [
      'border_battle',
      'border_spy',
      'border_supply',
      'border_night_raid',
    ],
    explorationSeconds: 55,
    requiredRealm: RealmTier.xianTian,
  ),
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArenaOpponentImpl _$$ArenaOpponentImplFromJson(Map<String, dynamic> json) =>
    _$ArenaOpponentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      level: (json['level'] as num).toInt(),
      hp: (json['hp'] as num).toInt(),
      atk: (json['atk'] as num).toInt(),
      def: (json['def'] as num).toInt(),
      speed: (json['speed'] as num).toInt(),
      skillIds:
          (json['skillIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      weaponId: json['weaponId'] as String?,
      armorId: json['armorId'] as String?,
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      rewardRanking: (json['rewardRanking'] as num?)?.toInt() ?? 0,
      rewardItemId: json['rewardItemId'] as String?,
    );

Map<String, dynamic> _$$ArenaOpponentImplToJson(_$ArenaOpponentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'level': instance.level,
      'hp': instance.hp,
      'atk': instance.atk,
      'def': instance.def,
      'speed': instance.speed,
      'skillIds': instance.skillIds,
      'weaponId': instance.weaponId,
      'armorId': instance.armorId,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardRanking': instance.rewardRanking,
      'rewardItemId': instance.rewardItemId,
    };

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
  Map<String, dynamic> json,
) => _$LeaderboardEntryImpl(
  rank: (json['rank'] as num).toInt(),
  characterId: json['characterId'] as String,
  characterName: json['characterName'] as String,
  value: (json['value'] as num).toInt(),
  sectName: json['sectName'] as String?,
  title: json['title'] as String?,
);

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
  _$LeaderboardEntryImpl instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'characterId': instance.characterId,
  'characterName': instance.characterName,
  'value': instance.value,
  'sectName': instance.sectName,
  'title': instance.title,
};

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$AchievementCategoryEnumMap, json['category']),
      targetValue: (json['targetValue'] as num).toInt(),
      rewardExp: (json['rewardExp'] as num?)?.toInt() ?? 0,
      rewardSilver: (json['rewardSilver'] as num?)?.toInt() ?? 0,
      rewardItemId: json['rewardItemId'] as String?,
      rewardTitle: json['rewardTitle'] as String?,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$AchievementCategoryEnumMap[instance.category]!,
      'targetValue': instance.targetValue,
      'rewardExp': instance.rewardExp,
      'rewardSilver': instance.rewardSilver,
      'rewardItemId': instance.rewardItemId,
      'rewardTitle': instance.rewardTitle,
    };

const _$AchievementCategoryEnumMap = {
  AchievementCategory.combat: 'combat',
  AchievementCategory.exploration: 'exploration',
  AchievementCategory.social: 'social',
  AchievementCategory.wealth: 'wealth',
  AchievementCategory.cultivation: 'cultivation',
};

_$TitleImpl _$$TitleImplFromJson(Map<String, dynamic> json) => _$TitleImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  atkBonus: (json['atkBonus'] as num?)?.toInt() ?? 0,
  defBonus: (json['defBonus'] as num?)?.toInt() ?? 0,
  hpBonus: (json['hpBonus'] as num?)?.toInt() ?? 0,
  speedBonus: (json['speedBonus'] as num?)?.toInt() ?? 0,
  luckBonus: (json['luckBonus'] as num?)?.toInt() ?? 0,
  achievementId: json['achievementId'] as String?,
  requiredRanking: (json['requiredRanking'] as num?)?.toInt(),
);

Map<String, dynamic> _$$TitleImplToJson(_$TitleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'atkBonus': instance.atkBonus,
      'defBonus': instance.defBonus,
      'hpBonus': instance.hpBonus,
      'speedBonus': instance.speedBonus,
      'luckBonus': instance.luckBonus,
      'achievementId': instance.achievementId,
      'requiredRanking': instance.requiredRanking,
    };

_$BrotherhoodImpl _$$BrotherhoodImplFromJson(Map<String, dynamic> json) =>
    _$BrotherhoodImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      memberIds: (json['memberIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      level: (json['level'] as num?)?.toInt() ?? 0,
      exp: (json['exp'] as num?)?.toInt() ?? 0,
      atkBonus: (json['atkBonus'] as num?)?.toInt() ?? 0,
      defBonus: (json['defBonus'] as num?)?.toInt() ?? 0,
      expBonus: (json['expBonus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BrotherhoodImplToJson(_$BrotherhoodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'memberIds': instance.memberIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'level': instance.level,
      'exp': instance.exp,
      'atkBonus': instance.atkBonus,
      'defBonus': instance.defBonus,
      'expBonus': instance.expBonus,
    };

_$LegacyImpl _$$LegacyImplFromJson(Map<String, dynamic> json) => _$LegacyImpl(
  id: json['id'] as String,
  fromCharacterId: json['fromCharacterId'] as String,
  fromCharacterName: json['fromCharacterName'] as String,
  retiredAt: DateTime.parse(json['retiredAt'] as String),
  inheritedExp: (json['inheritedExp'] as num?)?.toInt() ?? 0,
  inheritedSilver: (json['inheritedSilver'] as num?)?.toInt() ?? 0,
  inheritedSkillIds:
      (json['inheritedSkillIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  inheritedItemIds:
      (json['inheritedItemIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  inheritedReputation: (json['inheritedReputation'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$LegacyImplToJson(_$LegacyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromCharacterId': instance.fromCharacterId,
      'fromCharacterName': instance.fromCharacterName,
      'retiredAt': instance.retiredAt.toIso8601String(),
      'inheritedExp': instance.inheritedExp,
      'inheritedSilver': instance.inheritedSilver,
      'inheritedSkillIds': instance.inheritedSkillIds,
      'inheritedItemIds': instance.inheritedItemIds,
      'inheritedReputation': instance.inheritedReputation,
    };

_$JianghuRecordImpl _$$JianghuRecordImplFromJson(Map<String, dynamic> json) =>
    _$JianghuRecordImpl(
      id: json['id'] as String,
      characterId: json['characterId'] as String,
      eventType: json['eventType'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isLegendary: json['isLegendary'] as bool? ?? false,
    );

Map<String, dynamic> _$$JianghuRecordImplToJson(_$JianghuRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'characterId': instance.characterId,
      'eventType': instance.eventType,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'isLegendary': instance.isLegendary,
    };

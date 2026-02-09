// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CharactersTable extends Characters
    with TableInfo<$CharactersTable, Character> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseHpMeta = const VerificationMeta('baseHp');
  @override
  late final GeneratedColumn<int> baseHp = GeneratedColumn<int>(
    'base_hp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _baseMpMeta = const VerificationMeta('baseMp');
  @override
  late final GeneratedColumn<int> baseMp = GeneratedColumn<int>(
    'base_mp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _baseAtkMeta = const VerificationMeta(
    'baseAtk',
  );
  @override
  late final GeneratedColumn<int> baseAtk = GeneratedColumn<int>(
    'base_atk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _baseDefMeta = const VerificationMeta(
    'baseDef',
  );
  @override
  late final GeneratedColumn<int> baseDef = GeneratedColumn<int>(
    'base_def',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _baseSpeedMeta = const VerificationMeta(
    'baseSpeed',
  );
  @override
  late final GeneratedColumn<int> baseSpeed = GeneratedColumn<int>(
    'base_speed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _baseLuckMeta = const VerificationMeta(
    'baseLuck',
  );
  @override
  late final GeneratedColumn<int> baseLuck = GeneratedColumn<int>(
    'base_luck',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _baseComprehensionMeta = const VerificationMeta(
    'baseComprehension',
  );
  @override
  late final GeneratedColumn<int> baseComprehension = GeneratedColumn<int>(
    'base_comprehension',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _expMeta = const VerificationMeta('exp');
  @override
  late final GeneratedColumn<int> exp = GeneratedColumn<int>(
    'exp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _silverMeta = const VerificationMeta('silver');
  @override
  late final GeneratedColumn<int> silver = GeneratedColumn<int>(
    'silver',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _reputationMeta = const VerificationMeta(
    'reputation',
  );
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
    'reputation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _realmTierIndexMeta = const VerificationMeta(
    'realmTierIndex',
  );
  @override
  late final GeneratedColumn<int> realmTierIndex = GeneratedColumn<int>(
    'realm_tier_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _realmStageIndexMeta = const VerificationMeta(
    'realmStageIndex',
  );
  @override
  late final GeneratedColumn<int> realmStageIndex = GeneratedColumn<int>(
    'realm_stage_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentHpMeta = const VerificationMeta(
    'currentHp',
  );
  @override
  late final GeneratedColumn<int> currentHp = GeneratedColumn<int>(
    'current_hp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _currentMpMeta = const VerificationMeta(
    'currentMp',
  );
  @override
  late final GeneratedColumn<int> currentMp = GeneratedColumn<int>(
    'current_mp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _weaponIdMeta = const VerificationMeta(
    'weaponId',
  );
  @override
  late final GeneratedColumn<String> weaponId = GeneratedColumn<String>(
    'weapon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armorIdMeta = const VerificationMeta(
    'armorId',
  );
  @override
  late final GeneratedColumn<String> armorId = GeneratedColumn<String>(
    'armor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shoesIdMeta = const VerificationMeta(
    'shoesId',
  );
  @override
  late final GeneratedColumn<String> shoesId = GeneratedColumn<String>(
    'shoes_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accessoryIdMeta = const VerificationMeta(
    'accessoryId',
  );
  @override
  late final GeneratedColumn<String> accessoryId = GeneratedColumn<String>(
    'accessory_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('qingyun_village'),
  );
  static const VerificationMeta _lastOnlineTimeMeta = const VerificationMeta(
    'lastOnlineTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastOnlineTime =
      GeneratedColumn<DateTime>(
        'last_online_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    baseHp,
    baseMp,
    baseAtk,
    baseDef,
    baseSpeed,
    baseLuck,
    baseComprehension,
    exp,
    silver,
    reputation,
    realmTierIndex,
    realmStageIndex,
    currentHp,
    currentMp,
    weaponId,
    armorId,
    shoesId,
    accessoryId,
    locationId,
    lastOnlineTime,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Character> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_hp')) {
      context.handle(
        _baseHpMeta,
        baseHp.isAcceptableOrUnknown(data['base_hp']!, _baseHpMeta),
      );
    }
    if (data.containsKey('base_mp')) {
      context.handle(
        _baseMpMeta,
        baseMp.isAcceptableOrUnknown(data['base_mp']!, _baseMpMeta),
      );
    }
    if (data.containsKey('base_atk')) {
      context.handle(
        _baseAtkMeta,
        baseAtk.isAcceptableOrUnknown(data['base_atk']!, _baseAtkMeta),
      );
    }
    if (data.containsKey('base_def')) {
      context.handle(
        _baseDefMeta,
        baseDef.isAcceptableOrUnknown(data['base_def']!, _baseDefMeta),
      );
    }
    if (data.containsKey('base_speed')) {
      context.handle(
        _baseSpeedMeta,
        baseSpeed.isAcceptableOrUnknown(data['base_speed']!, _baseSpeedMeta),
      );
    }
    if (data.containsKey('base_luck')) {
      context.handle(
        _baseLuckMeta,
        baseLuck.isAcceptableOrUnknown(data['base_luck']!, _baseLuckMeta),
      );
    }
    if (data.containsKey('base_comprehension')) {
      context.handle(
        _baseComprehensionMeta,
        baseComprehension.isAcceptableOrUnknown(
          data['base_comprehension']!,
          _baseComprehensionMeta,
        ),
      );
    }
    if (data.containsKey('exp')) {
      context.handle(
        _expMeta,
        exp.isAcceptableOrUnknown(data['exp']!, _expMeta),
      );
    }
    if (data.containsKey('silver')) {
      context.handle(
        _silverMeta,
        silver.isAcceptableOrUnknown(data['silver']!, _silverMeta),
      );
    }
    if (data.containsKey('reputation')) {
      context.handle(
        _reputationMeta,
        reputation.isAcceptableOrUnknown(data['reputation']!, _reputationMeta),
      );
    }
    if (data.containsKey('realm_tier_index')) {
      context.handle(
        _realmTierIndexMeta,
        realmTierIndex.isAcceptableOrUnknown(
          data['realm_tier_index']!,
          _realmTierIndexMeta,
        ),
      );
    }
    if (data.containsKey('realm_stage_index')) {
      context.handle(
        _realmStageIndexMeta,
        realmStageIndex.isAcceptableOrUnknown(
          data['realm_stage_index']!,
          _realmStageIndexMeta,
        ),
      );
    }
    if (data.containsKey('current_hp')) {
      context.handle(
        _currentHpMeta,
        currentHp.isAcceptableOrUnknown(data['current_hp']!, _currentHpMeta),
      );
    }
    if (data.containsKey('current_mp')) {
      context.handle(
        _currentMpMeta,
        currentMp.isAcceptableOrUnknown(data['current_mp']!, _currentMpMeta),
      );
    }
    if (data.containsKey('weapon_id')) {
      context.handle(
        _weaponIdMeta,
        weaponId.isAcceptableOrUnknown(data['weapon_id']!, _weaponIdMeta),
      );
    }
    if (data.containsKey('armor_id')) {
      context.handle(
        _armorIdMeta,
        armorId.isAcceptableOrUnknown(data['armor_id']!, _armorIdMeta),
      );
    }
    if (data.containsKey('shoes_id')) {
      context.handle(
        _shoesIdMeta,
        shoesId.isAcceptableOrUnknown(data['shoes_id']!, _shoesIdMeta),
      );
    }
    if (data.containsKey('accessory_id')) {
      context.handle(
        _accessoryIdMeta,
        accessoryId.isAcceptableOrUnknown(
          data['accessory_id']!,
          _accessoryIdMeta,
        ),
      );
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    }
    if (data.containsKey('last_online_time')) {
      context.handle(
        _lastOnlineTimeMeta,
        lastOnlineTime.isAcceptableOrUnknown(
          data['last_online_time']!,
          _lastOnlineTimeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Character map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Character(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseHp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_hp'],
      )!,
      baseMp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_mp'],
      )!,
      baseAtk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_atk'],
      )!,
      baseDef: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_def'],
      )!,
      baseSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_speed'],
      )!,
      baseLuck: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_luck'],
      )!,
      baseComprehension: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_comprehension'],
      )!,
      exp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exp'],
      )!,
      silver: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}silver'],
      )!,
      reputation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reputation'],
      )!,
      realmTierIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}realm_tier_index'],
      )!,
      realmStageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}realm_stage_index'],
      )!,
      currentHp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_hp'],
      )!,
      currentMp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_mp'],
      )!,
      weaponId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weapon_id'],
      ),
      armorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}armor_id'],
      ),
      shoesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shoes_id'],
      ),
      accessoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accessory_id'],
      ),
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      lastOnlineTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_online_time'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CharactersTable createAlias(String alias) {
    return $CharactersTable(attachedDatabase, alias);
  }
}

class Character extends DataClass implements Insertable<Character> {
  final String id;
  final String name;
  final int baseHp;
  final int baseMp;
  final int baseAtk;
  final int baseDef;
  final int baseSpeed;
  final int baseLuck;
  final int baseComprehension;
  final int exp;
  final int silver;
  final int reputation;
  final int realmTierIndex;
  final int realmStageIndex;
  final int currentHp;
  final int currentMp;
  final String? weaponId;
  final String? armorId;
  final String? shoesId;
  final String? accessoryId;
  final String locationId;
  final DateTime? lastOnlineTime;
  final DateTime createdAt;
  const Character({
    required this.id,
    required this.name,
    required this.baseHp,
    required this.baseMp,
    required this.baseAtk,
    required this.baseDef,
    required this.baseSpeed,
    required this.baseLuck,
    required this.baseComprehension,
    required this.exp,
    required this.silver,
    required this.reputation,
    required this.realmTierIndex,
    required this.realmStageIndex,
    required this.currentHp,
    required this.currentMp,
    this.weaponId,
    this.armorId,
    this.shoesId,
    this.accessoryId,
    required this.locationId,
    this.lastOnlineTime,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['base_hp'] = Variable<int>(baseHp);
    map['base_mp'] = Variable<int>(baseMp);
    map['base_atk'] = Variable<int>(baseAtk);
    map['base_def'] = Variable<int>(baseDef);
    map['base_speed'] = Variable<int>(baseSpeed);
    map['base_luck'] = Variable<int>(baseLuck);
    map['base_comprehension'] = Variable<int>(baseComprehension);
    map['exp'] = Variable<int>(exp);
    map['silver'] = Variable<int>(silver);
    map['reputation'] = Variable<int>(reputation);
    map['realm_tier_index'] = Variable<int>(realmTierIndex);
    map['realm_stage_index'] = Variable<int>(realmStageIndex);
    map['current_hp'] = Variable<int>(currentHp);
    map['current_mp'] = Variable<int>(currentMp);
    if (!nullToAbsent || weaponId != null) {
      map['weapon_id'] = Variable<String>(weaponId);
    }
    if (!nullToAbsent || armorId != null) {
      map['armor_id'] = Variable<String>(armorId);
    }
    if (!nullToAbsent || shoesId != null) {
      map['shoes_id'] = Variable<String>(shoesId);
    }
    if (!nullToAbsent || accessoryId != null) {
      map['accessory_id'] = Variable<String>(accessoryId);
    }
    map['location_id'] = Variable<String>(locationId);
    if (!nullToAbsent || lastOnlineTime != null) {
      map['last_online_time'] = Variable<DateTime>(lastOnlineTime);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CharactersCompanion toCompanion(bool nullToAbsent) {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      baseHp: Value(baseHp),
      baseMp: Value(baseMp),
      baseAtk: Value(baseAtk),
      baseDef: Value(baseDef),
      baseSpeed: Value(baseSpeed),
      baseLuck: Value(baseLuck),
      baseComprehension: Value(baseComprehension),
      exp: Value(exp),
      silver: Value(silver),
      reputation: Value(reputation),
      realmTierIndex: Value(realmTierIndex),
      realmStageIndex: Value(realmStageIndex),
      currentHp: Value(currentHp),
      currentMp: Value(currentMp),
      weaponId: weaponId == null && nullToAbsent
          ? const Value.absent()
          : Value(weaponId),
      armorId: armorId == null && nullToAbsent
          ? const Value.absent()
          : Value(armorId),
      shoesId: shoesId == null && nullToAbsent
          ? const Value.absent()
          : Value(shoesId),
      accessoryId: accessoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(accessoryId),
      locationId: Value(locationId),
      lastOnlineTime: lastOnlineTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOnlineTime),
      createdAt: Value(createdAt),
    );
  }

  factory Character.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Character(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      baseHp: serializer.fromJson<int>(json['baseHp']),
      baseMp: serializer.fromJson<int>(json['baseMp']),
      baseAtk: serializer.fromJson<int>(json['baseAtk']),
      baseDef: serializer.fromJson<int>(json['baseDef']),
      baseSpeed: serializer.fromJson<int>(json['baseSpeed']),
      baseLuck: serializer.fromJson<int>(json['baseLuck']),
      baseComprehension: serializer.fromJson<int>(json['baseComprehension']),
      exp: serializer.fromJson<int>(json['exp']),
      silver: serializer.fromJson<int>(json['silver']),
      reputation: serializer.fromJson<int>(json['reputation']),
      realmTierIndex: serializer.fromJson<int>(json['realmTierIndex']),
      realmStageIndex: serializer.fromJson<int>(json['realmStageIndex']),
      currentHp: serializer.fromJson<int>(json['currentHp']),
      currentMp: serializer.fromJson<int>(json['currentMp']),
      weaponId: serializer.fromJson<String?>(json['weaponId']),
      armorId: serializer.fromJson<String?>(json['armorId']),
      shoesId: serializer.fromJson<String?>(json['shoesId']),
      accessoryId: serializer.fromJson<String?>(json['accessoryId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      lastOnlineTime: serializer.fromJson<DateTime?>(json['lastOnlineTime']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'baseHp': serializer.toJson<int>(baseHp),
      'baseMp': serializer.toJson<int>(baseMp),
      'baseAtk': serializer.toJson<int>(baseAtk),
      'baseDef': serializer.toJson<int>(baseDef),
      'baseSpeed': serializer.toJson<int>(baseSpeed),
      'baseLuck': serializer.toJson<int>(baseLuck),
      'baseComprehension': serializer.toJson<int>(baseComprehension),
      'exp': serializer.toJson<int>(exp),
      'silver': serializer.toJson<int>(silver),
      'reputation': serializer.toJson<int>(reputation),
      'realmTierIndex': serializer.toJson<int>(realmTierIndex),
      'realmStageIndex': serializer.toJson<int>(realmStageIndex),
      'currentHp': serializer.toJson<int>(currentHp),
      'currentMp': serializer.toJson<int>(currentMp),
      'weaponId': serializer.toJson<String?>(weaponId),
      'armorId': serializer.toJson<String?>(armorId),
      'shoesId': serializer.toJson<String?>(shoesId),
      'accessoryId': serializer.toJson<String?>(accessoryId),
      'locationId': serializer.toJson<String>(locationId),
      'lastOnlineTime': serializer.toJson<DateTime?>(lastOnlineTime),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Character copyWith({
    String? id,
    String? name,
    int? baseHp,
    int? baseMp,
    int? baseAtk,
    int? baseDef,
    int? baseSpeed,
    int? baseLuck,
    int? baseComprehension,
    int? exp,
    int? silver,
    int? reputation,
    int? realmTierIndex,
    int? realmStageIndex,
    int? currentHp,
    int? currentMp,
    Value<String?> weaponId = const Value.absent(),
    Value<String?> armorId = const Value.absent(),
    Value<String?> shoesId = const Value.absent(),
    Value<String?> accessoryId = const Value.absent(),
    String? locationId,
    Value<DateTime?> lastOnlineTime = const Value.absent(),
    DateTime? createdAt,
  }) => Character(
    id: id ?? this.id,
    name: name ?? this.name,
    baseHp: baseHp ?? this.baseHp,
    baseMp: baseMp ?? this.baseMp,
    baseAtk: baseAtk ?? this.baseAtk,
    baseDef: baseDef ?? this.baseDef,
    baseSpeed: baseSpeed ?? this.baseSpeed,
    baseLuck: baseLuck ?? this.baseLuck,
    baseComprehension: baseComprehension ?? this.baseComprehension,
    exp: exp ?? this.exp,
    silver: silver ?? this.silver,
    reputation: reputation ?? this.reputation,
    realmTierIndex: realmTierIndex ?? this.realmTierIndex,
    realmStageIndex: realmStageIndex ?? this.realmStageIndex,
    currentHp: currentHp ?? this.currentHp,
    currentMp: currentMp ?? this.currentMp,
    weaponId: weaponId.present ? weaponId.value : this.weaponId,
    armorId: armorId.present ? armorId.value : this.armorId,
    shoesId: shoesId.present ? shoesId.value : this.shoesId,
    accessoryId: accessoryId.present ? accessoryId.value : this.accessoryId,
    locationId: locationId ?? this.locationId,
    lastOnlineTime: lastOnlineTime.present
        ? lastOnlineTime.value
        : this.lastOnlineTime,
    createdAt: createdAt ?? this.createdAt,
  );
  Character copyWithCompanion(CharactersCompanion data) {
    return Character(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      baseHp: data.baseHp.present ? data.baseHp.value : this.baseHp,
      baseMp: data.baseMp.present ? data.baseMp.value : this.baseMp,
      baseAtk: data.baseAtk.present ? data.baseAtk.value : this.baseAtk,
      baseDef: data.baseDef.present ? data.baseDef.value : this.baseDef,
      baseSpeed: data.baseSpeed.present ? data.baseSpeed.value : this.baseSpeed,
      baseLuck: data.baseLuck.present ? data.baseLuck.value : this.baseLuck,
      baseComprehension: data.baseComprehension.present
          ? data.baseComprehension.value
          : this.baseComprehension,
      exp: data.exp.present ? data.exp.value : this.exp,
      silver: data.silver.present ? data.silver.value : this.silver,
      reputation: data.reputation.present
          ? data.reputation.value
          : this.reputation,
      realmTierIndex: data.realmTierIndex.present
          ? data.realmTierIndex.value
          : this.realmTierIndex,
      realmStageIndex: data.realmStageIndex.present
          ? data.realmStageIndex.value
          : this.realmStageIndex,
      currentHp: data.currentHp.present ? data.currentHp.value : this.currentHp,
      currentMp: data.currentMp.present ? data.currentMp.value : this.currentMp,
      weaponId: data.weaponId.present ? data.weaponId.value : this.weaponId,
      armorId: data.armorId.present ? data.armorId.value : this.armorId,
      shoesId: data.shoesId.present ? data.shoesId.value : this.shoesId,
      accessoryId: data.accessoryId.present
          ? data.accessoryId.value
          : this.accessoryId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      lastOnlineTime: data.lastOnlineTime.present
          ? data.lastOnlineTime.value
          : this.lastOnlineTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Character(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseHp: $baseHp, ')
          ..write('baseMp: $baseMp, ')
          ..write('baseAtk: $baseAtk, ')
          ..write('baseDef: $baseDef, ')
          ..write('baseSpeed: $baseSpeed, ')
          ..write('baseLuck: $baseLuck, ')
          ..write('baseComprehension: $baseComprehension, ')
          ..write('exp: $exp, ')
          ..write('silver: $silver, ')
          ..write('reputation: $reputation, ')
          ..write('realmTierIndex: $realmTierIndex, ')
          ..write('realmStageIndex: $realmStageIndex, ')
          ..write('currentHp: $currentHp, ')
          ..write('currentMp: $currentMp, ')
          ..write('weaponId: $weaponId, ')
          ..write('armorId: $armorId, ')
          ..write('shoesId: $shoesId, ')
          ..write('accessoryId: $accessoryId, ')
          ..write('locationId: $locationId, ')
          ..write('lastOnlineTime: $lastOnlineTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    baseHp,
    baseMp,
    baseAtk,
    baseDef,
    baseSpeed,
    baseLuck,
    baseComprehension,
    exp,
    silver,
    reputation,
    realmTierIndex,
    realmStageIndex,
    currentHp,
    currentMp,
    weaponId,
    armorId,
    shoesId,
    accessoryId,
    locationId,
    lastOnlineTime,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.name == this.name &&
          other.baseHp == this.baseHp &&
          other.baseMp == this.baseMp &&
          other.baseAtk == this.baseAtk &&
          other.baseDef == this.baseDef &&
          other.baseSpeed == this.baseSpeed &&
          other.baseLuck == this.baseLuck &&
          other.baseComprehension == this.baseComprehension &&
          other.exp == this.exp &&
          other.silver == this.silver &&
          other.reputation == this.reputation &&
          other.realmTierIndex == this.realmTierIndex &&
          other.realmStageIndex == this.realmStageIndex &&
          other.currentHp == this.currentHp &&
          other.currentMp == this.currentMp &&
          other.weaponId == this.weaponId &&
          other.armorId == this.armorId &&
          other.shoesId == this.shoesId &&
          other.accessoryId == this.accessoryId &&
          other.locationId == this.locationId &&
          other.lastOnlineTime == this.lastOnlineTime &&
          other.createdAt == this.createdAt);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> baseHp;
  final Value<int> baseMp;
  final Value<int> baseAtk;
  final Value<int> baseDef;
  final Value<int> baseSpeed;
  final Value<int> baseLuck;
  final Value<int> baseComprehension;
  final Value<int> exp;
  final Value<int> silver;
  final Value<int> reputation;
  final Value<int> realmTierIndex;
  final Value<int> realmStageIndex;
  final Value<int> currentHp;
  final Value<int> currentMp;
  final Value<String?> weaponId;
  final Value<String?> armorId;
  final Value<String?> shoesId;
  final Value<String?> accessoryId;
  final Value<String> locationId;
  final Value<DateTime?> lastOnlineTime;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.baseHp = const Value.absent(),
    this.baseMp = const Value.absent(),
    this.baseAtk = const Value.absent(),
    this.baseDef = const Value.absent(),
    this.baseSpeed = const Value.absent(),
    this.baseLuck = const Value.absent(),
    this.baseComprehension = const Value.absent(),
    this.exp = const Value.absent(),
    this.silver = const Value.absent(),
    this.reputation = const Value.absent(),
    this.realmTierIndex = const Value.absent(),
    this.realmStageIndex = const Value.absent(),
    this.currentHp = const Value.absent(),
    this.currentMp = const Value.absent(),
    this.weaponId = const Value.absent(),
    this.armorId = const Value.absent(),
    this.shoesId = const Value.absent(),
    this.accessoryId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.lastOnlineTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharactersCompanion.insert({
    required String id,
    required String name,
    this.baseHp = const Value.absent(),
    this.baseMp = const Value.absent(),
    this.baseAtk = const Value.absent(),
    this.baseDef = const Value.absent(),
    this.baseSpeed = const Value.absent(),
    this.baseLuck = const Value.absent(),
    this.baseComprehension = const Value.absent(),
    this.exp = const Value.absent(),
    this.silver = const Value.absent(),
    this.reputation = const Value.absent(),
    this.realmTierIndex = const Value.absent(),
    this.realmStageIndex = const Value.absent(),
    this.currentHp = const Value.absent(),
    this.currentMp = const Value.absent(),
    this.weaponId = const Value.absent(),
    this.armorId = const Value.absent(),
    this.shoesId = const Value.absent(),
    this.accessoryId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.lastOnlineTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Character> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? baseHp,
    Expression<int>? baseMp,
    Expression<int>? baseAtk,
    Expression<int>? baseDef,
    Expression<int>? baseSpeed,
    Expression<int>? baseLuck,
    Expression<int>? baseComprehension,
    Expression<int>? exp,
    Expression<int>? silver,
    Expression<int>? reputation,
    Expression<int>? realmTierIndex,
    Expression<int>? realmStageIndex,
    Expression<int>? currentHp,
    Expression<int>? currentMp,
    Expression<String>? weaponId,
    Expression<String>? armorId,
    Expression<String>? shoesId,
    Expression<String>? accessoryId,
    Expression<String>? locationId,
    Expression<DateTime>? lastOnlineTime,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (baseHp != null) 'base_hp': baseHp,
      if (baseMp != null) 'base_mp': baseMp,
      if (baseAtk != null) 'base_atk': baseAtk,
      if (baseDef != null) 'base_def': baseDef,
      if (baseSpeed != null) 'base_speed': baseSpeed,
      if (baseLuck != null) 'base_luck': baseLuck,
      if (baseComprehension != null) 'base_comprehension': baseComprehension,
      if (exp != null) 'exp': exp,
      if (silver != null) 'silver': silver,
      if (reputation != null) 'reputation': reputation,
      if (realmTierIndex != null) 'realm_tier_index': realmTierIndex,
      if (realmStageIndex != null) 'realm_stage_index': realmStageIndex,
      if (currentHp != null) 'current_hp': currentHp,
      if (currentMp != null) 'current_mp': currentMp,
      if (weaponId != null) 'weapon_id': weaponId,
      if (armorId != null) 'armor_id': armorId,
      if (shoesId != null) 'shoes_id': shoesId,
      if (accessoryId != null) 'accessory_id': accessoryId,
      if (locationId != null) 'location_id': locationId,
      if (lastOnlineTime != null) 'last_online_time': lastOnlineTime,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharactersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? baseHp,
    Value<int>? baseMp,
    Value<int>? baseAtk,
    Value<int>? baseDef,
    Value<int>? baseSpeed,
    Value<int>? baseLuck,
    Value<int>? baseComprehension,
    Value<int>? exp,
    Value<int>? silver,
    Value<int>? reputation,
    Value<int>? realmTierIndex,
    Value<int>? realmStageIndex,
    Value<int>? currentHp,
    Value<int>? currentMp,
    Value<String?>? weaponId,
    Value<String?>? armorId,
    Value<String?>? shoesId,
    Value<String?>? accessoryId,
    Value<String>? locationId,
    Value<DateTime?>? lastOnlineTime,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CharactersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      baseHp: baseHp ?? this.baseHp,
      baseMp: baseMp ?? this.baseMp,
      baseAtk: baseAtk ?? this.baseAtk,
      baseDef: baseDef ?? this.baseDef,
      baseSpeed: baseSpeed ?? this.baseSpeed,
      baseLuck: baseLuck ?? this.baseLuck,
      baseComprehension: baseComprehension ?? this.baseComprehension,
      exp: exp ?? this.exp,
      silver: silver ?? this.silver,
      reputation: reputation ?? this.reputation,
      realmTierIndex: realmTierIndex ?? this.realmTierIndex,
      realmStageIndex: realmStageIndex ?? this.realmStageIndex,
      currentHp: currentHp ?? this.currentHp,
      currentMp: currentMp ?? this.currentMp,
      weaponId: weaponId ?? this.weaponId,
      armorId: armorId ?? this.armorId,
      shoesId: shoesId ?? this.shoesId,
      accessoryId: accessoryId ?? this.accessoryId,
      locationId: locationId ?? this.locationId,
      lastOnlineTime: lastOnlineTime ?? this.lastOnlineTime,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseHp.present) {
      map['base_hp'] = Variable<int>(baseHp.value);
    }
    if (baseMp.present) {
      map['base_mp'] = Variable<int>(baseMp.value);
    }
    if (baseAtk.present) {
      map['base_atk'] = Variable<int>(baseAtk.value);
    }
    if (baseDef.present) {
      map['base_def'] = Variable<int>(baseDef.value);
    }
    if (baseSpeed.present) {
      map['base_speed'] = Variable<int>(baseSpeed.value);
    }
    if (baseLuck.present) {
      map['base_luck'] = Variable<int>(baseLuck.value);
    }
    if (baseComprehension.present) {
      map['base_comprehension'] = Variable<int>(baseComprehension.value);
    }
    if (exp.present) {
      map['exp'] = Variable<int>(exp.value);
    }
    if (silver.present) {
      map['silver'] = Variable<int>(silver.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    if (realmTierIndex.present) {
      map['realm_tier_index'] = Variable<int>(realmTierIndex.value);
    }
    if (realmStageIndex.present) {
      map['realm_stage_index'] = Variable<int>(realmStageIndex.value);
    }
    if (currentHp.present) {
      map['current_hp'] = Variable<int>(currentHp.value);
    }
    if (currentMp.present) {
      map['current_mp'] = Variable<int>(currentMp.value);
    }
    if (weaponId.present) {
      map['weapon_id'] = Variable<String>(weaponId.value);
    }
    if (armorId.present) {
      map['armor_id'] = Variable<String>(armorId.value);
    }
    if (shoesId.present) {
      map['shoes_id'] = Variable<String>(shoesId.value);
    }
    if (accessoryId.present) {
      map['accessory_id'] = Variable<String>(accessoryId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (lastOnlineTime.present) {
      map['last_online_time'] = Variable<DateTime>(lastOnlineTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseHp: $baseHp, ')
          ..write('baseMp: $baseMp, ')
          ..write('baseAtk: $baseAtk, ')
          ..write('baseDef: $baseDef, ')
          ..write('baseSpeed: $baseSpeed, ')
          ..write('baseLuck: $baseLuck, ')
          ..write('baseComprehension: $baseComprehension, ')
          ..write('exp: $exp, ')
          ..write('silver: $silver, ')
          ..write('reputation: $reputation, ')
          ..write('realmTierIndex: $realmTierIndex, ')
          ..write('realmStageIndex: $realmStageIndex, ')
          ..write('currentHp: $currentHp, ')
          ..write('currentMp: $currentMp, ')
          ..write('weaponId: $weaponId, ')
          ..write('armorId: $armorId, ')
          ..write('shoesId: $shoesId, ')
          ..write('accessoryId: $accessoryId, ')
          ..write('locationId: $locationId, ')
          ..write('lastOnlineTime: $lastOnlineTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _enhanceLevelMeta = const VerificationMeta(
    'enhanceLevel',
  );
  @override
  late final GeneratedColumn<int> enhanceLevel = GeneratedColumn<int>(
    'enhance_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    characterId,
    itemId,
    quantity,
    enhanceLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('enhance_level')) {
      context.handle(
        _enhanceLevelMeta,
        enhanceLevel.isAcceptableOrUnknown(
          data['enhance_level']!,
          _enhanceLevelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      enhanceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enhance_level'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final String characterId;
  final String itemId;
  final int quantity;
  final int enhanceLevel;
  const InventoryItem({
    required this.id,
    required this.characterId,
    required this.itemId,
    required this.quantity,
    required this.enhanceLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['character_id'] = Variable<String>(characterId);
    map['item_id'] = Variable<String>(itemId);
    map['quantity'] = Variable<int>(quantity);
    map['enhance_level'] = Variable<int>(enhanceLevel);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      characterId: Value(characterId),
      itemId: Value(itemId),
      quantity: Value(quantity),
      enhanceLevel: Value(enhanceLevel),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      characterId: serializer.fromJson<String>(json['characterId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      enhanceLevel: serializer.fromJson<int>(json['enhanceLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'characterId': serializer.toJson<String>(characterId),
      'itemId': serializer.toJson<String>(itemId),
      'quantity': serializer.toJson<int>(quantity),
      'enhanceLevel': serializer.toJson<int>(enhanceLevel),
    };
  }

  InventoryItem copyWith({
    String? id,
    String? characterId,
    String? itemId,
    int? quantity,
    int? enhanceLevel,
  }) => InventoryItem(
    id: id ?? this.id,
    characterId: characterId ?? this.characterId,
    itemId: itemId ?? this.itemId,
    quantity: quantity ?? this.quantity,
    enhanceLevel: enhanceLevel ?? this.enhanceLevel,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      enhanceLevel: data.enhanceLevel.present
          ? data.enhanceLevel.value
          : this.enhanceLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('enhanceLevel: $enhanceLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, characterId, itemId, quantity, enhanceLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.itemId == this.itemId &&
          other.quantity == this.quantity &&
          other.enhanceLevel == this.enhanceLevel);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<String> characterId;
  final Value<String> itemId;
  final Value<int> quantity;
  final Value<int> enhanceLevel;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.enhanceLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    required String characterId,
    required String itemId,
    this.quantity = const Value.absent(),
    this.enhanceLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       characterId = Value(characterId),
       itemId = Value(itemId);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<String>? characterId,
    Expression<String>? itemId,
    Expression<int>? quantity,
    Expression<int>? enhanceLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (itemId != null) 'item_id': itemId,
      if (quantity != null) 'quantity': quantity,
      if (enhanceLevel != null) 'enhance_level': enhanceLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? characterId,
    Value<String>? itemId,
    Value<int>? quantity,
    Value<int>? enhanceLevel,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      enhanceLevel: enhanceLevel ?? this.enhanceLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (enhanceLevel.present) {
      map['enhance_level'] = Variable<int>(enhanceLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('enhanceLevel: $enhanceLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearnedSkillsTable extends LearnedSkills
    with TableInfo<$LearnedSkillsTable, LearnedSkill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearnedSkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _skillIdMeta = const VerificationMeta(
    'skillId',
  );
  @override
  late final GeneratedColumn<String> skillId = GeneratedColumn<String>(
    'skill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _proficiencyMeta = const VerificationMeta(
    'proficiency',
  );
  @override
  late final GeneratedColumn<int> proficiency = GeneratedColumn<int>(
    'proficiency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isEquippedMeta = const VerificationMeta(
    'isEquipped',
  );
  @override
  late final GeneratedColumn<bool> isEquipped = GeneratedColumn<bool>(
    'is_equipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_equipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    characterId,
    skillId,
    level,
    proficiency,
    isEquipped,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learned_skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearnedSkill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('skill_id')) {
      context.handle(
        _skillIdMeta,
        skillId.isAcceptableOrUnknown(data['skill_id']!, _skillIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skillIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('proficiency')) {
      context.handle(
        _proficiencyMeta,
        proficiency.isAcceptableOrUnknown(
          data['proficiency']!,
          _proficiencyMeta,
        ),
      );
    }
    if (data.containsKey('is_equipped')) {
      context.handle(
        _isEquippedMeta,
        isEquipped.isAcceptableOrUnknown(data['is_equipped']!, _isEquippedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearnedSkill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearnedSkill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      skillId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      proficiency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}proficiency'],
      )!,
      isEquipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_equipped'],
      )!,
    );
  }

  @override
  $LearnedSkillsTable createAlias(String alias) {
    return $LearnedSkillsTable(attachedDatabase, alias);
  }
}

class LearnedSkill extends DataClass implements Insertable<LearnedSkill> {
  final String id;
  final String characterId;
  final String skillId;
  final int level;
  final int proficiency;
  final bool isEquipped;
  const LearnedSkill({
    required this.id,
    required this.characterId,
    required this.skillId,
    required this.level,
    required this.proficiency,
    required this.isEquipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['character_id'] = Variable<String>(characterId);
    map['skill_id'] = Variable<String>(skillId);
    map['level'] = Variable<int>(level);
    map['proficiency'] = Variable<int>(proficiency);
    map['is_equipped'] = Variable<bool>(isEquipped);
    return map;
  }

  LearnedSkillsCompanion toCompanion(bool nullToAbsent) {
    return LearnedSkillsCompanion(
      id: Value(id),
      characterId: Value(characterId),
      skillId: Value(skillId),
      level: Value(level),
      proficiency: Value(proficiency),
      isEquipped: Value(isEquipped),
    );
  }

  factory LearnedSkill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearnedSkill(
      id: serializer.fromJson<String>(json['id']),
      characterId: serializer.fromJson<String>(json['characterId']),
      skillId: serializer.fromJson<String>(json['skillId']),
      level: serializer.fromJson<int>(json['level']),
      proficiency: serializer.fromJson<int>(json['proficiency']),
      isEquipped: serializer.fromJson<bool>(json['isEquipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'characterId': serializer.toJson<String>(characterId),
      'skillId': serializer.toJson<String>(skillId),
      'level': serializer.toJson<int>(level),
      'proficiency': serializer.toJson<int>(proficiency),
      'isEquipped': serializer.toJson<bool>(isEquipped),
    };
  }

  LearnedSkill copyWith({
    String? id,
    String? characterId,
    String? skillId,
    int? level,
    int? proficiency,
    bool? isEquipped,
  }) => LearnedSkill(
    id: id ?? this.id,
    characterId: characterId ?? this.characterId,
    skillId: skillId ?? this.skillId,
    level: level ?? this.level,
    proficiency: proficiency ?? this.proficiency,
    isEquipped: isEquipped ?? this.isEquipped,
  );
  LearnedSkill copyWithCompanion(LearnedSkillsCompanion data) {
    return LearnedSkill(
      id: data.id.present ? data.id.value : this.id,
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      skillId: data.skillId.present ? data.skillId.value : this.skillId,
      level: data.level.present ? data.level.value : this.level,
      proficiency: data.proficiency.present
          ? data.proficiency.value
          : this.proficiency,
      isEquipped: data.isEquipped.present
          ? data.isEquipped.value
          : this.isEquipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearnedSkill(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('skillId: $skillId, ')
          ..write('level: $level, ')
          ..write('proficiency: $proficiency, ')
          ..write('isEquipped: $isEquipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, characterId, skillId, level, proficiency, isEquipped);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearnedSkill &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.skillId == this.skillId &&
          other.level == this.level &&
          other.proficiency == this.proficiency &&
          other.isEquipped == this.isEquipped);
}

class LearnedSkillsCompanion extends UpdateCompanion<LearnedSkill> {
  final Value<String> id;
  final Value<String> characterId;
  final Value<String> skillId;
  final Value<int> level;
  final Value<int> proficiency;
  final Value<bool> isEquipped;
  final Value<int> rowid;
  const LearnedSkillsCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.skillId = const Value.absent(),
    this.level = const Value.absent(),
    this.proficiency = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearnedSkillsCompanion.insert({
    required String id,
    required String characterId,
    required String skillId,
    this.level = const Value.absent(),
    this.proficiency = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       characterId = Value(characterId),
       skillId = Value(skillId);
  static Insertable<LearnedSkill> custom({
    Expression<String>? id,
    Expression<String>? characterId,
    Expression<String>? skillId,
    Expression<int>? level,
    Expression<int>? proficiency,
    Expression<bool>? isEquipped,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (skillId != null) 'skill_id': skillId,
      if (level != null) 'level': level,
      if (proficiency != null) 'proficiency': proficiency,
      if (isEquipped != null) 'is_equipped': isEquipped,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearnedSkillsCompanion copyWith({
    Value<String>? id,
    Value<String>? characterId,
    Value<String>? skillId,
    Value<int>? level,
    Value<int>? proficiency,
    Value<bool>? isEquipped,
    Value<int>? rowid,
  }) {
    return LearnedSkillsCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      skillId: skillId ?? this.skillId,
      level: level ?? this.level,
      proficiency: proficiency ?? this.proficiency,
      isEquipped: isEquipped ?? this.isEquipped,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (skillId.present) {
      map['skill_id'] = Variable<String>(skillId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (proficiency.present) {
      map['proficiency'] = Variable<int>(proficiency.value);
    }
    if (isEquipped.present) {
      map['is_equipped'] = Variable<bool>(isEquipped.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearnedSkillsCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('skillId: $skillId, ')
          ..write('level: $level, ')
          ..write('proficiency: $proficiency, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NpcRelationsTable extends NpcRelations
    with TableInfo<$NpcRelationsTable, NpcRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NpcRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _npcIdMeta = const VerificationMeta('npcId');
  @override
  late final GeneratedColumn<String> npcId = GeneratedColumn<String>(
    'npc_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _affectionMeta = const VerificationMeta(
    'affection',
  );
  @override
  late final GeneratedColumn<int> affection = GeneratedColumn<int>(
    'affection',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [characterId, npcId, affection];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'npc_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<NpcRelation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('npc_id')) {
      context.handle(
        _npcIdMeta,
        npcId.isAcceptableOrUnknown(data['npc_id']!, _npcIdMeta),
      );
    } else if (isInserting) {
      context.missing(_npcIdMeta);
    }
    if (data.containsKey('affection')) {
      context.handle(
        _affectionMeta,
        affection.isAcceptableOrUnknown(data['affection']!, _affectionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, npcId};
  @override
  NpcRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NpcRelation(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      npcId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}npc_id'],
      )!,
      affection: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}affection'],
      )!,
    );
  }

  @override
  $NpcRelationsTable createAlias(String alias) {
    return $NpcRelationsTable(attachedDatabase, alias);
  }
}

class NpcRelation extends DataClass implements Insertable<NpcRelation> {
  final String characterId;
  final String npcId;
  final int affection;
  const NpcRelation({
    required this.characterId,
    required this.npcId,
    required this.affection,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['npc_id'] = Variable<String>(npcId);
    map['affection'] = Variable<int>(affection);
    return map;
  }

  NpcRelationsCompanion toCompanion(bool nullToAbsent) {
    return NpcRelationsCompanion(
      characterId: Value(characterId),
      npcId: Value(npcId),
      affection: Value(affection),
    );
  }

  factory NpcRelation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NpcRelation(
      characterId: serializer.fromJson<String>(json['characterId']),
      npcId: serializer.fromJson<String>(json['npcId']),
      affection: serializer.fromJson<int>(json['affection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'npcId': serializer.toJson<String>(npcId),
      'affection': serializer.toJson<int>(affection),
    };
  }

  NpcRelation copyWith({String? characterId, String? npcId, int? affection}) =>
      NpcRelation(
        characterId: characterId ?? this.characterId,
        npcId: npcId ?? this.npcId,
        affection: affection ?? this.affection,
      );
  NpcRelation copyWithCompanion(NpcRelationsCompanion data) {
    return NpcRelation(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      npcId: data.npcId.present ? data.npcId.value : this.npcId,
      affection: data.affection.present ? data.affection.value : this.affection,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NpcRelation(')
          ..write('characterId: $characterId, ')
          ..write('npcId: $npcId, ')
          ..write('affection: $affection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(characterId, npcId, affection);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NpcRelation &&
          other.characterId == this.characterId &&
          other.npcId == this.npcId &&
          other.affection == this.affection);
}

class NpcRelationsCompanion extends UpdateCompanion<NpcRelation> {
  final Value<String> characterId;
  final Value<String> npcId;
  final Value<int> affection;
  final Value<int> rowid;
  const NpcRelationsCompanion({
    this.characterId = const Value.absent(),
    this.npcId = const Value.absent(),
    this.affection = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NpcRelationsCompanion.insert({
    required String characterId,
    required String npcId,
    this.affection = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       npcId = Value(npcId);
  static Insertable<NpcRelation> custom({
    Expression<String>? characterId,
    Expression<String>? npcId,
    Expression<int>? affection,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (npcId != null) 'npc_id': npcId,
      if (affection != null) 'affection': affection,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NpcRelationsCompanion copyWith({
    Value<String>? characterId,
    Value<String>? npcId,
    Value<int>? affection,
    Value<int>? rowid,
  }) {
    return NpcRelationsCompanion(
      characterId: characterId ?? this.characterId,
      npcId: npcId ?? this.npcId,
      affection: affection ?? this.affection,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (npcId.present) {
      map['npc_id'] = Variable<String>(npcId.value);
    }
    if (affection.present) {
      map['affection'] = Variable<int>(affection.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NpcRelationsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('npcId: $npcId, ')
          ..write('affection: $affection, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestProgressTable extends QuestProgress
    with TableInfo<$QuestProgressTable, QuestProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _questIdMeta = const VerificationMeta(
    'questId',
  );
  @override
  late final GeneratedColumn<String> questId = GeneratedColumn<String>(
    'quest_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _objectivesJsonMeta = const VerificationMeta(
    'objectivesJson',
  );
  @override
  late final GeneratedColumn<String> objectivesJson = GeneratedColumn<String>(
    'objectives_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _selectedBranchMeta = const VerificationMeta(
    'selectedBranch',
  );
  @override
  late final GeneratedColumn<int> selectedBranch = GeneratedColumn<int>(
    'selected_branch',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    characterId,
    questId,
    status,
    objectivesJson,
    selectedBranch,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quest_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('quest_id')) {
      context.handle(
        _questIdMeta,
        questId.isAcceptableOrUnknown(data['quest_id']!, _questIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('objectives_json')) {
      context.handle(
        _objectivesJsonMeta,
        objectivesJson.isAcceptableOrUnknown(
          data['objectives_json']!,
          _objectivesJsonMeta,
        ),
      );
    }
    if (data.containsKey('selected_branch')) {
      context.handle(
        _selectedBranchMeta,
        selectedBranch.isAcceptableOrUnknown(
          data['selected_branch']!,
          _selectedBranchMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      questId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quest_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      objectivesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objectives_json'],
      )!,
      selectedBranch: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selected_branch'],
      ),
    );
  }

  @override
  $QuestProgressTable createAlias(String alias) {
    return $QuestProgressTable(attachedDatabase, alias);
  }
}

class QuestProgressData extends DataClass
    implements Insertable<QuestProgressData> {
  final String id;
  final String characterId;
  final String questId;
  final int status;
  final String objectivesJson;
  final int? selectedBranch;
  const QuestProgressData({
    required this.id,
    required this.characterId,
    required this.questId,
    required this.status,
    required this.objectivesJson,
    this.selectedBranch,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['character_id'] = Variable<String>(characterId);
    map['quest_id'] = Variable<String>(questId);
    map['status'] = Variable<int>(status);
    map['objectives_json'] = Variable<String>(objectivesJson);
    if (!nullToAbsent || selectedBranch != null) {
      map['selected_branch'] = Variable<int>(selectedBranch);
    }
    return map;
  }

  QuestProgressCompanion toCompanion(bool nullToAbsent) {
    return QuestProgressCompanion(
      id: Value(id),
      characterId: Value(characterId),
      questId: Value(questId),
      status: Value(status),
      objectivesJson: Value(objectivesJson),
      selectedBranch: selectedBranch == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedBranch),
    );
  }

  factory QuestProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestProgressData(
      id: serializer.fromJson<String>(json['id']),
      characterId: serializer.fromJson<String>(json['characterId']),
      questId: serializer.fromJson<String>(json['questId']),
      status: serializer.fromJson<int>(json['status']),
      objectivesJson: serializer.fromJson<String>(json['objectivesJson']),
      selectedBranch: serializer.fromJson<int?>(json['selectedBranch']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'characterId': serializer.toJson<String>(characterId),
      'questId': serializer.toJson<String>(questId),
      'status': serializer.toJson<int>(status),
      'objectivesJson': serializer.toJson<String>(objectivesJson),
      'selectedBranch': serializer.toJson<int?>(selectedBranch),
    };
  }

  QuestProgressData copyWith({
    String? id,
    String? characterId,
    String? questId,
    int? status,
    String? objectivesJson,
    Value<int?> selectedBranch = const Value.absent(),
  }) => QuestProgressData(
    id: id ?? this.id,
    characterId: characterId ?? this.characterId,
    questId: questId ?? this.questId,
    status: status ?? this.status,
    objectivesJson: objectivesJson ?? this.objectivesJson,
    selectedBranch: selectedBranch.present
        ? selectedBranch.value
        : this.selectedBranch,
  );
  QuestProgressData copyWithCompanion(QuestProgressCompanion data) {
    return QuestProgressData(
      id: data.id.present ? data.id.value : this.id,
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      questId: data.questId.present ? data.questId.value : this.questId,
      status: data.status.present ? data.status.value : this.status,
      objectivesJson: data.objectivesJson.present
          ? data.objectivesJson.value
          : this.objectivesJson,
      selectedBranch: data.selectedBranch.present
          ? data.selectedBranch.value
          : this.selectedBranch,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestProgressData(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('questId: $questId, ')
          ..write('status: $status, ')
          ..write('objectivesJson: $objectivesJson, ')
          ..write('selectedBranch: $selectedBranch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    characterId,
    questId,
    status,
    objectivesJson,
    selectedBranch,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestProgressData &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.questId == this.questId &&
          other.status == this.status &&
          other.objectivesJson == this.objectivesJson &&
          other.selectedBranch == this.selectedBranch);
}

class QuestProgressCompanion extends UpdateCompanion<QuestProgressData> {
  final Value<String> id;
  final Value<String> characterId;
  final Value<String> questId;
  final Value<int> status;
  final Value<String> objectivesJson;
  final Value<int?> selectedBranch;
  final Value<int> rowid;
  const QuestProgressCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.questId = const Value.absent(),
    this.status = const Value.absent(),
    this.objectivesJson = const Value.absent(),
    this.selectedBranch = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestProgressCompanion.insert({
    required String id,
    required String characterId,
    required String questId,
    this.status = const Value.absent(),
    this.objectivesJson = const Value.absent(),
    this.selectedBranch = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       characterId = Value(characterId),
       questId = Value(questId);
  static Insertable<QuestProgressData> custom({
    Expression<String>? id,
    Expression<String>? characterId,
    Expression<String>? questId,
    Expression<int>? status,
    Expression<String>? objectivesJson,
    Expression<int>? selectedBranch,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (questId != null) 'quest_id': questId,
      if (status != null) 'status': status,
      if (objectivesJson != null) 'objectives_json': objectivesJson,
      if (selectedBranch != null) 'selected_branch': selectedBranch,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestProgressCompanion copyWith({
    Value<String>? id,
    Value<String>? characterId,
    Value<String>? questId,
    Value<int>? status,
    Value<String>? objectivesJson,
    Value<int?>? selectedBranch,
    Value<int>? rowid,
  }) {
    return QuestProgressCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      questId: questId ?? this.questId,
      status: status ?? this.status,
      objectivesJson: objectivesJson ?? this.objectivesJson,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (questId.present) {
      map['quest_id'] = Variable<String>(questId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (objectivesJson.present) {
      map['objectives_json'] = Variable<String>(objectivesJson.value);
    }
    if (selectedBranch.present) {
      map['selected_branch'] = Variable<int>(selectedBranch.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestProgressCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('questId: $questId, ')
          ..write('status: $status, ')
          ..write('objectivesJson: $objectivesJson, ')
          ..write('selectedBranch: $selectedBranch, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersTable characters = $CharactersTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $LearnedSkillsTable learnedSkills = $LearnedSkillsTable(this);
  late final $NpcRelationsTable npcRelations = $NpcRelationsTable(this);
  late final $QuestProgressTable questProgress = $QuestProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    characters,
    inventoryItems,
    learnedSkills,
    npcRelations,
    questProgress,
  ];
}

typedef $$CharactersTableCreateCompanionBuilder =
    CharactersCompanion Function({
      required String id,
      required String name,
      Value<int> baseHp,
      Value<int> baseMp,
      Value<int> baseAtk,
      Value<int> baseDef,
      Value<int> baseSpeed,
      Value<int> baseLuck,
      Value<int> baseComprehension,
      Value<int> exp,
      Value<int> silver,
      Value<int> reputation,
      Value<int> realmTierIndex,
      Value<int> realmStageIndex,
      Value<int> currentHp,
      Value<int> currentMp,
      Value<String?> weaponId,
      Value<String?> armorId,
      Value<String?> shoesId,
      Value<String?> accessoryId,
      Value<String> locationId,
      Value<DateTime?> lastOnlineTime,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$CharactersTableUpdateCompanionBuilder =
    CharactersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> baseHp,
      Value<int> baseMp,
      Value<int> baseAtk,
      Value<int> baseDef,
      Value<int> baseSpeed,
      Value<int> baseLuck,
      Value<int> baseComprehension,
      Value<int> exp,
      Value<int> silver,
      Value<int> reputation,
      Value<int> realmTierIndex,
      Value<int> realmStageIndex,
      Value<int> currentHp,
      Value<int> currentMp,
      Value<String?> weaponId,
      Value<String?> armorId,
      Value<String?> shoesId,
      Value<String?> accessoryId,
      Value<String> locationId,
      Value<DateTime?> lastOnlineTime,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CharactersTableReferences
    extends BaseReferences<_$AppDatabase, $CharactersTable, Character> {
  $$CharactersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventoryItemsTable, List<InventoryItem>>
  _inventoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryItems,
    aliasName: $_aliasNameGenerator(
      db.characters.id,
      db.inventoryItems.characterId,
    ),
  );

  $$InventoryItemsTableProcessedTableManager get inventoryItemsRefs {
    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearnedSkillsTable, List<LearnedSkill>>
  _learnedSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.learnedSkills,
    aliasName: $_aliasNameGenerator(
      db.characters.id,
      db.learnedSkills.characterId,
    ),
  );

  $$LearnedSkillsTableProcessedTableManager get learnedSkillsRefs {
    final manager = $$LearnedSkillsTableTableManager(
      $_db,
      $_db.learnedSkills,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_learnedSkillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NpcRelationsTable, List<NpcRelation>>
  _npcRelationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.npcRelations,
    aliasName: $_aliasNameGenerator(
      db.characters.id,
      db.npcRelations.characterId,
    ),
  );

  $$NpcRelationsTableProcessedTableManager get npcRelationsRefs {
    final manager = $$NpcRelationsTableTableManager(
      $_db,
      $_db.npcRelations,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_npcRelationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuestProgressTable, List<QuestProgressData>>
  _questProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.questProgress,
    aliasName: $_aliasNameGenerator(
      db.characters.id,
      db.questProgress.characterId,
    ),
  );

  $$QuestProgressTableProcessedTableManager get questProgressRefs {
    final manager = $$QuestProgressTableTableManager(
      $_db,
      $_db.questProgress,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CharactersTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseHp => $composableBuilder(
    column: $table.baseHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseMp => $composableBuilder(
    column: $table.baseMp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseAtk => $composableBuilder(
    column: $table.baseAtk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseDef => $composableBuilder(
    column: $table.baseDef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseSpeed => $composableBuilder(
    column: $table.baseSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseLuck => $composableBuilder(
    column: $table.baseLuck,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseComprehension => $composableBuilder(
    column: $table.baseComprehension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exp => $composableBuilder(
    column: $table.exp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get silver => $composableBuilder(
    column: $table.silver,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get realmTierIndex => $composableBuilder(
    column: $table.realmTierIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get realmStageIndex => $composableBuilder(
    column: $table.realmStageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentHp => $composableBuilder(
    column: $table.currentHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentMp => $composableBuilder(
    column: $table.currentMp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weaponId => $composableBuilder(
    column: $table.weaponId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get armorId => $composableBuilder(
    column: $table.armorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shoesId => $composableBuilder(
    column: $table.shoesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessoryId => $composableBuilder(
    column: $table.accessoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOnlineTime => $composableBuilder(
    column: $table.lastOnlineTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventoryItemsRefs(
    Expression<bool> Function($$InventoryItemsTableFilterComposer f) f,
  ) {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learnedSkillsRefs(
    Expression<bool> Function($$LearnedSkillsTableFilterComposer f) f,
  ) {
    final $$LearnedSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learnedSkills,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedSkillsTableFilterComposer(
            $db: $db,
            $table: $db.learnedSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> npcRelationsRefs(
    Expression<bool> Function($$NpcRelationsTableFilterComposer f) f,
  ) {
    final $$NpcRelationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.npcRelations,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NpcRelationsTableFilterComposer(
            $db: $db,
            $table: $db.npcRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> questProgressRefs(
    Expression<bool> Function($$QuestProgressTableFilterComposer f) f,
  ) {
    final $$QuestProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questProgress,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestProgressTableFilterComposer(
            $db: $db,
            $table: $db.questProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CharactersTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseHp => $composableBuilder(
    column: $table.baseHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseMp => $composableBuilder(
    column: $table.baseMp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseAtk => $composableBuilder(
    column: $table.baseAtk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseDef => $composableBuilder(
    column: $table.baseDef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseSpeed => $composableBuilder(
    column: $table.baseSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseLuck => $composableBuilder(
    column: $table.baseLuck,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseComprehension => $composableBuilder(
    column: $table.baseComprehension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exp => $composableBuilder(
    column: $table.exp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get silver => $composableBuilder(
    column: $table.silver,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get realmTierIndex => $composableBuilder(
    column: $table.realmTierIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get realmStageIndex => $composableBuilder(
    column: $table.realmStageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentHp => $composableBuilder(
    column: $table.currentHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentMp => $composableBuilder(
    column: $table.currentMp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weaponId => $composableBuilder(
    column: $table.weaponId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get armorId => $composableBuilder(
    column: $table.armorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shoesId => $composableBuilder(
    column: $table.shoesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessoryId => $composableBuilder(
    column: $table.accessoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOnlineTime => $composableBuilder(
    column: $table.lastOnlineTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharactersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get baseHp =>
      $composableBuilder(column: $table.baseHp, builder: (column) => column);

  GeneratedColumn<int> get baseMp =>
      $composableBuilder(column: $table.baseMp, builder: (column) => column);

  GeneratedColumn<int> get baseAtk =>
      $composableBuilder(column: $table.baseAtk, builder: (column) => column);

  GeneratedColumn<int> get baseDef =>
      $composableBuilder(column: $table.baseDef, builder: (column) => column);

  GeneratedColumn<int> get baseSpeed =>
      $composableBuilder(column: $table.baseSpeed, builder: (column) => column);

  GeneratedColumn<int> get baseLuck =>
      $composableBuilder(column: $table.baseLuck, builder: (column) => column);

  GeneratedColumn<int> get baseComprehension => $composableBuilder(
    column: $table.baseComprehension,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exp =>
      $composableBuilder(column: $table.exp, builder: (column) => column);

  GeneratedColumn<int> get silver =>
      $composableBuilder(column: $table.silver, builder: (column) => column);

  GeneratedColumn<int> get reputation => $composableBuilder(
    column: $table.reputation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get realmTierIndex => $composableBuilder(
    column: $table.realmTierIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get realmStageIndex => $composableBuilder(
    column: $table.realmStageIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentHp =>
      $composableBuilder(column: $table.currentHp, builder: (column) => column);

  GeneratedColumn<int> get currentMp =>
      $composableBuilder(column: $table.currentMp, builder: (column) => column);

  GeneratedColumn<String> get weaponId =>
      $composableBuilder(column: $table.weaponId, builder: (column) => column);

  GeneratedColumn<String> get armorId =>
      $composableBuilder(column: $table.armorId, builder: (column) => column);

  GeneratedColumn<String> get shoesId =>
      $composableBuilder(column: $table.shoesId, builder: (column) => column);

  GeneratedColumn<String> get accessoryId => $composableBuilder(
    column: $table.accessoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastOnlineTime => $composableBuilder(
    column: $table.lastOnlineTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> inventoryItemsRefs<T extends Object>(
    Expression<T> Function($$InventoryItemsTableAnnotationComposer a) f,
  ) {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> learnedSkillsRefs<T extends Object>(
    Expression<T> Function($$LearnedSkillsTableAnnotationComposer a) f,
  ) {
    final $$LearnedSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learnedSkills,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearnedSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.learnedSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> npcRelationsRefs<T extends Object>(
    Expression<T> Function($$NpcRelationsTableAnnotationComposer a) f,
  ) {
    final $$NpcRelationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.npcRelations,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NpcRelationsTableAnnotationComposer(
            $db: $db,
            $table: $db.npcRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> questProgressRefs<T extends Object>(
    Expression<T> Function($$QuestProgressTableAnnotationComposer a) f,
  ) {
    final $$QuestProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.questProgress,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuestProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.questProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CharactersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharactersTable,
          Character,
          $$CharactersTableFilterComposer,
          $$CharactersTableOrderingComposer,
          $$CharactersTableAnnotationComposer,
          $$CharactersTableCreateCompanionBuilder,
          $$CharactersTableUpdateCompanionBuilder,
          (Character, $$CharactersTableReferences),
          Character,
          PrefetchHooks Function({
            bool inventoryItemsRefs,
            bool learnedSkillsRefs,
            bool npcRelationsRefs,
            bool questProgressRefs,
          })
        > {
  $$CharactersTableTableManager(_$AppDatabase db, $CharactersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> baseHp = const Value.absent(),
                Value<int> baseMp = const Value.absent(),
                Value<int> baseAtk = const Value.absent(),
                Value<int> baseDef = const Value.absent(),
                Value<int> baseSpeed = const Value.absent(),
                Value<int> baseLuck = const Value.absent(),
                Value<int> baseComprehension = const Value.absent(),
                Value<int> exp = const Value.absent(),
                Value<int> silver = const Value.absent(),
                Value<int> reputation = const Value.absent(),
                Value<int> realmTierIndex = const Value.absent(),
                Value<int> realmStageIndex = const Value.absent(),
                Value<int> currentHp = const Value.absent(),
                Value<int> currentMp = const Value.absent(),
                Value<String?> weaponId = const Value.absent(),
                Value<String?> armorId = const Value.absent(),
                Value<String?> shoesId = const Value.absent(),
                Value<String?> accessoryId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<DateTime?> lastOnlineTime = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion(
                id: id,
                name: name,
                baseHp: baseHp,
                baseMp: baseMp,
                baseAtk: baseAtk,
                baseDef: baseDef,
                baseSpeed: baseSpeed,
                baseLuck: baseLuck,
                baseComprehension: baseComprehension,
                exp: exp,
                silver: silver,
                reputation: reputation,
                realmTierIndex: realmTierIndex,
                realmStageIndex: realmStageIndex,
                currentHp: currentHp,
                currentMp: currentMp,
                weaponId: weaponId,
                armorId: armorId,
                shoesId: shoesId,
                accessoryId: accessoryId,
                locationId: locationId,
                lastOnlineTime: lastOnlineTime,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> baseHp = const Value.absent(),
                Value<int> baseMp = const Value.absent(),
                Value<int> baseAtk = const Value.absent(),
                Value<int> baseDef = const Value.absent(),
                Value<int> baseSpeed = const Value.absent(),
                Value<int> baseLuck = const Value.absent(),
                Value<int> baseComprehension = const Value.absent(),
                Value<int> exp = const Value.absent(),
                Value<int> silver = const Value.absent(),
                Value<int> reputation = const Value.absent(),
                Value<int> realmTierIndex = const Value.absent(),
                Value<int> realmStageIndex = const Value.absent(),
                Value<int> currentHp = const Value.absent(),
                Value<int> currentMp = const Value.absent(),
                Value<String?> weaponId = const Value.absent(),
                Value<String?> armorId = const Value.absent(),
                Value<String?> shoesId = const Value.absent(),
                Value<String?> accessoryId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<DateTime?> lastOnlineTime = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion.insert(
                id: id,
                name: name,
                baseHp: baseHp,
                baseMp: baseMp,
                baseAtk: baseAtk,
                baseDef: baseDef,
                baseSpeed: baseSpeed,
                baseLuck: baseLuck,
                baseComprehension: baseComprehension,
                exp: exp,
                silver: silver,
                reputation: reputation,
                realmTierIndex: realmTierIndex,
                realmStageIndex: realmStageIndex,
                currentHp: currentHp,
                currentMp: currentMp,
                weaponId: weaponId,
                armorId: armorId,
                shoesId: shoesId,
                accessoryId: accessoryId,
                locationId: locationId,
                lastOnlineTime: lastOnlineTime,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharactersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                inventoryItemsRefs = false,
                learnedSkillsRefs = false,
                npcRelationsRefs = false,
                questProgressRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inventoryItemsRefs) db.inventoryItems,
                    if (learnedSkillsRefs) db.learnedSkills,
                    if (npcRelationsRefs) db.npcRelations,
                    if (questProgressRefs) db.questProgress,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inventoryItemsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          InventoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._inventoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learnedSkillsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          LearnedSkill
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._learnedSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).learnedSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (npcRelationsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          NpcRelation
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._npcRelationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).npcRelationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (questProgressRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          QuestProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._questProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).questProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CharactersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharactersTable,
      Character,
      $$CharactersTableFilterComposer,
      $$CharactersTableOrderingComposer,
      $$CharactersTableAnnotationComposer,
      $$CharactersTableCreateCompanionBuilder,
      $$CharactersTableUpdateCompanionBuilder,
      (Character, $$CharactersTableReferences),
      Character,
      PrefetchHooks Function({
        bool inventoryItemsRefs,
        bool learnedSkillsRefs,
        bool npcRelationsRefs,
        bool questProgressRefs,
      })
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String id,
      required String characterId,
      required String itemId,
      Value<int> quantity,
      Value<int> enhanceLevel,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<String> characterId,
      Value<String> itemId,
      Value<int> quantity,
      Value<int> enhanceLevel,
      Value<int> rowid,
    });

final class $$InventoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem> {
  $$InventoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(db.inventoryItems.characterId, db.characters.id),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enhanceLevel => $composableBuilder(
    column: $table.enhanceLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enhanceLevel => $composableBuilder(
    column: $table.enhanceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get enhanceLevel => $composableBuilder(
    column: $table.enhanceLevel,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (InventoryItem, $$InventoryItemsTableReferences),
          InventoryItem,
          PrefetchHooks Function({bool characterId})
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> characterId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> enhanceLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                characterId: characterId,
                itemId: itemId,
                quantity: quantity,
                enhanceLevel: enhanceLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String characterId,
                required String itemId,
                Value<int> quantity = const Value.absent(),
                Value<int> enhanceLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                characterId: characterId,
                itemId: itemId,
                quantity: quantity,
                enhanceLevel: enhanceLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable: $$InventoryItemsTableReferences
                                    ._characterIdTable(db),
                                referencedColumn:
                                    $$InventoryItemsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (InventoryItem, $$InventoryItemsTableReferences),
      InventoryItem,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$LearnedSkillsTableCreateCompanionBuilder =
    LearnedSkillsCompanion Function({
      required String id,
      required String characterId,
      required String skillId,
      Value<int> level,
      Value<int> proficiency,
      Value<bool> isEquipped,
      Value<int> rowid,
    });
typedef $$LearnedSkillsTableUpdateCompanionBuilder =
    LearnedSkillsCompanion Function({
      Value<String> id,
      Value<String> characterId,
      Value<String> skillId,
      Value<int> level,
      Value<int> proficiency,
      Value<bool> isEquipped,
      Value<int> rowid,
    });

final class $$LearnedSkillsTableReferences
    extends BaseReferences<_$AppDatabase, $LearnedSkillsTable, LearnedSkill> {
  $$LearnedSkillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(db.learnedSkills.characterId, db.characters.id),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearnedSkillsTableFilterComposer
    extends Composer<_$AppDatabase, $LearnedSkillsTable> {
  $$LearnedSkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearnedSkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearnedSkillsTable> {
  $$LearnedSkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillId => $composableBuilder(
    column: $table.skillId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearnedSkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearnedSkillsTable> {
  $$LearnedSkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get skillId =>
      $composableBuilder(column: $table.skillId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearnedSkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearnedSkillsTable,
          LearnedSkill,
          $$LearnedSkillsTableFilterComposer,
          $$LearnedSkillsTableOrderingComposer,
          $$LearnedSkillsTableAnnotationComposer,
          $$LearnedSkillsTableCreateCompanionBuilder,
          $$LearnedSkillsTableUpdateCompanionBuilder,
          (LearnedSkill, $$LearnedSkillsTableReferences),
          LearnedSkill,
          PrefetchHooks Function({bool characterId})
        > {
  $$LearnedSkillsTableTableManager(_$AppDatabase db, $LearnedSkillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearnedSkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearnedSkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearnedSkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> characterId = const Value.absent(),
                Value<String> skillId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> proficiency = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearnedSkillsCompanion(
                id: id,
                characterId: characterId,
                skillId: skillId,
                level: level,
                proficiency: proficiency,
                isEquipped: isEquipped,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String characterId,
                required String skillId,
                Value<int> level = const Value.absent(),
                Value<int> proficiency = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearnedSkillsCompanion.insert(
                id: id,
                characterId: characterId,
                skillId: skillId,
                level: level,
                proficiency: proficiency,
                isEquipped: isEquipped,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LearnedSkillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable: $$LearnedSkillsTableReferences
                                    ._characterIdTable(db),
                                referencedColumn: $$LearnedSkillsTableReferences
                                    ._characterIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LearnedSkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearnedSkillsTable,
      LearnedSkill,
      $$LearnedSkillsTableFilterComposer,
      $$LearnedSkillsTableOrderingComposer,
      $$LearnedSkillsTableAnnotationComposer,
      $$LearnedSkillsTableCreateCompanionBuilder,
      $$LearnedSkillsTableUpdateCompanionBuilder,
      (LearnedSkill, $$LearnedSkillsTableReferences),
      LearnedSkill,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$NpcRelationsTableCreateCompanionBuilder =
    NpcRelationsCompanion Function({
      required String characterId,
      required String npcId,
      Value<int> affection,
      Value<int> rowid,
    });
typedef $$NpcRelationsTableUpdateCompanionBuilder =
    NpcRelationsCompanion Function({
      Value<String> characterId,
      Value<String> npcId,
      Value<int> affection,
      Value<int> rowid,
    });

final class $$NpcRelationsTableReferences
    extends BaseReferences<_$AppDatabase, $NpcRelationsTable, NpcRelation> {
  $$NpcRelationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(db.npcRelations.characterId, db.characters.id),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NpcRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $NpcRelationsTable> {
  $$NpcRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get npcId => $composableBuilder(
    column: $table.npcId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get affection => $composableBuilder(
    column: $table.affection,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NpcRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NpcRelationsTable> {
  $$NpcRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get npcId => $composableBuilder(
    column: $table.npcId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get affection => $composableBuilder(
    column: $table.affection,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NpcRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NpcRelationsTable> {
  $$NpcRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get npcId =>
      $composableBuilder(column: $table.npcId, builder: (column) => column);

  GeneratedColumn<int> get affection =>
      $composableBuilder(column: $table.affection, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NpcRelationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NpcRelationsTable,
          NpcRelation,
          $$NpcRelationsTableFilterComposer,
          $$NpcRelationsTableOrderingComposer,
          $$NpcRelationsTableAnnotationComposer,
          $$NpcRelationsTableCreateCompanionBuilder,
          $$NpcRelationsTableUpdateCompanionBuilder,
          (NpcRelation, $$NpcRelationsTableReferences),
          NpcRelation,
          PrefetchHooks Function({bool characterId})
        > {
  $$NpcRelationsTableTableManager(_$AppDatabase db, $NpcRelationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NpcRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NpcRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NpcRelationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String> npcId = const Value.absent(),
                Value<int> affection = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NpcRelationsCompanion(
                characterId: characterId,
                npcId: npcId,
                affection: affection,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required String npcId,
                Value<int> affection = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NpcRelationsCompanion.insert(
                characterId: characterId,
                npcId: npcId,
                affection: affection,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NpcRelationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable: $$NpcRelationsTableReferences
                                    ._characterIdTable(db),
                                referencedColumn: $$NpcRelationsTableReferences
                                    ._characterIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NpcRelationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NpcRelationsTable,
      NpcRelation,
      $$NpcRelationsTableFilterComposer,
      $$NpcRelationsTableOrderingComposer,
      $$NpcRelationsTableAnnotationComposer,
      $$NpcRelationsTableCreateCompanionBuilder,
      $$NpcRelationsTableUpdateCompanionBuilder,
      (NpcRelation, $$NpcRelationsTableReferences),
      NpcRelation,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$QuestProgressTableCreateCompanionBuilder =
    QuestProgressCompanion Function({
      required String id,
      required String characterId,
      required String questId,
      Value<int> status,
      Value<String> objectivesJson,
      Value<int?> selectedBranch,
      Value<int> rowid,
    });
typedef $$QuestProgressTableUpdateCompanionBuilder =
    QuestProgressCompanion Function({
      Value<String> id,
      Value<String> characterId,
      Value<String> questId,
      Value<int> status,
      Value<String> objectivesJson,
      Value<int?> selectedBranch,
      Value<int> rowid,
    });

final class $$QuestProgressTableReferences
    extends
        BaseReferences<_$AppDatabase, $QuestProgressTable, QuestProgressData> {
  $$QuestProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(db.questProgress.characterId, db.characters.id),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuestProgressTableFilterComposer
    extends Composer<_$AppDatabase, $QuestProgressTable> {
  $$QuestProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questId => $composableBuilder(
    column: $table.questId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectivesJson => $composableBuilder(
    column: $table.objectivesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get selectedBranch => $composableBuilder(
    column: $table.selectedBranch,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestProgressTable> {
  $$QuestProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questId => $composableBuilder(
    column: $table.questId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectivesJson => $composableBuilder(
    column: $table.objectivesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get selectedBranch => $composableBuilder(
    column: $table.selectedBranch,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestProgressTable> {
  $$QuestProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questId =>
      $composableBuilder(column: $table.questId, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get objectivesJson => $composableBuilder(
    column: $table.objectivesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get selectedBranch => $composableBuilder(
    column: $table.selectedBranch,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuestProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestProgressTable,
          QuestProgressData,
          $$QuestProgressTableFilterComposer,
          $$QuestProgressTableOrderingComposer,
          $$QuestProgressTableAnnotationComposer,
          $$QuestProgressTableCreateCompanionBuilder,
          $$QuestProgressTableUpdateCompanionBuilder,
          (QuestProgressData, $$QuestProgressTableReferences),
          QuestProgressData,
          PrefetchHooks Function({bool characterId})
        > {
  $$QuestProgressTableTableManager(_$AppDatabase db, $QuestProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> characterId = const Value.absent(),
                Value<String> questId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String> objectivesJson = const Value.absent(),
                Value<int?> selectedBranch = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestProgressCompanion(
                id: id,
                characterId: characterId,
                questId: questId,
                status: status,
                objectivesJson: objectivesJson,
                selectedBranch: selectedBranch,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String characterId,
                required String questId,
                Value<int> status = const Value.absent(),
                Value<String> objectivesJson = const Value.absent(),
                Value<int?> selectedBranch = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestProgressCompanion.insert(
                id: id,
                characterId: characterId,
                questId: questId,
                status: status,
                objectivesJson: objectivesJson,
                selectedBranch: selectedBranch,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$QuestProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable: $$QuestProgressTableReferences
                                    ._characterIdTable(db),
                                referencedColumn: $$QuestProgressTableReferences
                                    ._characterIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuestProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestProgressTable,
      QuestProgressData,
      $$QuestProgressTableFilterComposer,
      $$QuestProgressTableOrderingComposer,
      $$QuestProgressTableAnnotationComposer,
      $$QuestProgressTableCreateCompanionBuilder,
      $$QuestProgressTableUpdateCompanionBuilder,
      (QuestProgressData, $$QuestProgressTableReferences),
      QuestProgressData,
      PrefetchHooks Function({bool characterId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersTableTableManager get characters =>
      $$CharactersTableTableManager(_db, _db.characters);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$LearnedSkillsTableTableManager get learnedSkills =>
      $$LearnedSkillsTableTableManager(_db, _db.learnedSkills);
  $$NpcRelationsTableTableManager get npcRelations =>
      $$NpcRelationsTableTableManager(_db, _db.npcRelations);
  $$QuestProgressTableTableManager get questProgress =>
      $$QuestProgressTableTableManager(_db, _db.questProgress);
}

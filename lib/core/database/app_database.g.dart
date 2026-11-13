// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phone,
    firstName,
    lastName,
    dateOfBirth,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final int id;
  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;
  final DateTime createdAt;
  const UsersTableData({
    required this.id,
    required this.phone,
    required this.firstName,
    this.lastName,
    required this.dateOfBirth,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['phone'] = Variable<String>(phone);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      phone: Value(phone),
      firstName: Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      dateOfBirth: Value(dateOfBirth),
      createdAt: Value(createdAt),
    );
  }

  factory UsersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<int>(json['id']),
      phone: serializer.fromJson<String>(json['phone']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'phone': serializer.toJson<String>(phone),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UsersTableData copyWith({
    int? id,
    String? phone,
    String? firstName,
    Value<String?> lastName = const Value.absent(),
    DateTime? dateOfBirth,
    DateTime? createdAt,
  }) => UsersTableData(
    id: id ?? this.id,
    phone: phone ?? this.phone,
    firstName: firstName ?? this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    createdAt: createdAt ?? this.createdAt,
  );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      phone: data.phone.present ? data.phone.value : this.phone,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, phone, firstName, lastName, dateOfBirth, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.phone == this.phone &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.createdAt == this.createdAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<int> id;
  final Value<String> phone;
  final Value<String> firstName;
  final Value<String?> lastName;
  final Value<DateTime> dateOfBirth;
  final Value<DateTime> createdAt;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.phone = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersTableCompanion.insert({
    this.id = const Value.absent(),
    required String phone,
    required String firstName,
    this.lastName = const Value.absent(),
    required DateTime dateOfBirth,
    required DateTime createdAt,
  }) : phone = Value(phone),
       firstName = Value(firstName),
       dateOfBirth = Value(dateOfBirth),
       createdAt = Value(createdAt);
  static Insertable<UsersTableData> custom({
    Expression<int>? id,
    Expression<String>? phone,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phone != null) 'phone': phone,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersTableCompanion copyWith({
    Value<int>? id,
    Value<String>? phone,
    Value<String>? firstName,
    Value<String?>? lastName,
    Value<DateTime>? dateOfBirth,
    Value<DateTime>? createdAt,
  }) {
    return UsersTableCompanion(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('phone: $phone, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MemberProfileTableTable extends MemberProfileTable
    with TableInfo<$MemberProfileTableTable, MemberProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarAssetMeta = const VerificationMeta(
    'avatarAsset',
  );
  @override
  late final GeneratedColumn<String> avatarAsset = GeneratedColumn<String>(
    'avatar_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notificationCountMeta = const VerificationMeta(
    'notificationCount',
  );
  @override
  late final GeneratedColumn<int> notificationCount = GeneratedColumn<int>(
    'notification_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardsCountMeta = const VerificationMeta(
    'rewardsCount',
  );
  @override
  late final GeneratedColumn<int> rewardsCount = GeneratedColumn<int>(
    'rewards_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalPoints,
    avatarUrl,
    avatarAsset,
    notificationCount,
    rewardsCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'member_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPointsMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarUrlMeta);
    }
    if (data.containsKey('avatar_asset')) {
      context.handle(
        _avatarAssetMeta,
        avatarAsset.isAcceptableOrUnknown(
          data['avatar_asset']!,
          _avatarAssetMeta,
        ),
      );
    }
    if (data.containsKey('notification_count')) {
      context.handle(
        _notificationCountMeta,
        notificationCount.isAcceptableOrUnknown(
          data['notification_count']!,
          _notificationCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationCountMeta);
    }
    if (data.containsKey('rewards_count')) {
      context.handle(
        _rewardsCountMeta,
        rewardsCount.isAcceptableOrUnknown(
          data['rewards_count']!,
          _rewardsCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardsCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      )!,
      avatarAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_asset'],
      ),
      notificationCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_count'],
      )!,
      rewardsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rewards_count'],
      )!,
    );
  }

  @override
  $MemberProfileTableTable createAlias(String alias) {
    return $MemberProfileTableTable(attachedDatabase, alias);
  }
}

class MemberProfileTableData extends DataClass
    implements Insertable<MemberProfileTableData> {
  final int id;
  final int totalPoints;
  final String avatarUrl;
  final String? avatarAsset;
  final int notificationCount;
  final int rewardsCount;
  const MemberProfileTableData({
    required this.id,
    required this.totalPoints,
    required this.avatarUrl,
    this.avatarAsset,
    required this.notificationCount,
    required this.rewardsCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_points'] = Variable<int>(totalPoints);
    map['avatar_url'] = Variable<String>(avatarUrl);
    if (!nullToAbsent || avatarAsset != null) {
      map['avatar_asset'] = Variable<String>(avatarAsset);
    }
    map['notification_count'] = Variable<int>(notificationCount);
    map['rewards_count'] = Variable<int>(rewardsCount);
    return map;
  }

  MemberProfileTableCompanion toCompanion(bool nullToAbsent) {
    return MemberProfileTableCompanion(
      id: Value(id),
      totalPoints: Value(totalPoints),
      avatarUrl: Value(avatarUrl),
      avatarAsset: avatarAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarAsset),
      notificationCount: Value(notificationCount),
      rewardsCount: Value(rewardsCount),
    );
  }

  factory MemberProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
      avatarAsset: serializer.fromJson<String?>(json['avatarAsset']),
      notificationCount: serializer.fromJson<int>(json['notificationCount']),
      rewardsCount: serializer.fromJson<int>(json['rewardsCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
      'avatarAsset': serializer.toJson<String?>(avatarAsset),
      'notificationCount': serializer.toJson<int>(notificationCount),
      'rewardsCount': serializer.toJson<int>(rewardsCount),
    };
  }

  MemberProfileTableData copyWith({
    int? id,
    int? totalPoints,
    String? avatarUrl,
    Value<String?> avatarAsset = const Value.absent(),
    int? notificationCount,
    int? rewardsCount,
  }) => MemberProfileTableData(
    id: id ?? this.id,
    totalPoints: totalPoints ?? this.totalPoints,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    avatarAsset: avatarAsset.present ? avatarAsset.value : this.avatarAsset,
    notificationCount: notificationCount ?? this.notificationCount,
    rewardsCount: rewardsCount ?? this.rewardsCount,
  );
  MemberProfileTableData copyWithCompanion(MemberProfileTableCompanion data) {
    return MemberProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      avatarAsset: data.avatarAsset.present
          ? data.avatarAsset.value
          : this.avatarAsset,
      notificationCount: data.notificationCount.present
          ? data.notificationCount.value
          : this.notificationCount,
      rewardsCount: data.rewardsCount.present
          ? data.rewardsCount.value
          : this.rewardsCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberProfileTableData(')
          ..write('id: $id, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsCount: $rewardsCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalPoints,
    avatarUrl,
    avatarAsset,
    notificationCount,
    rewardsCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberProfileTableData &&
          other.id == this.id &&
          other.totalPoints == this.totalPoints &&
          other.avatarUrl == this.avatarUrl &&
          other.avatarAsset == this.avatarAsset &&
          other.notificationCount == this.notificationCount &&
          other.rewardsCount == this.rewardsCount);
}

class MemberProfileTableCompanion
    extends UpdateCompanion<MemberProfileTableData> {
  final Value<int> id;
  final Value<int> totalPoints;
  final Value<String> avatarUrl;
  final Value<String?> avatarAsset;
  final Value<int> notificationCount;
  final Value<int> rewardsCount;
  const MemberProfileTableCompanion({
    this.id = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.avatarAsset = const Value.absent(),
    this.notificationCount = const Value.absent(),
    this.rewardsCount = const Value.absent(),
  });
  MemberProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required int totalPoints,
    required String avatarUrl,
    this.avatarAsset = const Value.absent(),
    required int notificationCount,
    required int rewardsCount,
  }) : totalPoints = Value(totalPoints),
       avatarUrl = Value(avatarUrl),
       notificationCount = Value(notificationCount),
       rewardsCount = Value(rewardsCount);
  static Insertable<MemberProfileTableData> custom({
    Expression<int>? id,
    Expression<int>? totalPoints,
    Expression<String>? avatarUrl,
    Expression<String>? avatarAsset,
    Expression<int>? notificationCount,
    Expression<int>? rewardsCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalPoints != null) 'total_points': totalPoints,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (avatarAsset != null) 'avatar_asset': avatarAsset,
      if (notificationCount != null) 'notification_count': notificationCount,
      if (rewardsCount != null) 'rewards_count': rewardsCount,
    });
  }

  MemberProfileTableCompanion copyWith({
    Value<int>? id,
    Value<int>? totalPoints,
    Value<String>? avatarUrl,
    Value<String?>? avatarAsset,
    Value<int>? notificationCount,
    Value<int>? rewardsCount,
  }) {
    return MemberProfileTableCompanion(
      id: id ?? this.id,
      totalPoints: totalPoints ?? this.totalPoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      notificationCount: notificationCount ?? this.notificationCount,
      rewardsCount: rewardsCount ?? this.rewardsCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (avatarAsset.present) {
      map['avatar_asset'] = Variable<String>(avatarAsset.value);
    }
    if (notificationCount.present) {
      map['notification_count'] = Variable<int>(notificationCount.value);
    }
    if (rewardsCount.present) {
      map['rewards_count'] = Variable<int>(rewardsCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemberProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('avatarAsset: $avatarAsset, ')
          ..write('notificationCount: $notificationCount, ')
          ..write('rewardsCount: $rewardsCount')
          ..write(')'))
        .toString();
  }
}

class $TiersTableTable extends TiersTable
    with TableInfo<$TiersTableTable, TiersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TiersTableTable(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minPointsMeta = const VerificationMeta(
    'minPoints',
  );
  @override
  late final GeneratedColumn<int> minPoints = GeneratedColumn<int>(
    'min_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    minPoints,
    sortOrder,
    imageUrl,
    imageAsset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tiers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TiersTableData> instance, {
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
    if (data.containsKey('min_points')) {
      context.handle(
        _minPointsMeta,
        minPoints.isAcceptableOrUnknown(data['min_points']!, _minPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_minPointsMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TiersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TiersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      minPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_points'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
    );
  }

  @override
  $TiersTableTable createAlias(String alias) {
    return $TiersTableTable(attachedDatabase, alias);
  }
}

class TiersTableData extends DataClass implements Insertable<TiersTableData> {
  final String id;
  final String name;
  final int minPoints;
  final int sortOrder;
  final String? imageUrl;
  final String? imageAsset;
  const TiersTableData({
    required this.id,
    required this.name,
    required this.minPoints,
    required this.sortOrder,
    this.imageUrl,
    this.imageAsset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['min_points'] = Variable<int>(minPoints);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    return map;
  }

  TiersTableCompanion toCompanion(bool nullToAbsent) {
    return TiersTableCompanion(
      id: Value(id),
      name: Value(name),
      minPoints: Value(minPoints),
      sortOrder: Value(sortOrder),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
    );
  }

  factory TiersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TiersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      minPoints: serializer.fromJson<int>(json['minPoints']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'minPoints': serializer.toJson<int>(minPoints),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
    };
  }

  TiersTableData copyWith({
    String? id,
    String? name,
    int? minPoints,
    int? sortOrder,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageAsset = const Value.absent(),
  }) => TiersTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    minPoints: minPoints ?? this.minPoints,
    sortOrder: sortOrder ?? this.sortOrder,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
  );
  TiersTableData copyWithCompanion(TiersTableCompanion data) {
    return TiersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      minPoints: data.minPoints.present ? data.minPoints.value : this.minPoints,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TiersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('minPoints: $minPoints, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, minPoints, sortOrder, imageUrl, imageAsset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TiersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.minPoints == this.minPoints &&
          other.sortOrder == this.sortOrder &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset);
}

class TiersTableCompanion extends UpdateCompanion<TiersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> minPoints;
  final Value<int> sortOrder;
  final Value<String?> imageUrl;
  final Value<String?> imageAsset;
  final Value<int> rowid;
  const TiersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.minPoints = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TiersTableCompanion.insert({
    required String id,
    required String name,
    required int minPoints,
    required int sortOrder,
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       minPoints = Value(minPoints),
       sortOrder = Value(sortOrder);
  static Insertable<TiersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? minPoints,
    Expression<int>? sortOrder,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (minPoints != null) 'min_points': minPoints,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TiersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? minPoints,
    Value<int>? sortOrder,
    Value<String?>? imageUrl,
    Value<String?>? imageAsset,
    Value<int>? rowid,
  }) {
    return TiersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      minPoints: minPoints ?? this.minPoints,
      sortOrder: sortOrder ?? this.sortOrder,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
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
    if (minPoints.present) {
      map['min_points'] = Variable<int>(minPoints.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TiersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('minPoints: $minPoints, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMmkMeta = const VerificationMeta(
    'priceMmk',
  );
  @override
  late final GeneratedColumn<int> priceMmk = GeneratedColumn<int>(
    'price_mmk',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<int> discountPercent = GeneratedColumn<int>(
    'discount_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    description,
    imageUrl,
    imageAsset,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_mmk')) {
      context.handle(
        _priceMmkMeta,
        priceMmk.isAcceptableOrUnknown(data['price_mmk']!, _priceMmkMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMmkMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priceMmk: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_mmk'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_percent'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String description;
  final String imageUrl;
  final String? imageAsset;
  final DateTime updatedAt;
  const ProductsTableData({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    required this.description,
    required this.imageUrl,
    this.imageAsset,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['price_mmk'] = Variable<int>(priceMmk);
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercent != null) {
      map['discount_percent'] = Variable<int>(discountPercent);
    }
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priceMmk: Value(priceMmk),
      isNew: Value(isNew),
      discountPercent: discountPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercent),
      description: Value(description),
      imageUrl: Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priceMmk: serializer.fromJson<int>(json['priceMmk']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercent: serializer.fromJson<int?>(json['discountPercent']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priceMmk': serializer.toJson<int>(priceMmk),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercent': serializer.toJson<int?>(discountPercent),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductsTableData copyWith({
    String? id,
    String? code,
    String? name,
    int? priceMmk,
    bool? isNew,
    Value<int?> discountPercent = const Value.absent(),
    String? description,
    String? imageUrl,
    Value<String?> imageAsset = const Value.absent(),
    DateTime? updatedAt,
  }) => ProductsTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priceMmk: priceMmk ?? this.priceMmk,
    isNew: isNew ?? this.isNew,
    discountPercent: discountPercent.present
        ? discountPercent.value
        : this.discountPercent,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priceMmk: data.priceMmk.present ? data.priceMmk.value : this.priceMmk,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    priceMmk,
    isNew,
    discountPercent,
    description,
    imageUrl,
    imageAsset,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priceMmk == this.priceMmk &&
          other.isNew == this.isNew &&
          other.discountPercent == this.discountPercent &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.updatedAt == this.updatedAt);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priceMmk;
  final Value<bool> isNew;
  final Value<int?> discountPercent;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<String?> imageAsset;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMmk = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,
    this.discountPercent = const Value.absent(),
    required String description,
    required String imageUrl,
    this.imageAsset = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       priceMmk = Value(priceMmk),
       isNew = Value(isNew),
       description = Value(description),
       imageUrl = Value(imageUrl),
       updatedAt = Value(updatedAt);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priceMmk,
    Expression<bool>? isNew,
    Expression<int>? discountPercent,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priceMmk != null) 'price_mmk': priceMmk,
      if (isNew != null) 'is_new': isNew,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priceMmk,
    Value<bool>? isNew,
    Value<int?>? discountPercent,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<String?>? imageAsset,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priceMmk: priceMmk ?? this.priceMmk,
      isNew: isNew ?? this.isNew,
      discountPercent: discountPercent ?? this.discountPercent,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMmk.present) {
      map['price_mmk'] = Variable<int>(priceMmk.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<int>(discountPercent.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priceMmk: $priceMmk, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HomeSectionsTableTable extends HomeSectionsTable
    with TableInfo<$HomeSectionsTableTable, HomeSectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HomeSectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleKeyMeta = const VerificationMeta(
    'titleKey',
  );
  @override
  late final GeneratedColumn<String> titleKey = GeneratedColumn<String>(
    'title_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, titleKey, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'home_sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<HomeSectionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title_key')) {
      context.handle(
        _titleKeyMeta,
        titleKey.isAcceptableOrUnknown(data['title_key']!, _titleKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_titleKeyMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HomeSectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HomeSectionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_key'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $HomeSectionsTableTable createAlias(String alias) {
    return $HomeSectionsTableTable(attachedDatabase, alias);
  }
}

class HomeSectionsTableData extends DataClass
    implements Insertable<HomeSectionsTableData> {
  final String id;
  final String titleKey;
  final int sortOrder;
  const HomeSectionsTableData({
    required this.id,
    required this.titleKey,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title_key'] = Variable<String>(titleKey);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HomeSectionsTableCompanion toCompanion(bool nullToAbsent) {
    return HomeSectionsTableCompanion(
      id: Value(id),
      titleKey: Value(titleKey),
      sortOrder: Value(sortOrder),
    );
  }

  factory HomeSectionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HomeSectionsTableData(
      id: serializer.fromJson<String>(json['id']),
      titleKey: serializer.fromJson<String>(json['titleKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titleKey': serializer.toJson<String>(titleKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HomeSectionsTableData copyWith({
    String? id,
    String? titleKey,
    int? sortOrder,
  }) => HomeSectionsTableData(
    id: id ?? this.id,
    titleKey: titleKey ?? this.titleKey,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  HomeSectionsTableData copyWithCompanion(HomeSectionsTableCompanion data) {
    return HomeSectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      titleKey: data.titleKey.present ? data.titleKey.value : this.titleKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionsTableData(')
          ..write('id: $id, ')
          ..write('titleKey: $titleKey, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, titleKey, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomeSectionsTableData &&
          other.id == this.id &&
          other.titleKey == this.titleKey &&
          other.sortOrder == this.sortOrder);
}

class HomeSectionsTableCompanion
    extends UpdateCompanion<HomeSectionsTableData> {
  final Value<String> id;
  final Value<String> titleKey;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const HomeSectionsTableCompanion({
    this.id = const Value.absent(),
    this.titleKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HomeSectionsTableCompanion.insert({
    required String id,
    required String titleKey,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titleKey = Value(titleKey),
       sortOrder = Value(sortOrder);
  static Insertable<HomeSectionsTableData> custom({
    Expression<String>? id,
    Expression<String>? titleKey,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleKey != null) 'title_key': titleKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HomeSectionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? titleKey,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return HomeSectionsTableCompanion(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titleKey.present) {
      map['title_key'] = Variable<String>(titleKey.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HomeSectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('titleKey: $titleKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionProductsTableTable extends SectionProductsTable
    with TableInfo<$SectionProductsTableTable, SectionProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES home_sections (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [sectionId, productId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'section_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionProductsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sectionId, productId};
  @override
  SectionProductsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionProductsTableData(
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SectionProductsTableTable createAlias(String alias) {
    return $SectionProductsTableTable(attachedDatabase, alias);
  }
}

class SectionProductsTableData extends DataClass
    implements Insertable<SectionProductsTableData> {
  final String sectionId;
  final String productId;
  final int sortOrder;
  const SectionProductsTableData({
    required this.sectionId,
    required this.productId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['section_id'] = Variable<String>(sectionId);
    map['product_id'] = Variable<String>(productId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SectionProductsTableCompanion toCompanion(bool nullToAbsent) {
    return SectionProductsTableCompanion(
      sectionId: Value(sectionId),
      productId: Value(productId),
      sortOrder: Value(sortOrder),
    );
  }

  factory SectionProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionProductsTableData(
      sectionId: serializer.fromJson<String>(json['sectionId']),
      productId: serializer.fromJson<String>(json['productId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sectionId': serializer.toJson<String>(sectionId),
      'productId': serializer.toJson<String>(productId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SectionProductsTableData copyWith({
    String? sectionId,
    String? productId,
    int? sortOrder,
  }) => SectionProductsTableData(
    sectionId: sectionId ?? this.sectionId,
    productId: productId ?? this.productId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  SectionProductsTableData copyWithCompanion(
    SectionProductsTableCompanion data,
  ) {
    return SectionProductsTableData(
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductsTableData(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sectionId, productId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionProductsTableData &&
          other.sectionId == this.sectionId &&
          other.productId == this.productId &&
          other.sortOrder == this.sortOrder);
}

class SectionProductsTableCompanion
    extends UpdateCompanion<SectionProductsTableData> {
  final Value<String> sectionId;
  final Value<String> productId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SectionProductsTableCompanion({
    this.sectionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionProductsTableCompanion.insert({
    required String sectionId,
    required String productId,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : sectionId = Value(sectionId),
       productId = Value(productId),
       sortOrder = Value(sortOrder);
  static Insertable<SectionProductsTableData> custom({
    Expression<String>? sectionId,
    Expression<String>? productId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sectionId != null) 'section_id': sectionId,
      if (productId != null) 'product_id': productId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionProductsTableCompanion copyWith({
    Value<String>? sectionId,
    Value<String>? productId,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return SectionProductsTableCompanion(
      sectionId: sectionId ?? this.sectionId,
      productId: productId ?? this.productId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionProductsTableCompanion(')
          ..write('sectionId: $sectionId, ')
          ..write('productId: $productId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BannersTableTable extends BannersTable
    with TableInfo<$BannersTableTable, BannersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BannersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _styleMeta = const VerificationMeta('style');
  @override
  late final GeneratedColumn<String> style = GeneratedColumn<String>(
    'style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tag,
    title,
    style,
    imageUrl,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<BannersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('style')) {
      context.handle(
        _styleMeta,
        style.isAcceptableOrUnknown(data['style']!, _styleMeta),
      );
    } else if (isInserting) {
      context.missing(_styleMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BannersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BannersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      style: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}style'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $BannersTableTable createAlias(String alias) {
    return $BannersTableTable(attachedDatabase, alias);
  }
}

class BannersTableData extends DataClass
    implements Insertable<BannersTableData> {
  final String id;
  final String tag;
  final String title;
  final String style;
  final String imageUrl;
  final String? imageAsset;
  final int sortOrder;
  const BannersTableData({
    required this.id,
    required this.tag,
    required this.title,
    required this.style,
    required this.imageUrl,
    this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tag'] = Variable<String>(tag);
    map['title'] = Variable<String>(title);
    map['style'] = Variable<String>(style);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  BannersTableCompanion toCompanion(bool nullToAbsent) {
    return BannersTableCompanion(
      id: Value(id),
      tag: Value(tag),
      title: Value(title),
      style: Value(style),
      imageUrl: Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory BannersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BannersTableData(
      id: serializer.fromJson<String>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
      title: serializer.fromJson<String>(json['title']),
      style: serializer.fromJson<String>(json['style']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tag': serializer.toJson<String>(tag),
      'title': serializer.toJson<String>(title),
      'style': serializer.toJson<String>(style),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  BannersTableData copyWith({
    String? id,
    String? tag,
    String? title,
    String? style,
    String? imageUrl,
    Value<String?> imageAsset = const Value.absent(),
    int? sortOrder,
  }) => BannersTableData(
    id: id ?? this.id,
    tag: tag ?? this.tag,
    title: title ?? this.title,
    style: style ?? this.style,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  BannersTableData copyWithCompanion(BannersTableCompanion data) {
    return BannersTableData(
      id: data.id.present ? data.id.value : this.id,
      tag: data.tag.present ? data.tag.value : this.tag,
      title: data.title.present ? data.title.value : this.title,
      style: data.style.present ? data.style.value : this.style,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BannersTableData(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('title: $title, ')
          ..write('style: $style, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tag, title, style, imageUrl, imageAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BannersTableData &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.title == this.title &&
          other.style == this.style &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class BannersTableCompanion extends UpdateCompanion<BannersTableData> {
  final Value<String> id;
  final Value<String> tag;
  final Value<String> title;
  final Value<String> style;
  final Value<String> imageUrl;
  final Value<String?> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const BannersTableCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.title = const Value.absent(),
    this.style = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BannersTableCompanion.insert({
    required String id,
    required String tag,
    required String title,
    required String style,
    required String imageUrl,
    this.imageAsset = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tag = Value(tag),
       title = Value(title),
       style = Value(style),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<BannersTableData> custom({
    Expression<String>? id,
    Expression<String>? tag,
    Expression<String>? title,
    Expression<String>? style,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (title != null) 'title': title,
      if (style != null) 'style': style,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BannersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? tag,
    Value<String>? title,
    Value<String>? style,
    Value<String>? imageUrl,
    Value<String?>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return BannersTableCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      title: title ?? this.title,
      style: style ?? this.style,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (style.present) {
      map['style'] = Variable<String>(style.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersTableCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('title: $title, ')
          ..write('style: $style, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopsTableTable extends ShopsTable
    with TableInfo<$ShopsTableTable, ShopsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTableTable(this.attachedDatabase, [this._alias]);
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    imageUrl,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopsTableData> instance, {
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
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ShopsTableTable createAlias(String alias) {
    return $ShopsTableTable(attachedDatabase, alias);
  }
}

class ShopsTableData extends DataClass implements Insertable<ShopsTableData> {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String? imageAsset;
  final int sortOrder;
  const ShopsTableData({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ShopsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopsTableCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      imageUrl: Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory ShopsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ShopsTableData copyWith({
    String? id,
    String? name,
    String? address,
    String? imageUrl,
    Value<String?> imageAsset = const Value.absent(),
    int? sortOrder,
  }) => ShopsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    imageUrl: imageUrl ?? this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ShopsTableData copyWithCompanion(ShopsTableCompanion data) {
    return ShopsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, address, imageUrl, imageAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class ShopsTableCompanion extends UpdateCompanion<ShopsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> imageUrl;
  final Value<String?> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ShopsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsTableCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    this.imageAsset = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       imageUrl = Value(imageUrl),
       sortOrder = Value(sortOrder);
  static Insertable<ShopsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? imageUrl,
    Value<String?>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ShopsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
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
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTableTable extends ChallengesTable
    with TableInfo<$ChallengesTableTable, ChallengesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardPointsMeta = const VerificationMeta(
    'rewardPoints',
  );
  @override
  late final GeneratedColumn<int> rewardPoints = GeneratedColumn<int>(
    'reward_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _claimedMeta = const VerificationMeta(
    'claimed',
  );
  @override
  late final GeneratedColumn<bool> claimed = GeneratedColumn<bool>(
    'claimed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("claimed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    kind,
    progress,
    target,
    rewardPoints,
    imageUrl,
    imageAsset,
    sortOrder,
    claimed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('reward_points')) {
      context.handle(
        _rewardPointsMeta,
        rewardPoints.isAcceptableOrUnknown(
          data['reward_points']!,
          _rewardPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardPointsMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('claimed')) {
      context.handle(
        _claimedMeta,
        claimed.isAcceptableOrUnknown(data['claimed']!, _claimedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      rewardPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_points'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      claimed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}claimed'],
      )!,
    );
  }

  @override
  $ChallengesTableTable createAlias(String alias) {
    return $ChallengesTableTable(attachedDatabase, alias);
  }
}

class ChallengesTableData extends DataClass
    implements Insertable<ChallengesTableData> {
  final String id;
  final String title;
  final String kind;
  final int progress;
  final int target;
  final int rewardPoints;
  final String? imageUrl;
  final String? imageAsset;
  final int sortOrder;

  /// True once the member has pressed Earn and the points were added to
  /// `member_profile.total_points`.
  final bool claimed;
  const ChallengesTableData({
    required this.id,
    required this.title,
    required this.kind,
    required this.progress,
    required this.target,
    required this.rewardPoints,
    this.imageUrl,
    this.imageAsset,
    required this.sortOrder,
    required this.claimed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['kind'] = Variable<String>(kind);
    map['progress'] = Variable<int>(progress);
    map['target'] = Variable<int>(target);
    map['reward_points'] = Variable<int>(rewardPoints);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['claimed'] = Variable<bool>(claimed);
    return map;
  }

  ChallengesTableCompanion toCompanion(bool nullToAbsent) {
    return ChallengesTableCompanion(
      id: Value(id),
      title: Value(title),
      kind: Value(kind),
      progress: Value(progress),
      target: Value(target),
      rewardPoints: Value(rewardPoints),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      sortOrder: Value(sortOrder),
      claimed: Value(claimed),
    );
  }

  factory ChallengesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengesTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      kind: serializer.fromJson<String>(json['kind']),
      progress: serializer.fromJson<int>(json['progress']),
      target: serializer.fromJson<int>(json['target']),
      rewardPoints: serializer.fromJson<int>(json['rewardPoints']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      claimed: serializer.fromJson<bool>(json['claimed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(kind),
      'progress': serializer.toJson<int>(progress),
      'target': serializer.toJson<int>(target),
      'rewardPoints': serializer.toJson<int>(rewardPoints),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'claimed': serializer.toJson<bool>(claimed),
    };
  }

  ChallengesTableData copyWith({
    String? id,
    String? title,
    String? kind,
    int? progress,
    int? target,
    int? rewardPoints,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageAsset = const Value.absent(),
    int? sortOrder,
    bool? claimed,
  }) => ChallengesTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    progress: progress ?? this.progress,
    target: target ?? this.target,
    rewardPoints: rewardPoints ?? this.rewardPoints,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
    claimed: claimed ?? this.claimed,
  );
  ChallengesTableData copyWithCompanion(ChallengesTableCompanion data) {
    return ChallengesTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      progress: data.progress.present ? data.progress.value : this.progress,
      target: data.target.present ? data.target.value : this.target,
      rewardPoints: data.rewardPoints.present
          ? data.rewardPoints.value
          : this.rewardPoints,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      claimed: data.claimed.present ? data.claimed.value : this.claimed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('claimed: $claimed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    kind,
    progress,
    target,
    rewardPoints,
    imageUrl,
    imageAsset,
    sortOrder,
    claimed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengesTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.progress == this.progress &&
          other.target == this.target &&
          other.rewardPoints == this.rewardPoints &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder &&
          other.claimed == this.claimed);
}

class ChallengesTableCompanion extends UpdateCompanion<ChallengesTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> kind;
  final Value<int> progress;
  final Value<int> target;
  final Value<int> rewardPoints;
  final Value<String?> imageUrl;
  final Value<String?> imageAsset;
  final Value<int> sortOrder;
  final Value<bool> claimed;
  final Value<int> rowid;
  const ChallengesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.progress = const Value.absent(),
    this.target = const Value.absent(),
    this.rewardPoints = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.claimed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesTableCompanion.insert({
    required String id,
    required String title,
    required String kind,
    required int progress,
    required int target,
    required int rewardPoints,
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    required int sortOrder,
    this.claimed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       kind = Value(kind),
       progress = Value(progress),
       target = Value(target),
       rewardPoints = Value(rewardPoints),
       sortOrder = Value(sortOrder);
  static Insertable<ChallengesTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<int>? progress,
    Expression<int>? target,
    Expression<int>? rewardPoints,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<bool>? claimed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (progress != null) 'progress': progress,
      if (target != null) 'target': target,
      if (rewardPoints != null) 'reward_points': rewardPoints,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (claimed != null) 'claimed': claimed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? kind,
    Value<int>? progress,
    Value<int>? target,
    Value<int>? rewardPoints,
    Value<String?>? imageUrl,
    Value<String?>? imageAsset,
    Value<int>? sortOrder,
    Value<bool>? claimed,
    Value<int>? rowid,
  }) {
    return ChallengesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      claimed: claimed ?? this.claimed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (rewardPoints.present) {
      map['reward_points'] = Variable<int>(rewardPoints.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (claimed.present) {
      map['claimed'] = Variable<bool>(claimed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('progress: $progress, ')
          ..write('target: $target, ')
          ..write('rewardPoints: $rewardPoints, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('claimed: $claimed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GiftsTableTable extends GiftsTable
    with TableInfo<$GiftsTableTable, GiftsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GiftsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPointsMeta = const VerificationMeta(
    'costPoints',
  );
  @override
  late final GeneratedColumn<int> costPoints = GeneratedColumn<int>(
    'cost_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    costPoints,
    imageUrl,
    imageAsset,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GiftsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cost_points')) {
      context.handle(
        _costPointsMeta,
        costPoints.isAcceptableOrUnknown(data['cost_points']!, _costPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_costPointsMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GiftsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GiftsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      costPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_points'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $GiftsTableTable createAlias(String alias) {
    return $GiftsTableTable(attachedDatabase, alias);
  }
}

class GiftsTableData extends DataClass implements Insertable<GiftsTableData> {
  final String id;
  final String title;
  final int costPoints;
  final String? imageUrl;
  final String? imageAsset;
  final int sortOrder;
  const GiftsTableData({
    required this.id,
    required this.title,
    required this.costPoints,
    this.imageUrl,
    this.imageAsset,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['cost_points'] = Variable<int>(costPoints);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GiftsTableCompanion toCompanion(bool nullToAbsent) {
    return GiftsTableCompanion(
      id: Value(id),
      title: Value(title),
      costPoints: Value(costPoints),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      sortOrder: Value(sortOrder),
    );
  }

  factory GiftsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GiftsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      costPoints: serializer.fromJson<int>(json['costPoints']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'costPoints': serializer.toJson<int>(costPoints),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  GiftsTableData copyWith({
    String? id,
    String? title,
    int? costPoints,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageAsset = const Value.absent(),
    int? sortOrder,
  }) => GiftsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    costPoints: costPoints ?? this.costPoints,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  GiftsTableData copyWithCompanion(GiftsTableCompanion data) {
    return GiftsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      costPoints: data.costPoints.present
          ? data.costPoints.value
          : this.costPoints,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GiftsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('costPoints: $costPoints, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, costPoints, imageUrl, imageAsset, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GiftsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.costPoints == this.costPoints &&
          other.imageUrl == this.imageUrl &&
          other.imageAsset == this.imageAsset &&
          other.sortOrder == this.sortOrder);
}

class GiftsTableCompanion extends UpdateCompanion<GiftsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> costPoints;
  final Value<String?> imageUrl;
  final Value<String?> imageAsset;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const GiftsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.costPoints = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GiftsTableCompanion.insert({
    required String id,
    required String title,
    required int costPoints,
    this.imageUrl = const Value.absent(),
    this.imageAsset = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       costPoints = Value(costPoints),
       sortOrder = Value(sortOrder);
  static Insertable<GiftsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? costPoints,
    Expression<String>? imageUrl,
    Expression<String>? imageAsset,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (costPoints != null) 'cost_points': costPoints,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GiftsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? costPoints,
    Value<String?>? imageUrl,
    Value<String?>? imageAsset,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return GiftsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      costPoints: costPoints ?? this.costPoints,
      imageUrl: imageUrl ?? this.imageUrl,
      imageAsset: imageAsset ?? this.imageAsset,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (costPoints.present) {
      map['cost_points'] = Variable<int>(costPoints.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GiftsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('costPoints: $costPoints, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStateTableTable extends SyncStateTable
    with TableInfo<$SyncStateTableTable, SyncStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, version, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncStateTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $SyncStateTableTable createAlias(String alias) {
    return $SyncStateTableTable(attachedDatabase, alias);
  }
}

class SyncStateTableData extends DataClass
    implements Insertable<SyncStateTableData> {
  final String key;
  final int version;
  final DateTime fetchedAt;
  const SyncStateTableData({
    required this.key,
    required this.version,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['version'] = Variable<int>(version);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  SyncStateTableCompanion toCompanion(bool nullToAbsent) {
    return SyncStateTableCompanion(
      key: Value(key),
      version: Value(version),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory SyncStateTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateTableData(
      key: serializer.fromJson<String>(json['key']),
      version: serializer.fromJson<int>(json['version']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'version': serializer.toJson<int>(version),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  SyncStateTableData copyWith({
    String? key,
    int? version,
    DateTime? fetchedAt,
  }) => SyncStateTableData(
    key: key ?? this.key,
    version: version ?? this.version,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  SyncStateTableData copyWithCompanion(SyncStateTableCompanion data) {
    return SyncStateTableData(
      key: data.key.present ? data.key.value : this.key,
      version: data.version.present ? data.version.value : this.version,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableData(')
          ..write('key: $key, ')
          ..write('version: $version, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, version, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateTableData &&
          other.key == this.key &&
          other.version == this.version &&
          other.fetchedAt == this.fetchedAt);
}

class SyncStateTableCompanion extends UpdateCompanion<SyncStateTableData> {
  final Value<String> key;
  final Value<int> version;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const SyncStateTableCompanion({
    this.key = const Value.absent(),
    this.version = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStateTableCompanion.insert({
    required String key,
    required int version,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       version = Value(version),
       fetchedAt = Value(fetchedAt);
  static Insertable<SyncStateTableData> custom({
    Expression<String>? key,
    Expression<int>? version,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (version != null) 'version': version,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStateTableCompanion copyWith({
    Value<String>? key,
    Value<int>? version,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return SyncStateTableCompanion(
      key: key ?? this.key,
      version: version ?? this.version,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateTableCompanion(')
          ..write('key: $key, ')
          ..write('version: $version, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTableTable extends CartItemsTable
    with TableInfo<$CartItemsTableTable, CartItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [productId, quantity, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  CartItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItemsTableData(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CartItemsTableTable createAlias(String alias) {
    return $CartItemsTableTable(attachedDatabase, alias);
  }
}

class CartItemsTableData extends DataClass
    implements Insertable<CartItemsTableData> {
  final String productId;
  final int quantity;
  final DateTime updatedAt;
  const CartItemsTableData({
    required this.productId,
    required this.quantity,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CartItemsTableCompanion toCompanion(bool nullToAbsent) {
    return CartItemsTableCompanion(
      productId: Value(productId),
      quantity: Value(quantity),
      updatedAt: Value(updatedAt),
    );
  }

  factory CartItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItemsTableData(
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CartItemsTableData copyWith({
    String? productId,
    int? quantity,
    DateTime? updatedAt,
  }) => CartItemsTableData(
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CartItemsTableData copyWithCompanion(CartItemsTableCompanion data) {
    return CartItemsTableData(
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsTableData(')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, quantity, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItemsTableData &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.updatedAt == this.updatedAt);
}

class CartItemsTableCompanion extends UpdateCompanion<CartItemsTableData> {
  final Value<String> productId;
  final Value<int> quantity;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CartItemsTableCompanion({
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartItemsTableCompanion.insert({
    required String productId,
    required int quantity,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       quantity = Value(quantity),
       updatedAt = Value(updatedAt);
  static Insertable<CartItemsTableData> custom({
    Expression<String>? productId,
    Expression<int>? quantity,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartItemsTableCompanion copyWith({
    Value<String>? productId,
    Value<int>? quantity,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CartItemsTableCompanion(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsTableCompanion(')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $MemberProfileTableTable memberProfileTable =
      $MemberProfileTableTable(this);
  late final $TiersTableTable tiersTable = $TiersTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $HomeSectionsTableTable homeSectionsTable =
      $HomeSectionsTableTable(this);
  late final $SectionProductsTableTable sectionProductsTable =
      $SectionProductsTableTable(this);
  late final $BannersTableTable bannersTable = $BannersTableTable(this);
  late final $ShopsTableTable shopsTable = $ShopsTableTable(this);
  late final $ChallengesTableTable challengesTable = $ChallengesTableTable(
    this,
  );
  late final $GiftsTableTable giftsTable = $GiftsTableTable(this);
  late final $SyncStateTableTable syncStateTable = $SyncStateTableTable(this);
  late final $CartItemsTableTable cartItemsTable = $CartItemsTableTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final CatalogDao catalogDao = CatalogDao(this as AppDatabase);
  late final MemberDao memberDao = MemberDao(this as AppDatabase);
  late final SyncStateDao syncStateDao = SyncStateDao(this as AppDatabase);
  late final CartDao cartDao = CartDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usersTable,
    memberProfileTable,
    tiersTable,
    productsTable,
    homeSectionsTable,
    sectionProductsTable,
    bannersTable,
    shopsTable,
    challengesTable,
    giftsTable,
    syncStateTable,
    cartItemsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'home_sections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('section_products', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('section_products', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cart_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  required String phone,
  required String firstName,
  Value<String?> lastName,
  required DateTime dateOfBirth,
  required DateTime createdAt,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<int> id,
  Value<String> phone,
  Value<String> firstName,
  Value<String?> lastName,
  Value<DateTime> dateOfBirth,
  Value<DateTime> createdAt,
});

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTableTable,
          UsersTableData,
          $$UsersTableTableFilterComposer,
          $$UsersTableTableOrderingComposer,
          $$UsersTableTableAnnotationComposer,
          $$UsersTableTableCreateCompanionBuilder,
          $$UsersTableTableUpdateCompanionBuilder,
          (
            UsersTableData,
            BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
          ),
          UsersTableData,
          PrefetchHooks Function()
        > {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersTableCompanion(
                id: id,
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String phone,
                required String firstName,
                Value<String?> lastName = const Value.absent(),
                required DateTime dateOfBirth,
                required DateTime createdAt,
              }) => UsersTableCompanion.insert(
                id: id,
                phone: phone,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTableTable, UsersTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UsersTableTable,
                    UsersTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTableTable,
      UsersTableData,
      $$UsersTableTableFilterComposer,
      $$UsersTableTableOrderingComposer,
      $$UsersTableTableAnnotationComposer,
      $$UsersTableTableCreateCompanionBuilder,
      $$UsersTableTableUpdateCompanionBuilder,
      (
        UsersTableData,
        BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
      ),
      UsersTableData,
      PrefetchHooks Function()
    >;
typedef $$MemberProfileTableTableCreateCompanionBuilder =
    MemberProfileTableCompanion Function({
      Value<int> id,
      required int totalPoints,
      required String avatarUrl,
      Value<String?> avatarAsset,
      required int notificationCount,
      required int rewardsCount,
    });
typedef $$MemberProfileTableTableUpdateCompanionBuilder =
    MemberProfileTableCompanion Function({
      Value<int> id,
      Value<int> totalPoints,
      Value<String> avatarUrl,
      Value<String?> avatarAsset,
      Value<int> notificationCount,
      Value<int> rewardsCount,
    });

class $$MemberProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $MemberProfileTableTable> {
  $$MemberProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemberProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberProfileTableTable> {
  $$MemberProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemberProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberProfileTableTable> {
  $$MemberProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get avatarAsset => $composableBuilder(
    column: $table.avatarAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationCount => $composableBuilder(
    column: $table.notificationCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardsCount => $composableBuilder(
    column: $table.rewardsCount,
    builder: (column) => column,
  );
}

class $$MemberProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberProfileTableTable,
          MemberProfileTableData,
          $$MemberProfileTableTableFilterComposer,
          $$MemberProfileTableTableOrderingComposer,
          $$MemberProfileTableTableAnnotationComposer,
          $$MemberProfileTableTableCreateCompanionBuilder,
          $$MemberProfileTableTableUpdateCompanionBuilder,
          (
            MemberProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $MemberProfileTableTable,
              MemberProfileTableData
            >,
          ),
          MemberProfileTableData,
          PrefetchHooks Function()
        > {
  $$MemberProfileTableTableTableManager(
    _$AppDatabase db,
    $MemberProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemberProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemberProfileTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<String> avatarUrl = const Value.absent(),
                Value<String?> avatarAsset = const Value.absent(),
                Value<int> notificationCount = const Value.absent(),
                Value<int> rewardsCount = const Value.absent(),
              }) => MemberProfileTableCompanion(
                id: id,
                totalPoints: totalPoints,
                avatarUrl: avatarUrl,
                avatarAsset: avatarAsset,
                notificationCount: notificationCount,
                rewardsCount: rewardsCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int totalPoints,
                required String avatarUrl,
                Value<String?> avatarAsset = const Value.absent(),
                required int notificationCount,
                required int rewardsCount,
              }) => MemberProfileTableCompanion.insert(
                id: id,
                totalPoints: totalPoints,
                avatarUrl: avatarUrl,
                avatarAsset: avatarAsset,
                notificationCount: notificationCount,
                rewardsCount: rewardsCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MemberProfileTableTable, MemberProfileTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $MemberProfileTableTable,
                    MemberProfileTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemberProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberProfileTableTable,
      MemberProfileTableData,
      $$MemberProfileTableTableFilterComposer,
      $$MemberProfileTableTableOrderingComposer,
      $$MemberProfileTableTableAnnotationComposer,
      $$MemberProfileTableTableCreateCompanionBuilder,
      $$MemberProfileTableTableUpdateCompanionBuilder,
      (
        MemberProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $MemberProfileTableTable,
          MemberProfileTableData
        >,
      ),
      MemberProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$TiersTableTableCreateCompanionBuilder = TiersTableCompanion Function({
  required String id,
  required String name,
  required int minPoints,
  required int sortOrder,
  Value<String?> imageUrl,
  Value<String?> imageAsset,
  Value<int> rowid,
});
typedef $$TiersTableTableUpdateCompanionBuilder = TiersTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> minPoints,
  Value<int> sortOrder,
  Value<String?> imageUrl,
  Value<String?> imageAsset,
  Value<int> rowid,
});

class $$TiersTableTableFilterComposer
    extends Composer<_$AppDatabase, $TiersTableTable> {
  $$TiersTableTableFilterComposer({
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

  ColumnFilters<int> get minPoints => $composableBuilder(
    column: $table.minPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TiersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TiersTableTable> {
  $$TiersTableTableOrderingComposer({
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

  ColumnOrderings<int> get minPoints => $composableBuilder(
    column: $table.minPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TiersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TiersTableTable> {
  $$TiersTableTableAnnotationComposer({
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

  GeneratedColumn<int> get minPoints =>
      $composableBuilder(column: $table.minPoints, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );
}

class $$TiersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TiersTableTable,
          TiersTableData,
          $$TiersTableTableFilterComposer,
          $$TiersTableTableOrderingComposer,
          $$TiersTableTableAnnotationComposer,
          $$TiersTableTableCreateCompanionBuilder,
          $$TiersTableTableUpdateCompanionBuilder,
          (
            TiersTableData,
            BaseReferences<_$AppDatabase, $TiersTableTable, TiersTableData>,
          ),
          TiersTableData,
          PrefetchHooks Function()
        > {
  $$TiersTableTableTableManager(_$AppDatabase db, $TiersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TiersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TiersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TiersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> minPoints = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TiersTableCompanion(
                id: id,
                name: name,
                minPoints: minPoints,
                sortOrder: sortOrder,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int minPoints,
                required int sortOrder,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TiersTableCompanion.insert(
                id: id,
                name: name,
                minPoints: minPoints,
                sortOrder: sortOrder,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TiersTableTable, TiersTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TiersTableTable,
                    TiersTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TiersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TiersTableTable,
      TiersTableData,
      $$TiersTableTableFilterComposer,
      $$TiersTableTableOrderingComposer,
      $$TiersTableTableAnnotationComposer,
      $$TiersTableTableCreateCompanionBuilder,
      $$TiersTableTableUpdateCompanionBuilder,
      (
        TiersTableData,
        BaseReferences<_$AppDatabase, $TiersTableTable, TiersTableData>,
      ),
      TiersTableData,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableTableCreateCompanionBuilder =
    ProductsTableCompanion Function({
      required String id,
      required String code,
      required String name,
      required int priceMmk,
      required bool isNew,
      Value<int?> discountPercent,
      required String description,
      required String imageUrl,
      Value<String?> imageAsset,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProductsTableTableUpdateCompanionBuilder =
    ProductsTableCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<int> priceMmk,
      Value<bool> isNew,
      Value<int?> discountPercent,
      Value<String> description,
      Value<String> imageUrl,
      Value<String?> imageAsset,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProductsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData> {
  $$ProductsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SectionProductsTableTable,
    List<SectionProductsTableData>
  >
  _sectionProductsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sectionProductsTable,
        aliasName: 'products__id__section_products__product_id',
      );

  $$SectionProductsTableTableProcessedTableManager
  get sectionProductsTableRefs {
    final manager = $$SectionProductsTableTableTableManager(
      $_db,
      $_db.sectionProductsTable,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CartItemsTableTable, List<CartItemsTableData>>
  _cartItemsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cartItemsTable,
    aliasName: 'products__id__cart_items__product_id',
  );

  $$CartItemsTableTableProcessedTableManager get cartItemsTableRefs {
    final manager = $$CartItemsTableTableTableManager(
      $_db,
      $_db.cartItemsTable,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cartItemsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsTableRefs(
    Expression<bool> Function($$SectionProductsTableTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProductsTable,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableTableFilterComposer(
            $db: $db,
            $table: $db.sectionProductsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cartItemsTableRefs(
    Expression<bool> Function($$CartItemsTableTableFilterComposer f) f,
  ) {
    final $$CartItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemsTable,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.cartItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceMmk => $composableBuilder(
    column: $table.priceMmk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMmk =>
      $composableBuilder(column: $table.priceMmk, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<int> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> sectionProductsTableRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sectionProductsTable,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SectionProductsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.sectionProductsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cartItemsTableRefs<T extends Object>(
    Expression<T> Function($$CartItemsTableTableAnnotationComposer a) f,
  ) {
    final $$CartItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cartItemsTable,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cartItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTableTable,
          ProductsTableData,
          $$ProductsTableTableFilterComposer,
          $$ProductsTableTableOrderingComposer,
          $$ProductsTableTableAnnotationComposer,
          $$ProductsTableTableCreateCompanionBuilder,
          $$ProductsTableTableUpdateCompanionBuilder,
          (ProductsTableData, $$ProductsTableTableReferences),
          ProductsTableData,
          PrefetchHooks Function({
            bool sectionProductsTableRefs,
            bool cartItemsTableRefs,
          })
        > {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priceMmk = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<int?> discountPercent = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                description: description,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required int priceMmk,
                required bool isNew,
                Value<int?> discountPercent = const Value.absent(),
                required String description,
                required String imageUrl,
                Value<String?> imageAsset = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion.insert(
                id: id,
                code: code,
                name: name,
                priceMmk: priceMmk,
                isNew: isNew,
                discountPercent: discountPercent,
                description: description,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTableTable, ProductsTableData>(table),
                  $$ProductsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sectionProductsTableRefs = false, cartItemsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sectionProductsTableRefs) db.sectionProductsTable,
                    if (cartItemsTableRefs) db.cartItemsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sectionProductsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          ProductsTableData,
                          $ProductsTableTable,
                          SectionProductsTableData,
                          $SectionProductsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableTableReferences
                              ._sectionProductsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).sectionProductsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'product_id',
                          typedResults: items,
                        ),
                      if (cartItemsTableRefs)
                        await $_getPrefetchedDataByColumns<
                          ProductsTableData,
                          $ProductsTableTable,
                          CartItemsTableData,
                          $CartItemsTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableTableReferences
                              ._cartItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).cartItemsTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'product_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTableTable,
      ProductsTableData,
      $$ProductsTableTableFilterComposer,
      $$ProductsTableTableOrderingComposer,
      $$ProductsTableTableAnnotationComposer,
      $$ProductsTableTableCreateCompanionBuilder,
      $$ProductsTableTableUpdateCompanionBuilder,
      (ProductsTableData, $$ProductsTableTableReferences),
      ProductsTableData,
      PrefetchHooks Function({
        bool sectionProductsTableRefs,
        bool cartItemsTableRefs,
      })
    >;
typedef $$HomeSectionsTableTableCreateCompanionBuilder =
    HomeSectionsTableCompanion Function({
      required String id,
      required String titleKey,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$HomeSectionsTableTableUpdateCompanionBuilder =
    HomeSectionsTableCompanion Function({
      Value<String> id,
      Value<String> titleKey,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$HomeSectionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HomeSectionsTableTable,
          HomeSectionsTableData
        > {
  $$HomeSectionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SectionProductsTableTable,
    List<SectionProductsTableData>
  >
  _sectionProductsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sectionProductsTable,
        aliasName: 'home_sections__id__section_products__section_id',
      );

  $$SectionProductsTableTableProcessedTableManager
  get sectionProductsTableRefs {
    final manager = $$SectionProductsTableTableTableManager(
      $_db,
      $_db.sectionProductsTable,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sectionProductsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HomeSectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HomeSectionsTableTable> {
  $$HomeSectionsTableTableFilterComposer({
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

  ColumnFilters<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sectionProductsTableRefs(
    Expression<bool> Function($$SectionProductsTableTableFilterComposer f) f,
  ) {
    final $$SectionProductsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionProductsTable,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionProductsTableTableFilterComposer(
            $db: $db,
            $table: $db.sectionProductsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HomeSectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HomeSectionsTableTable> {
  $$HomeSectionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HomeSectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HomeSectionsTableTable> {
  $$HomeSectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleKey =>
      $composableBuilder(column: $table.titleKey, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> sectionProductsTableRefs<T extends Object>(
    Expression<T> Function($$SectionProductsTableTableAnnotationComposer a) f,
  ) {
    final $$SectionProductsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sectionProductsTable,
          getReferencedColumn: (t) => t.sectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SectionProductsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.sectionProductsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HomeSectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HomeSectionsTableTable,
          HomeSectionsTableData,
          $$HomeSectionsTableTableFilterComposer,
          $$HomeSectionsTableTableOrderingComposer,
          $$HomeSectionsTableTableAnnotationComposer,
          $$HomeSectionsTableTableCreateCompanionBuilder,
          $$HomeSectionsTableTableUpdateCompanionBuilder,
          (HomeSectionsTableData, $$HomeSectionsTableTableReferences),
          HomeSectionsTableData,
          PrefetchHooks Function({bool sectionProductsTableRefs})
        > {
  $$HomeSectionsTableTableTableManager(
    _$AppDatabase db,
    $HomeSectionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HomeSectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HomeSectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HomeSectionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titleKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionsTableCompanion(
                id: id,
                titleKey: titleKey,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titleKey,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => HomeSectionsTableCompanion.insert(
                id: id,
                titleKey: titleKey,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HomeSectionsTableTable, HomeSectionsTableData>(
                    table,
                  ),
                  $$HomeSectionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionProductsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionProductsTableRefs) db.sectionProductsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionProductsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      HomeSectionsTableData,
                      $HomeSectionsTableTable,
                      SectionProductsTableData,
                      $SectionProductsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$HomeSectionsTableTableReferences
                          ._sectionProductsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HomeSectionsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).sectionProductsTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'section_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HomeSectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HomeSectionsTableTable,
      HomeSectionsTableData,
      $$HomeSectionsTableTableFilterComposer,
      $$HomeSectionsTableTableOrderingComposer,
      $$HomeSectionsTableTableAnnotationComposer,
      $$HomeSectionsTableTableCreateCompanionBuilder,
      $$HomeSectionsTableTableUpdateCompanionBuilder,
      (HomeSectionsTableData, $$HomeSectionsTableTableReferences),
      HomeSectionsTableData,
      PrefetchHooks Function({bool sectionProductsTableRefs})
    >;
typedef $$SectionProductsTableTableCreateCompanionBuilder =
    SectionProductsTableCompanion Function({
      required String sectionId,
      required String productId,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$SectionProductsTableTableUpdateCompanionBuilder =
    SectionProductsTableCompanion Function({
      Value<String> sectionId,
      Value<String> productId,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$SectionProductsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SectionProductsTableTable,
          SectionProductsTableData
        > {
  $$SectionProductsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HomeSectionsTableTable _sectionIdTable(_$AppDatabase db) => db
      .homeSectionsTable
      .createAlias('section_products__section_id__home_sections__id');

  $$HomeSectionsTableTableProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager = $$HomeSectionsTableTableTableManager(
      $_db,
      $_db.homeSectionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTableTable _productIdTable(_$AppDatabase db) => db
      .productsTable
      .createAlias('section_products__product_id__products__id');

  $$ProductsTableTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableTableManager(
      $_db,
      $_db.productsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SectionProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SectionProductsTableTable> {
  $$SectionProductsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$HomeSectionsTableTableFilterComposer get sectionId {
    final $$HomeSectionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.homeSectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeSectionsTableTableFilterComposer(
            $db: $db,
            $table: $db.homeSectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableTableFilterComposer get productId {
    final $$ProductsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableFilterComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionProductsTableTable> {
  $$SectionProductsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$HomeSectionsTableTableOrderingComposer get sectionId {
    final $$HomeSectionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.homeSectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HomeSectionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.homeSectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableTableOrderingComposer get productId {
    final $$ProductsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableOrderingComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionProductsTableTable> {
  $$SectionProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$HomeSectionsTableTableAnnotationComposer get sectionId {
    final $$HomeSectionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sectionId,
          referencedTable: $db.homeSectionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HomeSectionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.homeSectionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ProductsTableTableAnnotationComposer get productId {
    final $$ProductsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionProductsTableTable,
          SectionProductsTableData,
          $$SectionProductsTableTableFilterComposer,
          $$SectionProductsTableTableOrderingComposer,
          $$SectionProductsTableTableAnnotationComposer,
          $$SectionProductsTableTableCreateCompanionBuilder,
          $$SectionProductsTableTableUpdateCompanionBuilder,
          (SectionProductsTableData, $$SectionProductsTableTableReferences),
          SectionProductsTableData,
          PrefetchHooks Function({bool sectionId, bool productId})
        > {
  $$SectionProductsTableTableTableManager(
    _$AppDatabase db,
    $SectionProductsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionProductsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SectionProductsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sectionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsTableCompanion(
                sectionId: sectionId,
                productId: productId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sectionId,
                required String productId,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => SectionProductsTableCompanion.insert(
                sectionId: sectionId,
                productId: productId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $SectionProductsTableTable,
                    SectionProductsTableData
                  >(table),
                  $$SectionProductsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false, productId = false}) {
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
                    if (sectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sectionId,
                        referencedTable: $$SectionProductsTableTableReferences
                            ._sectionIdTable(db),
                        referencedColumn: $$SectionProductsTableTableReferences
                            ._sectionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$SectionProductsTableTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$SectionProductsTableTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
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

typedef $$SectionProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionProductsTableTable,
      SectionProductsTableData,
      $$SectionProductsTableTableFilterComposer,
      $$SectionProductsTableTableOrderingComposer,
      $$SectionProductsTableTableAnnotationComposer,
      $$SectionProductsTableTableCreateCompanionBuilder,
      $$SectionProductsTableTableUpdateCompanionBuilder,
      (SectionProductsTableData, $$SectionProductsTableTableReferences),
      SectionProductsTableData,
      PrefetchHooks Function({bool sectionId, bool productId})
    >;
typedef $$BannersTableTableCreateCompanionBuilder =
    BannersTableCompanion Function({
      required String id,
      required String tag,
      required String title,
      required String style,
      required String imageUrl,
      Value<String?> imageAsset,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$BannersTableTableUpdateCompanionBuilder =
    BannersTableCompanion Function({
      Value<String> id,
      Value<String> tag,
      Value<String> title,
      Value<String> style,
      Value<String> imageUrl,
      Value<String?> imageAsset,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$BannersTableTableFilterComposer
    extends Composer<_$AppDatabase, $BannersTableTable> {
  $$BannersTableTableFilterComposer({
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

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BannersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BannersTableTable> {
  $$BannersTableTableOrderingComposer({
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

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get style => $composableBuilder(
    column: $table.style,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BannersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BannersTableTable> {
  $$BannersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get style =>
      $composableBuilder(column: $table.style, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$BannersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BannersTableTable,
          BannersTableData,
          $$BannersTableTableFilterComposer,
          $$BannersTableTableOrderingComposer,
          $$BannersTableTableAnnotationComposer,
          $$BannersTableTableCreateCompanionBuilder,
          $$BannersTableTableUpdateCompanionBuilder,
          (
            BannersTableData,
            BaseReferences<_$AppDatabase, $BannersTableTable, BannersTableData>,
          ),
          BannersTableData,
          PrefetchHooks Function()
        > {
  $$BannersTableTableTableManager(_$AppDatabase db, $BannersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BannersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BannersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BannersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tag = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> style = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BannersTableCompanion(
                id: id,
                tag: tag,
                title: title,
                style: style,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tag,
                required String title,
                required String style,
                required String imageUrl,
                Value<String?> imageAsset = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => BannersTableCompanion.insert(
                id: id,
                tag: tag,
                title: title,
                style: style,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BannersTableTable, BannersTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BannersTableTable,
                    BannersTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BannersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BannersTableTable,
      BannersTableData,
      $$BannersTableTableFilterComposer,
      $$BannersTableTableOrderingComposer,
      $$BannersTableTableAnnotationComposer,
      $$BannersTableTableCreateCompanionBuilder,
      $$BannersTableTableUpdateCompanionBuilder,
      (
        BannersTableData,
        BaseReferences<_$AppDatabase, $BannersTableTable, BannersTableData>,
      ),
      BannersTableData,
      PrefetchHooks Function()
    >;
typedef $$ShopsTableTableCreateCompanionBuilder = ShopsTableCompanion Function({
  required String id,
  required String name,
  required String address,
  required String imageUrl,
  Value<String?> imageAsset,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$ShopsTableTableUpdateCompanionBuilder = ShopsTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> address,
  Value<String> imageUrl,
  Value<String?> imageAsset,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$ShopsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableFilterComposer({
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

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableOrderingComposer({
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

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ShopsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTableTable,
          ShopsTableData,
          $$ShopsTableTableFilterComposer,
          $$ShopsTableTableOrderingComposer,
          $$ShopsTableTableAnnotationComposer,
          $$ShopsTableTableCreateCompanionBuilder,
          $$ShopsTableTableUpdateCompanionBuilder,
          (
            ShopsTableData,
            BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
          ),
          ShopsTableData,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableTableManager(_$AppDatabase db, $ShopsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                required String imageUrl,
                Value<String?> imageAsset = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion.insert(
                id: id,
                name: name,
                address: address,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTableTable, ShopsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ShopsTableTable,
                    ShopsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTableTable,
      ShopsTableData,
      $$ShopsTableTableFilterComposer,
      $$ShopsTableTableOrderingComposer,
      $$ShopsTableTableAnnotationComposer,
      $$ShopsTableTableCreateCompanionBuilder,
      $$ShopsTableTableUpdateCompanionBuilder,
      (
        ShopsTableData,
        BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
      ),
      ShopsTableData,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableTableCreateCompanionBuilder =
    ChallengesTableCompanion Function({
      required String id,
      required String title,
      required String kind,
      required int progress,
      required int target,
      required int rewardPoints,
      Value<String?> imageUrl,
      Value<String?> imageAsset,
      required int sortOrder,
      Value<bool> claimed,
      Value<int> rowid,
    });
typedef $$ChallengesTableTableUpdateCompanionBuilder =
    ChallengesTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> kind,
      Value<int> progress,
      Value<int> target,
      Value<int> rewardPoints,
      Value<String?> imageUrl,
      Value<String?> imageAsset,
      Value<int> sortOrder,
      Value<bool> claimed,
      Value<int> rowid,
    });

class $$ChallengesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTableTable> {
  $$ChallengesTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTableTable> {
  $$ChallengesTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTableTable> {
  $$ChallengesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get claimed =>
      $composableBuilder(column: $table.claimed, builder: (column) => column);
}

class $$ChallengesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTableTable,
          ChallengesTableData,
          $$ChallengesTableTableFilterComposer,
          $$ChallengesTableTableOrderingComposer,
          $$ChallengesTableTableAnnotationComposer,
          $$ChallengesTableTableCreateCompanionBuilder,
          $$ChallengesTableTableUpdateCompanionBuilder,
          (
            ChallengesTableData,
            BaseReferences<
              _$AppDatabase,
              $ChallengesTableTable,
              ChallengesTableData
            >,
          ),
          ChallengesTableData,
          PrefetchHooks Function()
        > {
  $$ChallengesTableTableTableManager(
    _$AppDatabase db,
    $ChallengesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> rewardPoints = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesTableCompanion(
                id: id,
                title: title,
                kind: kind,
                progress: progress,
                target: target,
                rewardPoints: rewardPoints,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                claimed: claimed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String kind,
                required int progress,
                required int target,
                required int rewardPoints,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                required int sortOrder,
                Value<bool> claimed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesTableCompanion.insert(
                id: id,
                title: title,
                kind: kind,
                progress: progress,
                target: target,
                rewardPoints: rewardPoints,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                claimed: claimed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChallengesTableTable, ChallengesTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ChallengesTableTable,
                    ChallengesTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTableTable,
      ChallengesTableData,
      $$ChallengesTableTableFilterComposer,
      $$ChallengesTableTableOrderingComposer,
      $$ChallengesTableTableAnnotationComposer,
      $$ChallengesTableTableCreateCompanionBuilder,
      $$ChallengesTableTableUpdateCompanionBuilder,
      (
        ChallengesTableData,
        BaseReferences<
          _$AppDatabase,
          $ChallengesTableTable,
          ChallengesTableData
        >,
      ),
      ChallengesTableData,
      PrefetchHooks Function()
    >;
typedef $$GiftsTableTableCreateCompanionBuilder = GiftsTableCompanion Function({
  required String id,
  required String title,
  required int costPoints,
  Value<String?> imageUrl,
  Value<String?> imageAsset,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$GiftsTableTableUpdateCompanionBuilder = GiftsTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> costPoints,
  Value<String?> imageUrl,
  Value<String?> imageAsset,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$GiftsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GiftsTableTable> {
  $$GiftsTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPoints => $composableBuilder(
    column: $table.costPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GiftsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GiftsTableTable> {
  $$GiftsTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPoints => $composableBuilder(
    column: $table.costPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GiftsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GiftsTableTable> {
  $$GiftsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get costPoints => $composableBuilder(
    column: $table.costPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$GiftsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GiftsTableTable,
          GiftsTableData,
          $$GiftsTableTableFilterComposer,
          $$GiftsTableTableOrderingComposer,
          $$GiftsTableTableAnnotationComposer,
          $$GiftsTableTableCreateCompanionBuilder,
          $$GiftsTableTableUpdateCompanionBuilder,
          (
            GiftsTableData,
            BaseReferences<_$AppDatabase, $GiftsTableTable, GiftsTableData>,
          ),
          GiftsTableData,
          PrefetchHooks Function()
        > {
  $$GiftsTableTableTableManager(_$AppDatabase db, $GiftsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GiftsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GiftsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GiftsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> costPoints = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GiftsTableCompanion(
                id: id,
                title: title,
                costPoints: costPoints,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int costPoints,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageAsset = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => GiftsTableCompanion.insert(
                id: id,
                title: title,
                costPoints: costPoints,
                imageUrl: imageUrl,
                imageAsset: imageAsset,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GiftsTableTable, GiftsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GiftsTableTable,
                    GiftsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GiftsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GiftsTableTable,
      GiftsTableData,
      $$GiftsTableTableFilterComposer,
      $$GiftsTableTableOrderingComposer,
      $$GiftsTableTableAnnotationComposer,
      $$GiftsTableTableCreateCompanionBuilder,
      $$GiftsTableTableUpdateCompanionBuilder,
      (
        GiftsTableData,
        BaseReferences<_$AppDatabase, $GiftsTableTable, GiftsTableData>,
      ),
      GiftsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncStateTableTableCreateCompanionBuilder =
    SyncStateTableCompanion Function({
      required String key,
      required int version,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$SyncStateTableTableUpdateCompanionBuilder =
    SyncStateTableCompanion Function({
      Value<String> key,
      Value<int> version,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$SyncStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStateTableTable> {
  $$SyncStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$SyncStateTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStateTableTable,
          SyncStateTableData,
          $$SyncStateTableTableFilterComposer,
          $$SyncStateTableTableOrderingComposer,
          $$SyncStateTableTableAnnotationComposer,
          $$SyncStateTableTableCreateCompanionBuilder,
          $$SyncStateTableTableUpdateCompanionBuilder,
          (
            SyncStateTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncStateTableTable,
              SyncStateTableData
            >,
          ),
          SyncStateTableData,
          PrefetchHooks Function()
        > {
  $$SyncStateTableTableTableManager(
    _$AppDatabase db,
    $SyncStateTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStateTableCompanion(
                key: key,
                version: version,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required int version,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncStateTableCompanion.insert(
                key: key,
                version: version,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncStateTableTable, SyncStateTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncStateTableTable,
                    SyncStateTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStateTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStateTableTable,
      SyncStateTableData,
      $$SyncStateTableTableFilterComposer,
      $$SyncStateTableTableOrderingComposer,
      $$SyncStateTableTableAnnotationComposer,
      $$SyncStateTableTableCreateCompanionBuilder,
      $$SyncStateTableTableUpdateCompanionBuilder,
      (
        SyncStateTableData,
        BaseReferences<_$AppDatabase, $SyncStateTableTable, SyncStateTableData>,
      ),
      SyncStateTableData,
      PrefetchHooks Function()
    >;
typedef $$CartItemsTableTableCreateCompanionBuilder =
    CartItemsTableCompanion Function({
      required String productId,
      required int quantity,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CartItemsTableTableUpdateCompanionBuilder =
    CartItemsTableCompanion Function({
      Value<String> productId,
      Value<int> quantity,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CartItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CartItemsTableTable,
          CartItemsTableData
        > {
  $$CartItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTableTable _productIdTable(_$AppDatabase db) =>
      db.productsTable.createAlias('cart_items__product_id__products__id');

  $$ProductsTableTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableTableManager(
      $_db,
      $_db.productsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CartItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTableTable> {
  $$CartItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableTableFilterComposer get productId {
    final $$ProductsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableFilterComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTableTable> {
  $$CartItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableTableOrderingComposer get productId {
    final $$ProductsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableOrderingComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTableTable> {
  $$CartItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProductsTableTableAnnotationComposer get productId {
    final $$ProductsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CartItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTableTable,
          CartItemsTableData,
          $$CartItemsTableTableFilterComposer,
          $$CartItemsTableTableOrderingComposer,
          $$CartItemsTableTableAnnotationComposer,
          $$CartItemsTableTableCreateCompanionBuilder,
          $$CartItemsTableTableUpdateCompanionBuilder,
          (CartItemsTableData, $$CartItemsTableTableReferences),
          CartItemsTableData,
          PrefetchHooks Function({bool productId})
        > {
  $$CartItemsTableTableTableManager(
    _$AppDatabase db,
    $CartItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartItemsTableCompanion(
                productId: productId,
                quantity: quantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                required int quantity,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CartItemsTableCompanion.insert(
                productId: productId,
                quantity: quantity,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CartItemsTableTable, CartItemsTableData>(table),
                  $$CartItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
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
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$CartItemsTableTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$CartItemsTableTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
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

typedef $$CartItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTableTable,
      CartItemsTableData,
      $$CartItemsTableTableFilterComposer,
      $$CartItemsTableTableOrderingComposer,
      $$CartItemsTableTableAnnotationComposer,
      $$CartItemsTableTableCreateCompanionBuilder,
      $$CartItemsTableTableUpdateCompanionBuilder,
      (CartItemsTableData, $$CartItemsTableTableReferences),
      CartItemsTableData,
      PrefetchHooks Function({bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$MemberProfileTableTableTableManager get memberProfileTable =>
      $$MemberProfileTableTableTableManager(_db, _db.memberProfileTable);
  $$TiersTableTableTableManager get tiersTable =>
      $$TiersTableTableTableManager(_db, _db.tiersTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$HomeSectionsTableTableTableManager get homeSectionsTable =>
      $$HomeSectionsTableTableTableManager(_db, _db.homeSectionsTable);
  $$SectionProductsTableTableTableManager get sectionProductsTable =>
      $$SectionProductsTableTableTableManager(_db, _db.sectionProductsTable);
  $$BannersTableTableTableManager get bannersTable =>
      $$BannersTableTableTableManager(_db, _db.bannersTable);
  $$ShopsTableTableTableManager get shopsTable =>
      $$ShopsTableTableTableManager(_db, _db.shopsTable);
  $$ChallengesTableTableTableManager get challengesTable =>
      $$ChallengesTableTableTableManager(_db, _db.challengesTable);
  $$GiftsTableTableTableManager get giftsTable =>
      $$GiftsTableTableTableManager(_db, _db.giftsTable);
  $$SyncStateTableTableTableManager get syncStateTable =>
      $$SyncStateTableTableTableManager(_db, _db.syncStateTable);
  $$CartItemsTableTableTableManager get cartItemsTable =>
      $$CartItemsTableTableTableManager(_db, _db.cartItemsTable);
}

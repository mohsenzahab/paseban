// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SoldiersTableTable extends SoldiersTable
    with TableInfo<$SoldiersTableTable, SoldiersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoldiersTableTable(this.attachedDatabase, [this._alias]);
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MilitaryRank, int> rank =
      GeneratedColumn<int>(
        'rank',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MilitaryRank>($SoldiersTableTable.$converterrank);
  static const VerificationMeta _dateOfEnlistmentMeta = const VerificationMeta(
    'dateOfEnlistment',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfEnlistment =
      GeneratedColumn<DateTime>(
        'date_of_enlistment',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _nikNameMeta = const VerificationMeta(
    'nikName',
  );
  @override
  late final GeneratedColumn<String> nikName = GeneratedColumn<String>(
    'nik_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _militaryIdMeta = const VerificationMeta(
    'militaryId',
  );
  @override
  late final GeneratedColumn<String> militaryId = GeneratedColumn<String>(
    'military_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    rank,
    dateOfEnlistment,
    nikName,
    imageUrl,
    militaryId,
    phoneNumber,
    dateOfBirth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soldiers_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SoldiersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('date_of_enlistment')) {
      context.handle(
        _dateOfEnlistmentMeta,
        dateOfEnlistment.isAcceptableOrUnknown(
          data['date_of_enlistment']!,
          _dateOfEnlistmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfEnlistmentMeta);
    }
    if (data.containsKey('nik_name')) {
      context.handle(
        _nikNameMeta,
        nikName.isAcceptableOrUnknown(data['nik_name']!, _nikNameMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('military_id')) {
      context.handle(
        _militaryIdMeta,
        militaryId.isAcceptableOrUnknown(data['military_id']!, _militaryIdMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoldiersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoldiersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      rank: $SoldiersTableTable.$converterrank.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}rank'],
        )!,
      ),
      dateOfEnlistment: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_enlistment'],
      )!,
      nikName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nik_name'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      militaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}military_id'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
    );
  }

  @override
  $SoldiersTableTable createAlias(String alias) {
    return $SoldiersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MilitaryRank, int, int> $converterrank =
      const EnumIndexConverter<MilitaryRank>(MilitaryRank.values);
}

class SoldiersTableData extends DataClass
    implements Insertable<SoldiersTableData> {
  final int id;
  final String firstName;
  final String lastName;
  final MilitaryRank rank;
  final DateTime dateOfEnlistment;
  final String? nikName;
  final String? imageUrl;
  final String? militaryId;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  const SoldiersTableData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rank,
    required this.dateOfEnlistment,
    this.nikName,
    this.imageUrl,
    this.militaryId,
    this.phoneNumber,
    this.dateOfBirth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    {
      map['rank'] = Variable<int>(
        $SoldiersTableTable.$converterrank.toSql(rank),
      );
    }
    map['date_of_enlistment'] = Variable<DateTime>(dateOfEnlistment);
    if (!nullToAbsent || nikName != null) {
      map['nik_name'] = Variable<String>(nikName);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || militaryId != null) {
      map['military_id'] = Variable<String>(militaryId);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    return map;
  }

  SoldiersTableCompanion toCompanion(bool nullToAbsent) {
    return SoldiersTableCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      rank: Value(rank),
      dateOfEnlistment: Value(dateOfEnlistment),
      nikName: nikName == null && nullToAbsent
          ? const Value.absent()
          : Value(nikName),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      militaryId: militaryId == null && nullToAbsent
          ? const Value.absent()
          : Value(militaryId),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
    );
  }

  factory SoldiersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoldiersTableData(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      rank: $SoldiersTableTable.$converterrank.fromJson(
        serializer.fromJson<int>(json['rank']),
      ),
      dateOfEnlistment: serializer.fromJson<DateTime>(json['dateOfEnlistment']),
      nikName: serializer.fromJson<String?>(json['nikName']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      militaryId: serializer.fromJson<String?>(json['militaryId']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'rank': serializer.toJson<int>(
        $SoldiersTableTable.$converterrank.toJson(rank),
      ),
      'dateOfEnlistment': serializer.toJson<DateTime>(dateOfEnlistment),
      'nikName': serializer.toJson<String?>(nikName),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'militaryId': serializer.toJson<String?>(militaryId),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
    };
  }

  SoldiersTableData copyWith({
    int? id,
    String? firstName,
    String? lastName,
    MilitaryRank? rank,
    DateTime? dateOfEnlistment,
    Value<String?> nikName = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> militaryId = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<DateTime?> dateOfBirth = const Value.absent(),
  }) => SoldiersTableData(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    rank: rank ?? this.rank,
    dateOfEnlistment: dateOfEnlistment ?? this.dateOfEnlistment,
    nikName: nikName.present ? nikName.value : this.nikName,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    militaryId: militaryId.present ? militaryId.value : this.militaryId,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
  );
  SoldiersTableData copyWithCompanion(SoldiersTableCompanion data) {
    return SoldiersTableData(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      rank: data.rank.present ? data.rank.value : this.rank,
      dateOfEnlistment: data.dateOfEnlistment.present
          ? data.dateOfEnlistment.value
          : this.dateOfEnlistment,
      nikName: data.nikName.present ? data.nikName.value : this.nikName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      militaryId: data.militaryId.present
          ? data.militaryId.value
          : this.militaryId,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SoldiersTableData(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('rank: $rank, ')
          ..write('dateOfEnlistment: $dateOfEnlistment, ')
          ..write('nikName: $nikName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('militaryId: $militaryId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('dateOfBirth: $dateOfBirth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    rank,
    dateOfEnlistment,
    nikName,
    imageUrl,
    militaryId,
    phoneNumber,
    dateOfBirth,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoldiersTableData &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.rank == this.rank &&
          other.dateOfEnlistment == this.dateOfEnlistment &&
          other.nikName == this.nikName &&
          other.imageUrl == this.imageUrl &&
          other.militaryId == this.militaryId &&
          other.phoneNumber == this.phoneNumber &&
          other.dateOfBirth == this.dateOfBirth);
}

class SoldiersTableCompanion extends UpdateCompanion<SoldiersTableData> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<MilitaryRank> rank;
  final Value<DateTime> dateOfEnlistment;
  final Value<String?> nikName;
  final Value<String?> imageUrl;
  final Value<String?> militaryId;
  final Value<String?> phoneNumber;
  final Value<DateTime?> dateOfBirth;
  const SoldiersTableCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.rank = const Value.absent(),
    this.dateOfEnlistment = const Value.absent(),
    this.nikName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.militaryId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
  });
  SoldiersTableCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required MilitaryRank rank,
    required DateTime dateOfEnlistment,
    this.nikName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.militaryId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       rank = Value(rank),
       dateOfEnlistment = Value(dateOfEnlistment);
  static Insertable<SoldiersTableData> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? rank,
    Expression<DateTime>? dateOfEnlistment,
    Expression<String>? nikName,
    Expression<String>? imageUrl,
    Expression<String>? militaryId,
    Expression<String>? phoneNumber,
    Expression<DateTime>? dateOfBirth,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (rank != null) 'rank': rank,
      if (dateOfEnlistment != null) 'date_of_enlistment': dateOfEnlistment,
      if (nikName != null) 'nik_name': nikName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (militaryId != null) 'military_id': militaryId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    });
  }

  SoldiersTableCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<MilitaryRank>? rank,
    Value<DateTime>? dateOfEnlistment,
    Value<String?>? nikName,
    Value<String?>? imageUrl,
    Value<String?>? militaryId,
    Value<String?>? phoneNumber,
    Value<DateTime?>? dateOfBirth,
  }) {
    return SoldiersTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rank: rank ?? this.rank,
      dateOfEnlistment: dateOfEnlistment ?? this.dateOfEnlistment,
      nikName: nikName ?? this.nikName,
      imageUrl: imageUrl ?? this.imageUrl,
      militaryId: militaryId ?? this.militaryId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(
        $SoldiersTableTable.$converterrank.toSql(rank.value),
      );
    }
    if (dateOfEnlistment.present) {
      map['date_of_enlistment'] = Variable<DateTime>(dateOfEnlistment.value);
    }
    if (nikName.present) {
      map['nik_name'] = Variable<String>(nikName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (militaryId.present) {
      map['military_id'] = Variable<String>(militaryId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoldiersTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('rank: $rank, ')
          ..write('dateOfEnlistment: $dateOfEnlistment, ')
          ..write('nikName: $nikName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('militaryId: $militaryId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('dateOfBirth: $dateOfBirth')
          ..write(')'))
        .toString();
  }
}

class $GuardPostsTableTable extends GuardPostsTable
    with TableInfo<$GuardPostsTableTable, GuardPostsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuardPostsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _soldierIdMeta = const VerificationMeta(
    'soldierId',
  );
  @override
  late final GeneratedColumn<int> soldierId = GeneratedColumn<int>(
    'soldier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  @override
  late final GeneratedColumnWithTypeConverter<List<Weekday>?, String> weekDays =
      GeneratedColumn<String>(
        'week_days',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<Weekday>?>(
        $GuardPostsTableTable.$converterweekDaysn,
      );
  static const VerificationMeta _repeatMeta = const VerificationMeta('repeat');
  @override
  late final GeneratedColumn<int> repeat = GeneratedColumn<int>(
    'repeat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<int>?, String> monthDays =
      GeneratedColumn<String>(
        'month_days',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<int>?>($GuardPostsTableTable.$convertermonthDaysn);
  @override
  late final GeneratedColumnWithTypeConverter<GuardPostDifficulty, int>
  difficulty =
      GeneratedColumn<int>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<GuardPostDifficulty>(
        $GuardPostsTableTable.$converterdifficulty,
      );
  static const VerificationMeta _shiftsPerDayMeta = const VerificationMeta(
    'shiftsPerDay',
  );
  @override
  late final GeneratedColumn<int> shiftsPerDay = GeneratedColumn<int>(
    'shifts_per_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    soldierId,
    title,
    weekDays,
    repeat,
    monthDays,
    difficulty,
    shiftsPerDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guard_posts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GuardPostsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soldier_id')) {
      context.handle(
        _soldierIdMeta,
        soldierId.isAcceptableOrUnknown(data['soldier_id']!, _soldierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_soldierIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('repeat')) {
      context.handle(
        _repeatMeta,
        repeat.isAcceptableOrUnknown(data['repeat']!, _repeatMeta),
      );
    }
    if (data.containsKey('shifts_per_day')) {
      context.handle(
        _shiftsPerDayMeta,
        shiftsPerDay.isAcceptableOrUnknown(
          data['shifts_per_day']!,
          _shiftsPerDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shiftsPerDayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GuardPostsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuardPostsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      soldierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}soldier_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      weekDays: $GuardPostsTableTable.$converterweekDaysn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}week_days'],
        ),
      ),
      repeat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat'],
      )!,
      monthDays: $GuardPostsTableTable.$convertermonthDaysn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}month_days'],
        ),
      ),
      difficulty: $GuardPostsTableTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
      shiftsPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shifts_per_day'],
      )!,
    );
  }

  @override
  $GuardPostsTableTable createAlias(String alias) {
    return $GuardPostsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Weekday>, String> $converterweekDays =
      const WeekdayListConverter();
  static TypeConverter<List<Weekday>?, String?> $converterweekDaysn =
      NullAwareTypeConverter.wrap($converterweekDays);
  static TypeConverter<List<int>, String> $convertermonthDays =
      const IntListConverter();
  static TypeConverter<List<int>?, String?> $convertermonthDaysn =
      NullAwareTypeConverter.wrap($convertermonthDays);
  static JsonTypeConverter2<GuardPostDifficulty, int, int>
  $converterdifficulty = const EnumIndexConverter<GuardPostDifficulty>(
    GuardPostDifficulty.values,
  );
}

class GuardPostsTableData extends DataClass
    implements Insertable<GuardPostsTableData> {
  final int id;
  final int soldierId;
  final String title;
  final List<Weekday>? weekDays;
  final int repeat;
  final List<int>? monthDays;
  final GuardPostDifficulty difficulty;
  final int shiftsPerDay;
  const GuardPostsTableData({
    required this.id,
    required this.soldierId,
    required this.title,
    this.weekDays,
    required this.repeat,
    this.monthDays,
    required this.difficulty,
    required this.shiftsPerDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soldier_id'] = Variable<int>(soldierId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || weekDays != null) {
      map['week_days'] = Variable<String>(
        $GuardPostsTableTable.$converterweekDaysn.toSql(weekDays),
      );
    }
    map['repeat'] = Variable<int>(repeat);
    if (!nullToAbsent || monthDays != null) {
      map['month_days'] = Variable<String>(
        $GuardPostsTableTable.$convertermonthDaysn.toSql(monthDays),
      );
    }
    {
      map['difficulty'] = Variable<int>(
        $GuardPostsTableTable.$converterdifficulty.toSql(difficulty),
      );
    }
    map['shifts_per_day'] = Variable<int>(shiftsPerDay);
    return map;
  }

  GuardPostsTableCompanion toCompanion(bool nullToAbsent) {
    return GuardPostsTableCompanion(
      id: Value(id),
      soldierId: Value(soldierId),
      title: Value(title),
      weekDays: weekDays == null && nullToAbsent
          ? const Value.absent()
          : Value(weekDays),
      repeat: Value(repeat),
      monthDays: monthDays == null && nullToAbsent
          ? const Value.absent()
          : Value(monthDays),
      difficulty: Value(difficulty),
      shiftsPerDay: Value(shiftsPerDay),
    );
  }

  factory GuardPostsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuardPostsTableData(
      id: serializer.fromJson<int>(json['id']),
      soldierId: serializer.fromJson<int>(json['soldierId']),
      title: serializer.fromJson<String>(json['title']),
      weekDays: serializer.fromJson<List<Weekday>?>(json['weekDays']),
      repeat: serializer.fromJson<int>(json['repeat']),
      monthDays: serializer.fromJson<List<int>?>(json['monthDays']),
      difficulty: $GuardPostsTableTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
      shiftsPerDay: serializer.fromJson<int>(json['shiftsPerDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soldierId': serializer.toJson<int>(soldierId),
      'title': serializer.toJson<String>(title),
      'weekDays': serializer.toJson<List<Weekday>?>(weekDays),
      'repeat': serializer.toJson<int>(repeat),
      'monthDays': serializer.toJson<List<int>?>(monthDays),
      'difficulty': serializer.toJson<int>(
        $GuardPostsTableTable.$converterdifficulty.toJson(difficulty),
      ),
      'shiftsPerDay': serializer.toJson<int>(shiftsPerDay),
    };
  }

  GuardPostsTableData copyWith({
    int? id,
    int? soldierId,
    String? title,
    Value<List<Weekday>?> weekDays = const Value.absent(),
    int? repeat,
    Value<List<int>?> monthDays = const Value.absent(),
    GuardPostDifficulty? difficulty,
    int? shiftsPerDay,
  }) => GuardPostsTableData(
    id: id ?? this.id,
    soldierId: soldierId ?? this.soldierId,
    title: title ?? this.title,
    weekDays: weekDays.present ? weekDays.value : this.weekDays,
    repeat: repeat ?? this.repeat,
    monthDays: monthDays.present ? monthDays.value : this.monthDays,
    difficulty: difficulty ?? this.difficulty,
    shiftsPerDay: shiftsPerDay ?? this.shiftsPerDay,
  );
  GuardPostsTableData copyWithCompanion(GuardPostsTableCompanion data) {
    return GuardPostsTableData(
      id: data.id.present ? data.id.value : this.id,
      soldierId: data.soldierId.present ? data.soldierId.value : this.soldierId,
      title: data.title.present ? data.title.value : this.title,
      weekDays: data.weekDays.present ? data.weekDays.value : this.weekDays,
      repeat: data.repeat.present ? data.repeat.value : this.repeat,
      monthDays: data.monthDays.present ? data.monthDays.value : this.monthDays,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      shiftsPerDay: data.shiftsPerDay.present
          ? data.shiftsPerDay.value
          : this.shiftsPerDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuardPostsTableData(')
          ..write('id: $id, ')
          ..write('soldierId: $soldierId, ')
          ..write('title: $title, ')
          ..write('weekDays: $weekDays, ')
          ..write('repeat: $repeat, ')
          ..write('monthDays: $monthDays, ')
          ..write('difficulty: $difficulty, ')
          ..write('shiftsPerDay: $shiftsPerDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    soldierId,
    title,
    weekDays,
    repeat,
    monthDays,
    difficulty,
    shiftsPerDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuardPostsTableData &&
          other.id == this.id &&
          other.soldierId == this.soldierId &&
          other.title == this.title &&
          other.weekDays == this.weekDays &&
          other.repeat == this.repeat &&
          other.monthDays == this.monthDays &&
          other.difficulty == this.difficulty &&
          other.shiftsPerDay == this.shiftsPerDay);
}

class GuardPostsTableCompanion extends UpdateCompanion<GuardPostsTableData> {
  final Value<int> id;
  final Value<int> soldierId;
  final Value<String> title;
  final Value<List<Weekday>?> weekDays;
  final Value<int> repeat;
  final Value<List<int>?> monthDays;
  final Value<GuardPostDifficulty> difficulty;
  final Value<int> shiftsPerDay;
  const GuardPostsTableCompanion({
    this.id = const Value.absent(),
    this.soldierId = const Value.absent(),
    this.title = const Value.absent(),
    this.weekDays = const Value.absent(),
    this.repeat = const Value.absent(),
    this.monthDays = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.shiftsPerDay = const Value.absent(),
  });
  GuardPostsTableCompanion.insert({
    this.id = const Value.absent(),
    required int soldierId,
    required String title,
    this.weekDays = const Value.absent(),
    this.repeat = const Value.absent(),
    this.monthDays = const Value.absent(),
    required GuardPostDifficulty difficulty,
    required int shiftsPerDay,
  }) : soldierId = Value(soldierId),
       title = Value(title),
       difficulty = Value(difficulty),
       shiftsPerDay = Value(shiftsPerDay);
  static Insertable<GuardPostsTableData> custom({
    Expression<int>? id,
    Expression<int>? soldierId,
    Expression<String>? title,
    Expression<String>? weekDays,
    Expression<int>? repeat,
    Expression<String>? monthDays,
    Expression<int>? difficulty,
    Expression<int>? shiftsPerDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldierId != null) 'soldier_id': soldierId,
      if (title != null) 'title': title,
      if (weekDays != null) 'week_days': weekDays,
      if (repeat != null) 'repeat': repeat,
      if (monthDays != null) 'month_days': monthDays,
      if (difficulty != null) 'difficulty': difficulty,
      if (shiftsPerDay != null) 'shifts_per_day': shiftsPerDay,
    });
  }

  GuardPostsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? soldierId,
    Value<String>? title,
    Value<List<Weekday>?>? weekDays,
    Value<int>? repeat,
    Value<List<int>?>? monthDays,
    Value<GuardPostDifficulty>? difficulty,
    Value<int>? shiftsPerDay,
  }) {
    return GuardPostsTableCompanion(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      title: title ?? this.title,
      weekDays: weekDays ?? this.weekDays,
      repeat: repeat ?? this.repeat,
      monthDays: monthDays ?? this.monthDays,
      difficulty: difficulty ?? this.difficulty,
      shiftsPerDay: shiftsPerDay ?? this.shiftsPerDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soldierId.present) {
      map['soldier_id'] = Variable<int>(soldierId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (weekDays.present) {
      map['week_days'] = Variable<String>(
        $GuardPostsTableTable.$converterweekDaysn.toSql(weekDays.value),
      );
    }
    if (repeat.present) {
      map['repeat'] = Variable<int>(repeat.value);
    }
    if (monthDays.present) {
      map['month_days'] = Variable<String>(
        $GuardPostsTableTable.$convertermonthDaysn.toSql(monthDays.value),
      );
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(
        $GuardPostsTableTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (shiftsPerDay.present) {
      map['shifts_per_day'] = Variable<int>(shiftsPerDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuardPostsTableCompanion(')
          ..write('id: $id, ')
          ..write('soldierId: $soldierId, ')
          ..write('title: $title, ')
          ..write('weekDays: $weekDays, ')
          ..write('repeat: $repeat, ')
          ..write('monthDays: $monthDays, ')
          ..write('difficulty: $difficulty, ')
          ..write('shiftsPerDay: $shiftsPerDay')
          ..write(')'))
        .toString();
  }
}

class $PostPoliciesTableTable extends PostPoliciesTable
    with TableInfo<$PostPoliciesTableTable, PostPoliciesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostPoliciesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, priority, type, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'post_policies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PostPoliciesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostPoliciesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostPoliciesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
    );
  }

  @override
  $PostPoliciesTableTable createAlias(String alias) {
    return $PostPoliciesTableTable(attachedDatabase, alias);
  }
}

class PostPoliciesTableData extends DataClass
    implements Insertable<PostPoliciesTableData> {
  final int id;
  final int priority;
  final String type;
  final String data;
  const PostPoliciesTableData({
    required this.id,
    required this.priority,
    required this.type,
    required this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['priority'] = Variable<int>(priority);
    map['type'] = Variable<String>(type);
    map['data'] = Variable<String>(data);
    return map;
  }

  PostPoliciesTableCompanion toCompanion(bool nullToAbsent) {
    return PostPoliciesTableCompanion(
      id: Value(id),
      priority: Value(priority),
      type: Value(type),
      data: Value(data),
    );
  }

  factory PostPoliciesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostPoliciesTableData(
      id: serializer.fromJson<int>(json['id']),
      priority: serializer.fromJson<int>(json['priority']),
      type: serializer.fromJson<String>(json['type']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'priority': serializer.toJson<int>(priority),
      'type': serializer.toJson<String>(type),
      'data': serializer.toJson<String>(data),
    };
  }

  PostPoliciesTableData copyWith({
    int? id,
    int? priority,
    String? type,
    String? data,
  }) => PostPoliciesTableData(
    id: id ?? this.id,
    priority: priority ?? this.priority,
    type: type ?? this.type,
    data: data ?? this.data,
  );
  PostPoliciesTableData copyWithCompanion(PostPoliciesTableCompanion data) {
    return PostPoliciesTableData(
      id: data.id.present ? data.id.value : this.id,
      priority: data.priority.present ? data.priority.value : this.priority,
      type: data.type.present ? data.type.value : this.type,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostPoliciesTableData(')
          ..write('id: $id, ')
          ..write('priority: $priority, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, priority, type, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostPoliciesTableData &&
          other.id == this.id &&
          other.priority == this.priority &&
          other.type == this.type &&
          other.data == this.data);
}

class PostPoliciesTableCompanion
    extends UpdateCompanion<PostPoliciesTableData> {
  final Value<int> id;
  final Value<int> priority;
  final Value<String> type;
  final Value<String> data;
  const PostPoliciesTableCompanion({
    this.id = const Value.absent(),
    this.priority = const Value.absent(),
    this.type = const Value.absent(),
    this.data = const Value.absent(),
  });
  PostPoliciesTableCompanion.insert({
    this.id = const Value.absent(),
    required int priority,
    required String type,
    required String data,
  }) : priority = Value(priority),
       type = Value(type),
       data = Value(data);
  static Insertable<PostPoliciesTableData> custom({
    Expression<int>? id,
    Expression<int>? priority,
    Expression<String>? type,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (priority != null) 'priority': priority,
      if (type != null) 'type': type,
      if (data != null) 'data': data,
    });
  }

  PostPoliciesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? priority,
    Value<String>? type,
    Value<String>? data,
  }) {
    return PostPoliciesTableCompanion(
      id: id ?? this.id,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostPoliciesTableCompanion(')
          ..write('id: $id, ')
          ..write('priority: $priority, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SoldiersTableTable soldiersTable = $SoldiersTableTable(this);
  late final $GuardPostsTableTable guardPostsTable = $GuardPostsTableTable(
    this,
  );
  late final $PostPoliciesTableTable postPoliciesTable =
      $PostPoliciesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    soldiersTable,
    guardPostsTable,
    postPoliciesTable,
  ];
}

typedef $$SoldiersTableTableCreateCompanionBuilder =
    SoldiersTableCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required MilitaryRank rank,
      required DateTime dateOfEnlistment,
      Value<String?> nikName,
      Value<String?> imageUrl,
      Value<String?> militaryId,
      Value<String?> phoneNumber,
      Value<DateTime?> dateOfBirth,
    });
typedef $$SoldiersTableTableUpdateCompanionBuilder =
    SoldiersTableCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<MilitaryRank> rank,
      Value<DateTime> dateOfEnlistment,
      Value<String?> nikName,
      Value<String?> imageUrl,
      Value<String?> militaryId,
      Value<String?> phoneNumber,
      Value<DateTime?> dateOfBirth,
    });

class $$SoldiersTableTableFilterComposer
    extends Composer<_$AppDatabase, $SoldiersTableTable> {
  $$SoldiersTableTableFilterComposer({
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

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MilitaryRank, MilitaryRank, int> get rank =>
      $composableBuilder(
        column: $table.rank,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get dateOfEnlistment => $composableBuilder(
    column: $table.dateOfEnlistment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nikName => $composableBuilder(
    column: $table.nikName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get militaryId => $composableBuilder(
    column: $table.militaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SoldiersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SoldiersTableTable> {
  $$SoldiersTableTableOrderingComposer({
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

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfEnlistment => $composableBuilder(
    column: $table.dateOfEnlistment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nikName => $composableBuilder(
    column: $table.nikName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get militaryId => $composableBuilder(
    column: $table.militaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SoldiersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SoldiersTableTable> {
  $$SoldiersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MilitaryRank, int> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfEnlistment => $composableBuilder(
    column: $table.dateOfEnlistment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nikName =>
      $composableBuilder(column: $table.nikName, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get militaryId => $composableBuilder(
    column: $table.militaryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );
}

class $$SoldiersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SoldiersTableTable,
          SoldiersTableData,
          $$SoldiersTableTableFilterComposer,
          $$SoldiersTableTableOrderingComposer,
          $$SoldiersTableTableAnnotationComposer,
          $$SoldiersTableTableCreateCompanionBuilder,
          $$SoldiersTableTableUpdateCompanionBuilder,
          (
            SoldiersTableData,
            BaseReferences<
              _$AppDatabase,
              $SoldiersTableTable,
              SoldiersTableData
            >,
          ),
          SoldiersTableData,
          PrefetchHooks Function()
        > {
  $$SoldiersTableTableTableManager(_$AppDatabase db, $SoldiersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SoldiersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SoldiersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SoldiersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<MilitaryRank> rank = const Value.absent(),
                Value<DateTime> dateOfEnlistment = const Value.absent(),
                Value<String?> nikName = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> militaryId = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
              }) => SoldiersTableCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                rank: rank,
                dateOfEnlistment: dateOfEnlistment,
                nikName: nikName,
                imageUrl: imageUrl,
                militaryId: militaryId,
                phoneNumber: phoneNumber,
                dateOfBirth: dateOfBirth,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required MilitaryRank rank,
                required DateTime dateOfEnlistment,
                Value<String?> nikName = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> militaryId = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
              }) => SoldiersTableCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                rank: rank,
                dateOfEnlistment: dateOfEnlistment,
                nikName: nikName,
                imageUrl: imageUrl,
                militaryId: militaryId,
                phoneNumber: phoneNumber,
                dateOfBirth: dateOfBirth,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SoldiersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SoldiersTableTable,
      SoldiersTableData,
      $$SoldiersTableTableFilterComposer,
      $$SoldiersTableTableOrderingComposer,
      $$SoldiersTableTableAnnotationComposer,
      $$SoldiersTableTableCreateCompanionBuilder,
      $$SoldiersTableTableUpdateCompanionBuilder,
      (
        SoldiersTableData,
        BaseReferences<_$AppDatabase, $SoldiersTableTable, SoldiersTableData>,
      ),
      SoldiersTableData,
      PrefetchHooks Function()
    >;
typedef $$GuardPostsTableTableCreateCompanionBuilder =
    GuardPostsTableCompanion Function({
      Value<int> id,
      required int soldierId,
      required String title,
      Value<List<Weekday>?> weekDays,
      Value<int> repeat,
      Value<List<int>?> monthDays,
      required GuardPostDifficulty difficulty,
      required int shiftsPerDay,
    });
typedef $$GuardPostsTableTableUpdateCompanionBuilder =
    GuardPostsTableCompanion Function({
      Value<int> id,
      Value<int> soldierId,
      Value<String> title,
      Value<List<Weekday>?> weekDays,
      Value<int> repeat,
      Value<List<int>?> monthDays,
      Value<GuardPostDifficulty> difficulty,
      Value<int> shiftsPerDay,
    });

class $$GuardPostsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GuardPostsTableTable> {
  $$GuardPostsTableTableFilterComposer({
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

  ColumnFilters<int> get soldierId => $composableBuilder(
    column: $table.soldierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Weekday>?, List<Weekday>, String>
  get weekDays => $composableBuilder(
    column: $table.weekDays,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get repeat => $composableBuilder(
    column: $table.repeat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>?, List<int>, String> get monthDays =>
      $composableBuilder(
        column: $table.monthDays,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<GuardPostDifficulty, GuardPostDifficulty, int>
  get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get shiftsPerDay => $composableBuilder(
    column: $table.shiftsPerDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GuardPostsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GuardPostsTableTable> {
  $$GuardPostsTableTableOrderingComposer({
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

  ColumnOrderings<int> get soldierId => $composableBuilder(
    column: $table.soldierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekDays => $composableBuilder(
    column: $table.weekDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeat => $composableBuilder(
    column: $table.repeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get monthDays => $composableBuilder(
    column: $table.monthDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shiftsPerDay => $composableBuilder(
    column: $table.shiftsPerDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GuardPostsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuardPostsTableTable> {
  $$GuardPostsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get soldierId =>
      $composableBuilder(column: $table.soldierId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Weekday>?, String> get weekDays =>
      $composableBuilder(column: $table.weekDays, builder: (column) => column);

  GeneratedColumn<int> get repeat =>
      $composableBuilder(column: $table.repeat, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>?, String> get monthDays =>
      $composableBuilder(column: $table.monthDays, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GuardPostDifficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  GeneratedColumn<int> get shiftsPerDay => $composableBuilder(
    column: $table.shiftsPerDay,
    builder: (column) => column,
  );
}

class $$GuardPostsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GuardPostsTableTable,
          GuardPostsTableData,
          $$GuardPostsTableTableFilterComposer,
          $$GuardPostsTableTableOrderingComposer,
          $$GuardPostsTableTableAnnotationComposer,
          $$GuardPostsTableTableCreateCompanionBuilder,
          $$GuardPostsTableTableUpdateCompanionBuilder,
          (
            GuardPostsTableData,
            BaseReferences<
              _$AppDatabase,
              $GuardPostsTableTable,
              GuardPostsTableData
            >,
          ),
          GuardPostsTableData,
          PrefetchHooks Function()
        > {
  $$GuardPostsTableTableTableManager(
    _$AppDatabase db,
    $GuardPostsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuardPostsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuardPostsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuardPostsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> soldierId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<List<Weekday>?> weekDays = const Value.absent(),
                Value<int> repeat = const Value.absent(),
                Value<List<int>?> monthDays = const Value.absent(),
                Value<GuardPostDifficulty> difficulty = const Value.absent(),
                Value<int> shiftsPerDay = const Value.absent(),
              }) => GuardPostsTableCompanion(
                id: id,
                soldierId: soldierId,
                title: title,
                weekDays: weekDays,
                repeat: repeat,
                monthDays: monthDays,
                difficulty: difficulty,
                shiftsPerDay: shiftsPerDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int soldierId,
                required String title,
                Value<List<Weekday>?> weekDays = const Value.absent(),
                Value<int> repeat = const Value.absent(),
                Value<List<int>?> monthDays = const Value.absent(),
                required GuardPostDifficulty difficulty,
                required int shiftsPerDay,
              }) => GuardPostsTableCompanion.insert(
                id: id,
                soldierId: soldierId,
                title: title,
                weekDays: weekDays,
                repeat: repeat,
                monthDays: monthDays,
                difficulty: difficulty,
                shiftsPerDay: shiftsPerDay,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GuardPostsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GuardPostsTableTable,
      GuardPostsTableData,
      $$GuardPostsTableTableFilterComposer,
      $$GuardPostsTableTableOrderingComposer,
      $$GuardPostsTableTableAnnotationComposer,
      $$GuardPostsTableTableCreateCompanionBuilder,
      $$GuardPostsTableTableUpdateCompanionBuilder,
      (
        GuardPostsTableData,
        BaseReferences<
          _$AppDatabase,
          $GuardPostsTableTable,
          GuardPostsTableData
        >,
      ),
      GuardPostsTableData,
      PrefetchHooks Function()
    >;
typedef $$PostPoliciesTableTableCreateCompanionBuilder =
    PostPoliciesTableCompanion Function({
      Value<int> id,
      required int priority,
      required String type,
      required String data,
    });
typedef $$PostPoliciesTableTableUpdateCompanionBuilder =
    PostPoliciesTableCompanion Function({
      Value<int> id,
      Value<int> priority,
      Value<String> type,
      Value<String> data,
    });

class $$PostPoliciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PostPoliciesTableTable> {
  $$PostPoliciesTableTableFilterComposer({
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

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PostPoliciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PostPoliciesTableTable> {
  $$PostPoliciesTableTableOrderingComposer({
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

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PostPoliciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostPoliciesTableTable> {
  $$PostPoliciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$PostPoliciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PostPoliciesTableTable,
          PostPoliciesTableData,
          $$PostPoliciesTableTableFilterComposer,
          $$PostPoliciesTableTableOrderingComposer,
          $$PostPoliciesTableTableAnnotationComposer,
          $$PostPoliciesTableTableCreateCompanionBuilder,
          $$PostPoliciesTableTableUpdateCompanionBuilder,
          (
            PostPoliciesTableData,
            BaseReferences<
              _$AppDatabase,
              $PostPoliciesTableTable,
              PostPoliciesTableData
            >,
          ),
          PostPoliciesTableData,
          PrefetchHooks Function()
        > {
  $$PostPoliciesTableTableTableManager(
    _$AppDatabase db,
    $PostPoliciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostPoliciesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostPoliciesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostPoliciesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> data = const Value.absent(),
              }) => PostPoliciesTableCompanion(
                id: id,
                priority: priority,
                type: type,
                data: data,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int priority,
                required String type,
                required String data,
              }) => PostPoliciesTableCompanion.insert(
                id: id,
                priority: priority,
                type: type,
                data: data,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PostPoliciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PostPoliciesTableTable,
      PostPoliciesTableData,
      $$PostPoliciesTableTableFilterComposer,
      $$PostPoliciesTableTableOrderingComposer,
      $$PostPoliciesTableTableAnnotationComposer,
      $$PostPoliciesTableTableCreateCompanionBuilder,
      $$PostPoliciesTableTableUpdateCompanionBuilder,
      (
        PostPoliciesTableData,
        BaseReferences<
          _$AppDatabase,
          $PostPoliciesTableTable,
          PostPoliciesTableData
        >,
      ),
      PostPoliciesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SoldiersTableTableTableManager get soldiersTable =>
      $$SoldiersTableTableTableManager(_db, _db.soldiersTable);
  $$GuardPostsTableTableTableManager get guardPostsTable =>
      $$GuardPostsTableTableTableManager(_db, _db.guardPostsTable);
  $$PostPoliciesTableTableTableManager get postPoliciesTable =>
      $$PostPoliciesTableTableTableManager(_db, _db.postPoliciesTable);
}

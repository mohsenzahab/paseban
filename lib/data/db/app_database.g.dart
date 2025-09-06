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
  late final GeneratedColumnWithTypeConverter<List<List<Weekday>>?, String>
  weekDays =
      GeneratedColumn<String>(
        'week_days',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<List<Weekday>>?>(
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
  static const VerificationMeta _periodStartDateMeta = const VerificationMeta(
    'periodStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> periodStartDate =
      GeneratedColumn<DateTime>(
        'period_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    weekDays,
    repeat,
    monthDays,
    difficulty,
    shiftsPerDay,
    periodStartDate,
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
    if (data.containsKey('period_start_date')) {
      context.handle(
        _periodStartDateMeta,
        periodStartDate.isAcceptableOrUnknown(
          data['period_start_date']!,
          _periodStartDateMeta,
        ),
      );
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
      periodStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_start_date'],
      ),
    );
  }

  @override
  $GuardPostsTableTable createAlias(String alias) {
    return $GuardPostsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<List<Weekday>>, String> $converterweekDays =
      const WeekdayListConverter();
  static TypeConverter<List<List<Weekday>>?, String?> $converterweekDaysn =
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
  final String title;
  final List<List<Weekday>>? weekDays;
  final int repeat;
  final List<int>? monthDays;
  final GuardPostDifficulty difficulty;
  final int shiftsPerDay;
  final DateTime? periodStartDate;
  const GuardPostsTableData({
    required this.id,
    required this.title,
    this.weekDays,
    required this.repeat,
    this.monthDays,
    required this.difficulty,
    required this.shiftsPerDay,
    this.periodStartDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
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
    if (!nullToAbsent || periodStartDate != null) {
      map['period_start_date'] = Variable<DateTime>(periodStartDate);
    }
    return map;
  }

  GuardPostsTableCompanion toCompanion(bool nullToAbsent) {
    return GuardPostsTableCompanion(
      id: Value(id),
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
      periodStartDate: periodStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(periodStartDate),
    );
  }

  factory GuardPostsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuardPostsTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      weekDays: serializer.fromJson<List<List<Weekday>>?>(json['weekDays']),
      repeat: serializer.fromJson<int>(json['repeat']),
      monthDays: serializer.fromJson<List<int>?>(json['monthDays']),
      difficulty: $GuardPostsTableTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
      shiftsPerDay: serializer.fromJson<int>(json['shiftsPerDay']),
      periodStartDate: serializer.fromJson<DateTime?>(json['periodStartDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'weekDays': serializer.toJson<List<List<Weekday>>?>(weekDays),
      'repeat': serializer.toJson<int>(repeat),
      'monthDays': serializer.toJson<List<int>?>(monthDays),
      'difficulty': serializer.toJson<int>(
        $GuardPostsTableTable.$converterdifficulty.toJson(difficulty),
      ),
      'shiftsPerDay': serializer.toJson<int>(shiftsPerDay),
      'periodStartDate': serializer.toJson<DateTime?>(periodStartDate),
    };
  }

  GuardPostsTableData copyWith({
    int? id,
    String? title,
    Value<List<List<Weekday>>?> weekDays = const Value.absent(),
    int? repeat,
    Value<List<int>?> monthDays = const Value.absent(),
    GuardPostDifficulty? difficulty,
    int? shiftsPerDay,
    Value<DateTime?> periodStartDate = const Value.absent(),
  }) => GuardPostsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    weekDays: weekDays.present ? weekDays.value : this.weekDays,
    repeat: repeat ?? this.repeat,
    monthDays: monthDays.present ? monthDays.value : this.monthDays,
    difficulty: difficulty ?? this.difficulty,
    shiftsPerDay: shiftsPerDay ?? this.shiftsPerDay,
    periodStartDate: periodStartDate.present
        ? periodStartDate.value
        : this.periodStartDate,
  );
  GuardPostsTableData copyWithCompanion(GuardPostsTableCompanion data) {
    return GuardPostsTableData(
      id: data.id.present ? data.id.value : this.id,
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
      periodStartDate: data.periodStartDate.present
          ? data.periodStartDate.value
          : this.periodStartDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuardPostsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('weekDays: $weekDays, ')
          ..write('repeat: $repeat, ')
          ..write('monthDays: $monthDays, ')
          ..write('difficulty: $difficulty, ')
          ..write('shiftsPerDay: $shiftsPerDay, ')
          ..write('periodStartDate: $periodStartDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    weekDays,
    repeat,
    monthDays,
    difficulty,
    shiftsPerDay,
    periodStartDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuardPostsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.weekDays == this.weekDays &&
          other.repeat == this.repeat &&
          other.monthDays == this.monthDays &&
          other.difficulty == this.difficulty &&
          other.shiftsPerDay == this.shiftsPerDay &&
          other.periodStartDate == this.periodStartDate);
}

class GuardPostsTableCompanion extends UpdateCompanion<GuardPostsTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<List<List<Weekday>>?> weekDays;
  final Value<int> repeat;
  final Value<List<int>?> monthDays;
  final Value<GuardPostDifficulty> difficulty;
  final Value<int> shiftsPerDay;
  final Value<DateTime?> periodStartDate;
  const GuardPostsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.weekDays = const Value.absent(),
    this.repeat = const Value.absent(),
    this.monthDays = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.shiftsPerDay = const Value.absent(),
    this.periodStartDate = const Value.absent(),
  });
  GuardPostsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.weekDays = const Value.absent(),
    this.repeat = const Value.absent(),
    this.monthDays = const Value.absent(),
    required GuardPostDifficulty difficulty,
    required int shiftsPerDay,
    this.periodStartDate = const Value.absent(),
  }) : title = Value(title),
       difficulty = Value(difficulty),
       shiftsPerDay = Value(shiftsPerDay);
  static Insertable<GuardPostsTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? weekDays,
    Expression<int>? repeat,
    Expression<String>? monthDays,
    Expression<int>? difficulty,
    Expression<int>? shiftsPerDay,
    Expression<DateTime>? periodStartDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (weekDays != null) 'week_days': weekDays,
      if (repeat != null) 'repeat': repeat,
      if (monthDays != null) 'month_days': monthDays,
      if (difficulty != null) 'difficulty': difficulty,
      if (shiftsPerDay != null) 'shifts_per_day': shiftsPerDay,
      if (periodStartDate != null) 'period_start_date': periodStartDate,
    });
  }

  GuardPostsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<List<List<Weekday>>?>? weekDays,
    Value<int>? repeat,
    Value<List<int>?>? monthDays,
    Value<GuardPostDifficulty>? difficulty,
    Value<int>? shiftsPerDay,
    Value<DateTime?>? periodStartDate,
  }) {
    return GuardPostsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      weekDays: weekDays ?? this.weekDays,
      repeat: repeat ?? this.repeat,
      monthDays: monthDays ?? this.monthDays,
      difficulty: difficulty ?? this.difficulty,
      shiftsPerDay: shiftsPerDay ?? this.shiftsPerDay,
      periodStartDate: periodStartDate ?? this.periodStartDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (periodStartDate.present) {
      map['period_start_date'] = Variable<DateTime>(periodStartDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuardPostsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('weekDays: $weekDays, ')
          ..write('repeat: $repeat, ')
          ..write('monthDays: $monthDays, ')
          ..write('difficulty: $difficulty, ')
          ..write('shiftsPerDay: $shiftsPerDay, ')
          ..write('periodStartDate: $periodStartDate')
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
  static const VerificationMeta _soldierIdMeta = const VerificationMeta(
    'soldierId',
  );
  @override
  late final GeneratedColumn<int> soldierId = GeneratedColumn<int>(
    'soldier_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES soldiers_table (id) ON UPDATE CASCADE ON DELETE CASCADE',
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
  List<GeneratedColumn> get $columns => [id, soldierId, priority, type, data];
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
    if (data.containsKey('soldier_id')) {
      context.handle(
        _soldierIdMeta,
        soldierId.isAcceptableOrUnknown(data['soldier_id']!, _soldierIdMeta),
      );
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
      soldierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}soldier_id'],
      ),
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
  final int? soldierId;
  final int priority;
  final String type;
  final String data;
  const PostPoliciesTableData({
    required this.id,
    this.soldierId,
    required this.priority,
    required this.type,
    required this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || soldierId != null) {
      map['soldier_id'] = Variable<int>(soldierId);
    }
    map['priority'] = Variable<int>(priority);
    map['type'] = Variable<String>(type);
    map['data'] = Variable<String>(data);
    return map;
  }

  PostPoliciesTableCompanion toCompanion(bool nullToAbsent) {
    return PostPoliciesTableCompanion(
      id: Value(id),
      soldierId: soldierId == null && nullToAbsent
          ? const Value.absent()
          : Value(soldierId),
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
      soldierId: serializer.fromJson<int?>(json['soldierId']),
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
      'soldierId': serializer.toJson<int?>(soldierId),
      'priority': serializer.toJson<int>(priority),
      'type': serializer.toJson<String>(type),
      'data': serializer.toJson<String>(data),
    };
  }

  PostPoliciesTableData copyWith({
    int? id,
    Value<int?> soldierId = const Value.absent(),
    int? priority,
    String? type,
    String? data,
  }) => PostPoliciesTableData(
    id: id ?? this.id,
    soldierId: soldierId.present ? soldierId.value : this.soldierId,
    priority: priority ?? this.priority,
    type: type ?? this.type,
    data: data ?? this.data,
  );
  PostPoliciesTableData copyWithCompanion(PostPoliciesTableCompanion data) {
    return PostPoliciesTableData(
      id: data.id.present ? data.id.value : this.id,
      soldierId: data.soldierId.present ? data.soldierId.value : this.soldierId,
      priority: data.priority.present ? data.priority.value : this.priority,
      type: data.type.present ? data.type.value : this.type,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostPoliciesTableData(')
          ..write('id: $id, ')
          ..write('soldierId: $soldierId, ')
          ..write('priority: $priority, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, soldierId, priority, type, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostPoliciesTableData &&
          other.id == this.id &&
          other.soldierId == this.soldierId &&
          other.priority == this.priority &&
          other.type == this.type &&
          other.data == this.data);
}

class PostPoliciesTableCompanion
    extends UpdateCompanion<PostPoliciesTableData> {
  final Value<int> id;
  final Value<int?> soldierId;
  final Value<int> priority;
  final Value<String> type;
  final Value<String> data;
  const PostPoliciesTableCompanion({
    this.id = const Value.absent(),
    this.soldierId = const Value.absent(),
    this.priority = const Value.absent(),
    this.type = const Value.absent(),
    this.data = const Value.absent(),
  });
  PostPoliciesTableCompanion.insert({
    this.id = const Value.absent(),
    this.soldierId = const Value.absent(),
    required int priority,
    required String type,
    required String data,
  }) : priority = Value(priority),
       type = Value(type),
       data = Value(data);
  static Insertable<PostPoliciesTableData> custom({
    Expression<int>? id,
    Expression<int>? soldierId,
    Expression<int>? priority,
    Expression<String>? type,
    Expression<String>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldierId != null) 'soldier_id': soldierId,
      if (priority != null) 'priority': priority,
      if (type != null) 'type': type,
      if (data != null) 'data': data,
    });
  }

  PostPoliciesTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? soldierId,
    Value<int>? priority,
    Value<String>? type,
    Value<String>? data,
  }) {
    return PostPoliciesTableCompanion(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
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
    if (soldierId.present) {
      map['soldier_id'] = Variable<int>(soldierId.value);
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
          ..write('soldierId: $soldierId, ')
          ..write('priority: $priority, ')
          ..write('type: $type, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $SoldierPostsTableTable extends SoldierPostsTable
    with TableInfo<$SoldierPostsTableTable, SoldierPostsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoldierPostsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _soldierMeta = const VerificationMeta(
    'soldier',
  );
  @override
  late final GeneratedColumn<int> soldier = GeneratedColumn<int>(
    'soldier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES soldiers_table (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _guardPostMeta = const VerificationMeta(
    'guardPost',
  );
  @override
  late final GeneratedColumn<int> guardPost = GeneratedColumn<int>(
    'guard_post',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES guard_posts_table (id) ON UPDATE SET NULL ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _editTypeMeta = const VerificationMeta(
    'editType',
  );
  @override
  late final GeneratedColumn<int> editType = GeneratedColumn<int>(
    'edit_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    soldier,
    guardPost,
    editType,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soldier_posts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SoldierPostsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soldier')) {
      context.handle(
        _soldierMeta,
        soldier.isAcceptableOrUnknown(data['soldier']!, _soldierMeta),
      );
    } else if (isInserting) {
      context.missing(_soldierMeta);
    }
    if (data.containsKey('guard_post')) {
      context.handle(
        _guardPostMeta,
        guardPost.isAcceptableOrUnknown(data['guard_post']!, _guardPostMeta),
      );
    }
    if (data.containsKey('edit_type')) {
      context.handle(
        _editTypeMeta,
        editType.isAcceptableOrUnknown(data['edit_type']!, _editTypeMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {soldier, date},
  ];
  @override
  SoldierPostsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoldierPostsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      soldier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}soldier'],
      )!,
      guardPost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}guard_post'],
      ),
      editType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edit_type'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $SoldierPostsTableTable createAlias(String alias) {
    return $SoldierPostsTableTable(attachedDatabase, alias);
  }
}

class SoldierPostsTableData extends DataClass
    implements Insertable<SoldierPostsTableData> {
  final int id;
  final int soldier;
  final int? guardPost;
  final int editType;
  final DateTime date;
  const SoldierPostsTableData({
    required this.id,
    required this.soldier,
    this.guardPost,
    required this.editType,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soldier'] = Variable<int>(soldier);
    if (!nullToAbsent || guardPost != null) {
      map['guard_post'] = Variable<int>(guardPost);
    }
    map['edit_type'] = Variable<int>(editType);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  SoldierPostsTableCompanion toCompanion(bool nullToAbsent) {
    return SoldierPostsTableCompanion(
      id: Value(id),
      soldier: Value(soldier),
      guardPost: guardPost == null && nullToAbsent
          ? const Value.absent()
          : Value(guardPost),
      editType: Value(editType),
      date: Value(date),
    );
  }

  factory SoldierPostsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoldierPostsTableData(
      id: serializer.fromJson<int>(json['id']),
      soldier: serializer.fromJson<int>(json['soldier']),
      guardPost: serializer.fromJson<int?>(json['guardPost']),
      editType: serializer.fromJson<int>(json['editType']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soldier': serializer.toJson<int>(soldier),
      'guardPost': serializer.toJson<int?>(guardPost),
      'editType': serializer.toJson<int>(editType),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  SoldierPostsTableData copyWith({
    int? id,
    int? soldier,
    Value<int?> guardPost = const Value.absent(),
    int? editType,
    DateTime? date,
  }) => SoldierPostsTableData(
    id: id ?? this.id,
    soldier: soldier ?? this.soldier,
    guardPost: guardPost.present ? guardPost.value : this.guardPost,
    editType: editType ?? this.editType,
    date: date ?? this.date,
  );
  SoldierPostsTableData copyWithCompanion(SoldierPostsTableCompanion data) {
    return SoldierPostsTableData(
      id: data.id.present ? data.id.value : this.id,
      soldier: data.soldier.present ? data.soldier.value : this.soldier,
      guardPost: data.guardPost.present ? data.guardPost.value : this.guardPost,
      editType: data.editType.present ? data.editType.value : this.editType,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SoldierPostsTableData(')
          ..write('id: $id, ')
          ..write('soldier: $soldier, ')
          ..write('guardPost: $guardPost, ')
          ..write('editType: $editType, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, soldier, guardPost, editType, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoldierPostsTableData &&
          other.id == this.id &&
          other.soldier == this.soldier &&
          other.guardPost == this.guardPost &&
          other.editType == this.editType &&
          other.date == this.date);
}

class SoldierPostsTableCompanion
    extends UpdateCompanion<SoldierPostsTableData> {
  final Value<int> id;
  final Value<int> soldier;
  final Value<int?> guardPost;
  final Value<int> editType;
  final Value<DateTime> date;
  const SoldierPostsTableCompanion({
    this.id = const Value.absent(),
    this.soldier = const Value.absent(),
    this.guardPost = const Value.absent(),
    this.editType = const Value.absent(),
    this.date = const Value.absent(),
  });
  SoldierPostsTableCompanion.insert({
    this.id = const Value.absent(),
    required int soldier,
    this.guardPost = const Value.absent(),
    this.editType = const Value.absent(),
    required DateTime date,
  }) : soldier = Value(soldier),
       date = Value(date);
  static Insertable<SoldierPostsTableData> custom({
    Expression<int>? id,
    Expression<int>? soldier,
    Expression<int>? guardPost,
    Expression<int>? editType,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soldier != null) 'soldier': soldier,
      if (guardPost != null) 'guard_post': guardPost,
      if (editType != null) 'edit_type': editType,
      if (date != null) 'date': date,
    });
  }

  SoldierPostsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? soldier,
    Value<int?>? guardPost,
    Value<int>? editType,
    Value<DateTime>? date,
  }) {
    return SoldierPostsTableCompanion(
      id: id ?? this.id,
      soldier: soldier ?? this.soldier,
      guardPost: guardPost ?? this.guardPost,
      editType: editType ?? this.editType,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soldier.present) {
      map['soldier'] = Variable<int>(soldier.value);
    }
    if (guardPost.present) {
      map['guard_post'] = Variable<int>(guardPost.value);
    }
    if (editType.present) {
      map['edit_type'] = Variable<int>(editType.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoldierPostsTableCompanion(')
          ..write('id: $id, ')
          ..write('soldier: $soldier, ')
          ..write('guardPost: $guardPost, ')
          ..write('editType: $editType, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $HolidaysTableTable extends HolidaysTable
    with TableInfo<$HolidaysTableTable, HolidaysTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HolidaysTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holidays_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HolidaysTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  HolidaysTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HolidaysTableData(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $HolidaysTableTable createAlias(String alias) {
    return $HolidaysTableTable(attachedDatabase, alias);
  }
}

class HolidaysTableData extends DataClass
    implements Insertable<HolidaysTableData> {
  final DateTime date;
  const HolidaysTableData({required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  HolidaysTableCompanion toCompanion(bool nullToAbsent) {
    return HolidaysTableCompanion(date: Value(date));
  }

  factory HolidaysTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HolidaysTableData(date: serializer.fromJson<DateTime>(json['date']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'date': serializer.toJson<DateTime>(date)};
  }

  HolidaysTableData copyWith({DateTime? date}) =>
      HolidaysTableData(date: date ?? this.date);
  HolidaysTableData copyWithCompanion(HolidaysTableCompanion data) {
    return HolidaysTableData(
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HolidaysTableData(')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => date.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HolidaysTableData && other.date == this.date);
}

class HolidaysTableCompanion extends UpdateCompanion<HolidaysTableData> {
  final Value<DateTime> date;
  final Value<int> rowid;
  const HolidaysTableCompanion({
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HolidaysTableCompanion.insert({
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<HolidaysTableData> custom({
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HolidaysTableCompanion copyWith({Value<DateTime>? date, Value<int>? rowid}) {
    return HolidaysTableCompanion(
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HolidaysTableCompanion(')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
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
  late final $SoldierPostsTableTable soldierPostsTable =
      $SoldierPostsTableTable(this);
  late final $HolidaysTableTable holidaysTable = $HolidaysTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    soldiersTable,
    guardPostsTable,
    postPoliciesTable,
    soldierPostsTable,
    holidaysTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'soldiers_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('post_policies_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'soldiers_table',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('post_policies_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'soldiers_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('soldier_posts_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'soldiers_table',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('soldier_posts_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guard_posts_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('soldier_posts_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'guard_posts_table',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('soldier_posts_table', kind: UpdateKind.update)],
    ),
  ]);
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

final class $$SoldiersTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $SoldiersTableTable, SoldiersTableData> {
  $$SoldiersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $PostPoliciesTableTable,
    List<PostPoliciesTableData>
  >
  _postPoliciesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.postPoliciesTable,
        aliasName: $_aliasNameGenerator(
          db.soldiersTable.id,
          db.postPoliciesTable.soldierId,
        ),
      );

  $$PostPoliciesTableTableProcessedTableManager get postPoliciesTableRefs {
    final manager = $$PostPoliciesTableTableTableManager(
      $_db,
      $_db.postPoliciesTable,
    ).filter((f) => f.soldierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _postPoliciesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SoldierPostsTableTable,
    List<SoldierPostsTableData>
  >
  _soldierPostsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.soldierPostsTable,
        aliasName: $_aliasNameGenerator(
          db.soldiersTable.id,
          db.soldierPostsTable.soldier,
        ),
      );

  $$SoldierPostsTableTableProcessedTableManager get soldierPostsTableRefs {
    final manager = $$SoldierPostsTableTableTableManager(
      $_db,
      $_db.soldierPostsTable,
    ).filter((f) => f.soldier.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _soldierPostsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> postPoliciesTableRefs(
    Expression<bool> Function($$PostPoliciesTableTableFilterComposer f) f,
  ) {
    final $$PostPoliciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.postPoliciesTable,
      getReferencedColumn: (t) => t.soldierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PostPoliciesTableTableFilterComposer(
            $db: $db,
            $table: $db.postPoliciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> soldierPostsTableRefs(
    Expression<bool> Function($$SoldierPostsTableTableFilterComposer f) f,
  ) {
    final $$SoldierPostsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.soldierPostsTable,
      getReferencedColumn: (t) => t.soldier,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldierPostsTableTableFilterComposer(
            $db: $db,
            $table: $db.soldierPostsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> postPoliciesTableRefs<T extends Object>(
    Expression<T> Function($$PostPoliciesTableTableAnnotationComposer a) f,
  ) {
    final $$PostPoliciesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.postPoliciesTable,
          getReferencedColumn: (t) => t.soldierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PostPoliciesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.postPoliciesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> soldierPostsTableRefs<T extends Object>(
    Expression<T> Function($$SoldierPostsTableTableAnnotationComposer a) f,
  ) {
    final $$SoldierPostsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.soldierPostsTable,
          getReferencedColumn: (t) => t.soldier,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoldierPostsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.soldierPostsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (SoldiersTableData, $$SoldiersTableTableReferences),
          SoldiersTableData,
          PrefetchHooks Function({
            bool postPoliciesTableRefs,
            bool soldierPostsTableRefs,
          })
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$SoldiersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({postPoliciesTableRefs = false, soldierPostsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (postPoliciesTableRefs) db.postPoliciesTable,
                    if (soldierPostsTableRefs) db.soldierPostsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (postPoliciesTableRefs)
                        await $_getPrefetchedData<
                          SoldiersTableData,
                          $SoldiersTableTable,
                          PostPoliciesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoldiersTableTableReferences
                              ._postPoliciesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoldiersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).postPoliciesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.soldierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (soldierPostsTableRefs)
                        await $_getPrefetchedData<
                          SoldiersTableData,
                          $SoldiersTableTable,
                          SoldierPostsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SoldiersTableTableReferences
                              ._soldierPostsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SoldiersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).soldierPostsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.soldier == item.id,
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
      (SoldiersTableData, $$SoldiersTableTableReferences),
      SoldiersTableData,
      PrefetchHooks Function({
        bool postPoliciesTableRefs,
        bool soldierPostsTableRefs,
      })
    >;
typedef $$GuardPostsTableTableCreateCompanionBuilder =
    GuardPostsTableCompanion Function({
      Value<int> id,
      required String title,
      Value<List<List<Weekday>>?> weekDays,
      Value<int> repeat,
      Value<List<int>?> monthDays,
      required GuardPostDifficulty difficulty,
      required int shiftsPerDay,
      Value<DateTime?> periodStartDate,
    });
typedef $$GuardPostsTableTableUpdateCompanionBuilder =
    GuardPostsTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<List<List<Weekday>>?> weekDays,
      Value<int> repeat,
      Value<List<int>?> monthDays,
      Value<GuardPostDifficulty> difficulty,
      Value<int> shiftsPerDay,
      Value<DateTime?> periodStartDate,
    });

final class $$GuardPostsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GuardPostsTableTable,
          GuardPostsTableData
        > {
  $$GuardPostsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SoldierPostsTableTable,
    List<SoldierPostsTableData>
  >
  _soldierPostsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.soldierPostsTable,
        aliasName: $_aliasNameGenerator(
          db.guardPostsTable.id,
          db.soldierPostsTable.guardPost,
        ),
      );

  $$SoldierPostsTableTableProcessedTableManager get soldierPostsTableRefs {
    final manager = $$SoldierPostsTableTableTableManager(
      $_db,
      $_db.soldierPostsTable,
    ).filter((f) => f.guardPost.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _soldierPostsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    List<List<Weekday>>?,
    List<List<Weekday>>,
    String
  >
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

  ColumnFilters<DateTime> get periodStartDate => $composableBuilder(
    column: $table.periodStartDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> soldierPostsTableRefs(
    Expression<bool> Function($$SoldierPostsTableTableFilterComposer f) f,
  ) {
    final $$SoldierPostsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.soldierPostsTable,
      getReferencedColumn: (t) => t.guardPost,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldierPostsTableTableFilterComposer(
            $db: $db,
            $table: $db.soldierPostsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<DateTime> get periodStartDate => $composableBuilder(
    column: $table.periodStartDate,
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<List<Weekday>>?, String> get weekDays =>
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

  GeneratedColumn<DateTime> get periodStartDate => $composableBuilder(
    column: $table.periodStartDate,
    builder: (column) => column,
  );

  Expression<T> soldierPostsTableRefs<T extends Object>(
    Expression<T> Function($$SoldierPostsTableTableAnnotationComposer a) f,
  ) {
    final $$SoldierPostsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.soldierPostsTable,
          getReferencedColumn: (t) => t.guardPost,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SoldierPostsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.soldierPostsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (GuardPostsTableData, $$GuardPostsTableTableReferences),
          GuardPostsTableData,
          PrefetchHooks Function({bool soldierPostsTableRefs})
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
                Value<String> title = const Value.absent(),
                Value<List<List<Weekday>>?> weekDays = const Value.absent(),
                Value<int> repeat = const Value.absent(),
                Value<List<int>?> monthDays = const Value.absent(),
                Value<GuardPostDifficulty> difficulty = const Value.absent(),
                Value<int> shiftsPerDay = const Value.absent(),
                Value<DateTime?> periodStartDate = const Value.absent(),
              }) => GuardPostsTableCompanion(
                id: id,
                title: title,
                weekDays: weekDays,
                repeat: repeat,
                monthDays: monthDays,
                difficulty: difficulty,
                shiftsPerDay: shiftsPerDay,
                periodStartDate: periodStartDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<List<List<Weekday>>?> weekDays = const Value.absent(),
                Value<int> repeat = const Value.absent(),
                Value<List<int>?> monthDays = const Value.absent(),
                required GuardPostDifficulty difficulty,
                required int shiftsPerDay,
                Value<DateTime?> periodStartDate = const Value.absent(),
              }) => GuardPostsTableCompanion.insert(
                id: id,
                title: title,
                weekDays: weekDays,
                repeat: repeat,
                monthDays: monthDays,
                difficulty: difficulty,
                shiftsPerDay: shiftsPerDay,
                periodStartDate: periodStartDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GuardPostsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({soldierPostsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (soldierPostsTableRefs) db.soldierPostsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (soldierPostsTableRefs)
                    await $_getPrefetchedData<
                      GuardPostsTableData,
                      $GuardPostsTableTable,
                      SoldierPostsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$GuardPostsTableTableReferences
                          ._soldierPostsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GuardPostsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).soldierPostsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.guardPost == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (GuardPostsTableData, $$GuardPostsTableTableReferences),
      GuardPostsTableData,
      PrefetchHooks Function({bool soldierPostsTableRefs})
    >;
typedef $$PostPoliciesTableTableCreateCompanionBuilder =
    PostPoliciesTableCompanion Function({
      Value<int> id,
      Value<int?> soldierId,
      required int priority,
      required String type,
      required String data,
    });
typedef $$PostPoliciesTableTableUpdateCompanionBuilder =
    PostPoliciesTableCompanion Function({
      Value<int> id,
      Value<int?> soldierId,
      Value<int> priority,
      Value<String> type,
      Value<String> data,
    });

final class $$PostPoliciesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PostPoliciesTableTable,
          PostPoliciesTableData
        > {
  $$PostPoliciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoldiersTableTable _soldierIdTable(_$AppDatabase db) =>
      db.soldiersTable.createAlias(
        $_aliasNameGenerator(
          db.postPoliciesTable.soldierId,
          db.soldiersTable.id,
        ),
      );

  $$SoldiersTableTableProcessedTableManager? get soldierId {
    final $_column = $_itemColumn<int>('soldier_id');
    if ($_column == null) return null;
    final manager = $$SoldiersTableTableTableManager(
      $_db,
      $_db.soldiersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_soldierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  $$SoldiersTableTableFilterComposer get soldierId {
    final $$SoldiersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldierId,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableFilterComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  $$SoldiersTableTableOrderingComposer get soldierId {
    final $$SoldiersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldierId,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableOrderingComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  $$SoldiersTableTableAnnotationComposer get soldierId {
    final $$SoldiersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldierId,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (PostPoliciesTableData, $$PostPoliciesTableTableReferences),
          PostPoliciesTableData,
          PrefetchHooks Function({bool soldierId})
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
                Value<int?> soldierId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> data = const Value.absent(),
              }) => PostPoliciesTableCompanion(
                id: id,
                soldierId: soldierId,
                priority: priority,
                type: type,
                data: data,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> soldierId = const Value.absent(),
                required int priority,
                required String type,
                required String data,
              }) => PostPoliciesTableCompanion.insert(
                id: id,
                soldierId: soldierId,
                priority: priority,
                type: type,
                data: data,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PostPoliciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({soldierId = false}) {
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
                    if (soldierId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.soldierId,
                                referencedTable:
                                    $$PostPoliciesTableTableReferences
                                        ._soldierIdTable(db),
                                referencedColumn:
                                    $$PostPoliciesTableTableReferences
                                        ._soldierIdTable(db)
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
      (PostPoliciesTableData, $$PostPoliciesTableTableReferences),
      PostPoliciesTableData,
      PrefetchHooks Function({bool soldierId})
    >;
typedef $$SoldierPostsTableTableCreateCompanionBuilder =
    SoldierPostsTableCompanion Function({
      Value<int> id,
      required int soldier,
      Value<int?> guardPost,
      Value<int> editType,
      required DateTime date,
    });
typedef $$SoldierPostsTableTableUpdateCompanionBuilder =
    SoldierPostsTableCompanion Function({
      Value<int> id,
      Value<int> soldier,
      Value<int?> guardPost,
      Value<int> editType,
      Value<DateTime> date,
    });

final class $$SoldierPostsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SoldierPostsTableTable,
          SoldierPostsTableData
        > {
  $$SoldierPostsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SoldiersTableTable _soldierTable(_$AppDatabase db) =>
      db.soldiersTable.createAlias(
        $_aliasNameGenerator(db.soldierPostsTable.soldier, db.soldiersTable.id),
      );

  $$SoldiersTableTableProcessedTableManager get soldier {
    final $_column = $_itemColumn<int>('soldier')!;

    final manager = $$SoldiersTableTableTableManager(
      $_db,
      $_db.soldiersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_soldierTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GuardPostsTableTable _guardPostTable(_$AppDatabase db) =>
      db.guardPostsTable.createAlias(
        $_aliasNameGenerator(
          db.soldierPostsTable.guardPost,
          db.guardPostsTable.id,
        ),
      );

  $$GuardPostsTableTableProcessedTableManager? get guardPost {
    final $_column = $_itemColumn<int>('guard_post');
    if ($_column == null) return null;
    final manager = $$GuardPostsTableTableTableManager(
      $_db,
      $_db.guardPostsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_guardPostTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SoldierPostsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SoldierPostsTableTable> {
  $$SoldierPostsTableTableFilterComposer({
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

  ColumnFilters<int> get editType => $composableBuilder(
    column: $table.editType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$SoldiersTableTableFilterComposer get soldier {
    final $$SoldiersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldier,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableFilterComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuardPostsTableTableFilterComposer get guardPost {
    final $$GuardPostsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guardPost,
      referencedTable: $db.guardPostsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuardPostsTableTableFilterComposer(
            $db: $db,
            $table: $db.guardPostsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoldierPostsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SoldierPostsTableTable> {
  $$SoldierPostsTableTableOrderingComposer({
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

  ColumnOrderings<int> get editType => $composableBuilder(
    column: $table.editType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$SoldiersTableTableOrderingComposer get soldier {
    final $$SoldiersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldier,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableOrderingComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuardPostsTableTableOrderingComposer get guardPost {
    final $$GuardPostsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guardPost,
      referencedTable: $db.guardPostsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuardPostsTableTableOrderingComposer(
            $db: $db,
            $table: $db.guardPostsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoldierPostsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SoldierPostsTableTable> {
  $$SoldierPostsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get editType =>
      $composableBuilder(column: $table.editType, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$SoldiersTableTableAnnotationComposer get soldier {
    final $$SoldiersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.soldier,
      referencedTable: $db.soldiersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SoldiersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.soldiersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GuardPostsTableTableAnnotationComposer get guardPost {
    final $$GuardPostsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.guardPost,
      referencedTable: $db.guardPostsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GuardPostsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.guardPostsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SoldierPostsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SoldierPostsTableTable,
          SoldierPostsTableData,
          $$SoldierPostsTableTableFilterComposer,
          $$SoldierPostsTableTableOrderingComposer,
          $$SoldierPostsTableTableAnnotationComposer,
          $$SoldierPostsTableTableCreateCompanionBuilder,
          $$SoldierPostsTableTableUpdateCompanionBuilder,
          (SoldierPostsTableData, $$SoldierPostsTableTableReferences),
          SoldierPostsTableData,
          PrefetchHooks Function({bool soldier, bool guardPost})
        > {
  $$SoldierPostsTableTableTableManager(
    _$AppDatabase db,
    $SoldierPostsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SoldierPostsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SoldierPostsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SoldierPostsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> soldier = const Value.absent(),
                Value<int?> guardPost = const Value.absent(),
                Value<int> editType = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => SoldierPostsTableCompanion(
                id: id,
                soldier: soldier,
                guardPost: guardPost,
                editType: editType,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int soldier,
                Value<int?> guardPost = const Value.absent(),
                Value<int> editType = const Value.absent(),
                required DateTime date,
              }) => SoldierPostsTableCompanion.insert(
                id: id,
                soldier: soldier,
                guardPost: guardPost,
                editType: editType,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SoldierPostsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({soldier = false, guardPost = false}) {
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
                    if (soldier) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.soldier,
                                referencedTable:
                                    $$SoldierPostsTableTableReferences
                                        ._soldierTable(db),
                                referencedColumn:
                                    $$SoldierPostsTableTableReferences
                                        ._soldierTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (guardPost) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.guardPost,
                                referencedTable:
                                    $$SoldierPostsTableTableReferences
                                        ._guardPostTable(db),
                                referencedColumn:
                                    $$SoldierPostsTableTableReferences
                                        ._guardPostTable(db)
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

typedef $$SoldierPostsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SoldierPostsTableTable,
      SoldierPostsTableData,
      $$SoldierPostsTableTableFilterComposer,
      $$SoldierPostsTableTableOrderingComposer,
      $$SoldierPostsTableTableAnnotationComposer,
      $$SoldierPostsTableTableCreateCompanionBuilder,
      $$SoldierPostsTableTableUpdateCompanionBuilder,
      (SoldierPostsTableData, $$SoldierPostsTableTableReferences),
      SoldierPostsTableData,
      PrefetchHooks Function({bool soldier, bool guardPost})
    >;
typedef $$HolidaysTableTableCreateCompanionBuilder =
    HolidaysTableCompanion Function({required DateTime date, Value<int> rowid});
typedef $$HolidaysTableTableUpdateCompanionBuilder =
    HolidaysTableCompanion Function({Value<DateTime> date, Value<int> rowid});

class $$HolidaysTableTableFilterComposer
    extends Composer<_$AppDatabase, $HolidaysTableTable> {
  $$HolidaysTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HolidaysTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HolidaysTableTable> {
  $$HolidaysTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HolidaysTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HolidaysTableTable> {
  $$HolidaysTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$HolidaysTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HolidaysTableTable,
          HolidaysTableData,
          $$HolidaysTableTableFilterComposer,
          $$HolidaysTableTableOrderingComposer,
          $$HolidaysTableTableAnnotationComposer,
          $$HolidaysTableTableCreateCompanionBuilder,
          $$HolidaysTableTableUpdateCompanionBuilder,
          (
            HolidaysTableData,
            BaseReferences<
              _$AppDatabase,
              $HolidaysTableTable,
              HolidaysTableData
            >,
          ),
          HolidaysTableData,
          PrefetchHooks Function()
        > {
  $$HolidaysTableTableTableManager(_$AppDatabase db, $HolidaysTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HolidaysTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HolidaysTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HolidaysTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HolidaysTableCompanion(date: date, rowid: rowid),
          createCompanionCallback:
              ({
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => HolidaysTableCompanion.insert(date: date, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HolidaysTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HolidaysTableTable,
      HolidaysTableData,
      $$HolidaysTableTableFilterComposer,
      $$HolidaysTableTableOrderingComposer,
      $$HolidaysTableTableAnnotationComposer,
      $$HolidaysTableTableCreateCompanionBuilder,
      $$HolidaysTableTableUpdateCompanionBuilder,
      (
        HolidaysTableData,
        BaseReferences<_$AppDatabase, $HolidaysTableTable, HolidaysTableData>,
      ),
      HolidaysTableData,
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
  $$SoldierPostsTableTableTableManager get soldierPostsTable =>
      $$SoldierPostsTableTableTableManager(_db, _db.soldierPostsTable);
  $$HolidaysTableTableTableManager get holidaysTable =>
      $$HolidaysTableTableTableManager(_db, _db.holidaysTable);
}

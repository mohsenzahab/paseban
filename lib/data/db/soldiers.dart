import 'package:drift/drift.dart';

import '../../domain/enums.dart';
import 'app_database.dart';

class SoldiersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  IntColumn get rank => intEnum<MilitaryRank>()(); // با Converter
  DateTimeColumn get dateOfEnlistment => dateTime()();
  TextColumn get nikName => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get militaryId => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
}

extension IntEnumColumn on IntColumnBuilder {
  ColumnBuilder<int> intEnum<T extends Enum>() {
    return map(const EnumIndexConverter(MilitaryRank.values));
  }
}

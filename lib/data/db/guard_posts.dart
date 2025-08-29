import 'package:drift/drift.dart';

import '../../domain/enums.dart';
import 'converters.dart';
// import 'converters.dart';

class GuardPostsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();

  TextColumn get weekDays =>
      text().map(const WeekdayListConverter()).nullable()();
  IntColumn get repeat => integer().withDefault(const Constant(1))();
  TextColumn get monthDays => text().map(const IntListConverter()).nullable()();
  IntColumn get difficulty => intEnum<GuardPostDifficulty>()();
  IntColumn get shiftsPerDay => integer()();
}

import 'package:drift/drift.dart';

class HolidaysTable extends Table {
  DateTimeColumn get date => dateTime().unique()();
}

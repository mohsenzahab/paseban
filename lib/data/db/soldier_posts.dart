import 'package:drift/drift.dart';
import 'package:paseban/data/db/guard_posts.dart';
import 'package:paseban/data/db/soldiers.dart';

class SoldierPostsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get soldier => integer().references(
    SoldiersTable,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  IntColumn get guardPost => integer().nullable().references(
    GuardPostsTable,
    #id,
    onDelete: KeyAction.setNull,
    onUpdate: KeyAction.setNull,
  )();
  IntColumn get editType => integer().withDefault(Constant(0))();
  DateTimeColumn get date => dateTime()();

  @override
  List<Set<Column>>? get uniqueKeys => [
    {soldier, date},
  ];
}

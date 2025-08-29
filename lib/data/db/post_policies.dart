import 'package:drift/drift.dart';
import 'package:paseban/data/db/soldiers.dart';

class PostPoliciesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get soldierId => integer().nullable().references(
    SoldiersTable,
    #id,
    onDelete: KeyAction.cascade,
    onUpdate: KeyAction.cascade,
  )();
  IntColumn get priority => integer()(); // Priority index
  TextColumn get type => text()(); // نوع کلاس (مثلا Leave, FriendSoldiers)
  TextColumn get data => text()(); // داده‌های خاص هر subclass (json string)
}

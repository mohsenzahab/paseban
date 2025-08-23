import 'package:drift/drift.dart';

class PostPoliciesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get priority => integer()(); // Priority index
  TextColumn get type => text()(); // نوع کلاس (مثلا Leave, FriendSoldiers)
  TextColumn get data => text()(); // داده‌های خاص هر subclass (json string)
}

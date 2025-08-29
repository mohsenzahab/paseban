import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:paseban/data/db/soldier_posts.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../domain/enums.dart';
import '../../domain/models/weekday.dart';
import 'converters.dart' hide EnumIndexConverter;
import 'guard_posts.dart';
import 'post_policies.dart';
import 'soldiers.dart';
part 'app_database.g.dart';

typedef IntColumnBuilder = ColumnBuilder<int>;

@DriftDatabase(
  tables: [
    SoldiersTable,
    GuardPostsTable,
    PostPoliciesTable,
    SoldierPostsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
}

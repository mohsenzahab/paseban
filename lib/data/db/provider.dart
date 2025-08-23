import 'package:paseban/data/mappers/soldier_mapper.dart';

import '../../domain/models/models.dart';
import 'app_database.dart';

class DbProvider {
  static DbProvider? _instance;
  AppDatabase? _db;

  factory DbProvider() {
    return _instance ??= DbProvider._();
  }

  DbProvider._() {
    _db ??= AppDatabase();
  }

  Future<Soldier> addSoldier(Soldier soldier) async {
    // This method should insert a Soldier into the database and return the inserted Soldier.
    final id = await _db!
        .into(_db!.soldiersTable)
        .insert(soldier.toCompanion());
    return soldier.copyWith(id: id);
  }

  Future<List<Soldier>> getSoldiers() async {
    // This method should return a list of soldiers from the database.
    // Implementation will depend on the actual database schema and queries.
    final soldiers = await _db!.select(_db!.soldiersTable).get();
    return soldiers.map((e) => e.toDomain()).toList();
  }
}

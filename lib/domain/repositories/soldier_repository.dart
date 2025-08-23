import '../../data/db/app_database.dart';
import '../../data/mappers/soldier_mapper.dart';
import '../models/soldier.dart';

class SoldierRepository {
  final AppDatabase db;

  SoldierRepository(this.db);

  Future<int> insert(Soldier soldier) {
    return db.into(db.soldiersTable).insert(soldier.toCompanion());
  }

  Future<List<Soldier>> getAll() async {
    final rows = await db.select(db.soldiersTable).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<Soldier?> getById(int id) async {
    final row = await (db.select(
      db.soldiersTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<bool> updateSoldier(Soldier soldier) {
    return db.update(db.soldiersTable).replace(soldier.toCompanion());
  }

  Future<int> deleteById(int id) {
    return (db.delete(
      db.soldiersTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}

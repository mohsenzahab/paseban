import '../../data/db/app_database.dart';
import '../../data/mappers/guard_post_mapper.dart';
import '../models/guard_post.dart';

class GuardPostRepository {
  final AppDatabase db;

  GuardPostRepository(this.db);

  Future<int> insert(GuardPost post) {
    return db.into(db.guardPostsTable).insert(post.toCompanion());
  }

  Future<List<GuardPost>> getAll() async {
    final rows = await db.select(db.guardPostsTable).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<GuardPost?> getById(int id) async {
    final row = await (db.select(
      db.guardPostsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<bool> updatePost(GuardPost post) {
    return db.update(db.guardPostsTable).replace(post.toCompanion());
  }

  Future<int> deleteById(int id) {
    return (db.delete(
      db.guardPostsTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}

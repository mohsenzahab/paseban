import '../../data/db/app_database.dart';
import '../../data/mappers/post_policy_mapper.dart';
import '../models/post_policies.dart';

class PostPolicyRepository {
  final AppDatabase db;

  PostPolicyRepository(this.db);

  Future<int> insert(PostPolicy policy) {
    return db.into(db.postPoliciesTable).insert(policy.toCompanion());
  }

  Future<List<PostPolicy>> getAll() async {
    final rows = await db.select(db.postPoliciesTable).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<PostPolicy?> getById(int id) async {
    final row = await (db.select(
      db.postPoliciesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<bool> updatePolicy(PostPolicy policy) {
    return db.update(db.postPoliciesTable).replace(policy.toCompanion());
  }

  Future<int> deleteById(int id) {
    return (db.delete(
      db.postPoliciesTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}

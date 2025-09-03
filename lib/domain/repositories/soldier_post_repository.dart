import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:paseban/data/mappers/soldier_post_mapper.dart';
import 'package:paseban/domain/models/soldier_post.dart';

import '../../data/db/app_database.dart';

class SoldierPostRepository {
  final AppDatabase db;

  SoldierPostRepository(this.db);

  Future<int> insert(SoldierPost post) {
    return db
        .into(db.soldierPostsTable)
        .insert(post.toCompanion(), mode: InsertMode.replace);
  }

  Future<List<SoldierPost>> getSoldierPostsFromRange(
    DateTimeRange range,
  ) async {
    final rows = await (db.select(
      db.soldierPostsTable,
    )..where((tbl) => tbl.date.isBetweenValues(range.start, range.end))).get();
    return rows.map((e) => e.toDomain()).toList();
  }

  Future<int> delete(int soldierId, DateTime date) {
    return (db.delete(db.soldierPostsTable)..where(
          (tbl) => Expression.and([
            tbl.soldier.equals(soldierId),
            tbl.date.equals(date),
          ]),
        ))
        .go();
  }
}

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:paseban/core/utils/date_helper.dart';

import '../../data/db/app_database.dart';

class CalendarRepository {
  final AppDatabase db;

  CalendarRepository(this.db);

  Future<List<DateTime>> getHolidaysInRange(DateTimeRange range) async {
    final rows =
        await (db.select(db.holidaysTable)..where(
              (tbl) => tbl.date.isBetweenValues(
                range.start.dateOnly,
                range.end.dateOnly,
              ),
            ))
            .get();
    return rows.map((e) => e.date).toList();
  }

  Future<bool> insertHoliday(DateTime date) async {
    return (await db
            .into(db.holidaysTable)
            .insert(
              HolidaysTableCompanion.insert(date: date.dateOnly),
              mode: InsertMode.insertOrIgnore,
            )) ==
        1;
  }

  Future<bool> deleteHoliday(DateTime date) async {
    return (await (db.delete(
          db.holidaysTable,
        )..where((tbl) => tbl.date.equals(date.dateOnly))).go()) ==
        1;
  }
}

import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../../domain/models/guard_post.dart';
import '../../domain/enums.dart';

extension GuardPostToCompanion on GuardPost {
  GuardPostsTableCompanion toCompanion() {
    return GuardPostsTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      title: Value(title),
      difficulty: Value(difficulty),

      shiftsPerDay: Value(shiftsPerDay),
      monthDays: Value(monthDays),
      weekDays: Value(weekDays),
      repeat: Value(repeat),
    );
  }
}

extension GuardPostFromDb on GuardPostsTableData {
  GuardPost toDomain() {
    return GuardPost(
      id: id,
      title: title,
      difficulty: GuardPostDifficulty.values[difficulty.index],
      shiftsPerDay: shiftsPerDay,
      monthDays: monthDays,
      weekDays: weekDays,
      repeat: repeat,
    );
  }
}

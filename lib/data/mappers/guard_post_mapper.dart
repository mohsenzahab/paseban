import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../../domain/models/guard_post.dart';
import '../../domain/enums.dart';

extension GuardPostToCompanion on RawGuardPost {
  GuardPostsTableCompanion toCompanion() {
    return GuardPostsTableCompanion(
      id: Value.absentIfNull(id),
      title: Value(title),
      difficulty: Value(difficulty),
      shiftsPerDay: Value(shiftsPerDay),
      monthDays: Value.absentIfNull(monthDays),
      weekDays: Value.absentIfNull(weekDays),
      repeat: Value(periodRepeat),
      periodStartDate: Value.absentIfNull(periodStartDate),
    );
  }
}

extension GuardPostFromDb on GuardPostsTableData {
  RawGuardPost toDomain() {
    return RawGuardPost(
      id: id,
      title: title,
      difficulty: GuardPostDifficulty.values[difficulty.index],
      shiftsPerDay: shiftsPerDay,
      monthDays: monthDays,
      weekDays: weekDays,
      periodRepeat: repeat,
      periodStartDate: periodStartDate,
    );
  }
}

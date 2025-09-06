import 'package:drift/drift.dart';
import 'package:paseban/data/db/app_database.dart';
import 'package:paseban/domain/enums.dart';

import '../../domain/models/soldier_post.dart';

extension SoldierPostToCompanion on SoldierPost {
  SoldierPostsTableCompanion toCompanion() {
    return SoldierPostsTableCompanion(
      id: Value.absentIfNull(id),
      date: Value(date),
      guardPost: Value(guardPostId),
      soldier: Value(soldierId),
      editType: Value(editType.index),
    );
  }
}

extension SoldierPostFromDb on SoldierPostsTableData {
  SoldierPost toDomain() {
    return SoldierPost(
      id: id,
      soldierId: soldier,
      guardPostId: guardPost,
      date: date,
      editType: EditType.values[editType],
    );
  }
}

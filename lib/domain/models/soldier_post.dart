import '../enums.dart';

/// A soldier's post in a specific date.
///
/// This class holds the information about a soldier's post in a specific date.
/// It contains the soldier's id, the post's id, the date of the post, and the
/// type of the edit.
///
/// The type of the edit can be either [EditType.manual] or [EditType.auto].
/// The [EditType.manual] means that the post was edited manually by the user,
/// and the [EditType.auto] means that the post was edited automatically by the
/// system (or the algorithm).
class SoldierPost {
  /// The id of the soldier post.
  final int? id;

  /// The id of the soldier.
  final int soldierId;

  /// The id of the guard post.
  final int? guardPostId;

  /// The date of the post.
  final DateTime date;

  /// The type of the edit.
  final EditType editType;

  /// Creates a [SoldierPost] object with the given parameters.
  ///
  /// The [id] parameter is optional and defaults to `null`.
  /// The [soldierId] parameter is required.
  /// The [guardPostId] parameter is required.
  /// The [date] parameter is required.
  /// The [editType] parameter is optional and defaults to [EditType.manual].
  SoldierPost({
    this.id,
    required this.soldierId,
    required this.guardPostId,
    required this.date,
    this.editType = EditType.manual,
  });

  /// Returns a string representation of this object.
  @override
  String toString() {
    return 'SoldierPost(soldierId: $soldierId, guardPostId: $guardPostId, date: $date, editType: $editType)';
  }
}

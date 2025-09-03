import 'package:paseban/domain/models/models.dart';

class SoldierPost {
  final int soldierId;
  final int? guardPostId;
  final DateTime date;
  final EditType editType;

  SoldierPost({
    required this.soldierId,
    required this.guardPostId,
    required this.date,
    this.editType = EditType.manual,
  });

  @override
  String toString() {
    return 'SoldierPost(soldierId: $soldierId, guardPostId: $guardPostId, date: $date, editType: $editType)';
  }
}

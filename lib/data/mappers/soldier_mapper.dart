import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../../domain/models/soldier.dart';
import '../../domain/enums.dart';

extension SoldierToCompanion on Soldier {
  SoldiersTableCompanion toCompanion() {
    return SoldiersTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      firstName: Value(firstName),
      lastName: Value(lastName),
      rank: Value(rank),
      dateOfEnlistment: Value(dateOfEnlistment),
      nikName: nikName == null ? const Value.absent() : Value(nikName!),
      imageUrl: imageUrl == null ? const Value.absent() : Value(imageUrl!),
      militaryId: militaryId == null
          ? const Value.absent()
          : Value(militaryId!),
      phoneNumber: phoneNumber == null
          ? const Value.absent()
          : Value(phoneNumber!),
      dateOfBirth: dateOfBirth == null
          ? const Value.absent()
          : Value(dateOfBirth!),
    );
  }
}

extension SoldierFromDb on SoldiersTableData {
  Soldier toDomain() {
    return Soldier(
      id: id,
      firstName: firstName,
      lastName: lastName,
      rank: MilitaryRank.values[rank.index],
      dateOfEnlistment: dateOfEnlistment,
      nikName: nikName,
      imageUrl: imageUrl,
      militaryId: militaryId,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );
  }
}

import 'dart:convert';

import '../enums.dart';

class Soldier {
  /// Unique database identifier of the soldier
  final int? id;

  /// First name of the soldier
  final String firstName;

  /// Last name of the soldier
  final String lastName;

  /// Rank of the soldier
  final MilitaryRank rank;

  /// Date of enlistment of the soldier
  final DateTime dateOfEnlistment;

  /// Nick name of the soldier
  final String? nikName;

  /// Image url of the soldier
  final String? imageUrl;

  /// Military id of the soldier
  final String? militaryId;

  /// Phone number of the soldier
  final String? phoneNumber;

  /// Date of birth of the soldier
  final DateTime? dateOfBirth;

  /// Constructs a new soldier with given parameters
  Soldier({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.rank,
    required this.dateOfEnlistment,
    this.nikName,
    this.imageUrl,
    this.militaryId,
    this.phoneNumber,
    this.dateOfBirth,
  });

  Soldier copyWith({
    int? id,
    String? firstName,
    String? lastName,
    MilitaryRank? rank,
    DateTime? dateOfEnlistment,
    String? nikName,
    String? imageUrl,
    String? militaryId,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return Soldier(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rank: rank ?? this.rank,
      dateOfEnlistment: dateOfEnlistment ?? this.dateOfEnlistment,
      nikName: nikName ?? this.nikName,
      imageUrl: imageUrl ?? this.imageUrl,
      militaryId: militaryId ?? this.militaryId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  ConscriptionStage get conscriptionStage {
    final months = DateTime.now().difference(dateOfEnlistment).inDays ~/ 30;
    return ConscriptionStage.fromMonths(months);
  }

  ConscriptionStage getConscriptionStage(DateTime currentDate) {
    final months = (currentDate.difference(dateOfEnlistment).inDays / 30)
        .floor();
    return ConscriptionStage.fromMonths(months);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'rank': rank.index});
    result.addAll({
      'dateOfEnlistment': dateOfEnlistment.millisecondsSinceEpoch,
    });
    if (nikName != null) {
      result.addAll({'nikName': nikName});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    if (militaryId != null) {
      result.addAll({'militaryId': militaryId});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (dateOfBirth != null) {
      result.addAll({'dateOfBirth': dateOfBirth!.millisecondsSinceEpoch});
    }

    return result;
  }

  Map<String, dynamic> toFormValues() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'rank': rank.index});
    result.addAll({'dateOfEnlistment': dateOfEnlistment});
    result.addAll({'nikName': nikName});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'militaryId': militaryId});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'dateOfBirth': dateOfBirth});

    return result;
  }

  factory Soldier.fromMap(Map<String, dynamic> map) {
    return Soldier(
      id: map['id']?.toInt(),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      rank: MilitaryRank.values[map['rank']],
      dateOfEnlistment: DateTime.parse(map['dateOfEnlistment']),
      nikName: map['nikName'],
      imageUrl: map['imageUrl'],
      militaryId: map['militaryId'],
      phoneNumber: map['phoneNumber'],
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Soldier.fromJson(String source) =>
      Soldier.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Soldier(id: $id, firstName: $firstName, lastName: $lastName, rank: $rank, dateOfEnlistment: $dateOfEnlistment, nikName: $nikName, imageUrl: $imageUrl, militaryId: $militaryId, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Soldier &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.rank == rank &&
        other.dateOfEnlistment == dateOfEnlistment &&
        other.nikName == nikName &&
        other.imageUrl == imageUrl &&
        other.militaryId == militaryId &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        rank.hashCode ^
        dateOfEnlistment.hashCode ^
        nikName.hashCode ^
        imageUrl.hashCode ^
        militaryId.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode;
  }
}

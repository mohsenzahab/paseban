import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show DateTimeRange;
import '../../domain/models/post_policies.dart';
import '../../domain/models/weekday.dart';
import '../db/app_database.dart';
import '../../domain/enums.dart';

extension PostPolicyToCompanion on PostPolicy {
  PostPoliciesTableCompanion toCompanion() {
    Map<String, dynamic>? map;

    switch (this) {
      case Leave(:final value):
        map = {
          'start': value.start.toIso8601String(),
          'end': value.end.toIso8601String(),
        };
        break;

      case FriendSoldiers(:final value):
        map = {'ids': value};
        break;

      case WeekOffDays(:final value):
        map = {'days': value.map((e) => e.index).toList()};
        break;

      case NoNightNNight(:final value):
        map = {'count': value};
        break;

      case MinPostCount(:final value, :final stagePriority):
        map = {
          'value': value,
          'stagePriority': stagePriority?.map(
            (k, v) => MapEntry('${k.index}', v),
          ),
        };
        break;

      case MaxPostCount(:final value, :final stagePriority):
        map = {
          'value': value,
          'stagePriority': stagePriority?.map(
            (k, v) => MapEntry('${k.index}', v),
          ),
        };
        break;

      case NoWeekendPerMonth(:final value, :final stagePriority):
        map = {
          'value': value,
          'stagePriority': stagePriority?.map(
            (k, v) => MapEntry('${k.index}', v),
          ),
        };
        break;

      case EqualHolidayPost(:final stagePriority):
        map = {
          'stagePriority': stagePriority?.map(
            (k, v) => MapEntry('${k.index}', v),
          ),
        };
        break;

      case EqualPostDifficulty(:final stagePriority):
        map = {
          'stagePriority': stagePriority?.map(
            (k, v) => MapEntry('${k.index}', v.index),
          ),
        };
        break;

      default:
        map = null;
    }
    ;
    return PostPoliciesTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      priority: Value(priority.index),
      type: Value(runtimeType.toString()),
      data: Value.absentIfNull(map == null ? null : jsonEncode(map)),
    );
  }
}

extension PostPolicyFromDb on PostPoliciesTableData {
  PostPolicy toDomain() {
    final Map<String, dynamic> map = jsonDecode(data);

    switch (type) {
      case 'Leave':
        return Leave(
          id: id,
          value: DateTimeRange(
            start: DateTime.parse(map['start']),
            end: DateTime.parse(map['end']),
          ),
          priority: Priority.values[priority],
        );

      case 'FriendSoldiers':
        return FriendSoldiers(
          id: id,
          value: List<int>.from(map['ids']),
          priority: Priority.values[priority],
        );

      case 'WeekOffDays':
        return WeekOffDays(
          id: id,
          value: (map['days'] as List)
              .map((e) => Weekday.values[e as int])
              .toList(),
          priority: Priority.values[priority],
        );

      case 'NoNightNNight':
        return NoNightNNight(
          id: id,
          value: map['count'],
          priority: Priority.values[priority],
        );

      case 'NoNight1Night':
        return NoNight1Night(id: id, priority: Priority.values[priority]);

      case 'NoNight2Night':
        return NoNight2Night(id: id, priority: Priority.values[priority]);

      case 'MinPostCount':
        return MinPostCount(
          id: id,
          value: map['value'],
          priority: Priority.values[priority],
          stagePriority: (map['stagePriority'] as Map<String, dynamic>?)?.map(
            (k, v) =>
                MapEntry(ConscriptionStage.values[int.parse(k)], v as int),
          ),
        );

      case 'MaxPostCount':
        return MaxPostCount(
          id: id,
          value: map['value'],
          priority: Priority.values[priority],
          stagePriority: (map['stagePriority'] as Map<String, dynamic>?)?.map(
            (k, v) =>
                MapEntry(ConscriptionStage.values[int.parse(k)], v as int),
          ),
        );

      case 'NoWeekendPerMonth':
        return NoWeekendPerMonth(
          id: id,
          value: map['value'],
          priority: Priority.values[priority],
          stagePriority: (map['stagePriority'] as Map<String, dynamic>?)?.map(
            (k, v) =>
                MapEntry(ConscriptionStage.values[int.parse(k)], v as int),
          ),
        );

      case 'EqualHolidayPost':
        return EqualHolidayPost(
          id: id,
          priority: Priority.values[priority],
          stagePriority: (map['stagePriority'] as Map<String, dynamic>?)?.map(
            (k, v) =>
                MapEntry(ConscriptionStage.values[int.parse(k)], v as int),
          ),
        );

      case 'EqualPostDifficulty':
        return EqualPostDifficulty(
          id: id,
          priority: Priority.values[priority],
          stagePriority: (map['stagePriority'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(
              ConscriptionStage.values[int.parse(k)],
              GuardPostDifficulty.values[v as int],
            ),
          ),
        );

      default:
        throw Exception("Unknown PostPolicy type: $type");
    }
  }
}

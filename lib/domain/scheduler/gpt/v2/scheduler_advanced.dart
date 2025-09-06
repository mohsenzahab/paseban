import 'package:flutter/material.dart';
import 'package:paseban/domain/models/models.dart';

import '../../../enums.dart';
import 'constraints.dart';

class AdvancedScheduler {
  final Map<int, RawGuardPost> guardPosts;
  final Map<int, Soldier> soldiers;
  final List<Constraint> constraints;
  final DateTimeRange dateRange;

  AdvancedScheduler({
    required this.guardPosts,
    required this.soldiers,
    required this.constraints,
    required this.dateRange,
  });

  /// خروجی: Map<soldierId, List<SoldierPost>>
  Map<int, List<SoldierPost>> generateSchedule() {
    final schedule = <int, List<SoldierPost>>{};
    for (final s in soldiers.keys) {
      schedule[s] = [];
    }

    for (
      var date = dateRange.start;
      !date.isAfter(dateRange.end);
      date = date.add(const Duration(days: 1))
    ) {
      for (final entry in guardPosts.entries) {
        final post = entry.value;

        if (!post.includesDate(date)) continue;

        for (int shift = 0; shift < post.shiftsPerDay; shift++) {
          final soldierId = _chooseSoldier(date, post, schedule);
          if (soldierId == null) continue;

          final soldierPost = SoldierPost(
            soldierId: soldierId,
            guardPostId: post.id,
            date: date,
            editType: EditType.auto,
          );

          schedule[soldierId]!.add(soldierPost);
        }
      }
    }
    return schedule;
  }

  int? _chooseSoldier(
    DateTime date,
    RawGuardPost post,
    Map<int, List<SoldierPost>> schedule,
  ) {
    int? bestSoldier;
    int bestScore = -999999;

    for (final soldier in soldiers.values) {
      final candidate = SoldierPost(
        soldierId: soldier.id!,
        guardPostId: post.id,
        date: date,
        editType: EditType.auto,
      );

      bool valid = true;
      int score = 0;

      for (final c in constraints) {
        final ok = c.isSatisfied(candidate, schedule);
        if (!ok && c.isHard) {
          valid = false;
          break;
        }
        if (ok && !c.isHard) score += c.weight;
      }

      if (valid && score > bestScore) {
        bestScore = score;
        bestSoldier = soldier.id;
      }
    }

    return bestSoldier;
  }
}

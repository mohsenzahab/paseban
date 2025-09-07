import 'dart:math';
import 'package:flutter/material.dart' show DateTimeRange, DateUtils;
import 'package:paseban/domain/models/models.dart';
import 'package:collection/collection.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../enums.dart';
//endregion Mock Models and Enums

/// Represents a single available guard slot (a specific post on a specific day).
class _GuardSlot {
  final DateTime date;
  final RawGuardPost post;
  _GuardSlot(this.date, this.post);
}

/// Main class to handle the scheduling algorithm.
class GuardScheduler {
  final Map<int, Soldier> soldiers;
  final Map<int, RawGuardPost> guardPosts;
  final List<PostPolicy> publicPolicies;
  final Map<int, List<PostPolicy>> soldierPolicies;
  final Set<DateTime> holidays;
  final DateTimeRange dateRange;
  final int optimizationIterations;
  final Map<int, Map<DateTime, SoldierPost>> initialSchedule;

  // Internal state
  late Map<int, Map<DateTime, SoldierPost>> _schedule;
  late List<_GuardSlot> _availableSlots;
  late Map<int, List<PostPolicy>> _allSoldierPolicies;
  late Map<int, Set<DateTime>> _leaveDays;

  GuardScheduler({
    required this.initialSchedule,
    required this.soldiers,
    required this.guardPosts,
    required this.publicPolicies,
    required this.soldierPolicies,
    required this.holidays,
    required this.dateRange,
    this.optimizationIterations = 5000,

    // Number of optimization swaps to try
  });

  /// Generates the guard schedule.
  Future<Map<int, Map<DateTime, SoldierPost>>> generate() async {
    print("🚀 Starting schedule generation...");
    _phase1_preprocessData();
    _phase2_initialAllocation();
    _phase3_optimizeSchedule();
    print("✅ Schedule generation finished!");
    return _schedule;
  }

  // =========================================================================
  // PHASE 1: PREPROCESSING
  // =========================================================================
  void _phase1_preprocessData() {
    print("  PHASE 1: Preprocessing data...");
    _schedule = {for (var s in soldiers.keys) s: {}};
    _allSoldierPolicies = {};
    _leaveDays = {};

    initialSchedule.forEach((soldierId, posts) {
      posts.forEach((date, post) {
        if (post.editType == EditType.manual) {
          // _manualPosts.add(post);
          _schedule[soldierId]![date] = post;
        }
      });
    });

    // Combine public and specific policies for easy access
    for (final soldierId in soldiers.keys) {
      _allSoldierPolicies[soldierId] = [
        ...publicPolicies,
        ...(soldierPolicies[soldierId] ?? []),
      ];
      _leaveDays[soldierId] = {};
    }

    // Identify and store leave days for fast lookup
    for (final soldierId in soldiers.keys) {
      final leavePolicies = _allSoldierPolicies[soldierId]!.whereType<Leave>();
      for (final policy in leavePolicies) {
        for (int i = 0; i <= policy.value.duration.inDays; i++) {
          final day = DateUtils.dateOnly(
            policy.value.start.add(Duration(days: i)),
          );
          _leaveDays[soldierId]!.add(day);
        }
      }
    }

    // Create a flat list of all available guard slots
    _availableSlots = [];
    for (int i = 0; i <= dateRange.duration.inDays; i++) {
      final date = dateRange.start.add(Duration(days: i));
      for (final post in guardPosts.values) {
        if (post.includesDate(date)) {
          for (int j = 0; j < post.shiftsPerDay; j++) {
            _availableSlots.add(_GuardSlot(date, post));
          }
        }
      }
    }
    print("    - Found ${_availableSlots.length} available guard slots.");
    print("    - Processed policies for ${soldiers.length} soldiers.");
  }

  // =========================================================================
  // PHASE 2: INITIAL GREEDY ALLOCATION
  // =========================================================================
  void _phase2_initialAllocation() {
    print("  PHASE 2: Creating initial schedule (Greedy Allocation)...");

    o:
    for (final slot in _availableSlots) {
      double bestScore = double.infinity;
      int? bestSoldierId;
      final dateOnly = DateUtils.dateOnly(slot.date);
      bool isManuallyEdited = false;

      // Find all available soldiers for this slot
      final candidateIds = soldiers.keys.where((id) {
        isManuallyEdited =
            _schedule[id]?[dateOnly]?.editType == EditType.manual;
        if (isManuallyEdited) return false;
        final isOnLeave = _leaveDays[id]?.contains(dateOnly) ?? false;
        final isAlreadyPosted = _schedule[id]?.containsKey(dateOnly) ?? false;

        return !isOnLeave && !isAlreadyPosted;
      });

      if (isManuallyEdited) {
        print(
          "    - Skipping ${slot.post.title} on ${slot.date} (manually edited)",
        );
        continue;
      }

      if (candidateIds.isEmpty) {
        print(
          "    - WARNING: No available soldier for post ${slot.post.title} on ${slot.date}",
        );
        continue;
      }

      // Find the best soldier based on the cost function
      for (final soldierId in candidateIds) {
        final score = _calculateCost(
          soldiers[soldierId]!,
          slot.post,
          slot.date,
        );
        if (score < bestScore) {
          bestScore = score;
          bestSoldierId = soldierId;
        }
      }

      // Assign the best soldier to the schedule
      if (bestSoldierId != null) {
        final dateOnly = DateUtils.dateOnly(slot.date);
        _schedule[bestSoldierId]![dateOnly] = SoldierPost(
          soldierId: bestSoldierId,
          guardPostId: slot.post.id,
          date: dateOnly,
          editType: EditType.auto,
        );
      }
    }
  }

  /// The heart of the algorithm: calculates the cost of an assignment.
  /// Lower cost is better. Infinity means it's a hard violation.
  double _calculateCost(Soldier soldier, RawGuardPost post, DateTime date) {
    double totalCost = 0.0;
    final policies = _allSoldierPolicies[soldier.id] ?? [];

    // --- Base cost based on Seniority and Difficulty ---
    // More senior soldiers should have a higher cost for harder posts.
    // This is a core principle for fairness.
    final stage = soldier.getConscriptionStage(date);
    // Cost increases with seniority (stage.index) and post difficulty (difficulty.index).
    totalCost += (stage.index * post.difficulty.index * 5);

    // --- Evaluate all policies ---
    for (final policy in policies) {
      double policyCost = 0;
      switch (policy) {
        // --- موارد تکمیل شده قبلی ---
        case Leave p:
          // A date without time part for accurate comparison
          final currentDate = DateTime(date.year, date.month, date.day);
          if (!currentDate.isBefore(p.value.start) &&
              !currentDate.isAfter(p.value.end)) {
            policyCost = double.infinity; // Absolute constraint
          }
          break;
        case NoNightNNight p:
          for (int i = 1; i <= p.value; i++) {
            final prevDate = date.subtract(Duration(days: i));
            if (_schedule[soldier.id]!.containsKey(prevDate)) {
              // The closer the post, the higher the cost.
              policyCost = 1000.0 / i;
              break;
            }
          }
          break;
        case MaxPostCountPerMonth p:
          final startOfMonth = date.monthStartDate(CalendarMode.jalali);
          final endOfMonth = date.monthEndDate(CalendarMode.jalali);
          final count = _schedule[soldier.id]!.keys
              .where((d) => !d.isBefore(startOfMonth) && !d.isAfter(endOfMonth))
              .length;

          int maxPosts = p.value;
          if (p.stagePriority != null && p.stagePriority!.containsKey(stage)) {
            maxPosts = p.stagePriority![stage]!;
          }

          if (count >= maxPosts) {
            policyCost = 500; // High cost for exceeding the limit
          }
          break;

        // =======================================================
        // --- موارد جدید که تکمیل شدند ---
        // =======================================================

        case FriendSoldiers p:
          // **منطق:** اگر یکی از دوستان سرباز در همان روز پست داشته باشد، یک امتیاز (هزینه منفی) می‌گیرد.
          bool friendOnDuty = false;
          for (final friendId in p.value) {
            if (_schedule.containsKey(friendId) &&
                _schedule[friendId]!.containsKey(date)) {
              friendOnDuty = true;
              break;
            }
          }
          if (friendOnDuty) {
            policyCost = -50; // امتیاز برای نگهبانی با دوست
          }
          break;

        case WeekOffDays p:
          // **منطق:** اگر روز نگهبانی جزو روزهای استراحت درخواستی سرباز باشد، هزینه بالایی دارد.
          final currentWeekday = Weekday.fromValue(date.weekday);
          if (p.value.contains(currentWeekday)) {
            policyCost = 750; // هزینه بالا برای گرفتن روز استراحت
          }
          break;

        case EqualHolidayPost p:
          // **منطق:** هزینه نگهبانی در روز تعطیل برای سربازی که بیشتر از میانگین، پست تعطیل داشته، بالاتر است.
          final normalizedDate = date.dateOnly;
          if (holidays.contains(normalizedDate)) {
            double totalHolidayPosts = 0;
            _schedule.forEach((sId, posts) {
              totalHolidayPosts += posts.keys
                  .where(
                    (d) => holidays.contains(DateTime(d.year, d.month, d.day)),
                  )
                  .length;
            });
            final avgHolidayPosts = totalHolidayPosts / soldiers.length;
            final soldierHolidayPosts = _schedule[soldier.id]!.keys
                .where(
                  (d) => holidays.contains(DateTime(d.year, d.month, d.day)),
                )
                .length;

            if (soldierHolidayPosts > avgHolidayPosts) {
              // هرچه از میانگین بالاتر باشد، هزینه بیشتر می‌شود.
              policyCost = (soldierHolidayPosts - avgHolidayPosts) * 150;
            } else {
              policyCost = 50; // هزینه پایه برای گرفتن پست تعطیل
            }
          }
          break;

        case EqualPostDifficulty p:
          // **منطق:** هزینه پست سخت برای سربازی که مجموع سختی پست‌هایش از میانگین بالاتر است، بیشتر می‌شود.
          double totalDifficultyScore = 0;
          _schedule.forEach((sId, posts) {
            posts.forEach((d, p) {
              totalDifficultyScore +=
                  (guardPosts[p.guardPostId]?.difficulty.index ?? 0);
            });
          });
          final avgDifficulty = totalDifficultyScore / soldiers.length;
          final soldierDifficulty = _schedule[soldier.id]!.values.fold<double>(
            0,
            (sum, p) =>
                sum + (guardPosts[p.guardPostId]?.difficulty.index ?? 0),
          );

          final projectedDifficulty = soldierDifficulty + post.difficulty.index;
          if (projectedDifficulty > avgDifficulty) {
            policyCost = (projectedDifficulty - avgDifficulty) * 500;
          }
          break;

        case MinPostCountPerMonth p:
          // **منطق:** اگر سرباز در رسیدن به حداقل پست ماهانه عقب باشد، امتیاز (هزینه منفی) می‌گیرد تا انتخاب شود.
          final startOfMonth = date.monthStartDate(CalendarMode.jalali);
          final endOfMonth = date.monthEndDate(CalendarMode.jalali);
          final daysInMonth = endOfMonth.day;

          int minPosts = p.value;
          if (p.stagePriority != null && p.stagePriority!.containsKey(stage)) {
            minPosts = p.stagePriority![stage]!;
          }

          final currentPostCount = _schedule[soldier.id]!.keys
              .where((d) => !d.isBefore(startOfMonth) && !d.isAfter(endOfMonth))
              .length;

          if (currentPostCount < minPosts) {
            final postsNeeded = minPosts - currentPostCount;
            final daysRemaining = daysInMonth - date.day + 1;
            if (daysRemaining > 0) {
              // ضریب "فوریت": هر چه به پایان ماه نزدیک‌تر شویم و تعداد پست‌های مورد نیاز بیشتر باشد، این ضریب بزرگتر می‌شود.
              final urgency = postsNeeded / daysRemaining;
              policyCost = -urgency * 100; // امتیاز منفی برای تشویق به انتخاب
            }
          }
          break;

        case NoWeekendPerMonth p:
          // **منطق:** اگر سرباز به سقف نگهبانی آخر هفته خود رسیده باشد، هزینه بسیار بالایی برای پست جدید آخر هفته اعمال می‌شود.
          // فرض می‌کنیم جمعه (Weekday.friday) روز آخر هفته است.
          final isWeekend = (Weekday.fromValue(date.weekday) == Weekday.friday);
          if (isWeekend) {
            final startOfMonth = date.monthStartDate(CalendarMode.jalali);
            final weekendPostCount = _schedule[soldier.id]!.keys.where((d) {
              return !d.isBefore(startOfMonth) &&
                  Weekday.fromValue(d.weekday) == Weekday.friday;
            }).length;

            int maxWeekendPosts =
                p.value; // فرض می‌کنیم value حداکثر تعداد مجاز است.
            if (p.stagePriority != null &&
                p.stagePriority!.containsKey(stage)) {
              maxWeekendPosts = p.stagePriority![stage]!;
            }

            if (weekendPostCount >= maxWeekendPosts) {
              policyCost = 800; // هزینه بسیار بالا برای پست آخر هفته اضافی
            } else {
              policyCost =
                  150; // هزینه پایه برای گرفتن پست آخر هفته (چون ارزشمند است)
            }
          }
          break;
      }

      if (policyCost == double.infinity) return double.infinity;

      // Weight the cost by the policy priority.
      totalCost += policyCost * (policy.priority.index + 1);
    }

    return totalCost;
  }

  double _calculateAssignmentCost(
    Soldier soldier,
    RawGuardPost post,
    DateTime date,
  ) {
    double cost = 0.0;
    final policies = _allSoldierPolicies[soldier.id]!;
    final dateOnly = DateUtils.dateOnly(date);

    // 1. Base cost on conscription stage (senior soldiers are more "expensive")
    cost += soldier.conscriptionStage.index * 10.0;

    // 2. Base cost on post difficulty (harder posts are more "expensive")
    cost += post.difficulty.index * 5.0;

    for (final policy in policies) {
      final priorityMultiplier = pow(5, policy.priority.index);

      switch (policy) {
        case NoNightNNight p:
          for (int i = 1; i <= p.value; i++) {
            final prevDate = dateOnly.subtract(Duration(days: i));
            if (_schedule[soldier.id]!.containsKey(prevDate)) {
              cost += 10000.0 * priorityMultiplier; // Very high penalty
            }
          }
          break;
        case MaxPostCountPerMonth p:
          final postsThisMonth = _schedule[soldier.id]!.values
              .where((sp) => sp.date.month == date.month)
              .length;
          if (postsThisMonth >= p.value) {
            cost += 500.0 * priorityMultiplier; // High penalty
          }
          break;
        case WeekOffDays p:
          final weekday = Weekday.values.firstWhere(
            (w) => w.value == date.weekday,
          );
          if (p.value.contains(weekday)) {
            cost += 200.0 * priorityMultiplier; // Medium penalty
          }
          break;
        // Other policies like EqualDifficulty, EqualHolidayPost etc. can be added here
        // For simplicity, they are better handled in the total cost function for optimization
        default:
          break;
      }
    }
    return cost;
  }

  // =========================================================================
  // PHASE 3: OPTIMIZATION
  // =========================================================================
  void _phase3_optimizeSchedule() {
    print("  PHASE 3: Optimizing schedule via random swaps...");
    final random = Random();
    double currentTotalCost = _calculateTotalScheduleCost();
    print("    - Initial total schedule cost: $currentTotalCost");

    // Get a list of all assigned posts
    final allAssignments = _schedule.entries
        .expand(
          (e) => e.value.entries.map(
            (v) => SoldierPost(
              soldierId: e.key,
              guardPostId: v.value.guardPostId,
              date: v.key,
              editType: v.value.editType,
            ),
          ),
        )
        .toList();

    if (allAssignments.length < 2) {
      print("    - Not enough assignments to optimize. Skipping.");
      return;
    }

    for (int i = 0; i < optimizationIterations; i++) {
      // Pick two different random assignments to try swapping
      final indexA = random.nextInt(allAssignments.length);
      int indexB;
      do {
        indexB = random.nextInt(allAssignments.length);
      } while (indexA == indexB);

      final assignmentA = allAssignments[indexA];
      final assignmentB = allAssignments[indexB];

      // Simple swap: soldierA does soldierB's post, and vice versa.
      // This only works if their posts were on different days.
      if (assignmentA.date == assignmentB.date ||
          assignmentA.editType == EditType.manual ||
          assignmentB.editType == EditType.manual) {
        continue;
      }

      // Create a temporary schedule with the swap
      var tempSchedule = _copySchedule(_schedule);

      // Remove old posts
      tempSchedule[assignmentA.soldierId]!.remove(assignmentA.date);
      tempSchedule[assignmentB.soldierId]!.remove(assignmentB.date);

      // Add swapped posts
      tempSchedule[assignmentA.soldierId]![assignmentB.date] = SoldierPost(
        soldierId: assignmentA.soldierId,
        guardPostId: assignmentB.guardPostId,
        date: assignmentB.date,
        editType: assignmentB.editType,
      );
      tempSchedule[assignmentB.soldierId]![assignmentA.date] = SoldierPost(
        soldierId: assignmentB.soldierId,
        guardPostId: assignmentA.guardPostId,
        date: assignmentA.date,
        editType: assignmentA.editType,
      );

      // Check if the swap is valid (e.g., doesn't violate leave)
      final isAOnLeave =
          _leaveDays[assignmentA.soldierId]?.contains(assignmentB.date) ??
          false;
      final isBOnLeave =
          _leaveDays[assignmentB.soldierId]?.contains(assignmentA.date) ??
          false;
      if (isAOnLeave || isBOnLeave) continue;

      double newTotalCost = _calculateTotalScheduleCost(schedule: tempSchedule);

      if (newTotalCost < currentTotalCost) {
        _schedule = tempSchedule;
        currentTotalCost = newTotalCost;
        // Update the list of assignments for next iterations
        allAssignments[indexA] = SoldierPost(
          soldierId: assignmentA.soldierId,
          guardPostId: assignmentB.guardPostId,
          date: assignmentB.date,
          editType: assignmentB.editType,
        );
        allAssignments[indexB] = SoldierPost(
          soldierId: assignmentB.soldierId,
          guardPostId: assignmentA.guardPostId,
          date: assignmentA.date,
          editType: assignmentA.editType,
        );
      }
    }
    print("    - Final optimized schedule cost: $currentTotalCost");
  }

  /// Calculates the total "cost" or "badness" of the entire schedule.
  /// A lower score is better. Used by the optimization phase.
  double _calculateTotalScheduleCost({
    Map<int, Map<DateTime, SoldierPost>>? schedule,
  }) {
    final s = schedule ?? _schedule;
    double totalCost = 0;

    for (final soldierId in s.keys) {
      final soldier = soldiers[soldierId]!;
      final soldierPosts = s[soldierId]!.values.toList()..sortBy((p) => p.date);
      final policies = _allSoldierPolicies[soldierId]!;

      // Check policy violations for this soldier
      for (final policy in policies) {
        final priorityMultiplier = pow(5, policy.priority.index);
        switch (policy) {
          case NoNightNNight p:
            for (int i = 0; i < soldierPosts.length - 1; i++) {
              final post1 = soldierPosts[i];
              final post2 = soldierPosts[i + 1];
              if (post2.date.difference(post1.date).inDays <= p.value) {
                totalCost += 1000.0 * priorityMultiplier;
              }
            }
            break;
          case MaxPostCountPerMonth p:
            final postsByMonth = groupBy(soldierPosts, (p) => p.date.month);
            for (final count in postsByMonth.values.map(
              (list) => list.length,
            )) {
              if (count > p.value) {
                totalCost += (count - p.value) * 200.0 * priorityMultiplier;
              }
            }
            break;
          // Add more complex "fairness" policies here
          default:
            break;
        }
      }
    }
    return totalCost;
  }

  Map<int, Map<DateTime, SoldierPost>> _copySchedule(
    Map<int, Map<DateTime, SoldierPost>> original,
  ) {
    final newMap = <int, Map<DateTime, SoldierPost>>{};
    for (var entry in original.entries) {
      newMap[entry.key] = Map<DateTime, SoldierPost>.from(entry.value);
    }
    return newMap;
  }
}

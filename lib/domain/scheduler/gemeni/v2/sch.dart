import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/domain/models/models.dart';

import '../../../enums.dart';

// ... other policy classes would be defined here similarly
//endregion

// ===========================================================================
// Core Scheduling Algorithm
// ===========================================================================

/// A helper class to hold a potential assignment and its calculated cost.
class _AssignmentCandidate {
  final int soldierId;
  final double cost;

  _AssignmentCandidate(this.soldierId, this.cost);
}

/// The main class that orchestrates the scheduling process.
class GuardScheduler {
  // --- Inputs ---
  final Map<int, Soldier> soldiers;
  final Map<int, RawGuardPost> guardPosts;
  late final Map<int, List<PostPolicy>> allPolicies;
  final DateTimeRange dateRange;
  final Set<DateTime> holidays;

  // --- State ---
  /// The schedule being built. Key is soldierId, value is a map of dates to their posts.
  late Map<int, Map<DateTime, SoldierPost>> _schedule;
  final Set<SoldierPost> _manualPosts;

  GuardScheduler({
    required this.soldiers,
    required this.guardPosts,
    required List<PostPolicy> publicPolicies,
    required Map<int, List<PostPolicy>> soldierPolicies,
    required Map<int, Map<DateTime, SoldierPost>> initialSchedule,
    required this.dateRange,
    required this.holidays,
  }) : _manualPosts = {} {
    // Combine public and soldier-specific policies for easy access.
    allPolicies = {for (var s in soldiers.keys) s: []};
    for (var policy in publicPolicies) {
      for (var soldierId in soldiers.keys) {
        allPolicies[soldierId]!.add(policy);
      }
    }
    soldierPolicies.forEach((soldierId, policies) {
      allPolicies[soldierId]!.addAll(policies);
    });

    // Initialize the schedule and separate manual posts.
    _schedule = Map.fromEntries(soldiers.keys.map((id) => MapEntry(id, {})));
    initialSchedule.forEach((soldierId, posts) {
      posts.forEach((date, post) {
        if (post.editType == EditType.manual) {
          _manualPosts.add(post);
        }
        _schedule[soldierId]![date] = post;
      });
    });
  }

  /// Public method to start the scheduling process.
  Map<int, Map<DateTime, SoldierPost>>? generate() {
    bool success = _solve(dateRange.start);
    if (success) {
      return _schedule;
    } else {
      // Could not find a valid schedule
      return null;
    }
  }

  /// The recursive backtracking function.
  bool _solve(DateTime currentDate) {
    // Base case: If we've passed the end date, we've found a solution.
    if (currentDate.isAfter(dateRange.end)) {
      return true;
    }

    // Get all guard slots that need to be filled for the current day.
    final slotsToFill = <RawGuardPost>[];
    for (var post in guardPosts.values) {
      if (post.includesDate(currentDate)) {
        for (int i = 0; i < post.shiftsPerDay; i++) {
          slotsToFill.add(post);
        }
      }
    }

    // If there are no slots to fill, move to the next day.
    if (slotsToFill.isEmpty) {
      return _solve(currentDate.add(const Duration(days: 1)));
    }

    return _fillSlotsForDay(currentDate, slotsToFill, 0);
  }

  bool _fillSlotsForDay(
    DateTime date,
    List<RawGuardPost> slots,
    int slotIndex,
  ) {
    // Base case for the day: all slots for today are filled, move to the next day.
    if (slotIndex >= slots.length) {
      return _solve(date.add(const Duration(days: 1)));
    }

    final currentPost = slots[slotIndex];
    final alreadyAssignedToday = _schedule.values
        .where((posts) => posts.containsKey(date))
        .map((posts) => posts[date]!.soldierId)
        .toSet();

    // --- Candidate Selection ---
    final candidates = <_AssignmentCandidate>[];
    for (final soldier in soldiers.values) {
      // Rule: A soldier cannot have more than one post per day.
      if (alreadyAssignedToday.contains(soldier.id)) {
        continue;
      }

      final cost = _calculateCost(soldier, currentPost, date);
      // A cost of infinity means this assignment is impossible.
      if (cost != double.infinity) {
        candidates.add(_AssignmentCandidate(soldier.id!, cost));
      }
    }

    // Sort candidates by cost, lowest cost is the best option.
    candidates.sort((a, b) => a.cost.compareTo(b.cost));

    // --- Backtracking ---
    for (final candidate in candidates) {
      // 1. **Make a choice:** Assign the soldier to the post.
      final newPost = SoldierPost(
        soldierId: candidate.soldierId,
        guardPostId: currentPost.id,
        date: date,
        editType: EditType.auto,
      );
      _schedule[candidate.soldierId]![date] = newPost;

      // 2. **Recurse:** Try to solve for the next slot.
      if (_fillSlotsForDay(date, slots, slotIndex + 1)) {
        return true; // Success!
      }

      // 3. **Backtrack:** The choice led to a dead end. Undo it.
      _schedule[candidate.soldierId]!.remove(date);
    }

    // If no candidate leads to a solution, return false to trigger backtracking.
    return false;
  }

  /// The heart of the algorithm: calculates the cost of an assignment.
  /// Lower cost is better. Infinity means it's a hard violation.
  double _calculateCost(Soldier soldier, RawGuardPost post, DateTime date) {
    double totalCost = 0.0;
    final policies = allPolicies[soldier.id] ?? [];

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
            policyCost = (projectedDifficulty - avgDifficulty) * 100;
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
}

// ===========================================================================
// Public API Function
// ===========================================================================

/// Generates a guard schedule based on a set of soldiers, posts, and policies.
///
/// Returns the generated schedule map, or null if no solution could be found.
Map<int, Map<DateTime, SoldierPost>>? generateGuardSchedule({
  required Map<int, Soldier> soldiers,
  required Map<int, RawGuardPost> guardPosts,
  required List<PostPolicy> publicPolicies,
  required Map<int, List<PostPolicy>> soldierPolicies,
  required Map<int, Map<DateTime, SoldierPost>> initialSchedule,
  required Set<DateTime> holidays,
  required DateTimeRange dateRange,
}) {
  if (soldiers.isEmpty || guardPosts.isEmpty) {
    return initialSchedule;
  }

  final scheduler = GuardScheduler(
    soldiers: soldiers,
    guardPosts: guardPosts,
    publicPolicies: publicPolicies,
    soldierPolicies: soldierPolicies,
    initialSchedule: initialSchedule,
    holidays: holidays,
    dateRange: dateRange,
  );

  return scheduler.generate();
}

// ===========================================================================
// Example Usage
// ===========================================================================
// void main() {
//   // --- 1. Define Soldiers ---
//   final soldiers = {
//     1: Soldier(id: 1, firstName: 'Ali', lastName: 'Alavi', dateOfEnlistment: DateTime(2024, 1, 1), rank: ), // Senior
//     2: Soldier(id: 2, firstName: 'Reza', lastName: 'Rezaei', dateOfEnlistment: DateTime(2025, 6, 1)), // Junior
//     3: Soldier(id: 3, firstName: 'Hassan', lastName: 'Hassani', dateOfEnlistment: DateTime(2025, 7, 1)), // Recruit
//     4: Soldier(id: 4, firstName: 'Naser', lastName: 'Naseri', dateOfEnlistment: DateTime(2024, 3, 1)), // Senior
//   };

//   // --- 2. Define Guard Posts ---
//   final guardPosts = {
//     101: RawGuardPost(id: 101, title: 'برجک شمالی', difficulty: GuardPostDifficulty.hard, shiftsPerDay: 1),
//     102: RawGuardPost(id: 102, title: 'دژبانی', difficulty: GuardPostDifficulty.easy, shiftsPerDay: 2),
//   };

//   // --- 3. Define Policies ---
//   final publicPolicies = <PostPolicy>[
//     MaxPostCountPerMonth(value: 10, priority: Priority.medium),
//     NoNightNNight(value: 1, priority: Priority.veryHigh), // قانون یک شب در میان
//   ];
//   final soldierPolicies = {
//     1: <PostPolicy>[
//        MaxPostCountPerMonth(value: 8, priority: Priority.high) // سرباز ارشد، پست کمتر
//     ],
//     3: <PostPolicy>[
//       Leave(soldierId: 3, value: DateTimeRange(start: DateTime(2025, 9, 5), end: DateTime(2025, 9, 10)))
//     ],
//   };

//   // --- 4. Define other inputs ---
//   final dateRange = DateTimeRange(start: DateTime(2025, 9, 1), end: DateTime(2025, 9, 7));
//   final initialSchedule = <int, Map<DateTime, SoldierPost>>{}; // شروع از صفر

//   // --- 5. Run the algorithm ---
//   final schedule = generateGuardSchedule(
//     soldiers: soldiers,
//     guardPosts: guardPosts,
//     publicPolicies: publicPolicies,
//     soldierPolicies: soldierPolicies,
//     initialSchedule: initialSchedule,
//     holidays: {},
//     dateRange: dateRange,
//   );
  
//   // --- 6. Print the result ---
//   if (schedule == null) {
//     print('متاسفانه هیچ برنامه معتبری یافت نشد.');
//   } else {
//     print('برنامه نگهبانی تولید شد:');
//     for (var day = 0; day <= dateRange.end.difference(dateRange.start).inDays; day++) {
//        final date = dateRange.start.add(Duration(days: day));
//        print('\n--- ${date.year}/${date.month}/${date.day} ---');
//        final postsForDay = schedule.values.expand((posts) => posts.entries).where((entry) => entry.key == date);
//        if (postsForDay.isEmpty) {
//          print('هیچ پستی در این روز وجود ندارد.');
//          continue;
//        }
//        for (var postEntry in postsForDay) {
//          final soldier = soldiers[postEntry.value.soldierId]!;
//          final post = guardPosts[postEntry.value.guardPostId]!;
//          print('${post.title}: ${soldier.firstName} ${soldier.lastName}');
//        }
//     }
//   }
// }
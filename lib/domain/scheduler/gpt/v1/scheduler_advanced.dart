import 'dart:math';

import 'package:flutter/material.dart' show DateTimeRange;

import '../../../enums.dart';
import '../../../models/models.dart';
import '../../../models/soldier_post.dart'; // فرض: مدل‌ها (Soldier, RawGuardPost, SoldierPost, PostPolicy, Weekday, ConscriptionStage, GuardPostDifficulty, Priority) در models.dart تعریف شده‌اند

DateTime normalizeDate(DateTime d) => DateTime(d.year, d.month, d.day);

int daysBetween(DateTime a, DateTime b) => b.difference(a).inDays;

int monthsBetween(DateTime start, DateTime onDate) {
  final years = onDate.year - start.year;
  final months = onDate.month - start.month;
  final total = years * 12 + months;
  return total < 0 ? 0 : total;
}

double difficultyValue(GuardPostDifficulty d) {
  switch (d) {
    case GuardPostDifficulty.easy:
      return 0.0;
    case GuardPostDifficulty.medium:
      return 0.5;
    case GuardPostDifficulty.hard:
      return 1.0;
  }
}

double priorityWeight(Priority p) {
  switch (p) {
    case Priority.unimportant:
      return 0.2;
    case Priority.veryLow:
      return 0.4;
    case Priority.low:
      return 0.6;
    case Priority.medium:
      return 1.0;
    case Priority.high:
      return 1.6;
    case Priority.veryHigh:
      return 2.4;
    case Priority.absolute:
      return 5.0;
  }
}

class Slot {
  final int id;
  final int postId;
  final RawGuardPost post;
  final DateTime date;
  final int shiftIndex;

  Slot({
    required this.id,
    required this.postId,
    required this.post,
    required this.date,
    required this.shiftIndex,
  });
}

abstract class HardConstraint {
  bool isFeasible({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  });
}

abstract class SoftConstraint {
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  });
  double weight;
  SoftConstraint({required this.weight});
}

class ScheduleState {
  final Map<int, RawGuardPost> guardPosts;
  final Map<int, Soldier> soldiers;
  final DateTimeRange dateRange;
  final Set<DateTime> holidays;

  // assignments: soldierId -> date -> SoldierPost
  final Map<int, Map<DateTime, SoldierPost>> soldiersPosts;

  // slot assignments: slotId -> soldierId
  final Map<int, int> slotAssignments;

  // fast counters
  final Map<int, int> postsCount; // soldierId -> count in dateRange
  final Map<int, int> holidayCount; // soldierId -> count of holidays
  final Map<int, int> weekendCount; // soldierId -> count of weekends
  final Map<int, DateTime?>
  lastAssignedDate; // soldierId -> last assignment date (normalized)

  ScheduleState({
    required this.guardPosts,
    required this.soldiers,
    required this.dateRange,
    required this.holidays,
  }) : soldiersPosts = {},
       slotAssignments = {},
       postsCount = {},
       holidayCount = {},
       weekendCount = {},
       lastAssignedDate = {};

  bool hasAnyPostInDay(int soldierId, DateTime date) {
    final d = normalizeDate(date);
    return soldiersPosts[soldierId]?.containsKey(d) ?? false;
  }

  void assign(int soldierId, Slot slot, {EditType editType = EditType.auto}) {
    final d = normalizeDate(slot.date);
    soldiersPosts.putIfAbsent(soldierId, () => {});
    // create SoldierPost
    final sp = SoldierPost(
      soldierId: soldierId,
      guardPostId: slot.postId,
      date: d,
      editType: editType,
    );
    soldiersPosts[soldierId]![d] = sp;
    slotAssignments[slot.id] = soldierId;

    postsCount[soldierId] = (postsCount[soldierId] ?? 0) + 1;
    if (holidays.contains(d)) {
      holidayCount[soldierId] = (holidayCount[soldierId] ?? 0) + 1;
    }
    if (_isWeekend(d)) {
      weekendCount[soldierId] = (weekendCount[soldierId] ?? 0) + 1;
    }
    lastAssignedDate[soldierId] = d;
  }

  void unassign(int soldierId, Slot slot) {
    final d = normalizeDate(slot.date);
    soldiersPosts[soldierId]?.remove(d);
    slotAssignments.remove(slot.id);

    postsCount[soldierId] = (postsCount[soldierId] ?? 1) - 1;
    if (postsCount[soldierId]! <= 0) postsCount.remove(soldierId);

    if (holidays.contains(d)) {
      holidayCount[soldierId] = (holidayCount[soldierId] ?? 1) - 1;
      if (holidayCount[soldierId]! <= 0) holidayCount.remove(soldierId);
    }
    if (_isWeekend(d)) {
      weekendCount[soldierId] = (weekendCount[soldierId] ?? 1) - 1;
      if (weekendCount[soldierId]! <= 0) weekendCount.remove(soldierId);
    }
    // recompute lastAssignedDate
    final entries = soldiersPosts[soldierId]?.keys;
    if (entries == null || entries.isEmpty) {
      lastAssignedDate.remove(soldierId);
    } else {
      final last = entries.reduce((a, b) => a.isAfter(b) ? a : b);
      lastAssignedDate[soldierId] = last;
    }
  }

  bool _isWeekend(DateTime d) {
    final wd = Weekday.fromValue(d.weekday);
    return wd == Weekday.friday ||
        wd == Weekday.saturday; // depending locale; adjust if needed
  }
}

// ------------------ Concrete Constraints ------------------

class LeaveConstraint extends HardConstraint {
  final Map<int, List<DateTimeRange>> soldierLeaves;

  LeaveConstraint(this.soldierLeaves);

  @override
  bool isFeasible({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final leaves = soldierLeaves[soldierId];
    if (leaves == null) return true;
    final d = normalizeDate(slot.date);
    for (final r in leaves) {
      if (!d.isBefore(r.start) && !d.isAfter(r.end)) return false;
    }
    return true;
  }
}

class NoNightNNightConstraint extends HardConstraint {
  final Map<int, int>
  soldierCooldown; // soldierId -> N (number of nights to skip)

  NoNightNNightConstraint(this.soldierCooldown);

  @override
  bool isFeasible({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final n = soldierCooldown[soldierId] ?? 0;
    if (n <= 0) return true;
    final last = state.lastAssignedDate[soldierId];
    if (last == null) return true;
    final diff = daysBetween(last, normalizeDate(slot.date));
    return diff > n; // must be greater than N (i.e., N nights off between)
  }
}

class OnePostPerDayConstraint extends HardConstraint {
  @override
  bool isFeasible({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    return !state.hasAnyPostInDay(soldierId, slot.date);
  }
}

class PostAvailabilityConstraint extends HardConstraint {
  // ensures the guard post actually includes that date (redundant if slots were created correctly)
  @override
  bool isFeasible({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    return slot.post.includesDate(slot.date);
  }
}

// Soft constraints

class WeekOffDaysSoft extends SoftConstraint {
  final Map<int, List<Weekday>> weekOffDays;

  WeekOffDaysSoft({required double weight, required this.weekOffDays})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final prefs = weekOffDays[soldierId];
    if (prefs == null || prefs.isEmpty) return 0.0;
    final wd = Weekday.fromValue(slot.date.weekday);
    if (prefs.contains(wd)) {
      // negative score (they prefer not to have duty this weekday)
      return -1.0 * weight;
    }
    return 0.0;
  }
}

class MinPostCountSoft extends SoftConstraint {
  final Map<int, int> minPerSoldier; // soldierId -> min
  MinPostCountSoft({required double weight, required this.minPerSoldier})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final min = minPerSoldier[soldierId];
    if (min == null) return 0.0;
    final current = state.postsCount[soldierId] ?? 0;
    if (current < min) {
      // encourage assigning
      return (min - current) * 0.5 * weight;
    }
    return 0.0;
  }
}

class MaxPostCountSoft extends SoftConstraint {
  final Map<int, int> maxPerSoldier; // soldierId -> max
  MaxPostCountSoft({required double weight, required this.maxPerSoldier})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final max = maxPerSoldier[soldierId];
    if (max == null) return 0.0;
    final current = state.postsCount[soldierId] ?? 0;
    if (current >= max) {
      // discourage
      return -1.0 * (current - max + 1) * weight;
    }
    return 0.0;
  }
}

class EqualHolidaySoft extends SoftConstraint {
  final double targetPerSoldier; // average target

  EqualHolidaySoft({required double weight, required this.targetPerSoldier})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final isHoliday = state.holidays.contains(normalizeDate(slot.date));
    if (!isHoliday) return 0.0;
    final current = state.holidayCount[soldierId] ?? 0;
    final diff = targetPerSoldier - current;
    return diff * 0.6 * weight;
  }
}

class EqualDifficultySoft extends SoftConstraint {
  // use desired difficulty per stage if available, otherwise neutral
  final Map<ConscriptionStage, GuardPostDifficulty>? stageDesired;

  EqualDifficultySoft({required double weight, this.stageDesired})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final soldier = state.soldiers[soldierId]!;
    final months = monthsBetween(soldier.dateOfEnlistment, slot.date);
    final stage = ConscriptionStage.fromMonths(months);
    final desired = stageDesired?[stage];
    if (desired == null) return 0.0;
    final desiredVal = difficultyValue(desired);
    final slotVal = difficultyValue(slot.post.difficulty);
    // closer to desired gives positive score, farther gives negative
    return (1 - (slotVal - desiredVal).abs()) * weight;
  }
}

class FriendSoldiersSoft extends SoftConstraint {
  final Map<int, List<int>> friends; // soldierId -> list of friends

  FriendSoldiersSoft({required double weight, required this.friends})
    : super(weight: weight);

  @override
  double score({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
  }) {
    final f = friends[soldierId];
    if (f == null || f.isEmpty) return 0.0;
    final d = normalizeDate(slot.date);
    for (final fr in f) {
      if ((state.soldiersPosts[fr]?.containsKey(d) ?? false)) {
        return 0.7 * weight; // bonus if friend is also assigned this date
      }
    }
    return 0.0;
  }
}

// ------------------ SchedulerAdvanced ------------------

class SchedulerAdvanced {
  final Random _rand;
  final int maxBacktrackSteps;
  final int maxCandidatesToTry;

  SchedulerAdvanced({
    int seed = 42,
    this.maxBacktrackSteps = 20000,
    this.maxCandidatesToTry = 10,
  }) : _rand = Random(seed);

  /// Main entry point
  Map<int, Map<DateTime, SoldierPost>> generate({
    required Map<int, RawGuardPost> guardPosts,
    required Map<int, Soldier> soldiers,
    required List<PostPolicy> publicPolicies,
    required Map<int, List<PostPolicy>> soldierPolicies,
    required Set<DateTime> holidays,
    required DateTimeRange dateRange,
    Map<int, Map<DateTime, SoldierPost>>? existingAssignments,
  }) {
    final normHolidays = holidays.map(normalizeDate).toSet();

    final state = ScheduleState(
      guardPosts: guardPosts,
      soldiers: soldiers,
      dateRange: dateRange,
      holidays: normHolidays,
    );

    // Pre-load existing assignments if any
    if (existingAssignments != null) {
      for (final e in existingAssignments.entries) {
        final soldierId = e.key;
        for (final entry in e.value.entries) {
          final date = normalizeDate(entry.key);
          final postId = entry.value.guardPostId;
          if (postId == null) continue;
          // create a fake slot to register counts
          final post = guardPosts[postId];
          if (post == null) continue;
          final slot = Slot(
            id: -1,
            postId: postId,
            post: post,
            date: date,
            shiftIndex: 0,
          );
          state.assign(soldierId, slot, editType: entry.value.editType);
        }
      }
    }

    // build slots
    final slots = <Slot>[];
    var nextSlotId = 1;
    for (final entry in guardPosts.entries) {
      final postId = entry.key;
      final post = entry.value;
      for (
        var d = normalizeDate(dateRange.start);
        !d.isAfter(normalizeDate(dateRange.end));
        d = d.add(const Duration(days: 1))
      ) {
        if (!post.includesDate(d)) continue;
        for (var shift = 0; shift < post.shiftsPerDay; shift++) {
          slots.add(
            Slot(
              id: nextSlotId++,
              postId: postId,
              post: post,
              date: d,
              shiftIndex: shift,
            ),
          );
        }
      }
    }

    // Build policy maps from PostPolicy lists
    final policyMaps = _buildPolicyMaps(publicPolicies, soldierPolicies);

    // Create constraint objects
    final hardConstraints = <HardConstraint>[
      LeaveConstraint(policyMaps.soldierLeaves),
      NoNightNNightConstraint(policyMaps.noNight),
      OnePostPerDayConstraint(),
      PostAvailabilityConstraint(),
    ];

    // Create soft constraints with weights
    final softConstraints = <SoftConstraint>[];

    // week off days
    softConstraints.add(
      WeekOffDaysSoft(weight: 0.9, weekOffDays: policyMaps.weekOffDays),
    );

    // min/max
    softConstraints.add(
      MinPostCountSoft(weight: 1.0, minPerSoldier: policyMaps.minPerMonth),
    );
    softConstraints.add(
      MaxPostCountSoft(weight: 1.4, maxPerSoldier: policyMaps.maxPerMonth),
    );

    // friend
    softConstraints.add(
      FriendSoldiersSoft(weight: 1.1, friends: policyMaps.friends),
    );

    // equal holiday (compute average)
    final avgHoliday = _computeAverageHolidays(
      slots,
      normHolidays,
      soldiers.keys.toList(),
    );
    softConstraints.add(
      EqualHolidaySoft(weight: 1.0, targetPerSoldier: avgHoliday),
    );

    // difficulty by stage
    softConstraints.add(
      EqualDifficultySoft(
        weight: 1.2,
        stageDesired: policyMaps.equalDifficulty,
      ),
    );

    // now run backtracking search with MRV heuristic
    final assignments = <int, int>{}; // slotId -> soldierId

    final assignedSlots = <int>{};
    final unassignedSlots = Set<int>.from(
      List<int>.generate(slots.length, (i) => i),
    );

    int steps = 0;

    bool success = _backtrackAssign(
      slots: slots,
      slotIndexes: unassignedSlots,
      assignments: assignments,
      state: state,
      hardConstraints: hardConstraints,
      softConstraints: softConstraints,
      stepsLeft: maxBacktrackSteps,
      stepsUsed: () => steps++,
    );

    // build result map from state (it's already populated)
    return state.soldiersPosts;
  }

  double _scoreCandidate({
    required int soldierId,
    required Slot slot,
    required ScheduleState state,
    required List<SoftConstraint> softConstraints,
  }) {
    var s = 0.0;
    for (final sc in softConstraints) {
      s += sc.score(soldierId: soldierId, slot: slot, state: state);
    }

    // load balancing penalty: discourage assigning soldiers with much more posts than average
    final avg = _avgAssigned(state.postsCount);
    final current = state.postsCount[soldierId] ?? 0;
    s -= ((current - avg) / (1 + avg)) * 0.5;

    // slight random tie-breaker
    s += _rand.nextDouble() * 1e-3;
    return s;
  }

  double _avgAssigned(Map<int, int> postsCount) {
    if (postsCount.isEmpty) return 0.0;
    final total = postsCount.values.fold<int>(0, (p, e) => p + e);
    return total / postsCount.length;
  }

  bool _backtrackAssign({
    required List<Slot> slots,
    required Set<int> slotIndexes,
    required Map<int, int> assignments,
    required ScheduleState state,
    required List<HardConstraint> hardConstraints,
    required List<SoftConstraint> softConstraints,
    required int stepsLeft,
    required Function stepsUsed,
  }) {
    if (slotIndexes.isEmpty) return true;
    if (stepsLeft <= 0) return false;

    // MRV heuristic: choose slot with minimum feasible candidates
    int bestSlotIndex = -1;
    List<int> bestCandidates = [];

    for (final idx in slotIndexes) {
      final slot = slots[idx];
      final candidates = <int>[];
      for (final soldierId in state.soldiers.keys) {
        var feasible = true;
        for (final hc in hardConstraints) {
          if (!hc.isFeasible(soldierId: soldierId, slot: slot, state: state)) {
            feasible = false;
            break;
          }
        }
        if (feasible) candidates.add(soldierId);
      }
      if (bestSlotIndex == -1 || candidates.length < bestCandidates.length) {
        bestSlotIndex = idx;
        bestCandidates = candidates;
      }
      if (bestCandidates.length <= 1) break; // can't get better than 0 or 1
    }

    if (bestSlotIndex == -1) return false;

    final chosenSlot = slots[bestSlotIndex];

    // If no candidates, fail early
    if (bestCandidates.isEmpty) {
      return false;
    }

    // Score candidates
    final scored = <MapEntry<int, double>>[];
    for (final s in bestCandidates) {
      final sc = _scoreCandidate(
        soldierId: s,
        slot: chosenSlot,
        state: state,
        softConstraints: softConstraints,
      );
      scored.add(MapEntry(s, sc));
    }
    scored.sort((a, b) => b.value.compareTo(a.value));

    // Try top candidates up to a limit
    final toTry = scored.take(maxCandidatesToTry).toList();

    for (final candidate in toTry) {
      final soldierId = candidate.key;
      // assign
      state.assign(soldierId, chosenSlot);
      assignments[chosenSlot.id] = soldierId;
      slotIndexes.remove(bestSlotIndex);
      stepsUsed();

      final next = _backtrackAssign(
        slots: slots,
        slotIndexes: slotIndexes,
        assignments: assignments,
        state: state,
        hardConstraints: hardConstraints,
        softConstraints: softConstraints,
        stepsLeft: stepsLeft - 1,
        stepsUsed: stepsUsed,
      );

      if (next) return true;

      // undo
      state.unassign(soldierId, chosenSlot);
      assignments.remove(chosenSlot.id);
      slotIndexes.add(bestSlotIndex);
    }

    return false;
  }

  PolicyMaps _buildPolicyMaps(
    List<PostPolicy> publicPolicies,
    Map<int, List<PostPolicy>> soldierPolicies,
  ) {
    final leaves = <int, List<DateTimeRange>>{};
    final noNight = <int, int>{};
    final weekOff = <int, List<Weekday>>{};
    final minPer = <int, int>{};
    final maxPer = <int, int>{};
    final friends = <int, List<int>>{};
    final equalDifficulty = <ConscriptionStage, GuardPostDifficulty>{};

    // gather soldier-specific
    for (final entry in soldierPolicies.entries) {
      final soldierId = entry.key;
      for (final p in entry.value) {
        switch (p.type) {
          case PostPolicyType.leave:
            final r = (p as Leave).value;
            leaves.putIfAbsent(soldierId, () => []).add(r);
            break;
          case PostPolicyType.friendSoldiers:
            friends[soldierId] = (p as FriendSoldiers).value;
            break;
          case PostPolicyType.weekOffDays:
            weekOff[soldierId] = (p as WeekOffDays).value;
            break;
          case PostPolicyType.noNightNNight:
            noNight[soldierId] = (p as NoNightNNight).value;
            break;
          case PostPolicyType.minPostCount:
            minPer[soldierId] = (p as MinPostCountPerMonth).value;
            break;
          case PostPolicyType.maxPostCount:
            maxPer[soldierId] = (p as MaxPostCountPerMonth).value;
            break;
          default:
            // skip others for soldier-specific mapping
            break;
        }
      }
    }

    // public policies
    for (final p in publicPolicies) {
      switch (p.type) {
        case PostPolicyType.equalPostDifficulty:
          final eq = p as EqualPostDifficulty;
          if (eq.stagePriority != null) {
            eq.stagePriority!.forEach(
              (stage, diff) => equalDifficulty[stage] = diff,
            );
          }
          break;
        default:
          break;
      }
    }

    return PolicyMaps(
      soldierLeaves: leaves,
      noNight: noNight,
      weekOffDays: weekOff,
      minPerMonth: minPer,
      maxPerMonth: maxPer,
      friends: friends,
      equalDifficulty: equalDifficulty.isEmpty ? null : equalDifficulty,
    );
  }

  double _computeAverageHolidays(
    List<Slot> slots,
    Set<DateTime> holidays,
    List<int> soldierIds,
  ) {
    if (soldierIds.isEmpty) return 0.0;
    final holidaySlots = slots
        .where((s) => holidays.contains(normalizeDate(s.date)))
        .length;
    return holidaySlots / soldierIds.length;
  }
}

class PolicyMaps {
  final Map<int, List<DateTimeRange>> soldierLeaves;
  final Map<int, int> noNight;
  final Map<int, List<Weekday>> weekOffDays;
  final Map<int, int> minPerMonth;
  final Map<int, int> maxPerMonth;
  final Map<int, List<int>> friends;
  final Map<ConscriptionStage, GuardPostDifficulty>? equalDifficulty;

  PolicyMaps({
    required this.soldierLeaves,
    required this.noNight,
    required this.weekOffDays,
    required this.minPerMonth,
    required this.maxPerMonth,
    required this.friends,
    this.equalDifficulty,
  });
}

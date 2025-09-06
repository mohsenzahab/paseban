import 'package:flutter/material.dart';
import 'package:paseban/domain/models/models.dart';

import '../../../enums.dart';

/// Base class for all constraints
abstract class Constraint {
  bool isHard; // true = hard constraint, false = soft constraint
  int weight; // used for soft constraints scoring

  Constraint({this.isHard = true, this.weight = 1});

  bool isSatisfied(SoldierPost post, Map<int, List<SoldierPost>> schedule);
}

/// سرباز در این بازه زمانی مرخصی است
class LeaveConstraint extends Constraint {
  final DateTimeRange leaveRange;
  final int soldierId;

  LeaveConstraint(this.soldierId, this.leaveRange) : super(isHard: true);

  @override
  bool isSatisfied(SoldierPost post, Map<int, List<SoldierPost>> schedule) {
    if (post.soldierId != soldierId) return true;
    return !leaveRange.start.isBefore(post.date) ||
        !leaveRange.end.isAfter(post.date);
  }
}

/// فاصله‌ی بین پست‌ها
class NoNightNNightConstraint extends Constraint {
  final int soldierId;
  final int minGapDays;

  NoNightNNightConstraint(this.soldierId, this.minGapDays)
    : super(isHard: true);

  @override
  bool isSatisfied(SoldierPost post, Map<int, List<SoldierPost>> schedule) {
    if (post.soldierId != soldierId) return true;
    final posts = schedule[soldierId] ?? [];
    for (final p in posts) {
      final diff = post.date.difference(p.date).inDays.abs();
      if (diff <= minGapDays) return false;
    }
    return true;
  }
}

/// حداقل/حداکثر تعداد پست در ماه
class MinMaxPostsConstraint extends Constraint {
  final int soldierId;
  final int? minPosts;
  final int? maxPosts;

  MinMaxPostsConstraint(this.soldierId, {this.minPosts, this.maxPosts})
    : super(isHard: false, weight: 3);

  @override
  bool isSatisfied(SoldierPost post, Map<int, List<SoldierPost>> schedule) {
    final posts = schedule[soldierId] ?? [];
    final count = posts.length + 1; // بعد از این پست
    if (minPosts != null && count < minPosts!) return false;
    if (maxPosts != null && count > maxPosts!) return false;
    return true;
  }
}

/// تعادل سختی پست‌ها
class EqualDifficultyConstraint extends Constraint {
  final Map<int, GuardPostDifficulty> soldierStages;

  EqualDifficultyConstraint(this.soldierStages)
    : super(isHard: false, weight: 2);

  @override
  bool isSatisfied(SoldierPost post, Map<int, List<SoldierPost>> schedule) {
    final expected = soldierStages[post.soldierId];
    if (expected == null) return true;
    // اینجا می‌شه دقیق‌تر شد و آمار سختی‌های گذشته رو هم بررسی کرد
    return true;
  }
}

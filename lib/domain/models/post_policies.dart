import 'package:flutter/material.dart';

import '../enums.dart';
import 'weekday.dart';

sealed class PostPolicy {
  final int? id;
  final Priority priority;

  const PostPolicy({this.id, this.priority = Priority.unimportant});
}

class ValuePostPolicy<T> extends PostPolicy {
  const ValuePostPolicy({
    super.id,
    required this.value,
    super.priority = Priority.unimportant,
  });

  final T value;
}

class Leave extends ValuePostPolicy<DateTimeRange> {
  Leave({super.id, required super.value, super.priority = Priority.absolute});
}

class FriendSoldiers extends ValuePostPolicy<List<int>> {
  FriendSoldiers({
    super.id,
    required super.value,
    super.priority = Priority.veryLow,
  });
}

class WeekOffDays extends ValuePostPolicy<List<Weekday>> {
  WeekOffDays({super.id, required super.value, super.priority = Priority.low});
}

class NoNightNNight extends ValuePostPolicy<int> {
  NoNightNNight({
    super.id,
    super.value = 1,
    super.priority = Priority.veryHigh,
  });
}

class NoNight1Night extends NoNightNNight {
  NoNight1Night({super.id, super.priority = Priority.veryHigh})
    : super(value: 1);
}

class NoNight2Night extends NoNightNNight {
  NoNight2Night({super.id, super.priority = Priority.high}) : super(value: 2);
}

interface class StagedPostPolicy<T> {
  final Map<ConscriptionStage, T>? stagePriority;

  StagedPostPolicy({this.stagePriority});
}

abstract class PublicStagedPolicy<T> extends ValuePostPolicy<T>
    implements StagedPostPolicy<T> {
  PublicStagedPolicy({
    super.id,
    required super.value,
    super.priority = Priority.medium,
    this.stagePriority,
  });

  @override
  final Map<ConscriptionStage, T>? stagePriority;
}

class MinPostCount extends PublicStagedPolicy<int> {
  MinPostCount({
    super.id,
    required super.value,
    super.priority = Priority.medium,
    super.stagePriority,
  });
}

class MaxPostCount extends PublicStagedPolicy<int> {
  MaxPostCount({
    super.id,
    required super.value,
    super.priority = Priority.high,
    super.stagePriority,
  });
}

class NoWeekendPerMonth extends PublicStagedPolicy<int> {
  NoWeekendPerMonth({
    super.id,
    super.value = 1,
    super.priority = Priority.veryHigh,
    super.stagePriority,
  });
}

abstract class StaticStagedPolicy<T> extends PostPolicy
    implements StagedPostPolicy<T> {
  StaticStagedPolicy({
    super.id,
    super.priority = Priority.medium,
    this.stagePriority,
  });

  @override
  final Map<ConscriptionStage, T>? stagePriority;
}

class EqualHolidayPost extends StaticStagedPolicy<int> {
  EqualHolidayPost({
    super.id,
    super.priority = Priority.medium,
    super.stagePriority,
  });
}

class EqualPostDifficulty extends StaticStagedPolicy<GuardPostDifficulty> {
  EqualPostDifficulty({
    super.id,
    super.priority = Priority.medium,
    super.stagePriority,
  });
}

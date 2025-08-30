import 'package:flutter/material.dart';

import '../enums.dart';
import 'weekday.dart';

sealed class PostPolicy {
  final int? id;
  final int? soldierId;
  final Priority priority;

  const PostPolicy({
    this.id,
    this.soldierId,
    this.priority = Priority.unimportant,
  });

  String get title => switch (this) {
    Leave() => 'مرخصی',
    FriendSoldiers() => 'دوستان',
    WeekOffDays() => 'روز هفته',
    NoNightNNight() => 'بدون شب',
    MinPostCount() => 'حداقل پست',
    MaxPostCount() => 'حداکثر پست',
    NoWeekendPerMonth() => 'بدون هفته',
    EqualHolidayPost() => 'پست هفتگی',
    EqualPostDifficulty() => 'سختی پست',
  };

  // static List<PostPolicyType> get values => [Leave, FriendSoldiers, WeekOffDays, NoNightNNight, MinPostCount, MaxPostCount, NoWeekendPerMonth, EqualHolidayPost, EqualPostDifficulty];
}

sealed class ValuePostPolicy<T> extends PostPolicy {
  const ValuePostPolicy({
    super.id,
    super.soldierId,
    required this.value,
    super.priority = Priority.unimportant,
  });

  final T value;
}

class Leave extends ValuePostPolicy<DateTimeRange> {
  Leave({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.absolute,
  });
}

class FriendSoldiers extends ValuePostPolicy<List<int>> {
  FriendSoldiers({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.veryLow,
  });
}

class WeekOffDays extends ValuePostPolicy<List<Weekday>> {
  WeekOffDays({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.low,
  });
}

class NoNightNNight extends ValuePostPolicy<int> {
  NoNightNNight({
    super.id,
    super.soldierId,
    super.value = 1,
    super.priority = Priority.veryHigh,
  });
}

class NoNight1Night extends NoNightNNight {
  NoNight1Night({super.id, super.soldierId, super.priority = Priority.veryHigh})
    : super(value: 1);
}

class NoNight2Night extends NoNightNNight {
  NoNight2Night({super.id, super.soldierId, super.priority = Priority.high})
    : super(value: 2);
}

interface class StagedPostPolicy<T> {
  final Map<ConscriptionStage, T>? stagePriority;

  StagedPostPolicy({this.stagePriority});
}

sealed class PublicStagedPolicy<T> extends ValuePostPolicy<T>
    implements StagedPostPolicy<T> {
  PublicStagedPolicy({
    super.id,
    super.soldierId,
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
    super.soldierId,
    required super.value,
    super.priority = Priority.medium,
    super.stagePriority,
  });
}

class MaxPostCount extends PublicStagedPolicy<int> {
  MaxPostCount({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.high,
    super.stagePriority,
  });
}

class NoWeekendPerMonth extends PublicStagedPolicy<int> {
  NoWeekendPerMonth({
    super.id,
    super.soldierId,
    super.value = 1,
    super.priority = Priority.veryHigh,
    super.stagePriority,
  });
}

sealed class StaticStagedPolicy<T> extends PostPolicy
    implements StagedPostPolicy<T> {
  StaticStagedPolicy({
    super.id,
    super.soldierId,
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

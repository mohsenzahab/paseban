import 'package:flutter/material.dart';

import '../enums.dart';
import 'weekday.dart';

sealed class PostPolicy {
  final int? id;
  final int? soldierId;
  final Priority priority;

  PostPolicy copyWith({int? id, int? soldierId, Priority? priority});

  Map<String, dynamic> toFormValues() => {
    'priority': priority.index,
    'soldierId': soldierId,
    if (this is ValuePostPolicy)
      'value': (this as ValuePostPolicy).value.toString(),
    if (this is StagedPostPolicy)
      'stagePriority': (this as StagedPostPolicy).stagePriority,
  };

  PostPolicyType get type => switch (this) {
    Leave() => PostPolicyType.leave,
    FriendSoldiers() => PostPolicyType.friendSoldiers,
    WeekOffDays() => PostPolicyType.weekOffDays,
    NoNight1Night() => PostPolicyType.noNight1Night,
    NoNight2Night() => PostPolicyType.noNight2Night,
    NoNightNNight() => PostPolicyType.noNightNNight,
    MinPostCount() => PostPolicyType.minPostCount,
    MaxPostCount() => PostPolicyType.maxPostCount,
    NoWeekendPerMonth() => PostPolicyType.noWeekendPerMonth,
    EqualHolidayPost() => PostPolicyType.equalHolidayPost,
    EqualPostDifficulty() => PostPolicyType.equalPostDifficulty,
  };

  const PostPolicy({
    this.id,
    this.soldierId,
    this.priority = Priority.unimportant,
  });

  factory PostPolicy.leave({
    int? id,
    required int? soldierId,
    required DateTimeRange value,
    Priority priority = Priority.absolute,
  }) {
    return Leave(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
    );
  }

  factory PostPolicy.friendSoldiers({
    int? id,
    required int? soldierId,
    required List<int> value,
    Priority priority = Priority.veryLow,
  }) {
    return FriendSoldiers(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
    );
  }

  factory PostPolicy.weekOffDays({
    int? id,
    required int? soldierId,
    required List<Weekday> value,
    Priority priority = Priority.low,
  }) {
    return WeekOffDays(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
    );
  }

  factory PostPolicy.noNightNNight({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.medium,
  }) {
    return NoNightNNight(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
    );
  }

  factory PostPolicy.noNight1Night({
    int? id,
    required int? soldierId,
    Priority priority = Priority.veryHigh,
  }) {
    return NoNight1Night(id: id, soldierId: soldierId, priority: priority);
  }
  factory PostPolicy.noNight2Night({
    int? id,
    required int? soldierId,
    Priority priority = Priority.high,
  }) {
    return NoNight2Night(id: id, soldierId: soldierId, priority: priority);
  }

  factory PostPolicy.minPostCount({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.medium,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MinPostCount(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  factory PostPolicy.maxPostCount({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.high,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MaxPostCount(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  factory PostPolicy.noWeekendPerMonth({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.veryHigh,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return NoWeekendPerMonth(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  factory PostPolicy.equalHolidayPost({
    int? id,
    Priority priority = Priority.medium,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return EqualHolidayPost(
      id: id,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  factory PostPolicy.equalPostDifficulty({
    int? id,
    Priority priority = Priority.medium,
    Map<ConscriptionStage, GuardPostDifficulty>? stagePriority,
  }) {
    return EqualPostDifficulty(
      id: id,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

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

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return Leave(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
    );
  }
}

class FriendSoldiers extends ValuePostPolicy<List<int>> {
  FriendSoldiers({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.veryLow,
  });

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return FriendSoldiers(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
    );
  }
}

class WeekOffDays extends ValuePostPolicy<List<Weekday>> {
  WeekOffDays({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.low,
  });

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return WeekOffDays(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
    );
  }
}

class NoNightNNight extends ValuePostPolicy<int> {
  NoNightNNight({
    super.id,
    super.soldierId,
    super.value = 1,
    super.priority = Priority.veryHigh,
  });

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return NoNightNNight(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
    );
  }
}

class NoNight1Night extends NoNightNNight {
  NoNight1Night({super.id, super.soldierId, super.priority = Priority.veryHigh})
    : super(value: 1);

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return NoNight1Night(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      priority: priority ?? this.priority,
    );
  }
}

class NoNight2Night extends NoNightNNight {
  NoNight2Night({super.id, super.soldierId, super.priority = Priority.high})
    : super(value: 2);

  @override
  PostPolicy copyWith({int? id, int? soldierId, Priority? priority}) {
    return NoNight2Night(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      priority: priority ?? this.priority,
    );
  }
}

interface class StagedPostPolicy<T> {
  final Map<ConscriptionStage, T>? stagePriority;

  StagedPostPolicy({this.stagePriority});

  StagedPostPolicy copyWith({Map<ConscriptionStage, T>? stagePriority}) {
    return StagedPostPolicy(stagePriority: stagePriority);
  }
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

  @override
  PublicStagedPolicy copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, T>? stagePriority,
  });
}

class MinPostCount extends PublicStagedPolicy<int> {
  MinPostCount({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.medium,
    super.stagePriority,
  });

  @override
  MinPostCount copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MinPostCount(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
}

class MaxPostCount extends PublicStagedPolicy<int> {
  MaxPostCount({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.high,
    super.stagePriority,
  });

  @override
  MaxPostCount copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MaxPostCount(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
}

class NoWeekendPerMonth extends PublicStagedPolicy<int> {
  NoWeekendPerMonth({
    super.id,
    super.soldierId,
    super.value = 1,
    super.priority = Priority.veryHigh,
    super.stagePriority,
  });

  @override
  NoWeekendPerMonth copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return NoWeekendPerMonth(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
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

  @override
  StaticStagedPolicy copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, T>? stagePriority,
  });
}

class EqualHolidayPost extends StaticStagedPolicy<int> {
  EqualHolidayPost({
    super.id,
    super.priority = Priority.medium,
    super.stagePriority,
  });

  @override
  EqualHolidayPost copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return EqualHolidayPost(
      id: id ?? this.id,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
}

class EqualPostDifficulty extends StaticStagedPolicy<GuardPostDifficulty> {
  EqualPostDifficulty({
    super.id,
    super.priority = Priority.medium,
    super.stagePriority,
  });

  @override
  EqualPostDifficulty copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, GuardPostDifficulty>? stagePriority,
  }) {
    return EqualPostDifficulty(
      id: id ?? this.id,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
}

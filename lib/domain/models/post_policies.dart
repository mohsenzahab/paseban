import 'package:flutter/material.dart';

import '../enums.dart';
import 'weekday.dart';

/// Policies that are used to calculate and schedule soldiers posts.
///
/// These policies are used to configure the generation of posts for soldiers.
/// Policies can be used to specify the priority of a post, the number of posts
/// a soldier can have, the days of the week they can have posts, the number of
/// weeks a soldier can have a post, and more.
/// Each policy has a priority that determines its importance.
/// If its priority is high then algorithm should try hard to schedule it first and
/// make it valid. But if its priority is low ,then the algorithm isn't have to
/// try that hard. It depends on priority of this policy and the other policies.
/// Algorithm always have to try to schedule the post with the highest priority.
/// Although if it is possible to fit in all policies, then algorithm should do it.
///
/// Important note: Some of policies also have  `Map<ConscriptionStage,T>? stagePriority`
/// By specifying this parameter, we can make personalize values for each stage of
/// a soldier which means algorithm should be more specific at scheduling the
/// posts.
/// This values later will be used for all soldiers.
///
/// The [StagedPostPolicy.stagePriority] priority is always lower than [ValuePostPolicy.priority].
sealed class PostPolicy {
  final int? id;
  final int? soldierId;
  final Priority priority;

  PostPolicy copyWith({int? id, int? soldierId, Priority? priority});

  Map<String, dynamic> toFormValues() {
    final value = switch (this) {
      FriendSoldiers f => f.value,

      ValuePostPolicy v => v.value.toString(),

      _ => null,
    };
    return {
      'priority': priority.index,
      'soldierId': soldierId,

      if (value != null) 'value': value,
      if (this is StagedPostPolicy)
        'stagePriority': (this as StagedPostPolicy).stagePriority,
    };
  }

  PostPolicyType get type => switch (this) {
    Leave() => PostPolicyType.leave,
    FriendSoldiers() => PostPolicyType.friendSoldiers,
    WeekOffDays() => PostPolicyType.weekOffDays,
    NoNight1Night() => PostPolicyType.noNight1Night,
    NoNight2Night() => PostPolicyType.noNight2Night,
    NoNightNNight() => PostPolicyType.noNightNNight,
    MinPostCountPerMonth() => PostPolicyType.minPostCount,
    MaxPostCountPerMonth() => PostPolicyType.maxPostCount,
    NoWeekendPerMonth() => PostPolicyType.noWeekendPerMonth,
    EqualHolidayPost() => PostPolicyType.equalHolidayPost,
    EqualPostDifficulty() => PostPolicyType.equalPostDifficulty,
  };

  const PostPolicy({
    this.id,
    this.soldierId,
    this.priority = Priority.unimportant,
  });

  /// Creates a new leave policy.
  /// A leave policy specifies the date range that a soldier is on leave and
  /// cant be assigned to a post.
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

  /// Creates a new friend soldiers policy.
  /// A friend soldiers policy specifies the list of its friends.
  /// this means that algorithm should try to assign posts to this soldier and
  /// its friends in a same date.
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

  /// Creates a new week off days policy.
  /// A week off days policy specifies the list of days that a soldier dont want
  /// or cannot have a post.
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

  /// Creates a new no night n night policy.
  /// A no night n night policy specifies the number of nights that a soldier
  /// should not have a post. It may be translated to the distance between
  /// soldier's posts. If the value is 1, then the soldier should not have a
  /// post on the next day. If its 2, then the soldier should not have a post on
  /// the next 2 days.
  /// Like all the other policies, scheduling and implementing this policy depends
  /// on the priority of this policy compare to the other ones.
  factory PostPolicy.noNightNNight({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.medium,
  }) {
    assert(value > 0);
    return NoNightNNight(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
    );
  }

  /// Its a special case of [noNightNNight] where the value is 1
  factory PostPolicy.noNight1Night({
    int? id,
    required int? soldierId,
    Priority priority = Priority.veryHigh,
  }) {
    return NoNight1Night(id: id, soldierId: soldierId, priority: priority);
  }

  /// Its a special case of [noNightNNight] where the value is 2
  factory PostPolicy.noNight2Night({
    int? id,
    required int? soldierId,
    Priority priority = Priority.high,
  }) {
    return NoNight2Night(id: id, soldierId: soldierId, priority: priority);
  }

  /// Creates a new min post count policy.
  /// A min post count policy specifies the minimum number of posts that a soldier
  /// should have in a month.
  factory PostPolicy.minPostCountPerMonth({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.medium,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MinPostCountPerMonth(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  /// Creates a new max post count policy.
  /// A max post count policy specifies the maximum number of posts that a soldier
  /// should have in a month.
  factory PostPolicy.maxPostCountPerMonth({
    int? id,
    required int? soldierId,
    required int value,
    Priority priority = Priority.high,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MaxPostCountPerMonth(
      id: id,
      soldierId: soldierId,
      value: value,
      priority: priority,
      stagePriority: stagePriority,
    );
  }

  /// Creates a new no weekend per month policy.
  /// A no weekend per month policy specifies the number of weekends that a soldier
  /// should not have a post in a month.
  /// Its more controller using its [stagePriority] values. So higher stage soldiers
  /// can have less weekend posts while lower stage soldiers then must have more
  /// weekends posts.
  /// By default its equal for every one
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

  /// Creates a new equal holiday post policy.
  /// An equal holiday post policy states that soldiers must have equal number of holiday posts
  /// in a month. But it can be more controller using its [stagePriority] values. So higher stage soldiers can have less holiday posts and lower stage ones
  /// then should have more holiday posts.
  /// By default its equal for every one
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

  /// Creates a new equal post difficulty policy.
  /// An equal post difficulty policy states that soldiers must have equal difficulty of posts.
  /// in a month. But it can be more controller using its [stagePriority] values. So higher stage soldiers can have easier posts and lower stage ones
  /// then should have harder posts.
  /// By default its equal for every one

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
    MinPostCountPerMonth() => 'حداقل پست',
    MaxPostCountPerMonth() => 'حداکثر پست',
    NoWeekendPerMonth() => 'بدون هفته',
    EqualHolidayPost() => 'پست هفتگی',
    EqualPostDifficulty() => 'سختی پست',
  };
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

class MinPostCountPerMonth extends PublicStagedPolicy<int> {
  MinPostCountPerMonth({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.medium,
    super.stagePriority,
  });

  @override
  MinPostCountPerMonth copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MinPostCountPerMonth(
      id: id ?? this.id,
      soldierId: soldierId ?? this.soldierId,
      value: value,
      priority: priority ?? this.priority,
      stagePriority: stagePriority ?? this.stagePriority,
    );
  }
}

class MaxPostCountPerMonth extends PublicStagedPolicy<int> {
  MaxPostCountPerMonth({
    super.id,
    super.soldierId,
    required super.value,
    super.priority = Priority.high,
    super.stagePriority,
  });

  @override
  MaxPostCountPerMonth copyWith({
    int? id,
    int? soldierId,
    Priority? priority,
    Map<ConscriptionStage, int>? stagePriority,
  }) {
    return MaxPostCountPerMonth(
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

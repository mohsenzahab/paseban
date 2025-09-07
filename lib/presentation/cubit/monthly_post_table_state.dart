part of 'monthly_post_table_cubit.dart';

class MonthlyPostTableState extends BlocState {
  const MonthlyPostTableState._(
    super.status, {
    required this.soldiers,
    required this.guardPosts,
    required this.soldiersPosts,
    this.previewSoldiersPosts,
    required this.publicPolicies,
    required this.soldierPolicies,
    required this.holidays,
    DateTimeRange? dateRange,
    super.message,
  }) : _dateRange = dateRange;

  const MonthlyPostTableState.initial()
    : soldiersPosts = const {},
      previewSoldiersPosts = null,
      guardPosts = const {},
      soldiers = const {},
      soldierPolicies = const {},
      publicPolicies = const [],
      holidays = const {},
      _dateRange = null,
      super(BlocStatus.loading);

  factory MonthlyPostTableState(
    BlocStatus status, {
    required List<Soldier> soldiers,
    required List<RawGuardPost> guardPosts,
    required List<SoldierPost> posts,
    required List<PostPolicy> policies,
    required Set<DateTime> holidays,
    required DateTimeRange? dateRange,
    String? message,
  }) {
    final (publicPolicies, soldierPolicies) = _initPolicies(policies);
    return MonthlyPostTableState._(
      status,
      soldiers: _initSoldiers(soldiers),
      guardPosts: _initGuardPosts(guardPosts),
      soldiersPosts: _initSoldierPosts(posts),
      publicPolicies: publicPolicies,
      soldierPolicies: soldierPolicies,
      holidays: holidays,
      dateRange: dateRange,
      message: message,
    );
  }

  /// each map contains the post id as key and the SoldierPost object as value
  final Map<int, Map<DateTime, SoldierPost>> soldiersPosts;
  final Map<int, Map<DateTime, SoldierPost>>? previewSoldiersPosts;

  /// each map contains the post id as key and the GuardPost object as value
  final Map<int, RawGuardPost> guardPosts;

  /// each map contains the soldier id as key and the Soldier object as value
  final Map<int, Soldier> soldiers;

  /// all public policies
  final List<PostPolicy> publicPolicies;

  /// each map contains the soldier id as key and the list of its policies as value
  final Map<int, List<PostPolicy>> soldierPolicies;

  /// saved holidays
  final Set<DateTime> holidays;

  final DateTimeRange? _dateRange;

  DateTimeRange get dateRange =>
      _dateRange ??
      DateTimeRange(
        start: DateTime.now().monthStartDate(CalendarMode.jalali).dateOnly,
        end: DateTime.now().monthEndDate(CalendarMode.jalali).dateOnly,
      );

  @override
  List<Object?> get props => [
    guardPosts,
    soldiersPosts,
    previewSoldiersPosts,
    soldiers,
    publicPolicies,
    soldierPolicies,
    holidays,
    _dateRange,
  ];

  @override
  MonthlyPostTableState copyWith(
    BlocStatus status, {
    List<Soldier>? soldiers,
    List<RawGuardPost>? guardPosts,
    List<PostPolicy>? policies,
    List<SoldierPost>? posts,
    List<DateTime>? holidays,
    DateTimeRange? dateRange,
    String? message,
  }) {
    var (publicPolicies, soldierPolicies) = policies != null
        ? _initPolicies(policies)
        : (this.publicPolicies, this.soldierPolicies);
    return MonthlyPostTableState._(
      status,
      message: message ?? this.message,
      soldiers: soldiers != null ? _initSoldiers(soldiers) : this.soldiers,
      guardPosts: guardPosts != null
          ? _initGuardPosts(guardPosts)
          : this.guardPosts,
      soldiersPosts: posts != null ? _initSoldierPosts(posts) : soldiersPosts,
      publicPolicies: publicPolicies,
      soldierPolicies: soldierPolicies,
      holidays: holidays?.toSet() ?? this.holidays,
      dateRange: dateRange ?? _dateRange,
    );
  }

  MonthlyPostTableState copyWithPreviewPosts(
    Map<int, Map<DateTime, SoldierPost>> posts,
  ) {
    return MonthlyPostTableState._(
      status,
      message: message,
      soldiers: soldiers,
      guardPosts: guardPosts,
      previewSoldiersPosts: posts,
      soldiersPosts: soldiersPosts,
      publicPolicies: publicPolicies,
      soldierPolicies: soldierPolicies,
      holidays: holidays,
      dateRange: _dateRange,
    );
  }

  @override
  BlocState setLoading() {
    return copyWith(BlocStatus.loading);
  }

  static Map<int, Soldier> _initSoldiers(List<Soldier> soldiers) {
    final soldiersMap = <int, Soldier>{};
    for (var s in soldiers) {
      soldiersMap[s.id!] = s;
    }
    return soldiersMap;
  }

  static Map<int, RawGuardPost> _initGuardPosts(List<RawGuardPost> guardPosts) {
    final guardPostsMap = <int, RawGuardPost>{};
    for (var s in guardPosts) {
      guardPostsMap[s.id!] = s;
    }
    return guardPostsMap;
  }

  static Map<int, Map<DateTime, SoldierPost>> _initSoldierPosts(
    List<SoldierPost> posts,
  ) {
    final postsMap = <int, Map<DateTime, SoldierPost>>{};
    for (var p in posts) {
      if (postsMap[p.soldierId] != null) {
        postsMap[p.soldierId]![p.date] = p;
      } else {
        postsMap[p.soldierId] = {p.date: p};
      }
    }
    return postsMap;
  }

  static (List<PostPolicy>, Map<int, List<PostPolicy>>) _initPolicies(
    List<PostPolicy> policies,
  ) {
    final public = <PostPolicy>[];
    final soldiers = <int, List<PostPolicy>>{};
    for (var pol in policies) {
      final soldierId = pol.soldierId;

      if (soldierId == null) {
        public.add(pol);
      } else {
        if (soldiers[soldierId] == null) {
          soldiers[soldierId] = [pol];
        } else {
          soldiers[soldierId]!.add(pol);
        }
      }
    }
    return (public, soldiers);
  }
}

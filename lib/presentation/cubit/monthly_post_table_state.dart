part of 'monthly_post_table_cubit.dart';

class MonthlyPostTableState extends BlocState {
  const MonthlyPostTableState._(
    super.status, {
    required this.soldiers,
    required this.guardPosts,
    required this.soldierPosts,
    required this.publicPolicies,
    required this.soldierPolicies,
    DateTimeRange? dateRange,
    super.message,
  }) : _dateRange = dateRange;

  const MonthlyPostTableState.initial()
    : soldierPosts = const {},
      guardPosts = const {},
      soldiers = const {},
      soldierPolicies = const {},
      publicPolicies = const [],
      _dateRange = null,
      super(BlocStatus.loading);

  factory MonthlyPostTableState(
    BlocStatus status, {
    required List<Soldier> soldiers,
    required List<GuardPost> guardPosts,
    required List<SoldierPost> posts,
    required List<PostPolicy> policies,
    required DateTimeRange? dateRange,
    String? message,
  }) {
    final (publicPolicies, soldierPolicies) = _initPolicies(policies);
    return MonthlyPostTableState._(
      status,
      soldiers: _initSoldiers(soldiers),
      guardPosts: _initGuardPosts(guardPosts),
      soldierPosts: _initSoldierPosts(posts),
      publicPolicies: publicPolicies,
      soldierPolicies: soldierPolicies,
      dateRange: dateRange,
      message: message,
    );
  }

  final Map<int, Map<DateTime, SoldierPost>> soldierPosts;
  // each map contains the post id as key and the GuardPost object as value
  final Map<int, GuardPost> guardPosts;

  final Map<int, Soldier> soldiers;

  final List<PostPolicy> publicPolicies;

  final Map<int, List<PostPolicy>> soldierPolicies;

  final DateTimeRange? _dateRange;

  DateTimeRange get dateRange =>
      _dateRange ??
      DateTimeRange(
        start: DateTime.now().monthStartDate(CalendarMode.jalali).dateOnly,
        end: DateTime.now().monthEndDate(CalendarMode.jalali).dateOnly,
      );

  @override
  List<Object> get props => [
    guardPosts,
    soldierPosts,
    soldiers,
    publicPolicies,
    soldierPolicies,
  ];

  @override
  MonthlyPostTableState copyWith(
    BlocStatus status, {
    List<Soldier>? soldiers,
    List<GuardPost>? guardPosts,
    List<PostPolicy>? policies,
    List<SoldierPost>? posts,
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
      soldierPosts: posts != null ? _initSoldierPosts(posts) : soldierPosts,
      publicPolicies: publicPolicies,
      soldierPolicies: soldierPolicies,
      dateRange: dateRange ?? _dateRange,
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

  static Map<int, GuardPost> _initGuardPosts(List<GuardPost> guardPosts) {
    final guardPostsMap = <int, GuardPost>{};
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
    final public = List<PostPolicy>.empty();
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

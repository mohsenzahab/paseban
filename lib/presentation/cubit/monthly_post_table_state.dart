part of 'monthly_post_table_cubit.dart';

class MonthlyPostTableState extends BlocState {
  const MonthlyPostTableState(
    super.status, {
    required List<Soldier> soldiers,
    required List<GuardPost> posts,
    required List<PostPolicy> policies,
    super.message,
  }): soldierPosts=
  ;

  const MonthlyPostTableState.initial()
    : soldierPosts = const {},
      guardPosts = const {},
      super(BlocStatus.loading);

  // each list contains 29 - 31 integers representing the post id for each day of the month
  final Map<Soldier, List<int>> soldierPosts;
  // each map contains the post id as key and the GuardPost object as value
  final Map<int, GuardPost> guardPosts;

  @override
  List<Object> get props => [guardPosts, soldierPosts];

  @override
  MonthlyPostTableState copyWith(
    BlocStatus status, {
    List<Soldier>? soldiers,
    List<GuardPost>? posts,
    List<PostPolicy>? policies,
    String? message,
  }) {
    return MonthlyPostTableState(
      status,
      soldierPosts: soldierPosts,
      guardPosts: guardPosts,
      message: message ?? this.message,
    );
  }

  @override
  BlocState setLoading() {
    return copyWith(BlocStatus.loading);
  }
}

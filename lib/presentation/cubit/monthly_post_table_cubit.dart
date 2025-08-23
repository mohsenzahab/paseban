import 'package:bloc/bloc.dart';
import 'package:paseban/core/bloc/state.dart';
import 'package:paseban/data/db/app_database.dart';
import 'package:paseban/domain/repositories/guard_post_repository.dart';
import 'package:paseban/domain/repositories/post_policy_repository.dart';
import 'package:paseban/domain/repositories/soldier_repository.dart';

import '../../domain/models/models.dart';

part 'monthly_post_table_state.dart';

class MonthlyPostTableCubit extends Cubit<MonthlyPostTableState> {
  MonthlyPostTableCubit() : super(const MonthlyPostTableState.initial()) {
    db = AppDatabase();
    soldierRepository = SoldierRepository(db);
    guardPostRepository = GuardPostRepository(db);
    policyRepository = PostPolicyRepository(db);
  }

  late final AppDatabase db;
  late final SoldierRepository soldierRepository;
  late final GuardPostRepository guardPostRepository;
  late final PostPolicyRepository policyRepository;

  void _init() {
    final futures = Future.wait([
      soldierRepository.getAll(),
      guardPostRepository.getAll(),
      policyRepository.getAll(),
    ]);

    futures
        .then((results) {
          final soldiers = results[0] as List<Soldier>;
          final guardPosts = results[1] as List<GuardPost>;
          final policies = results[2] as List<PostPolicy>;

          emit(
            state.copyWith(
              BlocStatus.ready,
              soldiers: soldiers,
              guardPosts: guardPosts,
              policies: policies,
            ),
          );
        })
        .catchError((error) {
          emit(MonthlyPostTableState.error(error.toString()));
        });
  }
}

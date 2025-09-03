import 'package:get_it/get_it.dart';
import 'package:paseban/data/db/app_database.dart';
import 'package:paseban/domain/repositories/calendar_repository.dart';

import '../domain/repositories/repositories.dart';
import '../presentation/cubit/monthly_post_table_cubit.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  final db = AppDatabase();
  sl.registerSingleton(db);
  sl.registerSingleton(SoldierRepository(db));
  sl.registerSingleton(GuardPostRepository(db));
  sl.registerSingleton(PostPolicyRepository(db));
  sl.registerSingleton(SoldierPostRepository(db));
  sl.registerSingleton(CalendarRepository(db));
  sl.registerLazySingleton(
    () => MonthlyPostTableCubit(sl(), sl(), sl(), sl(), sl(), sl()),
  );
}

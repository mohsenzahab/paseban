import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:paseban/core/bloc/bloc_messenger.dart';
import 'package:paseban/core/bloc/state.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/data/db/app_database.dart';
import 'package:paseban/domain/repositories/guard_post_repository.dart';
import 'package:paseban/domain/repositories/post_policy_repository.dart';
import 'package:paseban/domain/repositories/soldier_post_repository.dart';
import 'package:paseban/domain/repositories/soldier_repository.dart';

import '../../domain/models/models.dart';
import '../../domain/models/soldier_post.dart';

part 'monthly_post_table_state.dart';

class MonthlyPostTableCubit extends Cubit<MonthlyPostTableState>
    with BlocMessenger {
  MonthlyPostTableCubit(
    this.db,
    this.soldierRepository,
    this.guardPostRepository,
    this.policyRepository,
    this.soldierPostRepository,
  ) : super(const MonthlyPostTableState.initial()) {
    _init();
  }

  final AppDatabase db;
  final SoldierRepository soldierRepository;
  final GuardPostRepository guardPostRepository;
  final PostPolicyRepository policyRepository;
  final SoldierPostRepository soldierPostRepository;

  void _init() {
    final sDate = DateTime.now().monthStartDate(CalendarMode.jalali);
    final eDate = DateTime.now().monthEndDate(CalendarMode.jalali);
    final futures = Future.wait([
      soldierRepository.getAll(),
      guardPostRepository.getAll(),
      policyRepository.getAll(),
      soldierPostRepository.getSoldierPostsFromRange(
        DateTimeRange(start: sDate, end: eDate),
      ),
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
          addError(error);
        });
  }

  void addSoldier(Map<String, dynamic> value) async {
    final s = Soldier.fromMap(value);
    final soldier = await soldierRepository.insert(s);
    if (soldier != null) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          soldiers: await soldierRepository.getAll(),
        ),
      );
      addSuccess('سرباز اضافه شد');
    } else {
      addError('سرباز اضافه نشد');
    }
  }

  void editSoldier(Map<String, dynamic> value, int id) async {
    final s = Soldier.fromMap(value).copyWith(id: id);
    final result = await soldierRepository.updateSoldier(s);
    if (result) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          soldiers: await soldierRepository.getAll(),
        ),
      );
      addSuccess('سرباز ویرایش شد');
    } else {
      addError('سرباز ویرایش نشد');
    }
  }

  void deleteSoldier(Soldier soldier) async {
    await soldierRepository.deleteById(soldier.id!);
    emit(
      state.copyWith(
        BlocStatus.ready,
        soldiers: await soldierRepository.getAll(),
      ),
    );
    addSuccess('سرباز حذف شد');
  }

  void addGuardPost(GuardPost post) async {
    final result = await guardPostRepository.insert(post);
    if (result != -1) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          guardPosts: await guardPostRepository.getAll(),
        ),
      );
      addSuccess('پست اضافه شد');
    } else {
      addError('پست اضافه نشد');
    }
  }

  void deleteGuardPost(int? id) async {
    guardPostRepository.deleteById(id!);
    emit(
      state.copyWith(
        BlocStatus.ready,
        guardPosts: await guardPostRepository.getAll(),
      ),
    );
    addSuccess('پست حذف شد');
  }
}

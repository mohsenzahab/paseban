import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:paseban/core/bloc/bloc_messenger.dart';
import 'package:paseban/core/bloc/state.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/data/db/app_database.dart';
import 'package:paseban/domain/scheduler/gemeni/v1/gemini_scheduler.dart';
import 'package:paseban/domain/scheduler/gpt/v1/scheduler_advanced.dart';
import 'package:paseban/domain/repositories/calendar_repository.dart';
import 'package:paseban/domain/repositories/guard_post_repository.dart';
import 'package:paseban/domain/repositories/post_policy_repository.dart';
import 'package:paseban/domain/repositories/soldier_post_repository.dart';
import 'package:paseban/domain/repositories/soldier_repository.dart';
import 'package:paseban/domain/scheduler/gpt/v2/scheduler_advanced.dart';

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
    this.calendarRepository,
  ) : super(const MonthlyPostTableState.initial()) {
    _init();
  }

  final CalendarRepository calendarRepository;
  final AppDatabase db;
  final GuardPostRepository guardPostRepository;
  final PostPolicyRepository policyRepository;
  final SoldierPostRepository soldierPostRepository;
  final SoldierRepository soldierRepository;

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

  void addGuardPost(RawGuardPost post) async {
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
    await guardPostRepository.deleteById(id!);
    emit(
      state.copyWith(
        BlocStatus.ready,
        guardPosts: await guardPostRepository.getAll(),
      ),
    );
    addSuccess('پست حذف شد');
  }

  void addPolicy(PostPolicy value) async {
    final result = await policyRepository.insert(value);
    if (result != -1) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          policies: await policyRepository.getAll(),
        ),
      );
      addSuccess('سیاست اضافه شد');
    } else {
      addFailure('سیاست اضافه نشد');
    }
  }

  void removePolicy(PostPolicy policy) async {
    await policyRepository.deleteById(policy.id!);
    emit(
      state.copyWith(
        BlocStatus.ready,
        policies: await policyRepository.getAll(),
      ),
    );
    addSuccess('سیاست حذف شد');
  }

  void editPolicy(PostPolicy value, int id) async {
    final result = await policyRepository.updatePolicy(value.copyWith(id: id));
    if (result) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          policies: await policyRepository.getAll(),
        ),
      );
      addSuccess('سیاست ویرایش شد');
    } else {
      addError('سیاست ویرایش نشد');
    }
  }

  Future<void> updateSoldierPost(SoldierPost post) async {
    // log('Updating soldier post:$post');
    final result = await soldierPostRepository.insert(post);
    if (result != -1) {
      final posts = await soldierPostRepository.getSoldierPostsFromRange(
        DateTimeRange(start: state.dateRange.start, end: state.dateRange.end),
      );
      log('Getting soldier posts');
      final prevPosts = state.previewSoldiersPosts == null
          ? null
          : Map<int, Map<DateTime, SoldierPost>>.from(
              state.previewSoldiersPosts!,
            );
      prevPosts?[post.soldierId]?[post.date] = post;
      emit(
        state.copyWith(
          BlocStatus.ready,
          posts: posts,
          previewSoldiersPosts: prevPosts,
        ),
      );
      // addSuccess('سیاست ویرایش شد');
    } else {
      addError('ویرایش پست ناموفق ');
    }
  }

  void deleteSoldierPost(SoldierPost oldValue) async {
    soldierPostRepository.delete(oldValue.soldierId, oldValue.date);
    final posts = await soldierPostRepository.getSoldierPostsFromRange(
      DateTimeRange(start: state.dateRange.start, end: state.dateRange.end),
    );
    emit(state.copyWith(BlocStatus.ready, posts: posts));
  }

  void toggleHoliday(DateTime date) async {
    final exists = state.holidays.contains(date);
    if (exists) {
      await calendarRepository.deleteHoliday(date);
    } else {
      await calendarRepository.insertHoliday(date);
    }
    final holidays = await calendarRepository.getHolidaysInRange(
      state.dateRange,
    );
    emit(state.copyWith(BlocStatus.ready, holidays: holidays));
  }

  void editGuardPost(RawGuardPost post, int id) async {
    final result = await guardPostRepository.updatePost(post.copyWith(id: id));
    if (result) {
      emit(
        state.copyWith(
          BlocStatus.ready,
          guardPosts: await guardPostRepository.getAll(),
        ),
      );
      addSuccess('پست ویرایش شد');
    } else {
      addError('پست ویرایش نشد');
    }
  }

  void _init() {
    final sDate = DateTime.now().monthStartDate(CalendarMode.jalali).dateOnly;
    final eDate = DateTime.now().monthEndDate(CalendarMode.jalali).dateOnly;
    final futures = Future.wait([
      soldierRepository.getAll(),
      guardPostRepository.getAll(),
      policyRepository.getAll(),
      soldierPostRepository.getSoldierPostsFromRange(
        DateTimeRange(start: sDate, end: eDate),
      ),
      calendarRepository.getHolidaysInRange(
        DateTimeRange(start: sDate, end: eDate),
      ),
    ]);

    futures
        .then((results) {
          final soldiers = results[0] as List<Soldier>;
          final guardPosts = results[1] as List<RawGuardPost>;
          final policies = results[2] as List<PostPolicy>;
          final soldiersPosts = results[3] as List<SoldierPost>;
          final holidays = results[4] as List<DateTime>;

          emit(
            state.copyWith(
              BlocStatus.ready,
              soldiers: soldiers,
              guardPosts: guardPosts,
              policies: policies,
              posts: soldiersPosts,
              holidays: holidays,
              dateRange: DateTimeRange(start: sDate, end: eDate),
            ),
          );
        })
        .catchError((error) {
          addError(error);
        });
  }

  void runScheduler() async {
    // final result = await GuardScheduler(
    //   soldiers: state.soldiers,
    //   guardPosts: state.guardPosts,
    //   publicPolicies: state.publicPolicies,
    //   soldierPolicies: state.soldierPolicies,
    //   holidays: state.holidays,
    //   dateRange: state.dateRange,
    // ).generate();
    // final result = SchedulerAdvanced().generate(
    //   soldiers: state.soldiers,
    //   guardPosts: state.guardPosts,
    //   publicPolicies: state.publicPolicies,
    //   soldierPolicies: state.soldierPolicies,
    //   holidays: state.holidays,
    //   dateRange: state.dateRange,
    // );
    // final result = AdvancedScheduler(
    //   soldiers: state.soldiers,
    //   guardPosts: state.guardPosts,

    //   dateRange: state.dateRange,
    //   constraints:
    // );
    final result = await GuardScheduler(
      soldiers: state.soldiers,
      guardPosts: state.guardPosts,
      publicPolicies: state.publicPolicies,
      soldierPolicies: state.soldierPolicies,
      holidays: state.holidays,
      dateRange: state.dateRange,
      initialSchedule: state.soldiersPosts,
    ).generate();
    emit(state.copyWithPreviewPosts(result));
  }

  void setDateRange(DateTime start, DateTime end) {
    emit(
      state.copyWith(
        BlocStatus.ready,
        dateRange: DateTimeRange(start: start.dateOnly, end: end.dateOnly),
      ),
    );
  }

  void savePreviewPosts() async {
    handleError(() async {
      await soldierPostRepository.insertAll(
        state.previewSoldiersPosts!.entries
            .expand((e) => e.value.values)
            .toList(),
      );
      final posts = await soldierPostRepository.getSoldierPostsFromRange(
        DateTimeRange(start: state.dateRange.start, end: state.dateRange.end),
      );
      emit(state.copyWith(BlocStatus.ready, posts: posts));
    });
  }

  void clearPreviewPosts() {
    emit(state.copyWithPreviewPosts(null));
  }

  void clearAllPosts() async {
    await soldierPostRepository.deleteAll();
    final posts = await soldierPostRepository.getSoldierPostsFromRange(
      DateTimeRange(start: state.dateRange.start, end: state.dateRange.end),
    );
    emit(
      state.copyWith(BlocStatus.ready, posts: posts).copyWithPreviewPosts(null),
    );
  }

  void deleteAllAutoPosts() async {
    await soldierPostRepository.deleteAllAutoPosts();
    final posts = await soldierPostRepository.getSoldierPostsFromRange(
      DateTimeRange(start: state.dateRange.start, end: state.dateRange.end),
    );
    emit(
      state.copyWith(BlocStatus.ready, posts: posts).copyWithPreviewPosts(null),
    );
  }

  void handleError(FutureOr<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      addError(e);
    }
  }
}

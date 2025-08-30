import 'dart:convert';

import '../enums.dart';
import 'weekday.dart';

class GuardPost {
  final int? id;
  final String title; // عنوان پست (مثلا برجک شمالی)
  final List<Weekday>? weekDays; // روزهای هفته (۱=شنبه ... ۷=جمعه)
  final int repeat;
  final List<int>? monthDays; // روزهای ماه (۱ تا ۳۱)
  final GuardPostDifficulty difficulty; // درجه سختی
  final int shiftsPerDay; // تعداد پاس (مثلا ۲ یا ۳)

  GuardPost({
    this.id,
    required this.title,
    this.weekDays,
    this.monthDays,
    this.repeat = 1,
    required this.difficulty,
    required this.shiftsPerDay,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'repeat': repeat});
    if (monthDays != null) {
      result.addAll({'monthDays': monthDays});
    }
    if (weekDays != null) {
      result.addAll({'weekdays': weekDays});
    }
    result.addAll({'difficulty': difficulty.index});
    result.addAll({'shiftsPerDay': shiftsPerDay});

    return result;
  }

  Map<String, dynamic> toFormValues() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'repeat': repeat.toString()});
    if (monthDays != null) {
      result.addAll({'monthDays': monthDays});
    }
    if (weekDays != null) {
      result.addAll({'weekdays': weekDays});
    }
    result.addAll({'difficulty': difficulty.index});
    result.addAll({'shiftsPerDay': shiftsPerDay.toString()});

    return result;
  }

  factory GuardPost.fromMap(Map<String, dynamic> map) {
    return GuardPost(
      id: map['id']?.toInt(),
      title: map['title'],
      repeat: map['repeat'],
      monthDays: map['monthDays'] == null
          ? null
          : List<int>.from(map['monthDays']),
      weekDays: map['weekdays'] == null
          ? null
          : List<Weekday>.from(map['weekdays'].map((x) => Weekday.values[x])),
      difficulty: GuardPostDifficulty.values[map['difficulty']],
      shiftsPerDay: map['shiftsPerDay']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuardPost.fromJson(String source) =>
      GuardPost.fromMap(json.decode(source));
}

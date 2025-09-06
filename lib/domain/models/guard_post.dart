import 'dart:convert';

import '../enums.dart';
import 'weekday.dart';

/// اطلاعات پست نگهبانی. در هر پادگان پست های نگهبانی وجود دارد که حاوی اطلاعات زیر است.
/// هر سرباز می تواند یک پست نگهبانی در روز داشته باشد.
class RawGuardPost {
  RawGuardPost({
    this.id,
    required this.title,
    this.weekDays,
    this.monthDays,
    required this.difficulty,
    required this.shiftsPerDay,

    /// without repeat
    this.periodRepeat = 1,
    this.periodStartDate,
  }) : assert(weekDays == null || monthDays == null),
       assert(monthDays == null || periodRepeat == 1),
       assert(periodRepeat == 1 || periodStartDate != null),
       assert(weekDays == null || weekDays.length == periodRepeat),
       assert(monthDays == null || monthDays.length == periodRepeat),

       assert(
         periodStartDate == null ||
             periodStartDate.weekday == weekDays!.first.first.value,
       );

  factory RawGuardPost.fromJson(String source) =>
      RawGuardPost.fromMap(json.decode(source));

  factory RawGuardPost.fromMap(Map<String, dynamic> map) {
    return RawGuardPost(
      id: map['id']?.toInt(),
      title: map['title'],
      periodRepeat: map['repeat'],
      monthDays: map['monthDays'] == null
          ? null
          : List<int>.from(map['monthDays']),
      weekDays: map['weekdays'] == null
          ? null
          : List<List<Weekday>>.from(
              map['weekdays']!.map((x) {
                return List<Weekday>.from(
                  x.map((e) {
                    return Weekday.values[e];
                  }),
                );
              }),
            ),
      difficulty: GuardPostDifficulty.values[map['difficulty']],
      shiftsPerDay: map['shiftsPerDay']?.toInt() ?? 0,
      periodStartDate: map['periodStartDate'] == null
          ? null
          : DateTime.parse(map['periodStartDate']),
    );
  }

  /// درجه سختی
  final GuardPostDifficulty difficulty;

  final int? id;

  /// می تواند مقادری ۱ تا ۳۱ را بگیرد. اگر null باشد هیچ تاثیری ندارد. این مقادیر نشان دهنده این است که این نگهبانی فقط در این روزهای مشخص تکرار می شود. اگر این مقدار مجود باشد، [weekDays] باید null باشد.
  final List<int>? monthDays; // روزهای ماه (۱ تا ۳۱)

  /// تعداد تکرار برای [weekDays] یا [monthDays]. مثلا اگر ۱ باشد، یعنی الگوی [weekDays] هر هفته تکرار می شود و اگر ۲ باشد، این الگو هر ۲ هفته یکبار تکرار می شود
  final int periodRepeat;

  /// calculations for [weekDays] and month days will start form this date.
  /// for example if we have
  /// ```dart
  /// final weekDays = [[Weekday.saturday,Weekday.friday],[],[Weekday.sunday]];
  /// ```
  /// then [periodRepeat] must be equal to 3 (weekDays.length) and also
  /// `[periodStartDate]!=null`.
  final DateTime? periodStartDate;

  /// تعداد پاس (مثلا ۲ یا ۳)
  /// بیشتر از این تعداد پاس در یکروز به سرباز ها تعلق نمی گیرد.
  final int shiftsPerDay;

  /// عنوان پست (مثلا برجک شمالی)
  final String title;

  /// مثلا [Weekday.shanbeh, Weekday.jomeh]
  /// اگر موجود باشد، یعنی این نگهبانی در این روزهای هفته تکرار می شود. اگر null باشد یعنی هر روز هفته تکرار می شود.
  final List<List<Weekday>>? weekDays;

  bool includesDate(DateTime date) {
    switch ((periodRepeat, weekDays, monthDays)) {
      // Every day
      case (1, null, null):
        return true;
      // Weekly pattern
      case (1, List<List<Weekday>> w, null):
        return w.first.contains(Weekday.fromValue(date.weekday));
      // Monthly pattern
      case (1, null, List<int> m):
        return m.contains(date.day);
      // Custom repeat with weekDays
      case (int repeat, List<List<Weekday>> w, null):
        if (periodStartDate == null) return false;
        final daysDiff = date.difference(periodStartDate!).inDays;
        if (daysDiff < 0) return false;
        final weekIndex = (daysDiff ~/ 7) % repeat;
        return w[weekIndex].contains(Weekday.fromValue(date.weekday));
      // Custom repeat with monthDays
      case (int repeat, null, List<int> m):
        if (periodStartDate == null) return false;
        final daysDiff = date.difference(periodStartDate!).inDays;
        if (daysDiff < 0) return false;
        final periodIndex = (daysDiff ~/ 30) % repeat;
        return m[periodIndex] == date.day;
      default:
        return false;
    }
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'repeat': periodRepeat});
    if (monthDays != null) {
      result.addAll({'monthDays': monthDays});
    }
    if (weekDays != null) {
      result.addAll({'weekdays': weekDays});
    }
    result.addAll({'difficulty': difficulty.index});
    result.addAll({'shiftsPerDay': shiftsPerDay});
    if (periodStartDate != null) {
      result.addAll({'periodStartDate': periodStartDate?.toIso8601String()});
    }
    return result;
  }

  Map<String, dynamic> toFormValues() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'repeat': periodRepeat.toString()});
    result.addAll({'monthDays': monthDays});

    result.addAll({'weekdays': weekDays});

    result.addAll({'difficulty': difficulty.index});
    result.addAll({'shiftsPerDay': shiftsPerDay.toString()});
    result.addAll({'periodStartDate': periodStartDate});

    return result;
  }

  String toJson() => json.encode(toMap());

  RawGuardPost copyWith({
    GuardPostDifficulty? difficulty,
    int? id,
    List<int>? monthDays,
    int? periodRepeat,
    DateTime? periodStartDate,
    int? shiftsPerDay,
    String? title,
    List<List<Weekday>>? weekDays,
  }) {
    return RawGuardPost(
      difficulty: difficulty ?? this.difficulty,
      id: id ?? this.id,
      monthDays: monthDays ?? this.monthDays,
      periodRepeat: periodRepeat ?? this.periodRepeat,
      periodStartDate: periodStartDate ?? this.periodStartDate,
      shiftsPerDay: shiftsPerDay ?? this.shiftsPerDay,
      title: title ?? this.title,
      weekDays: weekDays ?? this.weekDays,
    );
  }
}

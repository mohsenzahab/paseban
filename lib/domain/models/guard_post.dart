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
}

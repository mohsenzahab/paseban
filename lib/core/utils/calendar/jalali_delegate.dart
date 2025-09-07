import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JalaliDate extends DateTime {
  JalaliDate(super.year);
}

class JalaliCalendarDelegate extends CalendarDelegate {
  /// Convert [DateTime] to [Jalali].
  Jalali _toJalali(DateTime date) => Jalali.fromDateTime(date);

  /// Convert [Jalali] to [DateTime].
  DateTime _toDateTime(Jalali date) => date.toDateTime();

  @override
  DateTime addDaysToDate(DateTime date, int days) {
    final j = _toJalali(date).addDays(days);
    return _toDateTime(j);
  }

  @override
  DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    final j = _toJalali(monthDate).addMonths(monthsToAdd);
    return _toDateTime(j);
  }

  @override
  String dateHelpText(MaterialLocalizations localizations) {
    // Pattern: yyyy/mm/dd (Jalali)
    return 'yyyy/mm/dd';
  }

  @override
  DateTime dateOnly(DateTime date) {
    final j = _toJalali(date);
    return _toDateTime(Jalali(j.year, j.month, j.day));
  }

  @override
  int firstDayOffset(int year, int month, MaterialLocalizations localizations) {
    final firstDay = Jalali(year, month, 1).toDateTime().weekday;
    // Flutter expects offset from Sunday = 0
    return (firstDay % 7);
  }

  @override
  String formatCompactDate(DateTime date, MaterialLocalizations localizations) {
    final j = _toJalali(date);
    return '${j.year}/${j.month}/${j.day}';
  }

  @override
  String formatFullDate(DateTime date, MaterialLocalizations localizations) {
    final j = _toJalali(date);
    final formatter = j.formatter;
    return '${formatter.wN} ${formatter.d} ${formatter.mN} ${formatter.yyyy}';
  }

  @override
  String formatMediumDate(DateTime date, MaterialLocalizations localizations) {
    final j = _toJalali(date);
    return '${j.year}/${j.month}/${j.day}';
  }

  @override
  String formatMonthYear(DateTime date, MaterialLocalizations localizations) {
    final j = _toJalali(date);
    return '${j.formatter.mN} ${j.year}';
  }

  @override
  String formatShortDate(DateTime date, MaterialLocalizations localizations) {
    final j = _toJalali(date);
    return '${j.year}/${j.month}/${j.day}';
  }

  @override
  String formatShortMonthDay(
    DateTime date,
    MaterialLocalizations localizations,
  ) {
    final j = _toJalali(date);
    return '${j.month}/${j.day}';
  }

  @override
  DateTime getDay(int year, int month, int day) {
    return DateTime(year, month, day);
  }

  @override
  int getDaysInMonth(int year, int month) {
    final j = DateTime(year, month, 1).toJalali();
    return j.monthLength;
  }

  @override
  DateTime getMonth(int year, int month) {
    return DateTime(year, month).toJalali().copy(day: 1).toDateTime();
  }

  @override
  int monthDelta(DateTime startDate, DateTime endDate) {
    final j1 = _toJalali(startDate);
    final j2 = _toJalali(endDate);
    return (j2.year - j1.year) * 12 + (j2.month - j1.month);
  }

  @override
  DateTime now() {
    return Jalali.now().toDateTime();
  }

  @override
  DateTime? parseCompactDate(
    String? inputString,
    MaterialLocalizations localizations,
  ) {
    if (inputString == null) return null;
    try {
      final parts = inputString.split('/');
      if (parts.length != 3) return null;
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      return Jalali(year, month, day).toDateTime();
    } catch (_) {
      return null;
    }
  }
}

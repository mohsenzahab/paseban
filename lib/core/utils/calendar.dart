import 'package:flutter/material.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JalaliCalendarDelegate extends CalendarDelegate {
  @override
  DateTime addDaysToDate(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  @override
  DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return monthDate.toJalali().addMonths(monthsToAdd).toDateTime();
  }

  @override
  String dateHelpText(MaterialLocalizations localizations) {
    return 'help text';
  }

  @override
  DateTime dateOnly(DateTime date) {
    return date.dateOnly;
  }

  @override
  int firstDayOffset(int year, int month, MaterialLocalizations localizations) {
    return DateUtils.firstDayOffset(year, month, localizations);
  }

  @override
  String formatCompactDate(DateTime date, MaterialLocalizations localizations) {
    return formatJalaliCompactDate(date);
  }

  JalaliFormatter f(DateTime date) => Jalali.fromDateTime(date).formatter;

  @override
  String formatFullDate(DateTime date, MaterialLocalizations localizations) {
    return '${f(date).wN}, ${f(date).d} ${f(date).mN}, ${f(date).yyyy}';
  }

  @override
  String formatMediumDate(DateTime date, MaterialLocalizations localizations) {
    return '${f(date).wN}, ${f(date).d} ${f(date).mN}';
  }

  @override
  String formatMonthYear(DateTime date, MaterialLocalizations localizations) {
    return '${f(date).mN} ${f(date).yyyy}';
  }

  @override
  String formatShortDate(DateTime date, MaterialLocalizations localizations) {
    return '${f(date).d} ${f(date).m}, ${f(date).yyyy}';
  }

  @override
  String formatShortMonthDay(
    DateTime date,
    MaterialLocalizations localizations,
  ) {
    return '${f(date).d} ${f(date).mN}';
  }

  @override
  DateTime getDay(int year, int month, int day) {
    return Jalali(year, month, day).toDateTime();
  }

  @override
  int getDaysInMonth(int year, int month) {
    return Jalali(year, month).monthLength;
  }

  @override
  DateTime getMonth(int year, int month) {
    return Jalali(year, month).toDateTime();
  }

  @override
  int monthDelta(DateTime startDate, DateTime endDate) {
    return Jalali.fromDateTime(
      endDate,
    ).distanceTo(Jalali.fromDateTime(startDate));
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
    return parseJalaliCompactDate(inputString!).toDateTime();
  }
}

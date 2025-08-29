import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

enum CalendarMode { gregorian, jalali }

String jalaliFormatter(DateTime date) {
  var f = date.toJalali().formatter;

  return '${f.yyyy}/${f.m}/${f.dd}';
}

String gregorianFormatter(DateTime date) {
  var f = date.toGregorian().formatter;
  return '${f.m}/${f.dd}/${f.yyyy}';
}

String format(DateTime date, String localName) {
  if (localName == 'fa') {
    return jalaliFormatter(date);
  } else {
    return gregorianFormatter(date);
  }
}

extension DateHelper on DateTime {
  static DateTime withCalendar(
    CalendarMode calendarMode,
    int year, [
    int month = 1,
    int day = 1,
  ]) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return DateTime(year, month, day);
      case CalendarMode.jalali:
        return Jalali(year, month, day).toDateTime();
    }
  }

  JalaliFormatter get jf => Jalali.fromDateTime(this).formatter;

  Jalali get jalaliDate => Jalali.fromDateTime(this);

  String format(CalendarMode calendarMode, String locale) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateFormat('MM/dd/yyyy', locale).format(this);
    } else {
      var d = Jalali.fromDateTime(this);
      final nf = NumberFormat('####', locale);
      return '${nf.format(d.year)}/${nf.format(d.month)}/${nf.format(d.day)}';
    }
  }

  String dayOfMonthStr(CalendarMode calendarMode, Locale locale) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateFormat('MM/dd').format(this);
    } else {
      var f = Jalali.fromDateTime(this).formatter;
      return '${f.mm}/${f.dd}';
    }
  }

  int weekDay(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return weekday;
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).weekDay;
    }
  }

  String dayOfWeek(Locale locale) {
    if (locale.languageCode == 'en') {
      return Gregorian.fromDateTime(this).formatter.wN;
    } else {
      return Jalali.fromDateTime(this).formatter.wN;
    }
  }

  String toDBDate() {
    return toString().split(' ')[0];
  }

  String toDBDateTime() => DateFormat('yyyy-MM-ddTHH:MM').format(this);

  bool isInSameWeekWith(DateTime other, CalendarMode calendarMode) {
    return weekStartDate(
      calendarMode,
    ).isSameDate(other.weekStartDate(calendarMode));
  }

  bool isLeapYear(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return Gregorian.fromDateTime(this).isLeapYear();
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).isLeapYear();
    }
  }

  static int firstDayOfWeek(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return 1;
      case CalendarMode.jalali:
        return 6;
    }
  }

  static int lastDayOfWeek(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return 0;
      case CalendarMode.jalali:
        return 5;
    }
  }

  DateTime weekStartDate(CalendarMode calendarMode) =>
      subtract(Duration(days: (weekday - firstDayOfWeek(calendarMode)) % 7));

  DateTime weekEndDate(CalendarMode calendarMode) =>
      add(Duration(days: (lastDayOfWeek(calendarMode) - weekday) % 7));

  DateTime monthStartDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month, 1);
    } else {
      return Jalali.fromDateTime(this).copy(day: 1).toDateTime();
    }
  }

  DateTime monthEndDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month + 1, 0);
    } else {
      return Jalali.fromDateTime(
        this,
      ).copy(day: 1).addMonths(1).addDays(-1).toDateTime();
    }
  }

  int daysInMonth(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return DateTime(year, month + 1, 0).day;
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).monthLength;
    }
  }

  int dayOfMonth(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return day;
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).day;
    }
  }

  int monthNumber(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return month;
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).month;
    }
  }

  int yearNumber(CalendarMode calendarMode) {
    switch (calendarMode) {
      case CalendarMode.gregorian:
        return year;
      case CalendarMode.jalali:
        return Jalali.fromDateTime(this).year;
    }
  }

  DateTime yearStartDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, 1, 1);
    } else {
      return Jalali.fromDateTime(this).copy(month: 1, day: 1).toDateTime();
    }
  }

  DateTime yearEndDate(CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year + 1, 1, 1).subtract(Duration(days: 1));
    } else {
      return Jalali.fromDateTime(
        this,
      ).copy(month: 1, day: 1).addYears(1).addDays(-1).toDateTime();
    }
  }

  int dateDifference(DateTime secondDate) {
    return dateOnly.difference(secondDate.dateOnly).inDays;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Operator for date not time
  bool operator <=(DateTime o) {
    return year <= o.year && month <= o.month && day <= o.day;
  }

  /// Operator for date not time
  bool operator >=(DateTime o) {
    return year >= o.year && month >= o.month && day >= o.day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (isAfter(startDate) || isSameDate(startDate)) &&
        (isBefore(endDate) || isSameDate(endDate));
  }

  DateTime get dateOnly => DateTime(year, month, day);

  // String getGregorianWeekDayAndDate() {
  //   final f = DateFormat('EEEE, MMM d');
  //   return f.format(this);
  // }

  DateTime addMonth(int count, CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year, month + count, day, hour, minute, second);
    } else {
      return Jalali.fromDateTime(this).addMonths(count).toDateTime();
    }
  }

  DateTime addYears(int count, CalendarMode calendarMode) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateTime(year + 1, month, day);
    } else {
      return Jalali.fromDateTime(this).addYears(count).toDateTime();
    }
  }

  String getJalaliDay() {
    final f = Jalali.fromDateTime(this).formatter;

    return f.d;
  }

  String getWeekDayAndDate(CalendarMode calendarMode, BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    if (calendarMode == CalendarMode.gregorian) {
      return DateFormat('MMMEd', locale.toString()).format(this);
    }

    //TODO: if calendar mode is jalali, we must translate fa to other languages.
    switch (locale.languageCode) {
      default:
        //persian
        final f = Jalali.fromDateTime(this).formatter;
        return '${f.wN}، ${MaterialLocalizations.of(context).formatDecimal(f.date.day)} ${f.mN}';
    }
  }

  String getJalaliWeekDayAndDate() {
    final f = Jalali.fromDateTime(this).formatter;

    return '${f.wN}، ${f.d} ${f.mN}';
  }

  String getMonthName(CalendarMode calendarMode, String language) {
    if (calendarMode == CalendarMode.gregorian) {
      return DateFormat('MMM', language).format(this);
    } else {
      if (language == 'fa') {
        return Jalali.fromDateTime(this).formatter.mN;
      } else {
        int monthNumber = Jalali.fromDateTime(this).month;
        return [
          'Farvardin',
          'Ordibehesh',
          'Khordad',
          'Tir',
          'Mordad',
          'Shahrivar',
          'Mehr',
          'Aban',
          'Azar',
          'Dey',
          'Bahman',
          'Esfand',
        ][monthNumber - 1];
      }
    }
  }
}

extension TimeExtension on TimeOfDay {
  String get toDBTime {
    NumberFormat f = NumberFormat('00');
    return '${f.format(hour)}:${f.format(minute)}';
  }

  static TimeOfDay? parse(String? str) {
    if (str == null) return null;
    List<String> strs = str.split(':');
    return TimeOfDay(hour: int.parse(strs[0]), minute: int.parse(strs[1]));
  }
}

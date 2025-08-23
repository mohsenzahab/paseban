import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:intl_date_picker/intl_date_picker.dart';
// import 'package:shamsi_date/shamsi_date.dart';

class Formatter {
  Formatter._();
  static FilteringTextInputFormatter get wordsAndDigitsOnly =>
      FilteringTextInputFormatter.allow(RegExp(r'[\p{L}\p{N}]', unicode: true));
  static FilteringTextInputFormatter get onlyLatinWithDigits =>
      FilteringTextInputFormatter.allow(RegExp(r'\w', unicode: false));
  static FilteringTextInputFormatter get noSpace =>
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  /// Formats numbers to context locale language number.
  static String formateNumber(BuildContext context, num number) {
    return NumberFormat('#,##0', Localizations.localeOf(context).languageCode)
        .format(number);
  }

  /// Formats currency to context locale language number.
  static String formateCurrency(BuildContext context, num number,
      {String? currency}) {
    return NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).languageCode,
      name: currency,
    ).format(number);
  }

  /// Converts [DateTime] to jalali date which formatted to [languageCode](default is 'fa') language.
  // static String formatToJalaliDate(DateTime date, {String? languageCode}) {
  //   final c = NumberFormat('00', languageCode ?? 'fa');
  //   Jalali d = Jalali.fromDateTime(date);
  //   String yyyy, mm, dd;

  //   yyyy = c.format(d.year);
  //   mm = c.format(d.month);
  //   dd = c.format(d.day);
  //   return '$yyyy/$mm/$dd';
  // }

  /// Formats [DateTime] to [languageCode](default is 'en') language.
  // static String formatDateTime(BuildContext context, DateTime date,
  //     {Calendar calendar = Calendar.gregorian}) {
  //   return IntlDateUtils.formatDate(context, date, calendar);
  // }

  static DateTime? parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  // /// Converts and formats [DateTime] to context language locale date formation.
  // static String changeDateTime(
  //   BuildContext context,
  //   DateTime date,
  //   Calendar calendar,
  // ) {
  //   switch (Localizations.localeOf(context).languageCode) {
  //     case 'fa':
  //       return Formatter.formatToJalaliDate(date, languageCode: 'fa');
  //     case 'en':
  //       return Formatter.formatDateTime(context,date,calendar: calendar);
  //     default:
  //       throw UnimplementedError();
  //   }
  // }
}

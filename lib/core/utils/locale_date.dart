import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

final class LocaleDate {
  final DateTime date;

  LocaleDate(this.date);

  static LocaleDate get now => LocaleDate(DateTime.now());

  String fullDateFormat(String locale) {
    switch (locale) {
      case 'fa':
        final d = Jalali.fromDateTime(date);
        final f = d.formatter;
        final nf = NumberFormat('####', locale);
        return '${f.wN}، ${nf.format(d.day)} ${f.mN}، ${nf.format(d.year)}';

      default:
        return DateFormat.yMMMEd(locale).format(date);
    }
  }

  String dateOnlyFormat(String locale) {
    switch (locale) {
      case 'fa':
        final d = Jalali.fromDateTime(date);
        final nf = NumberFormat('####', locale);
        return '${nf.format(d.year)}/${nf.format(d.month)}/${nf.format(d.day)}';

      default:
        return DateFormat.yMd(locale).format(date);
    }
  }
}

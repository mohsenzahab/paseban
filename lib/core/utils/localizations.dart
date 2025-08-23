import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

TextDirection getTextDirectionality(String text) =>
    intl.Bidi.detectRtlDirectionality(text)
        ? TextDirection.rtl
        : TextDirection.ltr;
// FontFamily getTextFontFamily(String text) =>
//     intl.Bidi.detectRtlDirectionality(text)
//         ? FontFamily.nian
//         : FontFamily.sofiaPro;

TextDirection getLocaleDirectionality(BuildContext context) {
  return WidgetsLocalizations.of(context).textDirection;
  // return intl.Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode)
  //     ? TextDirection.rtl
  //     : TextDirection.ltr;
}

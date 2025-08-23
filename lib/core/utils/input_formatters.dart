import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Filters typed input. Only lets numbers through
class FilterNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty ||
        newValue.text.length < oldValue.text.length ||
        newValue.text == oldValue.text) {
      return newValue;
    }
    final int newChar = newValue.text.codeUnits.last;
    if (newChar >= 48 && newChar <= 57) return newValue;
    return oldValue;
  }
}

class ArabicNumberFormatter extends TextInputFormatter {
  static const Map<String, String> _arabicNumbers = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  static const Map<String, String> _englishNumbers = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
  };

  final bool toArabic;

  ArabicNumberFormatter({this.toArabic = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (toArabic) {
      newText = newText.replaceAllMapped(
        RegExp(r'\d'),
        (Match match) => _arabicNumbers[match.group(0)]!,
      );
    } else {
      newText = newText.replaceAllMapped(
        RegExp(r'[٠-٩]'),
        (Match match) => _englishNumbers[match.group(0)]!,
      );
    }

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}

/// This formatter will translate typed input numbers to provided lang numbers.
/// only supports fa,ar and en.
class LocaleNumberFormatter extends TextInputFormatter {
  LocaleNumberFormatter({this.outputLangCode = 'en', this.inputLangCode});

  /// The language code that inputs will translated to.
  /// If null, input translates to en.
  final String outputLangCode;

  /// The language code of the String which will be entered by user or system.
  /// If null, on every change will automatically figure it out.
  final String? inputLangCode;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Character removed so no problem
    if (newValue.text.isEmpty ||
        newValue.text.length < oldValue.text.length ||
        newValue.text == oldValue.text) {
      return newValue;
      // If a new character added
    } else {
      final unicode = newValue.text.codeUnits.last;
      final inputLangCode = this.inputLangCode ?? _getInputLangCode(unicode);
      // log.d(
      //     "newLength:${newValue.text.length}->text:${newValue.text}\noldLength:${oldValue.text.length}->text:${oldValue.text}");
      // if unsupported lang code
      if (inputLangCode == null || inputLangCode == outputLangCode) {
        return newValue;
      }
      final lastIndex = newValue.text.length - 1;
      final newChar = newValue.text[lastIndex];
      final numberValue = _getNumberValue(newChar, inputLangCode);
      final String translatedNumber;

      translatedNumber = _getOutputNumberString(numberValue);

      // log.d(
      //     "$newChar\n$inputLangCode->$outputLangCode\n$numberValue->$translatedNumber");

      return newValue.replaced(
        TextRange(start: lastIndex, end: lastIndex + 1),
        translatedNumber,
      );

      // return newValue.copyWith(
      //     text: oldValue.text + translatedNumber,
      //     composing: TextRange(start: -1, end: -1));
    }
  }

  /// Parses input number string to int value. If input lang is en then
  /// return the raw value.
  int _getNumberValue(String newChar, String inputLangCode) =>
      inputLangCode == 'en'
      ? int.parse(newChar)
      : NumberFormat('', inputLangCode).parse(newChar).toInt();

  /// determines the input language code and returns it. returns null if
  /// the input lang is unsupported.
  String? _getInputLangCode(int unicode) {
    bool isArabic = _checkArabicRange(unicode);
    bool isLatin = _checkBasicLatinRange(unicode);
    String? inputLangCode;
    if (isLatin && unicode >= 48 && unicode <= 57) {
      inputLangCode = 'en';
    } else if (isArabic) {
      // if it is an arabic number
      if (unicode >= 1632 && unicode <= 1641) {
        inputLangCode = 'ar';
      }
      // if it is an arabic number
      if (unicode >= 1632 && unicode <= 1641) {
        inputLangCode = 'fa';
      }
    }
    return inputLangCode;
  }

  /// translates given number to output locale string.
  String _getOutputNumberString(int number) =>
      NumberFormat('', outputLangCode).format(number);

  /// returns true if unicode is arabic
  bool _checkArabicRange(int unicode) => unicode >= 1536 && unicode <= 1791;

  /// returns true if the unicode is latin
  bool _checkBasicLatinRange(int unicode) => unicode >= 0 && unicode <= 127;

  /// returns true if there if the input and output langs are not equal.
  // bool _checkNeedTranslate(String inputLangCode) =>
  //     inputLangCode != outputLangCode;
}

class NumberInputFormatter extends TextInputFormatter {
  final int maxLength;

  NumberInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // if the new value is empty, return it
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // if the new value is not a valid number, return the old value
    if (double.tryParse(newValue.text) == null) {
      return oldValue;
    }
    // if the new value has more digits than the max length, return the old value
    if (newValue.text.length > maxLength) {
      return oldValue;
    }
    // otherwise, return the new value
    return newValue;
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final maxLength = 14; // Change this as needed for your desired format
    final newValueText = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');

    if (newValueText.length > maxLength) {
      return oldValue; // Don't allow input beyond the desired format length
    }

    String formattedValue = '';

    if (newValueText.isNotEmpty) {
      if (newValueText.startsWith('+')) {
        formattedValue += '+';
        if (newValueText.length > 1) {
          formattedValue += ' ${newValueText.substring(1)}';
        }
      } else {
        formattedValue = newValueText;
      }

      // Add parentheses and hyphens as needed for your desired format
      if (formattedValue.length > 1) {
        formattedValue = formattedValue.replaceFirstMapped(
          RegExp(r'(\d{1})(\d{3})(\d{1})'),
          (match) {
            return '${match[1]} (${match[2]}) ${match[3]}';
          },
        );

        if (formattedValue.length > 10) {
          formattedValue = formattedValue.replaceFirstMapped(
            RegExp(r'(\d{1})(\d{3})(\d{1})(\d{3})(\d{1})'),
            (match) {
              return '${match[1]} (${match[2]}) ${match[3]}-${match[4]}-${match[5]}';
            },
          );
        }
      }
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

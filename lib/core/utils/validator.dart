import 'package:flutter/material.dart';

/// Common validators for forms.

/// A Helper class for validating form values
///
/// The `Validate` class is used to validate form values. It has several methods and properties that are described in the following comments:
///
/// - The class has a `typedef` called `FormValidator`, which is a function that takes a nullable string value, and returns a nullable string.
/// - The class has a constructor that takes an input (a nullable string value), and an optional list of validators (which /are `FormValidator` functions).
/// - There are two static methods in the class: `requiredValidate` and `numericValidate`. These are both `FormValidator` functions that can be used to check if a value is required or numeric, respectively.
/// - The `addRequiredValidator` method adds a `FormValidator` function to the list of validators. This function checks if a value is empty or null, and returns the corresponding error message if necessary.
/// - The `addNumericValidator` method adds another `FormValidator` function to the list of validators. This function first checks if the previously validated value is a valid number, and then returns an error message if it isn't.
/// - Finally, the `call` method runs all of the validators in the list, and returns either the first error message encountered, or null if all of the validations pass.
///
/// There is a few examples on how to use this `Validate`.
///
/// Example 1:
///
/// ```dart
/// Validate(value, [
///        (value) => Validate.requiredValidate(
///                   value, 'Please enter item price.'),
///        (value) => Validate.numericValidate(
///                    value!, 'Please enter valid price.'),
///                  ])();
/// ```
///
/// Another way of using it is as follows:
///
/// Example 2:
///
/// ```dart
///  Validate(value)
///                 .addRequiredValidator('Please enter item price.')
///                 .addNumericValidator('Please enter valid price.')();
/// ```
///
///

// A class for validating input values with multiple validators.
class Validate<T> {
  Validate();
  // A list of validators to be applied to the input value.
  final List<FormFieldValidator<T>> _validators = [];

  T? Function(T? input)? inputChanger;

  Validate<T> addInputChanger(T? Function(T? input) inputChanger) {
    this.inputChanger = inputChanger;
    return this;
  }

  // A static function to check if a string value is not null or empty.
  static String? requiredValidate<T>(T? value, String nullMessage) {
    if (value == null) return nullMessage;
    if (value is String) return value.trim().isEmpty ? nullMessage : null;
    return null;
  }

  // A static function to check if a string value is a valid number greater than zero.
  static String? numericValidate(String value, String nullMessage) {
    final number = num.tryParse(value);
    return number == null || number <= 0 ? nullMessage : null;
  }

  // A method to add a required validator to the list of validators.
  Validate<T> addRequiredValidator(String invalidMessage) {
    // Add a new validator function to the list of validators that checks if the input value is not null or empty.
    _validators.add((value) {
      if (value == null) return invalidMessage;
      if (value is String) return value.trim().isEmpty ? invalidMessage : null;
      return null;
    });
    return this;
  }

  // A method to add a required validator to the list of validators.
  Validate<T> addIterableRequiredValidator(String invalidMessage) {
    // Add a new validator function to the list of validators that checks if the input value is not null or empty.
    _validators.add((value) {
      if (value == null) return invalidMessage;
      if (value is Iterable) return value.isEmpty ? invalidMessage : null;
      return null;
    });
    return this;
  }

  /// A method to add a numeric validator to the list of validators.
  /// must be used with [addRequiredValidator] and after it.
  Validate<T> addNumericValidator(String invalidMessage) {
    // Add a new validator function to the list of validators that checks if the passedValue is a valid number greater than zero.

    _validators.add((value) {
      if (value is! String) {
        throw Exception('Invalid string input as number.');
      }
      if (value.trim().isEmpty) {
        throw Exception('Invalid string input as number.');
      }
      final number = num.tryParse(value);

      if (number == null || number <= 0) {
        return invalidMessage;
      }
      return null;
    });
    return this;
  }

  Validate<T> addCustomValidator(FormFieldValidator<T> validator) {
    // Add a new validator function to the list of validators that checks if the passedValue is a valid number greater than zero.
    _validators.add((value) {
      final message = validator(value);
      if (message != null) return message;
      return null;
    });
    return this;
  }

  // A method to apply all validators to the input value and return the first error message, or null if all validators pass.
  String? validate(T? input) {
    if (inputChanger != null) {
      input = inputChanger!(input) ?? input;
    }
    for (final validator in _validators) {
      final message = validator(input);
      if (message != null) return message;
    }

    return null;
  }

  String? validator(T? value) {
    return validate(value);
  }
}

class PhoneValidator {
  bool validate(String phoneNumber) =>
      RegExp(r'^((\+\d{1,2})|0)\d{10}$').hasMatch(phoneNumber);
}

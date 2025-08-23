final class EmailValidator {
  bool validateEmail(String email) {
    // Define a regular expression pattern for email validation.
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false,
        multiLine: false);

    // Use the regular expression to validate the email.
    if (emailRegExp.hasMatch(email)) {
      return true; // Email is valid.
    } else {
      return false; // Email is not valid.
    }
  }
}

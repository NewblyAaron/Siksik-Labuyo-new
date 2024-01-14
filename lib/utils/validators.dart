class ValidationException implements Exception {
  ValidationException(this.title, this.message);

  final String title;
  final String message;
}

class Validators {
  static String? hasValue(String? value) {
    return (value == null || value.isEmpty)
        ? "This value cannot be left blank!"
        : null;
  }

  static String? isNumber(String? value) {
    return (value == null || num.tryParse(value) == null)
        ? "This value must be a number!"
        : null;
  }

  static String? isNonNegativeNumber(String? value) {
    return (value == null ||
            num.tryParse(value) == null ||
            num.parse(value) < 0)
        ? "This value must be a non-negative number!"
        : null;
  }
}

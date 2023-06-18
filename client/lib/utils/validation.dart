class Validation {
  static final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static bool isCpf(String value) {
    var sum = 0;
    var remainder = 0;

    if (value == '00000000000') {
      return false;
    }

    for (var i = 1; i <= 9; i++) {
      sum += int.parse(value.substring(i - 1, i)) * (11 - i);
    }

    remainder = (sum * 10) % 11;

    if ((remainder == 10) || (remainder == 11)) {
      remainder = 0;
    }

    if (remainder != int.parse(value.substring(9, 10))) {
      return false;
    }

    sum = 0;

    for (var i = 1; i <= 10; i++) {
      sum += int.parse(value.substring(i - 1, i)) * (12 - i);
    }

    remainder = (sum * 10) % 11;

    if ((remainder == 10) || (remainder == 11)) {
      remainder = 0;
    }

    if (remainder != int.parse(value.substring(10, 11))) {
      return false;
    }

    return true;
  }

  static bool isEmail(String value) {
    return _emailRegex.hasMatch(value);
  }
}

class Parsing {
  static double parseDouble(dynamic value) {
    if (value is double) {
      return value;
    }

    return double.tryParse(value.toString()) ?? 0;
  }

  static int parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value.toString()) ?? 0;
  }

  static String parseString(dynamic value) {
    if (value is String) {
      return value;
    }

    return '';
  }
}

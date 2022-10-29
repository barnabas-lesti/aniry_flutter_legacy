import 'package:diacritic/diacritic.dart';

class AppUtils {
  static bool hasFractional(double number) => (number - number.truncate()) != 0;

  static String doubleToString(double number, {bool? exact}) {
    if (hasFractional(number)) {
      if (exact ?? false) return number.toString();
      return number.toStringAsFixed(1).replaceAll('.0', '');
    }
    return number.toStringAsFixed(0);
  }

  static double stringToDouble(String value) {
    return value.isNotEmpty ? double.parse(value) : 0;
  }

  static bool isStringInString(String a, String b) {
    return removeDiacritics(a.toLowerCase()).contains(removeDiacritics(b.toLowerCase()));
  }
}

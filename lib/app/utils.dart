class AppUtils {
  static bool hasFractional(double number) => (number - number.truncate()) != 0;

  static String doubleToString(double number, {bool? exact}) {
    if (hasFractional(number)) return (exact ?? false) ? number.toString() : number.toStringAsFixed(1);
    return number.toStringAsFixed(0);
  }
}

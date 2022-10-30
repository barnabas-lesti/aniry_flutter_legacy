import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
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

  static double reduceCalories(List<double> listOfCalories) {
    double calories = 0;
    for (int index = 0; index < listOfCalories.length; index++) {
      calories += listOfCalories[index];
    }
    return calories;
  }

  static AppNutrients reduceNutrients(List<AppNutrients> listOfNutrients) {
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    for (int index = 0; index < listOfNutrients.length; index++) {
      carbs += listOfNutrients[index].carbs;
      protein += listOfNutrients[index].protein;
      fat += listOfNutrients[index].fat;
    }
    return AppNutrients(
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }

  static double getProxyCalories({
    required double itemCalories,
    required AppServing itemServing,
    required AppServing proxyServing,
  }) {
    return (itemCalories / itemServing.value) * proxyServing.value;
  }

  static AppNutrients getProxyNutrients({
    required AppNutrients itemNutrients,
    required AppServing itemServing,
    required AppServing proxyServing,
  }) {
    return AppNutrients(
      carbs: (itemNutrients.carbs / itemServing.value) * proxyServing.value,
      protein: (itemNutrients.protein / itemServing.value) * proxyServing.value,
      fat: (itemNutrients.fat / itemServing.value) * proxyServing.value,
    );
  }
}

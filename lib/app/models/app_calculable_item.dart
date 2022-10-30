import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';

abstract class AppCalculableItem {
  late String id;
  late String name;
  late double calories;
  late AppNutrients nutrients;
  late AppServing serving;
  late List<AppServing> servings;

  AppListItem toListItem();

  static double reduceListOfCalories(List<double> listOfCalories) {
    double calories = 0;
    for (int index = 0; index < listOfCalories.length; index++) {
      calories += listOfCalories[index];
    }
    return calories;
  }

  static AppNutrients reduceListOfNutrients(List<AppNutrients> listOfNutrients) {
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

  static double calculateProxyCalories({
    required double itemCalories,
    required AppServing itemServing,
    required AppServing proxyServing,
  }) {
    return (itemCalories / itemServing.value) * proxyServing.value;
  }

  static AppNutrients calculateProxyNutrients({
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

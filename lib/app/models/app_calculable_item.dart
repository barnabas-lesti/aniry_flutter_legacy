import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';

class AppCalculableItem {
  final Type source;
  final double calories;
  final AppNutrients nutrients;
  final AppServing serving;

  const AppCalculableItem({
    required this.source,
    required this.calories,
    required this.nutrients,
    required this.serving,
  });

  static double reduceCaloriesList(List<double> caloriesList) {
    double calories = 0;
    for (int index = 0; index < caloriesList.length; index++) {
      calories += caloriesList[index];
    }
    return calories;
  }

  static AppNutrients reduceNutrientsList(List<AppNutrients> nutrientsList) {
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    for (int index = 0; index < nutrientsList.length; index++) {
      carbs += nutrientsList[index].carbs;
      protein += nutrientsList[index].protein;
      fat += nutrientsList[index].fat;
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

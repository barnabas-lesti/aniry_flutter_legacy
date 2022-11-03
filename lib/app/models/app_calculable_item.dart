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

  static double reduceCalories(Iterable<double> calories) {
    return calories.fold(0, (value, element) => value + element);
  }

  static AppNutrients reduceNutrients(Iterable<AppNutrients> nutrients) {
    return nutrients.fold(AppNutrients(), (value, element) {
      value.carbs + element.carbs;
      value.protein + element.protein;
      value.fat + element.fat;
      return value;
    });
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

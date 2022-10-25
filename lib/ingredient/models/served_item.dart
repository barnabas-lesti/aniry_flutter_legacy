import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/ingredient/models/item.dart';

class IngredientServedItem {
  late IngredientItem item;
  late AppServing serving;

  IngredientServedItem({
    required this.item,
    serving,
  }) {
    this.serving = serving ?? item.serving ?? AppServing();
  }

  static double getCalories(List<IngredientServedItem> items) {
    double calories = 0;
    for (int i = 0; i < items.length; i++) {
      calories += items[i].calories;
    }
    return calories;
  }

  static AppNutrients getNutrients(List<IngredientServedItem> items) {
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    for (int i = 0; i < items.length; i++) {
      carbs += items[i].nutrients.carbs;
      protein += items[i].nutrients.protein;
      fat += items[i].nutrients.fat;
    }
    return AppNutrients(
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }

  static IngredientServedItem fromJson(Map<String, dynamic> json) {
    return IngredientServedItem(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      item: IngredientItem.fromJson(json['item'] as Map<String, dynamic>),
    );
  }

  AppServing get usedServing {
    return item.servings.where((serving) => serving.unit == this.serving.unit).first;
  }

  double get calories {
    return (item.calories / usedServing.value) * serving.value;
  }

  AppNutrients get nutrients {
    return AppNutrients(
      carbs: (item.nutrients.carbs / usedServing.value) * serving.value,
      protein: (item.nutrients.protein / usedServing.value) * serving.value,
      fat: (item.nutrients.fat / usedServing.value) * serving.value,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'item': item,
      'serving': serving,
    };
  }
}

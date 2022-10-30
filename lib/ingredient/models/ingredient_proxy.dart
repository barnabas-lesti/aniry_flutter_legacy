import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/ingredient/models/ingredient.dart';

class IngredientProxy {
  late final Ingredient ingredient;
  late AppServing serving;

  IngredientProxy({
    required this.ingredient,
    serving,
  }) {
    this.serving = serving ?? AppServing();
  }

  static double getCalories(List<IngredientProxy> proxies) {
    double calories = 0;
    for (int i = 0; i < proxies.length; i++) {
      calories += proxies[i].calories;
    }
    return calories;
  }

  static AppNutrients getNutrients(List<IngredientProxy> proxies) {
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    for (int i = 0; i < proxies.length; i++) {
      carbs += proxies[i].nutrients.carbs;
      protein += proxies[i].nutrients.protein;
      fat += proxies[i].nutrients.fat;
    }
    return AppNutrients(
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }

  static IngredientProxy fromJson(Map<String, dynamic> json) {
    return IngredientProxy(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      ingredient: Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    );
  }

  String get id => ingredient.id;

  double get calories {
    return (ingredient.calories / ingredient.serving.value) * serving.value;
  }

  AppNutrients get nutrients {
    return AppNutrients(
      carbs: (ingredient.nutrients.carbs / ingredient.serving.value) * serving.value,
      protein: (ingredient.nutrients.protein / ingredient.serving.value) * serving.value,
      fat: (ingredient.nutrients.fat / ingredient.serving.value) * serving.value,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ingredient': ingredient,
      'serving': serving,
    };
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      textLeftPrimary: ingredient.name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: Ingredient.icon,
      color: Ingredient.color,
    );
  }
}

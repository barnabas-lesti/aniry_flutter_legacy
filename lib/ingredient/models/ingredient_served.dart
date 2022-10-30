import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/ingredient/models/ingredient.dart';

class IngredientServed {
  late Ingredient ingredient;
  late AppServing serving;

  IngredientServed({
    required this.ingredient,
    serving,
  }) {
    this.serving = serving ?? ingredient.serving ?? AppServing();
  }

  static double getCalories(List<IngredientServed> ingredientsServed) {
    double calories = 0;
    for (int i = 0; i < ingredientsServed.length; i++) {
      calories += ingredientsServed[i].calories;
    }
    return calories;
  }

  static AppNutrients getNutrients(List<IngredientServed> ingredientsServed) {
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    for (int i = 0; i < ingredientsServed.length; i++) {
      carbs += ingredientsServed[i].nutrients.carbs;
      protein += ingredientsServed[i].nutrients.protein;
      fat += ingredientsServed[i].nutrients.fat;
    }
    return AppNutrients(
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }

  static IngredientServed fromJson(Map<String, dynamic> json) {
    return IngredientServed(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      ingredient: Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    );
  }

  String get id => ingredient.id;

  AppServing get usedIngredientServing {
    return ingredient.servings.where((serving) => serving.unit == this.serving.unit).first;
  }

  double get calories {
    return (ingredient.calories / usedIngredientServing.value) * serving.value;
  }

  AppNutrients get nutrients {
    return AppNutrients(
      carbs: (ingredient.nutrients.carbs / usedIngredientServing.value) * serving.value,
      protein: (ingredient.nutrients.protein / usedIngredientServing.value) * serving.value,
      fat: (ingredient.nutrients.fat / usedIngredientServing.value) * serving.value,
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

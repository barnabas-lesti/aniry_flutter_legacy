import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/recipe/models/recipe.dart';

class RecipeProxy extends AppCalculableItem {
  late Recipe recipe;

  RecipeProxy({
    required Recipe recipe,
    AppServing? serving,
  }) {
    this.recipe = recipe.clone();
    this.serving = serving != null ? serving.clone() : AppServing();
  }

  static RecipeProxy fromJson(Map<String, dynamic> json) {
    return RecipeProxy(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
    );
  }

  @override
  String get id => recipe.id;

  @override
  double get calories {
    return AppCalculableItem.calculateProxyCalories(
      itemCalories: recipe.calories,
      itemServing: recipe.serving,
      proxyServing: serving,
    );
  }

  @override
  AppNutrients get nutrients {
    return AppCalculableItem.calculateProxyNutrients(
      itemNutrients: recipe.nutrients,
      itemServing: recipe.serving,
      proxyServing: serving,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'recipe': recipe,
      'serving': serving,
    };
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      textLeftPrimary: recipe.name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: Recipe.icon,
      color: Recipe.color,
    );
  }
}

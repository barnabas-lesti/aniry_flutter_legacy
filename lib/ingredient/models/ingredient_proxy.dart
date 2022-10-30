import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/ingredient/models/ingredient.dart';

class IngredientProxy extends AppCalculableItem {
  late Ingredient ingredient;

  IngredientProxy({
    required Ingredient ingredient,
    AppServing? serving,
  }) {
    this.ingredient = ingredient.clone();
    this.serving = serving != null ? serving.clone() : AppServing();
  }

  static IngredientProxy fromJson(Map<String, dynamic> json) {
    return IngredientProxy(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      ingredient: Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    );
  }

  @override
  String get id => ingredient.id;

  @override
  double get calories {
    return AppCalculableItem.calculateProxyCalories(
      itemCalories: ingredient.calories,
      itemServing: ingredient.serving,
      proxyServing: serving,
    );
  }

  @override
  AppNutrients get nutrients {
    return AppCalculableItem.calculateProxyNutrients(
      itemNutrients: ingredient.nutrients,
      itemServing: ingredient.serving,
      proxyServing: serving,
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

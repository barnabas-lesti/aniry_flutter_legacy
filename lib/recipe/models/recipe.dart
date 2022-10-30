import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';

class Recipe {
  late String id;
  late String name;
  late List<AppServing> servings;
  late List<IngredientProxy> ingredientProxies;
  late String description;

  Recipe({
    id,
    name,
    servings,
    ingredientProxies,
    description,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.ingredientProxies = ingredientProxies ?? [];
    this.servings = servings ?? [AppServing(unit: defaultServingUnit, value: defaultServingValue)];
    this.description = description ?? '';
  }

  static const String defaultServingUnit = AppUnit.plate;
  static const double defaultServingValue = 1.0;
  static const List<String> primaryServingUnits = [AppUnit.plate, AppUnit.piece];
  static const IconData icon = Icons.class_;
  static Color color = Colors.brown[600]!;

  static Recipe fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      servings: (json['servings'] as List<dynamic>).map((e) => AppServing.fromJson(e as Map<String, dynamic>)).toList(),
      ingredientProxies: (json['ingredientProxies'] as List<dynamic>? ?? [])
          .map((e) => IngredientProxy.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String? ?? '',
    );
  }

  AppServing get serving => servings[0];

  double get calories => IngredientProxy.getCalories(ingredientProxies);

  AppNutrients get nutrients => IngredientProxy.getNutrients(ingredientProxies);

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      textLeftPrimary: name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: icon,
      color: color,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'servings': servings,
      'ingredientProxies': ingredientProxies,
      'description': description,
    };
  }
}

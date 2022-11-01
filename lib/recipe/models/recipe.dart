import 'dart:convert';

import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';

class Recipe {
  late String id;
  late String name;
  late List<AppServing> servings;
  late String description;
  late List<IngredientProxy> ingredientProxies;

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

  AppServing get serving => servings[0];

  double get calories =>
      AppCalculableItem.reduceCaloriesList(ingredientProxies.map((proxy) => proxy.calories).toList());

  AppNutrients get nutrients =>
      AppCalculableItem.reduceNutrientsList(ingredientProxies.map((proxy) => proxy.nutrients).toList());

  static const String defaultServingUnit = AppUnit.plate;
  static const double defaultServingValue = 1.0;
  static const List<String> primaryServingUnits = [AppUnit.plate, AppUnit.piece];
  static const IconData icon = Icons.class_;
  static Color color = Colors.brown[600]!;

  static Recipe fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      servings: (json['servings'] as List<dynamic>)
          .map((serving) => AppServing.fromJson(serving as Map<String, dynamic>))
          .toList(),
      ingredientProxies: (json['ingredientProxies'] as List<dynamic>? ?? [])
          .map((proxy) => IngredientProxy.fromJson(proxy as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'name': name,
      'servings': servings,
    };
    if (ingredientProxies.isNotEmpty) json['ingredientProxies'] = ingredientProxies;
    if (description.isNotEmpty) json['description'] = description;
    return json;
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      source: Recipe,
      textLeftPrimary: name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: icon,
      color: color,
    );
  }

  AppCalculableItem toCalculableItem() {
    return AppCalculableItem(
      source: Recipe,
      calories: calories,
      nutrients: nutrients,
      serving: serving,
    );
  }

  Recipe clone() {
    return fromJson(json.decode(json.encode(this)));
  }
}

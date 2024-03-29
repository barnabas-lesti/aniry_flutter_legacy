import 'dart:convert';

import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';

class Ingredient {
  late String id;
  late String name;
  late double calories;
  late AppNutrients nutrients;
  late List<AppServing> servings;
  late String description;

  Ingredient({
    id,
    name,
    calories,
    nutrients,
    servings,
    description,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.calories = calories ?? 0.0;
    this.nutrients = nutrients ?? AppNutrients();
    this.servings = servings ?? [AppServing(unit: defaultServingUnit, value: defaultServingValue)];
    this.description = description ?? '';
  }

  static const String defaultServingUnit = AppUnit.g;
  static const double defaultServingValue = 100.0;
  static const List<String> primaryServingUnits = [AppUnit.g, AppUnit.ml];
  static const IconData icon = Icons.apple;
  static final Color color = Colors.green[400]!;

  AppServing get serving => servings[0];

  static Ingredient fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num? ?? 0).toDouble(),
      nutrients: AppNutrients.fromJson(json['nutrients'] as Map<String, dynamic>),
      servings: (json['servings'] as List<dynamic>)
          .map((serving) => AppServing.fromJson(serving as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'name': name,
      'nutrients': nutrients,
      'servings': servings,
    };
    if (calories != 0) json['calories'] = calories;
    if (description.isNotEmpty) json['description'] = description;
    return json;
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      source: Ingredient,
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
      source: Ingredient,
      calories: calories,
      nutrients: nutrients,
      serving: serving,
    );
  }

  Ingredient clone() {
    return fromJson(json.decode(json.encode(this)));
  }
}

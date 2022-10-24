import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/unit.dart';
import 'package:flutter/material.dart';

class IngredientItem {
  late String id;
  late String name;
  late double calories;
  late AppNutrients nutrients;
  late List<AppServing> servings;
  late String description;

  IngredientItem({
    id,
    name,
    calories,
    nutrients,
    servings,
    description,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.calories = calories ?? 0;
    this.nutrients = nutrients ?? AppNutrients();
    this.servings = servings ?? [AppServing(unit: defaultServingUnit, value: defaultServingValue)];
    this.description = description ?? '';
  }

  static const String defaultServingUnit = AppUnit.g;
  static const double defaultServingValue = 100;
  static const List<String> primaryServingUnits = [AppUnit.g, AppUnit.ml];
  static const IconData icon = Icons.apple;
  static Color color = Colors.green[400]!;

  AppServing get serving => servings[0];

  static IngredientItem fromJson(Map<String, dynamic> json) {
    return IngredientItem(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num? ?? 0).toDouble(),
      nutrients: AppNutrients.fromJson(json['nutrients'] as Map<String, dynamic>),
      servings: (json['servings'] as List<dynamic>).map((e) => AppServing.fromJson(e as Map<String, dynamic>)).toList(),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'calories': calories,
      'nutrients': nutrients,
      'servings': servings,
      'description': description,
    };
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      textLeftPrimary: name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: icon,
      iconColor: color,
    );
  }
}

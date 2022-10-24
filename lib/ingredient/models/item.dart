import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
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
  static const List<String> primaryServingUnits = [
    AppUnit.g,
    AppUnit.ml,
  ];
  static const IconData icon = Icons.apple;
  static Color color = Colors.green[400]!;

  AppServing get serving => servings[0];

  factory IngredientItem.fromJson(Map<String, dynamic> json) => _$IngredientItemFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientItemToJson(this);

  AppListItem toListItem() => AppListItem(
        id: id,
        textLeftPrimary: name,
        textLeftSecondary: nutrients.toString(),
        textRightPrimary: serving.toString(),
        textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
        icon: icon,
        iconColor: color,
      );
}

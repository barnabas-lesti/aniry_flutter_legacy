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

  static String defaultServingUnit = AppUnit.g;
  static double defaultServingValue = 100;
  static List<String> primaryServingUnits = [
    AppUnit.g,
    AppUnit.ml,
  ];
  static IconData icon = Icons.apple;
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

  @override
  bool operator ==(Object other) {
    if (other is IngredientItem) {
      return id == other.id &&
          name == other.name &&
          calories == other.calories &&
          nutrients.carbs == other.nutrients.carbs &&
          nutrients.protein == other.nutrients.protein &&
          nutrients.fat == other.nutrients.fat &&
          serving.unit == other.serving.unit &&
          serving.value == other.serving.value;
    }

    return false;
  }

  @override
  int get hashCode => id.hashCode;
}

import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/ingredient/models/served_item.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/unit.dart';
import 'package:flutter/material.dart';

class RecipeItem {
  late String id;
  late String name;
  late List<AppServing> servings;
  late List<IngredientServedItem> servedItems;
  late String description;

  RecipeItem({
    id,
    name,
    servings,
    servedItems,
    description,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.servedItems = servedItems ?? [];
    this.servings = servings ?? [AppServing(unit: defaultServingUnit, value: defaultServingValue)];
    this.description = description ?? '';
  }

  static const String defaultServingUnit = AppUnit.plate;
  static const double defaultServingValue = 1.0;
  static const List<String> primaryServingUnits = [AppUnit.plate, AppUnit.piece];
  static const IconData icon = Icons.class_;
  static Color color = Colors.brown[600]!;

  static RecipeItem fromJson(Map<String, dynamic> json) {
    return RecipeItem(
      id: json['id'] as String,
      name: json['name'] as String,
      servings: (json['servings'] as List<dynamic>).map((e) => AppServing.fromJson(e as Map<String, dynamic>)).toList(),
      servedItems: (json['servedItems'] as List<dynamic>)
          .map((e) => IngredientServedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String? ?? '',
    );
  }

  AppServing get serving => servings[0];

  double get calories => IngredientServedItem.getCalories(servedItems);

  AppNutrients get nutrients => IngredientServedItem.getNutrients(servedItems);

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'servings': servings,
      'servedItems': servedItems,
      'description': description,
    };
  }
}

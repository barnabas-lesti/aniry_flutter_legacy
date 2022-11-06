import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_served_item.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';

class Recipe {
  late String id;
  late String name;
  late List<AppServing> servings;
  late String description;
  late List<AppServedItem> servedItems;

  Recipe({
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

  AppServing get serving => servings[0];

  double get calories {
    return AppServedItem.reduceCalories(servedItems.map((item) => item.calories).toList());
  }

  AppNutrients get nutrients {
    return AppServedItem.reduceNutrients(servedItems.map((item) => item.nutrients).toList());
  }

  static const String defaultServingUnit = AppUnit.plate;
  static const double defaultServingValue = 1.0;
  static const List<String> primaryServingUnits = [AppUnit.plate, AppUnit.piece];
  static const IconData icon = Icons.class_;
  static Color color = Colors.brown[600]!;

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

  Recipe clone() {
    return Recipe(
      id: id,
      name: name,
      servings: servings,
      description: description,
      servedItems: [...servedItems],
    );
  }
}

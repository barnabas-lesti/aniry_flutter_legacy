import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/unit.dart';
import 'package:flutter/material.dart';

class RecipeItem {
  late String id;
  late String name;
  late List<AppServing> servings;

  RecipeItem({
    id,
    name,
    servings,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.servings = servings ?? [AppServing(unit: defaultServingUnit, value: defaultServingValue)];
  }

  static const String defaultServingUnit = AppUnit.plate;
  static const double defaultServingValue = 1;
  static const List<String> primaryServingUnits = [AppUnit.plate, AppUnit.piece];
  static const IconData icon = Icons.class_;
  static Color color = Colors.brown[600]!;

  static RecipeItem fromJson(dynamic json) {
    return RecipeItem();
  }

  AppServing get serving => servings[0];

  AppListItem toListItem() {
    return AppListItem(id: id, textLeftPrimary: name);
  }
}

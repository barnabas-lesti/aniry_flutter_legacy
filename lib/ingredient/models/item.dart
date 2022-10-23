import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'item.g.dart';

@JsonSerializable()
class IngredientItem {
  final String id;
  String name;
  double calories;
  AppNutrients nutrients;
  List<AppServing> servings;
  String? description;

  IngredientItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.nutrients,
    required this.servings,
    this.description,
  });

  static String defaultServingUnit = AppUnit.g;
  static double defaultServingValue = 100;
  static List<String> primaryServingUnits = [
    AppUnit.g,
    AppUnit.ml,
  ];
  static IconData icon = Icons.apple;
  static Color color = Colors.green[400]!;

  static String createId() => const Uuid().v4().toString();

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

import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:flutter/material.dart';

class AppServableItem {
  final String id;
  final String name;
  final double calories;
  final AppNutrients nutrients;
  final AppServing serving;
  final IconData icon;
  final Color color;

  const AppServableItem({
    required this.id,
    required this.name,
    required this.calories,
    required this.nutrients,
    required this.serving,
    required this.icon,
    required this.color,
  });
}

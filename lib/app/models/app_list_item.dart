import 'package:flutter/material.dart';

class AppListItem {
  final String id;
  final AppListItemOrigin origin;
  final String textLeftPrimary;
  final String textLeftSecondary;
  final String textRightPrimary;
  final String textRightSecondary;
  final IconData? icon;
  final Color? color;

  const AppListItem({
    required this.id,
    required this.origin,
    required this.textLeftPrimary,
    this.textLeftSecondary = '',
    this.textRightPrimary = '',
    this.textRightSecondary = '',
    this.icon,
    this.color,
  });
}

enum AppListItemOrigin {
  ingredient,
  ingredientProxy,
  recipe,
  recipeProxy,
  shoppingItem,
}

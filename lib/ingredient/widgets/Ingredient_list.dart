import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;
  final void Function(String) onTap;

  const IngredientList({
    required this.ingredients,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(context) {
    return AppList(
      items: ingredients.map((ingredient) => ingredient.toListItem()).toList(),
      onTap: onTap,
      noItemsText: AppI10N.of(context).ingredientListNoItems,
    );
  }
}

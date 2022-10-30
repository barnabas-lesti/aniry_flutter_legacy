import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(String) onTap;

  const RecipeList({
    required this.recipes,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(context) {
    return AppList(
      items: recipes.map((recipe) => recipe.toListItem()).toList(),
      noItemsText: AppI10N.of(context).recipeListNoItems,
      showIcon: true,
      showTextLeftSecondary: true,
      showTextRightPrimary: true,
      showTextRightSecondary: true,
      expanded: true,
      onTap: onTap,
    );
  }
}

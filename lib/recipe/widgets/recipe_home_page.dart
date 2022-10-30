import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_search_input.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeHomePage extends StatelessWidget {
  final String title;

  RecipeHomePage({
    required this.title,
    super.key,
  });

  final FocusNode _inputFocusNode = FocusNode();

  @override
  Widget build(context) {
    final appI10N = AppI10N.of(context);
    final beamer = Beamer.of(context);

    void onSearch(String searchString) {
      RecipeProvider.of(context).recipeHomeSearchString = searchString;
    }

    void onListTileTap(String id) {
      if (_inputFocusNode.hasFocus) {
        _inputFocusNode.unfocus();
      } else {
        beamer.beamToNamed('/recipe/edit/$id');
      }
    }

    return AppPageScaffold(
      title: title,
      actions: [
        AppHeaderAction(
          icon: Icons.add,
          tooltip: appI10N.recipeHomeCreateTooltip,
          onPressed: () => beamer.beamToNamed('/recipe/create'),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppSearchInput(
              label: appI10N.recipeHomeSearchLabel,
              onSearch: onSearch,
              focusNode: _inputFocusNode,
            ),
          ),
          Consumer<RecipeProvider>(
            builder: (context, recipeProvider, widget) => _RecipeHomePageList(
              recipes: recipeProvider.recipeHomeRecipes,
              onTap: onListTileTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeHomePageList extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(String) onTap;

  const _RecipeHomePageList({
    required this.recipes,
    required this.onTap,
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

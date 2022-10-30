import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_search_input.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientHomePage extends StatelessWidget {
  final String title;

  IngredientHomePage({
    required this.title,
    super.key,
  });

  final FocusNode _inputFocusNode = FocusNode();

  @override
  Widget build(context) {
    void onSearch(String searchString) {
      IngredientProvider.of(context).ingredientHomeSearchString = searchString;
    }

    void onListTileTap(String id) {
      if (_inputFocusNode.hasFocus) {
        _inputFocusNode.unfocus();
      } else {
        Beamer.of(context).beamToNamed('/ingredient/edit/$id');
      }
    }

    return AppPageScaffold(
      title: title,
      actions: [
        AppHeaderAction(
          icon: Icons.add,
          tooltip: AppI10N.of(context).ingredientHomeCreateTooltip,
          onPressed: () => Beamer.of(context).beamToNamed('/ingredient/create'),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppSearchInput(
              label: AppI10N.of(context).ingredientHomeSearchLabel,
              onSearch: onSearch,
              focusNode: _inputFocusNode,
            ),
          ),
          Consumer<IngredientProvider>(
            builder: (context, ingredientProvider, widget) => _IngredientHomePageList(
              ingredients: ingredientProvider.ingredientHomeIngredients,
              onTap: onListTileTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientHomePageList extends StatelessWidget {
  final List<Ingredient> ingredients;
  final void Function(String) onTap;

  const _IngredientHomePageList({
    required this.ingredients,
    required this.onTap,
  });

  @override
  Widget build(context) {
    return AppList(
      items: ingredients.map((ingredient) => ingredient.toListItem()).toList(),
      onTap: onTap,
      noItemsText: AppI10N.of(context).ingredientListNoItems,
      showIcon: true,
      showTextLeftSecondary: true,
      showTextRightPrimary: true,
      showTextRightSecondary: true,
      expanded: true,
    );
  }
}

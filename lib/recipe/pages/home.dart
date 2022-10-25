import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/app/widgets/search_input.dart';
import 'package:aniry/recipe/provider.dart';
import 'package:aniry/recipe/widgets/list.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeHome extends StatelessWidget {
  final String title;

  RecipeHome({
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
        AppPageAction(
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
            builder: (context, recipeProvider, widget) => RecipeList(
              items: recipeProvider.recipeHomeItems,
              onTap: onListTileTap,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/widgets/header_action.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/app/widgets/search_input.dart';
import 'package:aniry/ingredient/provider.dart';
import 'package:aniry/ingredient/widgets/list.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientHome extends StatelessWidget {
  final String title;

  IngredientHome({
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
            builder: (context, ingredientProvider, widget) => IngredientList(
              items: ingredientProvider.ingredientHomeItems,
              onTap: onListTileTap,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/widgets/app_button_group.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_search_input.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showIngredientSelectorDialog({
  required BuildContext context,
  required List<String> initialSelectedIDs,
  required void Function(List<String>) onSave,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return IngredientSelectorDialog(
        initialSelectedIDs: initialSelectedIDs,
        onSave: onSave,
      );
    },
  );
}

class IngredientSelectorDialog extends StatelessWidget {
  final List<String> initialSelectedIDs;
  final void Function(List<String>) onSave;

  IngredientSelectorDialog({
    required this.initialSelectedIDs,
    required this.onSave,
    super.key,
  });

  final _listController = AppDataController<List<String>>();

  void Function() _buildOnSave(BuildContext context) {
    return () {
      onSave(_listController.getData());
      Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    return SimpleDialog(
      title: Text(appI10N.ingredientSelectorDialogTitle),
      titlePadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      children: [
        _IngredientSelectorList(
          initialSelectedIDs: initialSelectedIDs,
          controller: _listController,
        ),
        AppButtonGroup(actions: [
          AppButtonGroupAction(
            label: appI10N.ingredientSelectorDialogCancel,
            onPressed: () => Navigator.pop(context),
          ),
          AppButtonGroupAction(
            label: appI10N.ingredientSelectorDialogSave,
            onPressed: _buildOnSave(context),
          ),
        ]),
      ],
    );
  }
}

class _IngredientSelectorList extends StatefulWidget {
  final List<String> initialSelectedIDs;
  final AppDataController<List<String>> controller;

  const _IngredientSelectorList({
    required this.initialSelectedIDs,
    required this.controller,
  });

  @override
  State<_IngredientSelectorList> createState() => _IngredientSelectorListState();
}

class _IngredientSelectorListState extends State<_IngredientSelectorList> {
  late String _searchString;
  late List<String> _selectedIDs;

  @override
  void initState() {
    super.initState();
    _searchString = '';
    _selectedIDs = widget.initialSelectedIDs;
  }

  void _onSearch(String searchString) {
    setState(() {
      _searchString = searchString;
    });
  }

  void _onTap(String id) {
    setState(() {
      _selectedIDs.contains(id) ? _selectedIDs.remove(id) : _selectedIDs.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    widget.controller.onGetData(() {
      return _selectedIDs;
    });

    return Column(
      children: [
        AppSearchInput(
          label: appI10N.ingredientSelectorListSearchLabel,
          onSearch: _onSearch,
          paddingBottom: 16,
        ),
        Consumer<IngredientProvider>(builder: (context, ingredientProvider, w) {
          return AppList(
            items: ingredientProvider.ingredients
                .where((ingredient) => AppUtils.isStringInString(ingredient.name, _searchString))
                .map((ingredient) => ingredient.toListItem())
                .toList(),
            noItemsText: appI10N.ingredientSelectorListNoItems,
            selectedIDs: _selectedIDs,
            showIcon: true,
            showCheckbox: true,
            numberOfVisibleItems: 5,
            paddingBottom: 16,
            onTap: _onTap,
          );
        }),
      ],
    );
  }
}

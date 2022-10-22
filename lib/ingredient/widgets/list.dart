import 'package:aniry/app/widgets/list.dart';
import 'package:aniry/app/i10n.dart';
import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  // final List<ShoppingItem> items;
  // final List<ShoppingItem> checkedItems;
  // final void Function(List<String>) onReorder;
  // final void Function(String) onDelete;
  // final void Function(String) onTap;

  IngredientList({
    // required this.items,
    // required this.checkedItems,
    // required this.onReorder,
    // required this.onDelete,
    // required this.onTap,
    super.key,
  });

  // List<AppListItem> _toListItems(List<ShoppingItem> items) =>
  //     items.map((ShoppingItem item) => AppListItem(id: item.id, textLeftPrimary: item.name)).toList();

  final List<AppListItem> _items = [
    AppListItem(
      id: '1',
      textLeftPrimary: 'Fuszerkeverek (fokhagymas)',
      // textLeftSecondary: '30g carbs, 25g protein, 5g fat',
      textRightPrimary: '100 g',
      textRightSecondary: '352 kcal',
      icon: Icons.apple,
      iconColor: Colors.green[400],
    ),
    AppListItem(
      id: '2',
      textLeftPrimary: 'Tejfolos gomas csirke rizzsel',
      // textLeftSecondary: '100g carbs, 25g protein, 50g fat',
      textRightPrimary: '1 plate',
      textRightSecondary: '1532 kcal',
      icon: Icons.settings,
      iconColor: Colors.indigo[400],
    ),
    AppListItem(
      id: '3',
      textLeftPrimary: 'Onions tejfolos gombas csirke rizzsel',
      textLeftSecondary: '300g carbs, 250g protein, 500g fat',
      textRightPrimary: '100 pieces',
      textRightSecondary: '3520kcal',
      icon: Icons.book,
      iconColor: Colors.brown[400],
    ),
  ];
  final List<AppListItem> _selectedItems = [];

  void _onDelete(String id) {}
  void _onTap(String id) {}
  // void _onReorder(List<String> ids) {}

  @override
  Widget build(context) {
    return AppList(
      items: [],
      onDelete: _onDelete,
      onTap: _onTap,
      // onReorder: _onReorder,
      noItemsText: appI10N(context).ingredientListNoItems,
      selectedItems: _selectedItems,
      // withCheckbox: true,
    );
  }
}

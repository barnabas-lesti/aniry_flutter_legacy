import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/shopping/models/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  final List<ShoppingItem> items;
  final List<ShoppingItem> checkedItems;
  final void Function(List<String>) onReorder;
  final void Function(String) onDelete;
  final void Function(String) onTap;

  const ShoppingList({
    required this.items,
    required this.checkedItems,
    required this.onReorder,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  List<AppListItem> _toListItems(List<ShoppingItem> items) => items.map((item) => item.toListItem()).toList();

  @override
  Widget build(context) {
    return AppList(
      items: _toListItems(items),
      onDelete: onDelete,
      onTap: onTap,
      onReorder: onReorder,
      noItemsText: AppI10N.of(context).shoppingListNoItems,
      selectedItems: _toListItems(checkedItems),
      withCheckbox: true,
      dense: true,
    );
  }
}

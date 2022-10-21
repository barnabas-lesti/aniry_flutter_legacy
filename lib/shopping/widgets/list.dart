import 'package:aniry/app/widgets/list.dart';
import 'package:aniry/app/i10n.dart';
import 'package:aniry/shopping/models/item.dart';
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

  List<AppListItem> _toListItems(List<ShoppingItem> items) =>
      items.map((ShoppingItem item) => AppListItem(id: item.id, textLeftPrimary: item.name)).toList();

  @override
  Widget build(context) {
    return AppList(
      items: _toListItems(items),
      onDelete: onDelete,
      onTap: onTap,
      onReorder: onReorder,
      noItemsText: appI10N(context)!.shoppingHomePageNoItems,
      selectedItems: _toListItems(checkedItems),
      withCheckbox: true,
    );
  }
}

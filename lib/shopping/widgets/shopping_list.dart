import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/shopping/models/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  final List<ShoppingItem> items;
  final List<String> selectedIDs;
  final void Function(List<String>) onReorder;
  final void Function(String) onDelete;
  final void Function(String) onTap;

  const ShoppingList({
    required this.items,
    required this.selectedIDs,
    required this.onReorder,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(context) {
    return AppList(
      items: items.map((item) => item.toListItem()).toList(),
      selectedIDs: selectedIDs,
      noItemsText: AppI10N.of(context).shoppingListNoItems,
      dense: true,
      showCheckbox: true,
      selectedDecoration: AppListSelectedDecoration.strikethrough,
      expanded: true,
      onDelete: onDelete,
      onTap: onTap,
      onReorder: onReorder,
    );
  }
}

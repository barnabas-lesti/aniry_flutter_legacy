import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_row.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final List<ShoppingListItem> items;
  final void Function(int, bool) onCheck;
  final void Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return ShoppingListRow(
            onDelete: () => onDelete(index),
            item: items[index],
            onCheck: (isChecked) => onCheck(index, isChecked),
          );
        },
      ),
    );
  }
}

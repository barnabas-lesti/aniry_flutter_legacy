import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_tile.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<ShoppingListItem> items;
  final void Function(int, bool) onCheck;
  final void Function(int) onDelete;
  final void Function(List<ShoppingListItem>) onReorder;

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ShoppingListItem item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    onReorder([...items]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView(
        onReorder: _onReorder,
        children: [
          for (int index = 0; index < items.length; index += 1)
            ShoppingListTile(
              key: UniqueKey(),
              onDelete: () => onDelete(index),
              item: items[index],
              onCheck: (isChecked) => onCheck(index, isChecked),
            )
        ],
      ),
    );
  }
}

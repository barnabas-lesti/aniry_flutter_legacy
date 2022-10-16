import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<ShoppingItem> items;
  final void Function(ShoppingItem, bool) onCheck;
  final void Function(ShoppingItem) onDelete;
  final void Function(List<ShoppingItem>) onReorder;

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ShoppingItem item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    onReorder([...items]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView(
        onReorder: _onReorder,
        children: [
          for (int i = 0; i < items.length; i++)
            _ShoppingListTile(
              key: UniqueKey(),
              onDelete: () => onDelete(items[i]),
              item: items[i],
              onCheck: (checked) => onCheck(items[i], checked),
            )
        ],
      ),
    );
  }
}

class _ShoppingListTile extends StatelessWidget {
  const _ShoppingListTile({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final ShoppingItem item;
  final void Function(bool) onCheck;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Dismissible(
        key: super.key ?? UniqueKey(),
        onDismissed: (_) => onDelete(),
        child: GestureDetector(
          onTap: () => onCheck(!item.checked),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Checkbox(
              value: item.checked,
              onChanged: (bool? value) => onCheck(value ?? false),
            ),
            title: Text(
              item.text,
              style: TextStyle(decoration: item.checked ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}

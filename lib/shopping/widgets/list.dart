import 'package:aniry/shopping/models/item.dart';
import 'package:flutter/material.dart';

class ShoppingListWidget extends StatelessWidget {
  const ShoppingListWidget({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<ShoppingItemModel> items;
  final void Function(ShoppingItemModel, bool) onCheck;
  final void Function(ShoppingItemModel) onDelete;
  final void Function(List<ShoppingItemModel>) onReorder;

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ShoppingItemModel item = items.removeAt(oldIndex);
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
            _ShoppingListTileWidget(
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

class _ShoppingListTileWidget extends StatelessWidget {
  const _ShoppingListTileWidget({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final ShoppingItemModel item;
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

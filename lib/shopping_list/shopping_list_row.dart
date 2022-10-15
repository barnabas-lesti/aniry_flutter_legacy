import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:flutter/material.dart';

class ShoppingListRow extends StatelessWidget {
  const ShoppingListRow({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onCheck,
  }) : super(key: key);

  final ShoppingListItem item;
  final void Function(bool) onCheck;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (_) => onDelete(),
        child: GestureDetector(
          onTap: () => onCheck(!item.isChecked),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Checkbox(
              value: item.isChecked,
              onChanged: (bool? value) => onCheck(value ?? false),
            ),
            title: Text(
              item.text,
              style: TextStyle(decoration: item.isChecked ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:aniry_shopping_list/shopping_list/item.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatelessWidget {
  const ShoppingListTile({
    required this.item,
    required this.onDelete,
    required this.onCheck,
    Key? key,
  }) : super(key: key);

  final ShoppingListItem item;
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

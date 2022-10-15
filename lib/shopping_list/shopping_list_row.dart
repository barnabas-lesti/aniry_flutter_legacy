import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:flutter/material.dart';

class ShoppingListRow extends StatelessWidget {
  const ShoppingListRow({
    Key? key,
    required this.item,
    this.onCheck,
  }) : super(key: key);

  final ShoppingListItem item;
  final void Function(bool)? onCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => onCheck!(!item.isChecked),
        child: Row(
          children: [
            Checkbox(
              value: item.isChecked,
              onChanged: (bool? value) => onCheck!(value ?? false),
            ),
            Text(
              item.text,
              style: TextStyle(decoration: item.isChecked ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}

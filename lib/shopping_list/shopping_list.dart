import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_row.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({
    required this.items,
    Key? key,
  }) : super(key: key);

  final List<ShoppingListItem> items;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  void _onCheck(int index, bool value) {
    setState(() => widget.items[index].isChecked = value);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.items.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return ShoppingListRow(
            item: widget.items[index],
            onCheck: (isChecked) => _onCheck(index, isChecked),
          );
        },
      ),
    );
  }
}

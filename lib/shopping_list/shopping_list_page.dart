import 'package:aniry_shopping_list/shopping_list/shopping_list.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_input.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  final String title = 'Shopping List';

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ShoppingListItem> _items = [];

  void _createNewItem(String newItem) {
    setState(() => _items = [ShoppingListItem(text: newItem), ..._items]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: ShoppingListInput(onSubmit: _createNewItem),
            ),
            ShoppingList(items: _items),
          ],
        ),
      ),
    );
  }
}

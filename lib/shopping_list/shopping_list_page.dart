import 'package:aniry_shopping_list/app/app_confirmation_dialog.dart';
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

  void _addItem(String text) => setState(() => _items.add(ShoppingListItem(text: text)));
  void _checkItem(int index, bool isChecked) => setState(() => _items[index].isChecked = isChecked);
  void _deleteItem(int index) => setState(() => _items.removeAt(index));
  void _deleteItems() => setState(() => _items = []);
  void _onReorder(List<ShoppingListItem> items) => setState(() => _items = items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: _items.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => showAppConfirmationDialog(
                context: context,
                text: 'Are you sure you want to clear your list?',
                onConfirm: _deleteItems,
              ),
              backgroundColor: Colors.red[400],
              child: const Icon(Icons.delete),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShoppingListInput(onSubmit: _addItem),
            ),
            ShoppingList(
              items: _items,
              onCheck: _checkItem,
              onDelete: _deleteItem,
              onReorder: _onReorder,
            ),
          ],
        ),
      ),
    );
  }
}

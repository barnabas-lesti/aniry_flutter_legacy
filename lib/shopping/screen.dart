import 'package:aniry_shopping_list/app/confirmation_dialog.dart';
import 'package:aniry_shopping_list/app/fab.dart';
import 'package:aniry_shopping_list/shopping/list.dart';
import 'package:aniry_shopping_list/shopping/input.dart';
import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:aniry_shopping_list/shopping/service.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  final String title = 'Shopping List';

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  late ShoppingServiceResult<ShoppingItem> _items;

  _ShoppingScreenState() {
    _items = shoppingService.getAllItems();
  }

  void _addItem(String text) => setState(() => shoppingService.addItem(text, _items.toList().length));

  void _checkItem(ShoppingItem item, bool checked) => setState(() => shoppingService.checkItem(item, checked));

  void _deleteItem(ShoppingItem item) => setState(() => shoppingService.deleteItem(item));

  void _deleteItems() => setState(() => shoppingService.deleteAllItems());

  void _reorderItems(List<ShoppingItem> items) => setState(() => shoppingService.reorderItems(_items, items));

  List<ShoppingItem> _sortByOrder(List<ShoppingItem> items) => shoppingService.sortItemsByOrder(items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: _items.isNotEmpty
          ? AppFab(
              onPressed: () => showAppConfirmationDialog(
                context: context,
                text: 'Are you sure you want to clear your list?',
                onConfirm: _deleteItems,
              ),
              icon: const Icon(Icons.delete),
              color: Colors.red[400],
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShoppingInput(onSubmit: _addItem),
            ),
            ShoppingList(
              items: _sortByOrder(_items.toList()),
              onCheck: _checkItem,
              onDelete: _deleteItem,
              onReorder: _reorderItems,
            ),
          ],
        ),
      ),
    );
  }
}

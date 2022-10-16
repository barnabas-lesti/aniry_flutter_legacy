import 'package:aniry_shopping_list/app/app_confirmation_dialog.dart';
import 'package:aniry_shopping_list/app/realm.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_input.dart';
import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  final String title = 'Shopping List';

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  late RealmResults<ShoppingListItem> _items;

  _ShoppingListPageState() {
    _items = realm.all<ShoppingListItem>();
  }

  void _addItem(String text) =>
      setState(() => realm.write(() => realm.add(ShoppingListItem(Uuid.v4(), text, _items.toList().length))));

  void _checkItem(ShoppingListItem item, bool checked) => setState(() => realm.write(() => item.checked = checked));

  void _deleteItem(ShoppingListItem item) => setState(() => realm.write(() => realm.delete(item)));

  void _deleteItems() => setState(() => realm.write(() => realm.deleteAll<ShoppingListItem>()));

  void _changeItemsOrder(List<ShoppingListItem> updatedItems) => setState(() => realm.write(() {
        for (int i = 0; i < updatedItems.length; i++) {
          final item = _items.singleWhere((element) => element.id == updatedItems[i].id);
          if (item.order != i) {
            item.order = i;
          }
        }
      }));

  List<ShoppingListItem> _sortByOrder(List<ShoppingListItem> items) =>
      items..sort((a, b) => a.order.compareTo(b.order));

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
              items: _sortByOrder(_items.toList()),
              onCheck: _checkItem,
              onDelete: _deleteItem,
              onReorder: _changeItemsOrder,
            ),
          ],
        ),
      ),
    );
  }
}

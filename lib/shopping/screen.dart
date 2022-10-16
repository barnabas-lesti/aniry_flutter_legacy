import 'package:aniry_shopping_list/app/confirmation_dialog.dart';
import 'package:aniry_shopping_list/app/realm.dart';
import 'package:aniry_shopping_list/shopping/list.dart';
import 'package:aniry_shopping_list/shopping/input.dart';
import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  final String title = 'Shopping List';

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  late RealmResults<ShoppingItem> _items;

  _ShoppingScreenState() {
    _items = appRealm.all<ShoppingItem>();
  }

  void _addItem(String text) =>
      setState(() => appRealm.write(() => appRealm.add(ShoppingItem(Uuid.v4(), text, _items.toList().length))));

  void _checkItem(ShoppingItem item, bool checked) => setState(() => appRealm.write(() => item.checked = checked));

  void _deleteItem(ShoppingItem item) => setState(() => appRealm.write(() => appRealm.delete(item)));

  void _deleteItems() => setState(() => appRealm.write(() => appRealm.deleteAll<ShoppingItem>()));

  void _changeItemsOrder(List<ShoppingItem> updatedItems) => setState(() => appRealm.write(() {
        for (int i = 0; i < updatedItems.length; i++) {
          final item = _items.singleWhere((element) => element.id == updatedItems[i].id);
          if (item.order != i) {
            item.order = i;
          }
        }
      }));

  List<ShoppingItem> _sortByOrder(List<ShoppingItem> items) => items..sort((a, b) => a.order.compareTo(b.order));

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
              child: ShoppingInput(onSubmit: _addItem),
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

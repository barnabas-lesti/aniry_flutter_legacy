import 'package:aniry_shopping_list/app/app_confirmation_dialog.dart';
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
  final Realm realm = Realm(Configuration.local([ShoppingListItem.schema]));
  late List<ShoppingListItem> _items;

  _ShoppingListPageState() {
    _items = realm.all<ShoppingListItem>().toList();
  }

  void _addItem(String text) {
    final item = ShoppingListItem(Uuid.v4(), text, _items.length);
    _items.add(item);
    realm.write(() => realm.add(item));
    setState(() => {});
  }

  void _checkItem(int index, bool checked) {
    realm.write(() => _items[index].checked = checked);
    setState(() => {});
  }

  void _deleteItem(int index) {
    final item = _items.removeAt(index);
    realm.write(() => realm.delete(item));
    setState(() => {});
  }

  void _deleteItems() {
    _items = [];
    realm.write(() => realm.deleteAll<ShoppingListItem>());
    setState(() => {});
  }

  void _changeOrder(List<ShoppingListItem> updatedItems) {
    realm.write(() {
      for (int i = 0; i < updatedItems.length; i++) {
        final item = _items.singleWhere((element) => element.id == updatedItems[i].id);
        if (item.order != i) {
          item.order = i;
        }
      }
    });
    setState(() => {});
  }

  List<ShoppingListItem> _sortByOrder(List<ShoppingListItem> items) {
    return items..sort((a, b) => a.order.compareTo(b.order));
  }

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
              items: _sortByOrder(_items),
              onCheck: _checkItem,
              onDelete: _deleteItem,
              onReorder: _changeOrder,
            ),
          ],
        ),
      ),
    );
  }
}

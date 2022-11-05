import 'package:aniry/app/app_storage.dart';
import 'package:aniry/shopping/models/shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  ShoppingProvider() {
    lazyLoadItems();
  }

  bool _itemsLoaded = false;
  List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;
  List<ShoppingItem> get checkedItems => items.where((item) => item.checked).toList();

  set items(List<ShoppingItem> items) {
    _items = items;
    notifyListeners();
    if (_itemsLoaded) _storeItems();
  }

  void createItem(String name) {
    items = [...items, ShoppingItem(id: const Uuid().v4(), name: name)];
  }

  void checkItem(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    items[index].checked = !_items[index].checked;
    items = [...items];
  }

  void deleteItem(String id) {
    items = items.where((item) => item.id != id).toList();
  }

  void deleteCheckedItems() {
    items = items.where((item) => !item.checked).toList();
  }

  void deleteAllItems() {
    items = [];
  }

  void reorderItems(List<String> orderedIDs) {
    items = orderedIDs.map((id) => items.singleWhere((item) => item.id == id)).toList();
  }

  static ShoppingProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of(context, listen: listen);
  }

  Future<List<ShoppingItem>> lazyLoadItems() async {
    if (!_itemsLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.shopping) as List<dynamic>;
      items = data.map((raw) => ShoppingItem.fromJson(raw)).toList();
      _itemsLoaded = true;
    }
    return items;
  }

  Future<void> _storeItems() async {
    AppStorage.storePartitionData(AppPartition.shopping, items);
  }
}

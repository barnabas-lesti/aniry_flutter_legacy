import 'package:aniry/app/storage.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  ShoppingProvider() {
    _loadItems();
  }

  bool itemsLoaded = false;
  List<ShoppingItem> _items = [];
  List<ShoppingItem> get items => _items;
  List<ShoppingItem> get checkedItems => items.where((item) => item.checked).toList();

  set items(List<ShoppingItem> items) {
    _items = items;
    notifyListeners();
    if (itemsLoaded) _storeItems();
  }

  void addItem(String name) {
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

  void reorderItems(List<String> ids) {
    items = ids.map((id) => items.singleWhere((item) => item.id == id)).toList();
  }

  void deleteAllItems() {
    items = [];
  }

  Future<void> _loadItems() async {
    final data = await appStorage.fetchData(AppPartition.shopping) as List<dynamic>;
    items = data.map((raw) => ShoppingItem.fromJson(raw)).toList();
    itemsLoaded = true;
  }

  Future<void> _storeItems() async {
    appStorage.storeData(AppPartition.shopping, items);
  }
}

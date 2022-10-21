import 'package:aniry/app/storage.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  ShoppingProvider() {
    _storage = AppStorage(partition: AppPartition.shopping);
    _fetchItems();
  }

  late final AppStorage _storage;

  List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  List<ShoppingItem> get checkedItems => _items.where((item) => item.checked).toList();

  set items(List<ShoppingItem> items) {
    _items = items;
    notifyListeners();
  }

  void addItem(String name) {
    _items.add(ShoppingItem(id: const Uuid().v4(), name: name));
    _postChange();
  }

  void checkItem(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items[index].checked = !_items[index].checked;
    _postChange();
  }

  void deleteItem(String id) {
    _items = _items.where((item) => item.id != id).toList();
    _postChange();
  }

  void deleteCheckedItems() {
    _items = _items.where((item) => !item.checked).toList();
    _postChange();
  }

  void reorderItems(List<String> ids) {
    _items = ids.map((id) => _items.singleWhere((item) => item.id == id)).toList();
    _postChange();
  }

  void deleteAllItems() {
    _items.clear();
    _postChange();
  }

  void _postChange() {
    notifyListeners();
    _storeItems();
  }

  Future<void> _fetchItems() async {
    final data = await _storage.fetchData() as List<dynamic>;
    items = data.map((raw) => ShoppingItem.fromJson(raw)).toList();
  }

  Future<void> _storeItems() async => _storage.storeData(_items);
}

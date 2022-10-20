import 'package:aniry/app/storage.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  late final AppStorage storage;

  ShoppingProvider() {
    storage = AppStorage<ShoppingItem>(collection: AppCollection.shopping, fromJson: ShoppingItem.fromJson);
    storage.fetchItems().then((storedItems) => items = storedItems as List<ShoppingItem>);
  }

  List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  List<ShoppingItem> get checkedItems => _items.where((item) => item.checked).toList();

  set items(List<ShoppingItem> items) {
    _items = items;
    notifyListeners();
  }

  void addItem(String text) {
    _items.add(ShoppingItem(id: const Uuid().v4(), text: text));
    _postChange();
  }

  void checkItem(ShoppingItem item, bool checked) {
    _items[_items.indexWhere((i) => i.id == item.id)].checked = checked;
    _postChange();
  }

  void deleteItem(ShoppingItem item) {
    _items = _items.where((i) => i.id != item.id).toList();
    _postChange();
  }

  void deleteCheckedItems() {
    _items = _items.where((item) => !item.checked).toList();
    _postChange();
  }

  void deleteAllItems() {
    _items.clear();
    _postChange();
  }

  void _postChange() {
    notifyListeners();
    storage.storeItems(_items);
  }
}

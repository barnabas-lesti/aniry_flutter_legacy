import 'package:aniry/shopping/item.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  List<ShoppingItem> get checkedItems => _items.where((item) => item.checked).toList();

  set items(List<ShoppingItem> items) {
    _items = items;
    notifyListeners();
  }

  void addItem(String text) {
    _items.add(ShoppingItem(id: const Uuid().v4(), text: text));
    notifyListeners();
  }

  void checkItem(ShoppingItem item, bool checked) {
    _items[_items.indexWhere((i) => i.id == item.id)].checked = checked;
    notifyListeners();
  }

  void deleteItem(ShoppingItem item) {
    _items = _items.where((i) => i.id != item.id).toList();
    notifyListeners();
  }

  void deleteCheckedItems() {
    _items = _items.where((item) => !item.checked).toList();
    notifyListeners();
  }

  void deleteAllItems() {
    _items.clear();
    notifyListeners();
  }
}

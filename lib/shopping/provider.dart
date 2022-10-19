import 'dart:convert';
import 'dart:io';

import 'package:aniry/shopping/item.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ShoppingProvider extends ChangeNotifier {
  ShoppingProvider() {
    _loadItems();
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
    notifyListeners();
    _storeItems();
  }

  void checkItem(ShoppingItem item, bool checked) {
    _items[_items.indexWhere((i) => i.id == item.id)].checked = checked;
    notifyListeners();
    _storeItems();
  }

  void deleteItem(ShoppingItem item) {
    _items = _items.where((i) => i.id != item.id).toList();
    notifyListeners();
    _storeItems();
  }

  void deleteCheckedItems() {
    _items = _items.where((item) => !item.checked).toList();
    notifyListeners();
    _storeItems();
  }

  void deleteAllItems() {
    _items.clear();
    notifyListeners();
    _storeItems();
  }

  Future<File> get _storageFile async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/storage.ani');
  }

  void _loadItems() async {
    final file = await _storageFile;
    if (!await file.exists()) return;

    final dataString = await file.readAsString();
    final data = json.decode(dataString) as List<dynamic>;
    items = data.map((raw) => ShoppingItem.fromJson(raw)).toList();
  }

  void _storeItems() async {
    final file = await _storageFile;
    await file.writeAsString(json.encode(_items));
  }
}

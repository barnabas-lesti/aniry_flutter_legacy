import 'package:aniry/app/storage.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class IngredientProvider extends ChangeNotifier {
  IngredientProvider() {
    _loadItems();
  }

  bool itemsLoaded = false;
  List<IngredientItem> _items = [];
  List<IngredientItem> get items => _items;

  set items(List<IngredientItem> items) {
    _items = items;
    notifyListeners();
    if (itemsLoaded) _storeItems();
  }

  void createItem(IngredientItem item) {
    item.id = const Uuid().v4();
    items = [...items, item];
  }

  void updateItem(IngredientItem update) {
    items = [...items.where((item) => item.id != update.id).toList(), update];
  }

  IngredientItem getItem(String id) {
    return items.where((item) => item.id == id).first;
  }

  void deleteItem(String id) {
    items = items.where((item) => item.id != id).toList();
  }

  Future<void> _loadItems() async {
    final data = await appStorage.fetchData(AppPartition.ingredient) as List<dynamic>;
    items = data.map((raw) => IngredientItem.fromJson(raw)).toList();
    itemsLoaded = true;
  }

  Future<void> _storeItems() async {
    appStorage.storeData(AppPartition.ingredient, items);
  }
}

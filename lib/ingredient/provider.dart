import 'package:aniry/app/storage.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class IngredientProvider extends ChangeNotifier {
  IngredientProvider() {
    lazyLoadItems();
  }

  bool itemsLoaded = false;
  List<IngredientItem> _items = [];
  List<IngredientItem> get items => _items;

  set items(List<IngredientItem> items) {
    _items = items;
    notifyListeners();
    if (itemsLoaded) _storeItems();
  }

  IngredientItem getItem(String id) {
    return items.where((item) => item.id == id).first;
  }

  void createItem(IngredientItem item) {
    item.id = const Uuid().v4();
    items = [...items, item];
  }

  void updateItem(IngredientItem update) {
    items = [...items.where((item) => item.id != update.id).toList(), update];
  }

  void deleteItem(String id) {
    items = items.where((item) => item.id != id).toList();
  }

  Future<List<IngredientItem>> lazyLoadItems() async {
    if (!itemsLoaded) {
      final data = await appStorage.fetchPartitionData(AppPartition.ingredient) as List<dynamic>;
      items = data.map((raw) => IngredientItem.fromJson(raw)).toList();
      itemsLoaded = true;
    }
    return items;
  }

  static IngredientProvider of(BuildContext context) {
    return Provider.of(context, listen: false);
  }

  Future<void> _storeItems() async {
    appStorage.storePartitionData(AppPartition.ingredient, items);
  }
}

import 'package:aniry/app/storage.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class IngredientProvider extends ChangeNotifier {
  IngredientProvider() {
    lazyLoadItems();
  }

  bool _itemsLoaded = false;
  List<IngredientItem> _items = [];
  String _ingredientHomeSearchString = '';

  List<IngredientItem> get items => _items;
  String get ingredientHomeSearchString => _ingredientHomeSearchString;
  List<IngredientItem> get ingredientHomeItems {
    return items.where((item) => AppUtils.isStringInString(item.name, ingredientHomeSearchString)).toList();
  }

  set items(List<IngredientItem> items) {
    _items = items;
    notifyListeners();
    if (_itemsLoaded) _storeItems();
  }

  set ingredientHomeSearchString(String searchString) {
    _ingredientHomeSearchString = searchString;
    notifyListeners();
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

  static IngredientProvider of(BuildContext context) {
    return Provider.of(context, listen: false);
  }

  Future<List<IngredientItem>> lazyLoadItems() async {
    if (!_itemsLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.ingredient) as List<dynamic>;
      items = data.map((raw) => IngredientItem.fromJson(raw)).toList();
      _itemsLoaded = true;
    }
    return items;
  }

  Future<void> _storeItems() async {
    AppStorage.storePartitionData(AppPartition.ingredient, items);
  }
}

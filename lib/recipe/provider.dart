import 'package:aniry/app/storage.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/recipe/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeProvider() {
    lazyLoadItems();
  }

  bool _itemsLoaded = false;
  List<RecipeItem> _items = [];
  String _recipeHomeSearchString = '';

  List<RecipeItem> get items => _items;
  String get recipeHomeSearchString => _recipeHomeSearchString;
  List<RecipeItem> get recipeHomeItems {
    return items.where((item) => AppUtils.isStringInString(item.name, recipeHomeSearchString)).toList();
  }

  set items(List<RecipeItem> items) {
    _items = items;
    notifyListeners();
    if (_itemsLoaded) _storeItems();
  }

  set recipeHomeSearchString(String searchString) {
    _recipeHomeSearchString = searchString;
    notifyListeners();
  }

  RecipeItem getItem(String id) {
    return items.where((item) => item.id == id).first;
  }

  void createItem(RecipeItem item) {
    item.id = const Uuid().v4();
    items = [...items, item];
  }

  void updateItem(RecipeItem update) {
    items = [...items.where((item) => item.id != update.id).toList(), update];
  }

  void deleteItem(String id) {
    items = items.where((item) => item.id != id).toList();
  }

  static RecipeProvider of(BuildContext context) {
    return Provider.of(context, listen: false);
  }

  Future<List<RecipeItem>> lazyLoadItems() async {
    if (!_itemsLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.recipe) as List<dynamic>;
      items = data.map((raw) => RecipeItem.fromJson(raw)).toList();
      _itemsLoaded = true;
    }
    return items;
  }

  Future<void> _storeItems() async {
    AppStorage.storePartitionData(AppPartition.recipe, items);
  }
}

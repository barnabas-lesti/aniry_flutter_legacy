import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/models/serving_unit.dart';
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

  void createItem({
    required String name,
    required double calories,
    required double carbs,
    required double protein,
    required double fat,
    required double servingValue,
    required AppServingUnit servingUnit,
    required String? description,
  }) {
    final item = IngredientItem(
      id: const Uuid().v4(),
      name: name,
      calories: calories,
      description: description,
      nutrients: AppNutrients(
        carbs: carbs,
        protein: protein,
        fat: fat,
      ),
      servings: [
        AppServing(
          unit: servingUnit,
          value: servingValue,
        )
      ],
    );
    items = [...items, item];
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

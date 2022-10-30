import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryProvider extends ChangeNotifier {
  List<AppCalculableItem> _calculableItems = [];

  List<AppCalculableItem> get calculableItems => _calculableItems;

  set calculableItems(List<AppCalculableItem> items) {
    _calculableItems = items;
    notifyListeners();
  }

  static DiaryProvider of(BuildContext context) {
    return Provider.of(context, listen: false);
  }

  Future<List<AppCalculableItem>> lazyLoadCalculableItems(BuildContext context) async {
    final partitions = await Future.wait([
      IngredientProvider.of(context).lazyLoadIngredients(),
      RecipeProvider.of(context).lazyLoadRecipes(),
    ]);
    calculableItems = [...partitions[0], ...partitions[1]];
    return calculableItems;
  }
}

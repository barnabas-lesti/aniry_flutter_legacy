import 'package:aniry/app/app_storage.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class IngredientProvider extends ChangeNotifier {
  IngredientProvider() {
    lazyLoadIngredients();
  }

  bool _ingredientsLoaded = false;
  List<Ingredient> _ingredients = [];
  String _ingredientHomeSearchString = '';

  List<Ingredient> get ingredients => _ingredients;
  String get ingredientHomeSearchString => _ingredientHomeSearchString;
  List<Ingredient> get ingredientHomeIngredients {
    return ingredients
        .where((ingredient) => AppUtils.isStringInString(ingredient.name, ingredientHomeSearchString))
        .toList();
  }

  set ingredients(List<Ingredient> ingredients) {
    _ingredients = ingredients;
    notifyListeners();
    _storeIngredients();
  }

  set ingredientHomeSearchString(String searchString) {
    _ingredientHomeSearchString = searchString;
    notifyListeners();
  }

  Ingredient getIngredient(String id) {
    return ingredients.where((ingredient) => ingredient.id == id).first;
  }

  void createIngredient(Ingredient ingredient) {
    ingredient.id = const Uuid().v4();
    ingredients = [...ingredients, ingredient];
  }

  void updateIngredient(BuildContext context, Ingredient updatedIngredient) {
    ingredients = [
      ...ingredients.where((ingredient) => ingredient.id != updatedIngredient.id).toList(),
      updatedIngredient
    ];
    RecipeProvider.of(context).updateIngredientInRecipes(updatedIngredient);
  }

  void deleteIngredient(BuildContext context, String id) {
    ingredients = ingredients.where((ingredient) => ingredient.id != id).toList();
    RecipeProvider.of(context).deleteIngredientFromRecipes(id);
  }

  static IngredientProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of(context, listen: listen);
  }

  Future<List<Ingredient>> lazyLoadIngredients() async {
    if (!_ingredientsLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.ingredient) as List<dynamic>;
      _ingredients = data.map((raw) => Ingredient.fromJson(raw)).toList();
      _ingredientsLoaded = true;
      notifyListeners();
    }
    return ingredients;
  }

  Future<void> _storeIngredients() async {
    AppStorage.storePartitionData(AppPartition.ingredient, ingredients);
  }
}

import 'package:aniry/app/app_storage.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeProvider() {
    lazyLoadRecipes();
  }

  bool _recipesLoaded = false;
  List<Recipe> _recipes = [];
  String _recipeHomeSearchString = '';

  List<Recipe> get recipes => _recipes;
  String get recipeHomeSearchString => _recipeHomeSearchString;
  List<Recipe> get recipeHomeRecipes {
    return recipes.where((recipe) => AppUtils.isStringInString(recipe.name, recipeHomeSearchString)).toList();
  }

  set recipes(List<Recipe> recipes) {
    _recipes = recipes;
    notifyListeners();
    _storeRecipes();
  }

  set recipeHomeSearchString(String searchString) {
    _recipeHomeSearchString = searchString;
    notifyListeners();
  }

  Recipe getRecipe(String id) {
    return recipes.where((recipe) => recipe.id == id).first;
  }

  void createRecipe(Recipe recipe) {
    recipe.id = const Uuid().v4();
    recipes = [...recipes, recipe];
  }

  void updateRecipe(Recipe updatedRecipe) {
    recipes = [...recipes.where((recipe) => recipe.id != updatedRecipe.id).toList(), updatedRecipe];
  }

  void deleteRecipe(String id) {
    recipes = recipes.where((recipe) => recipe.id != id).toList();
  }

  static RecipeProvider of(BuildContext context) {
    return Provider.of(context, listen: false);
  }

  Future<List<Recipe>> lazyLoadRecipes() async {
    if (!_recipesLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.recipe) as List<dynamic>;
      _recipes = data.map((raw) => Recipe.fromJson(raw)).toList();
      _recipesLoaded = true;
      notifyListeners();
    }
    return recipes;
  }

  Future<void> _storeRecipes() async {
    AppStorage.storePartitionData(AppPartition.recipe, recipes);
  }
}

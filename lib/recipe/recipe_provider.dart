import 'package:aniry/app/app_storage.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/models/app_served_item.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/models/recipe_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeProvider() {
    lazyLoadRecipes();
  }

  bool _recipesLoaded = false;

  List<Ingredient> _ingredients = [];
  List<Ingredient> get ingredients => _ingredients;
  set ingredients(List<Ingredient> ingredients) {
    print('RecipeProvider::set::ingredients');
    _ingredients = ingredients;
    notifyListeners();
  }

  List<RecipeSource> _recipeSources = [];
  List<RecipeSource> get recipeSources => _recipeSources;
  set recipeSources(List<RecipeSource> recipeSources) {
    print('RecipeProvider::set::recipeSources');
    _recipeSources = recipeSources;
    notifyListeners();
    _storeRecipes();
  }

  List<Recipe> get recipes {
    print('RecipeProvider::get::recipes');
    return recipeSources.map((recipeSource) {
      final servedItems = recipeSource.servedItemSources
          .map((servedItemSource) {
            final servableItem = ingredients
                .where((ingredient) => ingredient.id == servedItemSource.itemID)
                .firstOrNull
                ?.toServableItem();
            if (servableItem == null) return null;
            return AppServedItem(
              serving: AppServing(unit: servableItem.serving.unit, value: servedItemSource.serving.value),
              item: servableItem,
            );
          })
          .whereType<AppServedItem>()
          .toList();
      return recipeSource.toRecipe(servedItems: servedItems);
    }).toList();
  }

  set recipes(List<Recipe> recipes) {
    recipeSources = recipes.map((recipe) => RecipeSource.fromRecipe(recipe)).toList();
  }

  String _recipeHomeSearchString = '';
  String get recipeHomeSearchString => _recipeHomeSearchString;
  set recipeHomeSearchString(String searchString) {
    _recipeHomeSearchString = searchString;
    notifyListeners();
  }

  List<Recipe> get recipeHomeRecipes {
    return recipes.where((recipe) => AppUtils.isStringInString(recipe.name, recipeHomeSearchString)).toList();
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

  static RecipeProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of(context, listen: listen);
  }

  Future<List<Recipe>> lazyLoadRecipes() async {
    if (!_recipesLoaded) {
      final data = await AppStorage.loadPartitionData(AppPartition.recipe) as List<dynamic>;
      _recipeSources = data.map((raw) => RecipeSource.fromJson(raw)).toList();
      _recipesLoaded = true;
      notifyListeners();
    }
    return recipes;
  }

  Future<void> _storeRecipes() async {
    AppStorage.storePartitionData(AppPartition.recipe, recipeSources);
  }
}

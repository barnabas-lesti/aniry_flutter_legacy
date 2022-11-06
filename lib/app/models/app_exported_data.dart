import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/recipe/models/recipe_source.dart';
import 'package:aniry/shopping/models/shopping_item.dart';

class AppExportedData {
  late final List<ShoppingItem> shoppingItems;
  late final List<Ingredient> ingredients;
  late final List<RecipeSource> recipeSources;

  AppExportedData({
    this.shoppingItems = const [],
    this.ingredients = const [],
    this.recipeSources = const [],
  });

  static AppExportedData fromJson(Map<String, dynamic> json) {
    return AppExportedData(
      shoppingItems: ((json['shoppingItems'] ?? []) as List<dynamic>)
          .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      ingredients: ((json['ingredients'] ?? []) as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipeSources: ((json['recipeSources'] ?? []) as List<dynamic>)
          .map((e) => RecipeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'shoppingItems': shoppingItems,
      'ingredients': ingredients,
      'recipeSources': recipeSources,
    };
  }
}

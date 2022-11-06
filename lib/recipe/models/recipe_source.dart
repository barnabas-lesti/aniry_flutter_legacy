import 'package:aniry/app/models/app_served_item.dart';
import 'package:aniry/app/models/app_served_item_source.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/recipe/models/recipe.dart';

class RecipeSource {
  late String id;
  late String name;
  late List<AppServing> servings;
  late String description;
  late List<AppServedItemSource> servedItemSources;

  RecipeSource({
    required this.id,
    required this.name,
    required this.servings,
    required this.servedItemSources,
    required this.description,
  });

  static RecipeSource fromJson(Map<String, dynamic> json) {
    return RecipeSource(
      id: json['id'] as String,
      name: json['name'] as String,
      servings: (json['servings'] as List<dynamic>)
          .map((serving) => AppServing.fromJson(serving as Map<String, dynamic>))
          .toList(),
      servedItemSources: (json['servedItemSources'] as List<dynamic>? ?? [])
          .map((item) => AppServedItemSource.fromJson(item as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String? ?? '',
    );
  }

  static RecipeSource fromRecipe(Recipe recipe) {
    return RecipeSource(
      id: recipe.id,
      name: recipe.name,
      servings: recipe.servings,
      description: recipe.description,
      servedItemSources:
          recipe.servedItems.map((servedItem) => AppServedItemSource.fromServedItem(servedItem)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'name': name,
      'servings': servings,
    };
    if (servedItemSources.isNotEmpty) json['servedItemSources'] = servedItemSources;
    if (description.isNotEmpty) json['description'] = description;
    return json;
  }

  Recipe toRecipe({required List<AppServedItem> servedItems}) {
    return Recipe(
      id: id,
      name: name,
      servings: servings,
      description: description,
      servedItems: servedItems,
    );
  }
}

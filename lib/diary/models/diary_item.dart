import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/recipe/models/recipe_proxy.dart';
import 'package:collection/collection.dart';

class DiaryItem {
  late List<IngredientProxy> ingredientProxies;
  late List<RecipeProxy> recipeProxies;
  late List<String> orderedIDs;

  DiaryItem() {
    ingredientProxies = [];
    recipeProxies = [];
    orderedIDs = [];
  }

  double get calories {
    final ingredientCalories =
        AppCalculableItem.reduceCaloriesList(ingredientProxies.map((proxy) => proxy.calories).toList());
    final recipeCalories = AppCalculableItem.reduceCaloriesList(recipeProxies.map((proxy) => proxy.calories).toList());
    return ingredientCalories + recipeCalories;
  }

  AppNutrients get nutrients {
    final ingredientNutrients =
        AppCalculableItem.reduceNutrientsList(ingredientProxies.map((proxy) => proxy.nutrients).toList());
    final recipeNutrients =
        AppCalculableItem.reduceNutrientsList(recipeProxies.map((proxy) => proxy.nutrients).toList());
    return AppNutrients(
      carbs: ingredientNutrients.carbs + recipeNutrients.carbs,
      protein: ingredientNutrients.protein + recipeNutrients.protein,
      fat: ingredientNutrients.fat + recipeNutrients.fat,
    );
  }

  List<AppListItem> get listItems {
    return orderedIDs
        .map((id) {
          final ingredientProxy = ingredientProxies.where((proxy) => proxy.id == id).firstOrNull;
          if (ingredientProxy != null) return ingredientProxy.toListItem();
          final recipeProxy = recipeProxies.where((proxy) => proxy.id == id).firstOrNull;
          if (recipeProxy != null) return recipeProxy.toListItem();
        })
        .whereType<AppListItem>()
        .toList();
  }
}

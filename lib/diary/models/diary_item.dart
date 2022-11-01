import 'package:aniry/app/models/app_calculable_item.dart';
import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/recipe/models/recipe_proxy.dart';

class DiaryItem {
  late List<IngredientProxy> ingredientProxies;
  late List<RecipeProxy> recipeProxies;

  DiaryItem() {
    ingredientProxies = [];
    recipeProxies = [];
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
    return [
      ...ingredientProxies.map((proxy) => proxy.toListItem()).toList(),
      ...recipeProxies.map((proxy) => proxy.toListItem()).toList(),
    ];
  }
}

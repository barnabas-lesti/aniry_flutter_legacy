// import 'package:aniry/app/models/app_calculable_item.dart';
// import 'package:aniry/app/models/app_list_item.dart';
// import 'package:aniry/app/models/app_nutrients.dart';
// import 'package:aniry/ingredient/models/ingredient_proxy.dart';
// import 'package:aniry/recipe/models/recipe_proxy.dart';
// import 'package:collection/collection.dart';

// class DiaryItem {
//   late List<IngredientProxy> ingredientProxies;
//   late List<RecipeProxy> recipeProxies;
//   late List<String> orderedIDs;

//   DiaryItem() {
//     ingredientProxies = [];
//     recipeProxies = [];
//     orderedIDs = [];
//   }

//   double get calories {
//     return AppCalculableItem.reduceCalories([
//       ...ingredientProxies.map((proxy) => proxy.calories),
//       ...recipeProxies.map((proxy) => proxy.calories),
//     ]);
//   }

//   AppNutrients get nutrients {
//     return AppCalculableItem.reduceNutrients([
//       ...ingredientProxies.map((proxy) => proxy.nutrients),
//       ...recipeProxies.map((proxy) => proxy.nutrients),
//     ]);
//   }

//   List<AppListItem> get listItems {
//     return orderedIDs
//         .map((id) {
//           return ingredientProxies.where((proxy) => proxy.id == id).firstOrNull?.toListItem() ??
//               recipeProxies.where((proxy) => proxy.id == id).firstOrNull?.toListItem();
//         })
//         .whereType<AppListItem>()
//         .toList();
//   }
// }

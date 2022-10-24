import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/shopping/models/item.dart';

class AppExportedData {
  late final List<ShoppingItem> shoppingItems;
  late final List<IngredientItem> ingredientItems;

  AppExportedData({
    this.shoppingItems = const [],
    this.ingredientItems = const [],
  });

  static AppExportedData fromJson(Map<String, dynamic> json) {
    return AppExportedData(
      shoppingItems: ((json['shoppingItems'] ?? []) as List<dynamic>)
          .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      ingredientItems: ((json['ingredientItems'] ?? []) as List<dynamic>)
          .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'shoppingItems': shoppingItems,
      'ingredientItems': ingredientItems,
    };
  }
}

import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_data.g.dart';

@JsonSerializable()
class AppExportData {
  final List<ShoppingItem> shoppingItems;
  final List<IngredientItem> ingredients;

  AppExportData({
    required this.shoppingItems,
    required this.ingredients,
  });

  factory AppExportData.fromJson(Map<String, dynamic> json) => _$AppExportDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppExportDataToJson(this);
}

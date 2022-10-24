// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppExportData _$AppExportDataFromJson(Map<String, dynamic> json) =>
    AppExportData(
      shoppingItems: (json['shoppingItems'] as List<dynamic>)
          .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppExportDataToJson(AppExportData instance) =>
    <String, dynamic>{
      'shoppingItems': instance.shoppingItems,
      'ingredients': instance.ingredients,
    };

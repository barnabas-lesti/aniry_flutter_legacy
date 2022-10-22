// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientItem _$IngredientItemFromJson(Map<String, dynamic> json) =>
    IngredientItem(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num).toDouble(),
      nutrients:
          AppNutrients.fromJson(json['nutrients'] as Map<String, dynamic>),
      servings: (json['servings'] as List<dynamic>)
          .map((e) => AppServing.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$IngredientItemToJson(IngredientItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'calories': instance.calories,
      'nutrients': instance.nutrients,
      'servings': instance.servings,
      'description': instance.description,
    };

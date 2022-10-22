// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNutrients _$AppNutrientsFromJson(Map<String, dynamic> json) => AppNutrients(
      carbs: (json['carbs'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$AppNutrientsToJson(AppNutrients instance) =>
    <String, dynamic>{
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
    };

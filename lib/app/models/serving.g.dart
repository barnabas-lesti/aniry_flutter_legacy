// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppServing _$AppServingFromJson(Map<String, dynamic> json) => AppServing(
      unit: $enumDecode(_$AppServingUnitEnumMap, json['unit']),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$AppServingToJson(AppServing instance) =>
    <String, dynamic>{
      'unit': _$AppServingUnitEnumMap[instance.unit]!,
      'value': instance.value,
    };

const _$AppServingUnitEnumMap = {
  AppServingUnit.g: 'g',
  AppServingUnit.ml: 'ml',
  AppServingUnit.kcal: 'kcal',
};

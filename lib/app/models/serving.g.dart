// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppServing _$AppServingFromJson(Map<String, dynamic> json) => AppServing(
      unit: json['unit'] as String? ?? AppUnit.g,
      value: (json['value'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AppServingToJson(AppServing instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'value': instance.value,
    };

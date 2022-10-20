// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingItem _$ShoppingItemFromJson(Map<String, dynamic> json) => ShoppingItem(
      id: json['id'] as String,
      text: json['text'] as String,
      checked: json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$ShoppingItemToJson(ShoppingItem instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'checked': instance.checked,
    };

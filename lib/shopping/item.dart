import 'package:aniry/common/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class ShoppingItem extends CommonItem {
  ShoppingItem({
    required String id,
    required String text,
    bool checked = false,
  }) : super(
          id: id,
          text: text,
          checked: checked,
        );

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => _$ShoppingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingItemToJson(this);
}

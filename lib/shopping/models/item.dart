import 'package:aniry/app/models/list_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class ShoppingItem {
  final String id;
  final String name;
  bool checked;

  ShoppingItem({
    required this.id,
    required this.name,
    this.checked = false,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => _$ShoppingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingItemToJson(this);

  AppListItem toListItem() => AppListItem(id: id, textLeftPrimary: name);
}

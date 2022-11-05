import 'package:aniry/app/models/app_list_item.dart';

class ShoppingItem {
  late final String id;
  late final String name;
  late bool checked;

  ShoppingItem({
    required this.id,
    required this.name,
    this.checked = false,
  });

  static ShoppingItem fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'] as String,
      name: json['name'] as String,
      checked: json['checked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'id': id,
      'name': name,
    };
    if (checked) json['checked'] = checked;
    return json;
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      source: ShoppingItem,
      textLeftPrimary: name,
    );
  }
}

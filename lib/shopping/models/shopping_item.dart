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
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      checked: json['checked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'checked': checked,
    };
  }

  AppListItem toListItem() {
    return AppListItem(
      id: id,
      source: ShoppingItem,
      textLeftPrimary: name,
    );
  }
}

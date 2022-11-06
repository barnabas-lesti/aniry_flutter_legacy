import 'package:aniry/app/models/app_list_item.dart';

class ShoppingItem {
  final String id;
  final String name;
  bool checked;

  ShoppingItem({
    required this.id,
    required this.name,
    this.checked = false,
  });

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ checked.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShoppingItem &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            checked == other.checked;
  }

  @override
  String toString() {
    return 'ShoppingItem{id: $id, name: $name, checked: $checked}';
  }

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
      textLeftPrimary: name,
    );
  }
}

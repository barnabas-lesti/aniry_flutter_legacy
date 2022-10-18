import 'package:aniry/app/widgets/list.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:flutter/material.dart';

class ShoppingListWidget extends StatelessWidget {
  const ShoppingListWidget({
    required this.items,
    required this.onDelete,
    required this.onCheck,
    required this.onReorder,
    Key? key,
  }) : super(key: key);

  final List<ShoppingItemModel> items;
  final void Function(ShoppingItemModel, bool) onCheck;
  final void Function(ShoppingItemModel) onDelete;
  final void Function(List<ShoppingItemModel>) onReorder;

  AppListItem _toAppListItem(ShoppingItemModel item) => AppListItem(
        id: item.id,
        text: item.text,
        checked: item.checked,
      );

  ShoppingItemModel _toShoppingItem(AppListItem listItem) => items.singleWhere((item) => item.id == listItem.id);

  @override
  Widget build(BuildContext context) {
    return AppListWidget(
      items: items.map((item) => _toAppListItem(item)).toList(),
      onDelete: (listItem) => onDelete(_toShoppingItem(listItem)),
      onCheck: (listItem, checked) => onCheck(_toShoppingItem(listItem), checked),
      onReorder: (listItems) => onReorder(listItems.map((listItem) => _toShoppingItem(listItem)).toList()),
    );
  }
}

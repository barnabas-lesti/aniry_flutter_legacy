import 'package:aniry/app/models/list_item.dart';
import 'package:aniry/app/widgets/list.dart';
import 'package:aniry/app/i10n.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  final List<IngredientItem> items;
  final void Function(String) onTap;

  const IngredientList({
    required this.items,
    required this.onTap,
    super.key,
  });

  List<AppListItem> _toListItems(List<IngredientItem> items) => items.map((item) => item.toListItem()).toList();

  @override
  Widget build(context) {
    return AppList(
      items: _toListItems(items),
      onTap: onTap,
      noItemsText: AppI10N.of(context).ingredientListNoItems,
    );
  }
}

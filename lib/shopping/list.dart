import 'package:aniry/app/list.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return AppList(
      items: shoppingProvider.items,
      onDelete: (item) => shoppingProvider.deleteItem(item),
      onCheck: (item, checked) => shoppingProvider.checkItem(item, checked),
      onReorder: (items) => shoppingProvider.items = items,
    );
  }
}

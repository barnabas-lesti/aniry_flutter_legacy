import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/header.dart';
import 'package:aniry/shopping/widgets/list.dart';
import 'package:aniry/shopping/widgets/input.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:aniry/shopping/service.dart';
import 'package:flutter/material.dart';

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  final String title = 'Shopping List';

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  late ShoppingServiceResult<ShoppingItemModel> _items;

  _ShoppingHomeScreenState() {
    _items = shoppingService.getAllItems();
  }

  void _addItem(String text) => setState(() => shoppingService.addItem(text, _items.toList().length));

  void _checkItem(ShoppingItemModel item, bool checked) => setState(() => shoppingService.checkItem(item, checked));

  void _deleteItem(ShoppingItemModel item) => setState(() => shoppingService.deleteItem(item));

  void _deleteItems() => setState(() => shoppingService.deleteAllItems());

  void _reorderItems(List<ShoppingItemModel> items) => setState(() => shoppingService.reorderItems(_items, items));

  List<ShoppingItemModel> _sortByOrder(List<ShoppingItemModel> items) => shoppingService.sortItemsByOrder(items);

  void _onDeletePress() => showAppConfirmationDialogWidget(
        context: context,
        text: 'Are you sure you want to clear your list?',
        onConfirm: _deleteItems,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppHeaderWidget(
        title: 'Shopping List',
        actions: [
          AppHeaderWidgetAction(
            icon: Icons.delete,
            tooltip: 'Clear list',
            onPressed: _items.isNotEmpty ? _onDeletePress : null,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShoppingInputWidget(onSubmit: _addItem),
            ),
            ShoppingListWidget(
              items: _sortByOrder(_items.toList()),
              onCheck: _checkItem,
              onDelete: _deleteItem,
              onReorder: _reorderItems,
            ),
          ],
        ),
      ),
    );
  }
}

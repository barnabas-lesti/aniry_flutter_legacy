import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/screen.dart';
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

  void _deleteCheckedItems() =>
      setState(() => shoppingService.deleteItems(_items.where((item) => item.checked).toList()));

  void _deleteAllItems() => setState(() => shoppingService.deleteItems(_items.toList()));

  void _reorderItems(List<ShoppingItemModel> items) => setState(() => shoppingService.reorderItems(_items, items));

  List<ShoppingItemModel> _sortByOrder(List<ShoppingItemModel> items) => shoppingService.sortItemsByOrder(items);

  bool _hasCheckedItems() => _items.where((item) => item.checked).isNotEmpty;

  void _onDeletePress() => showAppConfirmationDialogWidget(
        context: context,
        text: _hasCheckedItems() ? 'Delete only the Checked items or All items?' : 'Delete All items?',
        actions: [
          if (_hasCheckedItems())
            AppConfirmationDialogAction(
              label: 'Checked',
              color: Colors.red[500],
              onPressed: _deleteCheckedItems,
            ),
          AppConfirmationDialogAction(
            label: 'All',
            color: Colors.red[500],
            onPressed: _deleteAllItems,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AppScreenWidget(
      title: 'Shopping List',
      actions: [
        AppScreenAction(
          icon: Icons.delete,
          tooltip: 'Clear list',
          onPressed: _items.isNotEmpty ? _onDeletePress : null,
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: AppScreenWidget.gutter),
          child: ShoppingInputWidget(onSubmit: _addItem),
        ),
        ShoppingListWidget(
          items: _sortByOrder(_items.toList()),
          onCheck: _checkItem,
          onDelete: _deleteItem,
          onReorder: _reorderItems,
        ),
      ],
    );
  }
}

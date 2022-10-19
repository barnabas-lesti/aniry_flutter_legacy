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

  void _onDeletePress() {
    final List<ShoppingItemModel> checkedItems = _items.where((item) => item.checked).toList();
    showAppConfirmationDialogWidget(
      context: context,
      text: checkedItems.isNotEmpty ? 'Delete only the Checked items or All items?' : 'Delete All items?',
      actions: [
        if (checkedItems.isNotEmpty)
          AppConfirmationDialogAction(
            label: 'Checked',
            color: Colors.red[500],
            onPressed: () => setState(() => shoppingService.deleteItems(checkedItems)),
          ),
        AppConfirmationDialogAction(
          label: 'All',
          color: Colors.red[500],
          onPressed: () => setState(() => shoppingService.deleteItems(_items.toList())),
        ),
      ],
    );
  }

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
          child: ShoppingInputWidget(
            onSubmit: (text) => setState(() => shoppingService.addItem(text, _items.toList().length)),
          ),
        ),
        ShoppingListWidget(
          items: shoppingService.sortItemsByOrder(_items.toList()),
          onCheck: (item, checked) => setState(() => shoppingService.checkItem(item, checked)),
          onDelete: (item) => setState(() => shoppingService.deleteItem(item)),
          onReorder: (items) => setState(() => shoppingService.reorderItems(_items, items)),
        ),
      ],
    );
  }
}

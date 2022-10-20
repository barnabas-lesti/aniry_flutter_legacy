import 'package:aniry/common/confirmation_dialog.dart';
import 'package:aniry/common/page.dart';
import 'package:aniry/shopping/list.dart';
import 'package:aniry/shopping/input.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHomePage extends StatelessWidget {
  const ShoppingHomePage({super.key});

  void Function() _buildOnDeletePress(BuildContext context, ShoppingProvider shoppingProvider) => () {
        showCommonConfirmationDialog(
          context: context,
          text: shoppingProvider.checkedItems.isNotEmpty
              ? 'Delete only the Checked items or All items?'
              : 'Delete All items?',
          actions: [
            if (shoppingProvider.checkedItems.isNotEmpty)
              CommonConfirmationDialogAction(
                label: 'Checked',
                color: Colors.red[500],
                onPressed: () => shoppingProvider.deleteCheckedItems(),
              ),
            CommonConfirmationDialogAction(
              label: 'All',
              color: Colors.red[500],
              onPressed: () => shoppingProvider.deleteAllItems(),
            ),
          ],
        );
      };

  @override
  Widget build(context) {
    return CommonPage(
      title: 'Shopping List',
      actions: [
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => CommonPageAction(
            icon: Icons.delete,
            tooltip: 'Clear list',
            onPressed: shoppingProvider.items.isNotEmpty ? _buildOnDeletePress(context, shoppingProvider) : null,
          ),
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: CommonPage.gutter),
          child: ShoppingInput(),
        ),
        const ShoppingList(),
      ],
    );
  }
}

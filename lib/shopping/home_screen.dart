import 'package:aniry/app/confirmation_dialog.dart';
import 'package:aniry/app/screen.dart';
import 'package:aniry/shopping/list.dart';
import 'package:aniry/shopping/input.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHomeScreen extends StatelessWidget {
  const ShoppingHomeScreen({super.key});

  final String title = 'Shopping List';

  void Function() _buildOnDeletePress(BuildContext context, ShoppingProvider shoppingProvider) => () {
        showAppConfirmationDialog(
          context: context,
          text: shoppingProvider.checkedItems.isNotEmpty
              ? 'Delete only the Checked items or All items?'
              : 'Delete All items?',
          actions: [
            if (shoppingProvider.checkedItems.isNotEmpty)
              AppConfirmationDialogAction(
                label: 'Checked',
                color: Colors.red[500],
                onPressed: () => shoppingProvider.deleteCheckedItems(),
              ),
            AppConfirmationDialogAction(
              label: 'All',
              color: Colors.red[500],
              onPressed: () => shoppingProvider.deleteAllItems(),
            ),
          ],
        );
      };

  @override
  Widget build(context) {
    return AppScreen(
      title: title,
      actions: [
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => buildAppScreenAction(
            Icons.delete,
            'Clear list',
            onPressed: shoppingProvider.items.isNotEmpty ? _buildOnDeletePress(context, shoppingProvider) : null,
          ),
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: AppScreen.gutter),
          child: ShoppingInput(),
        ),
        const ShoppingList(),
      ],
    );
  }
}

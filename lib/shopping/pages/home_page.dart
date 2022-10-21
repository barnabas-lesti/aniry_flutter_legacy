import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/page.dart';
import 'package:aniry/app/i10n.dart';
import 'package:aniry/shopping/widgets/input.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:aniry/shopping/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHomePage extends StatefulWidget {
  const ShoppingHomePage({super.key});

  @override
  State<ShoppingHomePage> createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
  final FocusNode inputFocusNode = FocusNode();

  void Function() _buildOnDeletePress(BuildContext context, ShoppingProvider shoppingProvider) => () {
        showAppConfirmationDialog(
          context: context,
          text: shoppingProvider.checkedItems.isNotEmpty
              ? appI10N(context)!.shoppingHomePageDeleteCheckedText
              : appI10N(context)!.shoppingHomePageDeleteAllText,
          actions: [
            if (shoppingProvider.checkedItems.isNotEmpty)
              AppConfirmationDialogAction(
                label: appI10N(context)!.shoppingHomePageDeleteCheckedButton,
                color: Colors.red[500],
                onPressed: () => shoppingProvider.deleteCheckedItems(),
              ),
            AppConfirmationDialogAction(
              label: appI10N(context)!.shoppingHomePageDeleteAllButton,
              color: Colors.red[500],
              onPressed: () => shoppingProvider.deleteAllItems(),
            ),
          ],
        );
      };

  void Function(String) _buildOnCreate(BuildContext context) => (String text) {
        Provider.of<ShoppingProvider>(context, listen: false).addItem(text);
      };

  void Function(String) _buildOnTap(ShoppingProvider shoppingProvider) =>
      (id) => inputFocusNode.hasFocus ? inputFocusNode.unfocus() : shoppingProvider.checkItem(id);

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: appI10N(context)!.shoppingHomePageTitle,
      actions: [
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => AppPageAction(
            icon: Icons.delete,
            tooltip: appI10N(context)!.shoppingHomePageDeleteTooltip,
            onPressed: shoppingProvider.items.isNotEmpty ? _buildOnDeletePress(context, shoppingProvider) : null,
          ),
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: AppPageScaffold.gutter),
          child: ShoppingInput(
            focusNode: inputFocusNode,
            onCreate: _buildOnCreate(context),
            onTap: inputFocusNode.hasFocus ? () => inputFocusNode.unfocus() : null,
          ),
        ),
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => ShoppingList(
            items: shoppingProvider.items,
            onDelete: shoppingProvider.deleteItem,
            onTap: _buildOnTap(shoppingProvider),
            onReorder: shoppingProvider.reorderItems,
            checkedItems: shoppingProvider.checkedItems,
          ),
        ),
      ],
    );
  }
}

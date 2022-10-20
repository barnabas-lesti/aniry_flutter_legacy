import 'package:aniry/common/confirmation_dialog.dart';
import 'package:aniry/common/list.dart';
import 'package:aniry/common/page.dart';
import 'package:aniry/i10n.dart';
import 'package:aniry/shopping/input.dart';
import 'package:aniry/shopping/item.dart';
import 'package:aniry/shopping/provider.dart';
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
        showCommonConfirmationDialog(
          context: context,
          text: shoppingProvider.checkedItems.isNotEmpty
              ? appI10N(context)!.shoppingHomePageDeleteCheckedText
              : appI10N(context)!.shoppingHomePageDeleteAllText,
          actions: [
            if (shoppingProvider.checkedItems.isNotEmpty)
              CommonConfirmationDialogAction(
                label: appI10N(context)!.shoppingHomePageDeleteCheckedButton,
                color: Colors.red[500],
                onPressed: () => shoppingProvider.deleteCheckedItems(),
              ),
            CommonConfirmationDialogAction(
              label: appI10N(context)!.shoppingHomePageDeleteAllButton,
              color: Colors.red[500],
              onPressed: () => shoppingProvider.deleteAllItems(),
            ),
          ],
        );
      };

  void Function(String) _buildOnCreate(BuildContext context) =>
      (String text) => Provider.of<ShoppingProvider>(context, listen: false).addItem(text);

  void Function(ShoppingItem, bool) _buildOnItemCheck(ShoppingProvider shoppingProvider) =>
      (item, checked) => inputFocusNode.hasFocus ? inputFocusNode.unfocus() : shoppingProvider.checkItem(item, checked);

  void _onInputTap() {
    if (inputFocusNode.hasFocus) {
      inputFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return CommonPage(
      title: appI10N(context)!.shoppingHomePageTitle,
      actions: [
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => CommonPageAction(
            icon: Icons.delete,
            tooltip: appI10N(context)!.shoppingHomePageDeleteTooltip,
            onPressed: shoppingProvider.items.isNotEmpty ? _buildOnDeletePress(context, shoppingProvider) : null,
          ),
        ),
      ],
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: CommonPage.gutter),
          child: ShoppingInput(
            focusNode: inputFocusNode,
            onCreate: _buildOnCreate(context),
            onTap: _onInputTap,
          ),
        ),
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => CommonList(
              items: shoppingProvider.items,
              onDelete: (item) => shoppingProvider.deleteItem(item),
              onCheck: _buildOnItemCheck(shoppingProvider),
              onReorder: (items) => shoppingProvider.items = items,
              noItemsText: appI10N(context)!.shoppingHomePageNoItems),
        ),
      ],
    );
  }
}

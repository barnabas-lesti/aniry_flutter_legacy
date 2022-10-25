import 'package:aniry/app/widgets/header_action.dart';
import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/app/i10n.dart';
import 'package:aniry/shopping/widgets/input.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:aniry/shopping/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHome extends StatefulWidget {
  final String title;

  const ShoppingHome({
    required this.title,
    super.key,
  });

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  final FocusNode inputFocusNode = FocusNode();

  void Function() _buildOnDelete(BuildContext context, ShoppingProvider shoppingProvider) => () {
        showAppConfirmationDialog(
          context: context,
          text: shoppingProvider.checkedItems.isNotEmpty
              ? AppI10N.of(context).shoppingHomeDeleteCheckedText
              : AppI10N.of(context).shoppingHomeDeleteAllText,
          actions: [
            if (shoppingProvider.checkedItems.isNotEmpty)
              AppConfirmationDialogAction(
                label: AppI10N.of(context).shoppingHomeDeleteCheckedButton,
                color: Colors.red[500],
                onPressed: () => shoppingProvider.deleteCheckedItems(),
              ),
            AppConfirmationDialogAction(
              label: AppI10N.of(context).shoppingHomeDeleteAllButton,
              color: Colors.red[500],
              onPressed: () => shoppingProvider.deleteAllItems(),
            ),
          ],
        );
      };

  void Function(String) _buildOnCreate(BuildContext context) => (String text) {
        Provider.of<ShoppingProvider>(context, listen: false).addItem(text);
      };

  void Function(String) _buildOnTap(ShoppingProvider shoppingProvider) => (id) {
        inputFocusNode.hasFocus ? inputFocusNode.unfocus() : shoppingProvider.checkItem(id);
      };

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: widget.title,
      actions: [
        Consumer<ShoppingProvider>(
          builder: (context, shoppingProvider, widget) => AppHeaderAction(
            icon: Icons.delete,
            tooltip: AppI10N.of(context).shoppingHomeDeleteTooltip,
            onPressed: shoppingProvider.items.isNotEmpty ? _buildOnDelete(context, shoppingProvider) : null,
          ),
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppPageScaffold.gap),
            child: ShoppingInput(
              focusNode: inputFocusNode,
              onCreate: _buildOnCreate(context),
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
      ),
    );
  }
}

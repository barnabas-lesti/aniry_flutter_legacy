import 'package:aniry/app/widgets/app_gap.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/shopping/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHomePage extends StatelessWidget {
  final String title;

  const ShoppingHomePage({
    required this.title,
    super.key,
  });

  void Function()? _buildOnDeletePress(BuildContext context) {
    final provider = ShoppingProvider.of(context);

    if (provider.items.isEmpty) {
      return null;
    }

    return () {
      showAppConfirmationDialog(
        context: context,
        text: provider.checkedItems.isNotEmpty
            ? AppI10N.of(context).shoppingHomeDeleteCheckedText
            : AppI10N.of(context).shoppingHomeDeleteAllText,
        actions: [
          if (provider.checkedItems.isNotEmpty)
            AppConfirmationDialogAction(
              label: AppI10N.of(context).shoppingHomeDeleteCheckedButton,
              color: Colors.red[500],
              onPressed: provider.deleteCheckedItems,
            ),
          AppConfirmationDialogAction(
            label: AppI10N.of(context).shoppingHomeDeleteAllButton,
            color: Colors.red[500],
            onPressed: provider.deleteAllItems,
          ),
        ],
      );
    };
  }

  @override
  Widget build(context) {
    final appI10N = AppI10N.of(context);
    return AppPageScaffold(
      title: title,
      actions: [
        Consumer<ShoppingProvider>(builder: (context, p, w) {
          return AppHeaderAction(
            icon: Icons.delete,
            tooltip: appI10N.shoppingHomeDeleteTooltip,
            onPressed: _buildOnDeletePress(context),
          );
        }),
      ],
      child: Column(
        children: [
          const _ShoppingHomePageInput(),
          const AppGap(vertical: 16),
          Consumer<ShoppingProvider>(builder: (context, provider, w) {
            return AppList(
              items: provider.items.map((item) => item.toListItem()).toList(),
              selectedItems: provider.checkedItems.map((item) => item.toListItem()).toList(),
              noItemsText: appI10N.shoppingListNoItems,
              selectedDecoration: AppListSelectedDecoration.strikethrough,
              dense: true,
              showCheckbox: true,
              expanded: true,
              onDelete: (item) => provider.deleteItem(item.id),
              onTap: (item) => provider.checkItem(item.id),
              onReorder: (items) => provider.reorderItems(items.map((item) => item.id).toList()),
            );
          }),
        ],
      ),
    );
  }
}

class _ShoppingHomePageInput extends StatefulWidget {
  const _ShoppingHomePageInput();

  @override
  State<_ShoppingHomePageInput> createState() => _ShoppingHomePageInputState();
}

class _ShoppingHomePageInputState extends State<_ShoppingHomePageInput> {
  final _controller = TextEditingController();

  void Function() _buildOnCreate(BuildContext context) {
    return () {
      if (_controller.text.isNotEmpty) {
        ShoppingProvider.of(context).createItem(_controller.text);
        _controller.clear();
      }
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return TextFormField(
      controller: _controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: AppI10N.of(context).shoppingInputLabel,
        suffix: IconButton(
          icon: const Icon(Icons.done),
          onPressed: _buildOnCreate(context),
        ),
      ),
    );
  }
}

import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/shopping/shopping_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingHomePage extends StatefulWidget {
  final String title;

  const ShoppingHomePage({
    required this.title,
    super.key,
  });

  @override
  State<ShoppingHomePage> createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
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
            child: _ShoppingHomePageInput(
              focusNode: inputFocusNode,
              onCreate: _buildOnCreate(context),
            ),
          ),
          Consumer<ShoppingProvider>(
            builder: (context, shoppingProvider, widget) => _ShoppingHomePageList(
              items: shoppingProvider.items.map((item) => item.toListItem()).toList(),
              selectedItems: shoppingProvider.checkedItems.map((item) => item.toListItem()).toList(),
              onDelete: (item) => shoppingProvider.deleteItem(item.id),
              onTap: (item) => _buildOnTap(shoppingProvider)(item.id),
              onReorder: (items) => shoppingProvider.reorderItems(items.map((item) => item.id).toList()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingHomePageList extends StatelessWidget {
  final List<AppListItem> items;
  final List<AppListItem> selectedItems;
  final void Function(List<AppListItem>) onReorder;
  final void Function(AppListItem) onDelete;
  final void Function(AppListItem) onTap;

  const _ShoppingHomePageList({
    required this.items,
    required this.selectedItems,
    required this.onReorder,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(context) {
    return AppList(
      items: items,
      selectedItems: selectedItems,
      noItemsText: AppI10N.of(context).shoppingListNoItems,
      dense: true,
      showCheckbox: true,
      selectedDecoration: AppListSelectedDecoration.strikethrough,
      expanded: true,
      onDelete: onDelete,
      onTap: onTap,
      onReorder: onReorder,
    );
  }
}

class _ShoppingHomePageInput extends StatefulWidget {
  final void Function(String) onCreate;
  final FocusNode? focusNode;

  const _ShoppingHomePageInput({
    required this.onCreate,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  State<_ShoppingHomePageInput> createState() => _ShoppingHomePageInputState();
}

class _ShoppingHomePageInputState extends State<_ShoppingHomePageInput> {
  final _controller = TextEditingController();

  void _onCreate() {
    if (_controller.text.isNotEmpty) {
      widget.onCreate(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onEditingComplete: _onCreate,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      controller: _controller,
      decoration: InputDecoration(
        labelText: AppI10N.of(context).shoppingInputLabel,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

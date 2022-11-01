import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/widgets/app_button_group.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_search_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAppItemSelectorDialog({
  required BuildContext context,
  required List<AppListItem> items,
  required List<AppListItem> selectedItems,
  required void Function(List<AppListItem>) onSave,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider<_AppItemSelectorDialogProvider>(
        create: (c) => _AppItemSelectorDialogProvider(
          items: items,
          selectedItems: selectedItems,
        ),
        child: _AppItemSelectorDialog(
          onSave: onSave,
        ),
      );
    },
  );
}

class _AppItemSelectorDialog extends StatelessWidget {
  final void Function(List<AppListItem>) onSave;

  const _AppItemSelectorDialog({
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);
    final provider = Provider.of<_AppItemSelectorDialogProvider>(context, listen: false);
    return SimpleDialog(
      title: Text(appI10N.appItemSelectorDialogTitle),
      titlePadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      children: [
        Column(
          children: [
            AppSearchInput(
              label: appI10N.appItemSelectorDialogSearchLabel,
              initialValue: provider.searchString,
              onSearch: (searchString) => provider.searchString = searchString,
              paddingBottom: 16,
            ),
            Consumer<_AppItemSelectorDialogProvider>(builder: (c, p, w) {
              return AppList(
                items: provider.filteredItems,
                noItemsText: appI10N.appItemSelectorDialogNoItems,
                selectedItems: provider.selectedItems,
                showIcon: true,
                showCheckbox: true,
                numberOfVisibleItems: 5,
                paddingBottom: 16,
                onTap: (item) => provider.toggleItem(item),
              );
            }),
          ],
        ),
        AppButtonGroup(actions: [
          AppButtonGroupAction(
            label: appI10N.appItemSelectorDialogCancel,
            onPressed: () => Navigator.pop(context),
          ),
          AppButtonGroupAction(
            label: appI10N.appItemSelectorDialogSave,
            onPressed: () {
              onSave(provider.selectedItems);
              Navigator.pop(context);
            },
          ),
        ]),
      ],
    );
  }
}

class _AppItemSelectorDialogProvider extends ChangeNotifier {
  late List<AppListItem> _items;
  late List<AppListItem> _selectedItems;
  late String _searchString;

  _AppItemSelectorDialogProvider({
    required List<AppListItem> items,
    required List<AppListItem> selectedItems,
  }) {
    this.items = items;
    this.selectedItems = selectedItems;
    searchString = '';
  }

  set selectedItems(List<AppListItem> selectedItems) {
    _selectedItems = selectedItems;
    notifyListeners();
  }

  List<AppListItem> get selectedItems => _selectedItems;

  set items(List<AppListItem> items) {
    _items = items;
    notifyListeners();
  }

  List<AppListItem> get items => _items;
  List<AppListItem> get filteredItems =>
      items.where((item) => AppUtils.isStringInString(item.textLeftPrimary, searchString)).toList();

  set searchString(String string) {
    _searchString = string;
    notifyListeners();
  }

  String get searchString => _searchString;

  void toggleItem(AppListItem item) {
    if (selectedItems.where((selectedItem) => selectedItem.id == item.id).isEmpty) {
      selectedItems.add(item);
    } else {
      selectedItems.removeWhere((selectedItem) => selectedItem.id == item.id);
    }
    notifyListeners();
  }
}

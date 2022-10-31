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
  required Iterable<String> selectedIDs,
  required Iterable<AppListItem> listItems,
  required void Function(Iterable<String>) onSave,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider<_AppItemSelectorDialogProvider>(
        create: (c) => _AppItemSelectorDialogProvider(
          selectedIDs: selectedIDs,
          listItems: listItems,
        ),
        child: _AppItemSelectorDialog(
          onSave: onSave,
        ),
      );
    },
  );
}

class _AppItemSelectorDialog extends StatelessWidget {
  final void Function(Iterable<String>) onSave;

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
                items: provider.filteredListItems.toList(),
                noItemsText: appI10N.appItemSelectorDialogNoItems,
                selectedIDs: provider.selectedIDs.toList(),
                showIcon: true,
                showCheckbox: true,
                numberOfVisibleItems: 5,
                paddingBottom: 16,
                onTap: (id) => provider.toggleID(id),
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
              onSave(provider.selectedIDs);
              Navigator.pop(context);
            },
          ),
        ]),
      ],
    );
  }
}

class _AppItemSelectorDialogProvider extends ChangeNotifier {
  late Iterable<String> _selectedIDs;
  late Iterable<AppListItem> _listItems;
  late String _searchString;

  _AppItemSelectorDialogProvider({
    required Iterable<String> selectedIDs,
    required Iterable<AppListItem> listItems,
  }) {
    this.selectedIDs = selectedIDs;
    this.listItems = listItems;
    searchString = '';
  }

  set selectedIDs(Iterable<String> ids) {
    _selectedIDs = ids;
    notifyListeners();
  }

  Iterable<String> get selectedIDs => _selectedIDs;

  set listItems(Iterable<AppListItem> items) {
    _listItems = items;
    notifyListeners();
  }

  Iterable<AppListItem> get listItems => _listItems;
  Iterable<AppListItem> get filteredListItems =>
      listItems.where((item) => AppUtils.isStringInString(item.textLeftPrimary, searchString));

  set searchString(String string) {
    _searchString = string;
    notifyListeners();
  }

  String get searchString => _searchString;

  void toggleID(String id) {
    if (selectedIDs.contains(id)) {
      selectedIDs = [...selectedIDs.where((selectedId) => selectedId != id)];
    } else {
      selectedIDs = [...selectedIDs, id];
    }
  }
}

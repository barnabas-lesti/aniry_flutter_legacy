import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/models/exported_data.dart';
import 'package:aniry/app/storage.dart';
import 'package:aniry/app/widgets/button.dart';
import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/notification.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/app/widgets/title.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/ingredient/provider.dart';
import 'package:aniry/shopping/models/item.dart';
import 'package:aniry/shopping/provider.dart';
import 'package:flutter/material.dart';

class SettingsHome extends StatelessWidget {
  final String title;

  const SettingsHome({
    required this.title,
    super.key,
  });

  final _space = AppPageScaffold.gap / 2;
  final _spacePadding = const EdgeInsets.only(bottom: AppPageScaffold.gap / 2);

  @override
  Widget build(context) {
    final shoppingProvider = ShoppingProvider.of(context);
    final ingredientProvider = IngredientProvider.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final appI10N = AppI10N.of(context);

    void showImportConfirmationDialog(AppExportedData data) {
      showAppConfirmationDialog(
        context: context,
        text: appI10N.settingsHomeDataImportConfirmationText,
        actions: [
          AppConfirmationDialogAction(
            label: appI10N.settingsHomeDataImportConfirmationButton,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              shoppingProvider.items = data.shoppingItems;
              ingredientProvider.items = data.ingredientItems;
              scaffoldMessenger.showSnackBar(buildAppNotification(appI10N.settingsHomeDataImportSuccess));
            },
          ),
        ],
      );
    }

    Future<void> onImportPress() async {
      final data = await AppStorage.importData();
      if (data != null) {
        showImportConfirmationDialog(data);
      }
    }

    Future<void> onExportPress() async {
      final items = await Future.wait([
        shoppingProvider.lazyLoadItems(),
        ingredientProvider.lazyLoadItems(),
      ]);
      final data = AppExportedData(
        shoppingItems: items[0] as List<ShoppingItem>,
        ingredientItems: items[1] as List<IngredientItem>,
      );
      if (await AppStorage.exportData('export', data)) {
        scaffoldMessenger.showSnackBar(buildAppNotification(appI10N.settingsHomeDataExportSuccess));
      }
    }

    return AppPageScaffold(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _spacePadding,
            child: AppSectionTitle(AppI10N.of(context).settingsHomeDataTitle),
          ),
          Padding(
            padding: _spacePadding,
            child: Text(AppI10N.of(context).settingsHomeDataText),
          ),
          Padding(
            padding: _spacePadding,
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: AppI10N.of(context).settingsHomeDataExportButton,
                    onPressed: onExportPress,
                  ),
                ),
                SizedBox(width: _space),
                Expanded(
                  child: AppButton(
                    label: AppI10N.of(context).settingsHomeDataImportButton,
                    onPressed: onImportPress,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}

import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_exported_data.dart';
import 'package:aniry/app/app_storage.dart';
import 'package:aniry/app/widgets/app_button.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_notification.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/shopping/models/shopping_item.dart';
import 'package:aniry/shopping/shopping_provider.dart';
import 'package:flutter/material.dart';

class SettingsHome extends StatelessWidget {
  final String title;

  const SettingsHome({
    required this.title,
    super.key,
  });

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
              ingredientProvider.ingredients = data.ingredients;
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
      final partitions = await Future.wait([
        shoppingProvider.lazyLoadItems(),
        ingredientProvider.lazyLoadIngredients(),
      ]);
      final data = AppExportedData(
        shoppingItems: partitions[0] as List<ShoppingItem>,
        ingredients: partitions[1] as List<Ingredient>,
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
          AppSectionHeader(
            title: appI10N.settingsHomeDataTitle,
            paddingBottom: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(appI10N.settingsHomeDataText),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: appI10N.settingsHomeDataExportButton,
                    onPressed: onExportPress,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButton(
                    label: appI10N.settingsHomeDataImportButton,
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

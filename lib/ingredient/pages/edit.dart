import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/widgets/header_action.dart';
import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/notification.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/ingredient/provider.dart';
import 'package:aniry/ingredient/widgets/form.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class IngredientEdit extends StatelessWidget {
  final String title;
  final String? id;

  IngredientEdit({
    required this.title,
    this.id,
    super.key,
  });

  final _formController = AppItemFormController<IngredientItem>();

  void _buildOnSave(BuildContext context) {
    final item = _formController.getItem();
    if (item != null) {
      final ingredientProvider = IngredientProvider.of(context);
      if (item.id.isEmpty) {
        ingredientProvider.createItem(item);
        ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditCreated));
        Beamer.of(context).popToNamed('/ingredient');
      } else {
        _buildOnUpdate(context, ingredientProvider)(item);
      }
    }
  }

  void Function() _buildOnDelete(BuildContext context, IngredientProvider ingredientProvider) => () {
        showAppConfirmationDialog(
          context: context,
          text: AppI10N.of(context).ingredientEditDeleteText,
          actions: [
            AppConfirmationDialogAction(
              label: AppI10N.of(context).ingredientEditDeleteButton,
              color: Colors.red[500],
              onPressed: () {
                ingredientProvider.deleteItem(id!);
                ScaffoldMessenger.of(context)
                    .showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditDeleted));
                Beamer.of(context).popToNamed('/ingredient');
              },
            ),
          ],
        );
      };

  void Function(IngredientItem) _buildOnUpdate(BuildContext context, IngredientProvider ingredientProvider) =>
      (IngredientItem item) {
        showAppConfirmationDialog(
          context: context,
          text: AppI10N.of(context).ingredientEditUpdateText,
          actions: [
            AppConfirmationDialogAction(
              label: AppI10N.of(context).ingredientEditUpdateButton,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                ingredientProvider.updateItem(item);
                ScaffoldMessenger.of(context)
                    .showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditUpdated));
                Beamer.of(context).popToNamed('/ingredient');
              },
            ),
          ],
        );
      };

  @override
  Widget build(context) {
    final ingredientProvider = IngredientProvider.of(context);
    final appI10N = AppI10N.of(context);

    return AppPageScaffold(
      title: title,
      actions: [
        AppHeaderAction(
          icon: Icons.done,
          tooltip: appI10N.ingredientEditSaveTooltip,
          onPressed: () => _buildOnSave(context),
        ),
        if (id != null)
          AppHeaderAction(
            icon: Icons.delete,
            tooltip: appI10N.ingredientEditDeleteTooltip,
            onPressed: _buildOnDelete(context, ingredientProvider),
          )
      ],
      child: SingleChildScrollView(
        child: IngredientForm(
          controller: _formController,
          item: (id != null) ? ingredientProvider.getItem(id!) : null,
        ),
      ),
    );
  }
}

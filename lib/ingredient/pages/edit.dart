import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
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
      } else {
        ingredientProvider.updateItem(item);
        ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditUpdated));
      }
      Beamer.of(context).popToNamed('/ingredient');
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

  @override
  Widget build(context) {
    final ingredientProvider = IngredientProvider.of(context);
    return AppPageScaffold(
      title: title,
      actions: [
        AppPageAction(
          icon: Icons.done,
          tooltip: AppI10N.of(context).ingredientEditSaveTooltip,
          onPressed: () => _buildOnSave(context),
        ),
        if (id != null)
          AppPageAction(
            icon: Icons.delete,
            tooltip: AppI10N.of(context).ingredientEditDeleteTooltip,
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

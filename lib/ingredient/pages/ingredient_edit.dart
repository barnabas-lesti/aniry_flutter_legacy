import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_notification.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/widgets/Ingredient_form.dart';
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

  final _formController = AppDataController<Ingredient?>();

  void _buildOnSave(BuildContext context) {
    final ingredient = _formController.getData();
    if (ingredient != null) {
      final ingredientProvider = IngredientProvider.of(context);
      if (ingredient.id.isEmpty) {
        ingredientProvider.createIngredient(ingredient);
        ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditCreated));
        Beamer.of(context).popToNamed('/ingredient');
      } else {
        _buildOnUpdate(context, ingredientProvider)(ingredient);
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
                ingredientProvider.deleteIngredient(context, id!);
                ScaffoldMessenger.of(context)
                    .showSnackBar(buildAppNotification(AppI10N.of(context).ingredientEditDeleted));
                Beamer.of(context).popToNamed('/ingredient');
              },
            ),
          ],
        );
      };

  void Function(Ingredient) _buildOnUpdate(BuildContext context, IngredientProvider ingredientProvider) =>
      (Ingredient ingredient) {
        showAppConfirmationDialog(
          context: context,
          text: AppI10N.of(context).ingredientEditUpdateText,
          actions: [
            AppConfirmationDialogAction(
              label: AppI10N.of(context).ingredientEditUpdateButton,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                ingredientProvider.updateIngredient(context, ingredient);
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
          ingredient: (id != null) ? ingredientProvider.getIngredient(id!) : null,
        ),
      ),
    );
  }
}

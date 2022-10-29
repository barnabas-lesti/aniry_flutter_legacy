import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_item_form_controller.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_notification.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:aniry/recipe/widgets/recipe_form.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class RecipeEdit extends StatelessWidget {
  final String title;
  final String? id;

  RecipeEdit({
    required this.title,
    this.id,
    super.key,
  });

  final _formController = AppItemFormController<Recipe>();

  @override
  Widget build(context) {
    final recipeProvider = RecipeProvider.of(context);
    final appI10N = AppI10N.of(context);
    final beamer = Beamer.of(context);

    void onUpdate(Recipe recipe) {
      showAppConfirmationDialog(
        context: context,
        text: appI10N.recipeEditUpdateText,
        actions: [
          AppConfirmationDialogAction(
            label: appI10N.recipeEditUpdateButton,
            onPressed: () {
              recipeProvider.updateRecipe(recipe);
              ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(appI10N.recipeEditUpdated));
              beamer.popToNamed('/recipe');
            },
          ),
        ],
      );
    }

    void onSave() {
      final recipe = _formController.getItem();
      if (recipe != null) {
        if (recipe.id.isEmpty) {
          recipeProvider.createRecipe(recipe);
          ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(appI10N.recipeEditCreated));
          beamer.popToNamed('/recipe');
        } else {
          onUpdate(recipe);
        }
      }
    }

    void onDelete() {
      showAppConfirmationDialog(
        context: context,
        text: appI10N.recipeEditDeleteText,
        actions: [
          AppConfirmationDialogAction(
            label: appI10N.recipeEditDeleteButton,
            color: Colors.red[500],
            onPressed: () {
              recipeProvider.deleteRecipe(id!);
              ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(appI10N.recipeEditDeleted));
              beamer.popToNamed('/recipe');
            },
          ),
        ],
      );
    }

    return AppPageScaffold(
      title: title,
      actions: [
        AppHeaderAction(
          icon: Icons.done,
          tooltip: appI10N.recipeEditSaveTooltip,
          onPressed: onSave,
        ),
        if (id != null)
          AppHeaderAction(
            icon: Icons.delete,
            tooltip: appI10N.recipeEditDeleteTooltip,
            onPressed: onDelete,
          )
      ],
      child: SingleChildScrollView(
        child: RecipeForm(
          controller: _formController,
          recipe: (id != null) ? recipeProvider.getRecipe(id!) : null,
        ),
      ),
    );
  }
}

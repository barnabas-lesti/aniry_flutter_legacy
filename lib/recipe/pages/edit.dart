import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/widgets/confirmation_dialog.dart';
import 'package:aniry/app/widgets/notification.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/recipe/models/item.dart';
import 'package:aniry/recipe/provider.dart';
import 'package:aniry/recipe/widgets/form.dart';
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

  final _formController = AppItemFormController<RecipeItem>();

  @override
  Widget build(context) {
    final recipeProvider = RecipeProvider.of(context);
    final appI10N = AppI10N.of(context);
    final beamer = Beamer.of(context);

    void onUpdate(RecipeItem item) {
      showAppConfirmationDialog(
        context: context,
        text: appI10N.recipeEditUpdateText,
        actions: [
          AppConfirmationDialogAction(
            label: appI10N.recipeEditUpdateButton,
            onPressed: () {
              recipeProvider.updateItem(item);
              ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(appI10N.recipeEditUpdated));
              beamer.popToNamed('/recipe');
            },
          ),
        ],
      );
    }

    void onSave() {
      final item = _formController.getItem();
      if (item != null) {
        if (item.id.isEmpty) {
          recipeProvider.createItem(item);
          ScaffoldMessenger.of(context).showSnackBar(buildAppNotification(appI10N.recipeEditCreated));
          beamer.popToNamed('/recipe');
        } else {
          onUpdate(item);
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
              recipeProvider.deleteItem(id!);
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
        AppPageAction(
          icon: Icons.done,
          tooltip: appI10N.recipeEditSaveTooltip,
          onPressed: onSave,
        ),
        if (id != null)
          AppPageAction(
            icon: Icons.delete,
            tooltip: appI10N.recipeEditDeleteTooltip,
            onPressed: onDelete,
          )
      ],
      child: SingleChildScrollView(
        child: RecipeForm(
          controller: _formController,
          item: (id != null) ? recipeProvider.getItem(id!) : null,
        ),
      ),
    );
  }
}

import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/widgets/page.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:aniry/ingredient/provider.dart';
import 'package:aniry/ingredient/widgets/form.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientEditPage extends StatelessWidget {
  final String title;
  final String? id;

  IngredientEditPage({
    required this.title,
    this.id,
    super.key,
  });

  final controller = AppItemFormController<IngredientItem>();

  void _buildOnSave(BuildContext context) {
    final ingredient = controller.getItem();
    if (ingredient != null) {
      Provider.of<IngredientProvider>(context, listen: false).create(ingredient);
      Beamer.of(context).popToNamed('/ingredient');
    }
  }

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: title,
      actions: [
        AppPageAction(
          icon: Icons.done,
          tooltip: appI10N(context).ingredientEditPageSaveTooltip,
          onPressed: () => _buildOnSave(context),
        ),
      ],
      children: [
        IngredientForm(controller: controller),
      ],
    );
  }
}

import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:aniry/app/widgets/app_notification.dart';
import 'package:aniry/app/widgets/app_nutrients_chart.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/app/widgets/app_serving_input.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class IngredientEditPage extends StatelessWidget {
  final String title;
  final String? id;

  IngredientEditPage({
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
        child: _IngredientEditPageForm(
          controller: _formController,
          ingredient: (id != null) ? ingredientProvider.getIngredient(id!) : null,
        ),
      ),
    );
  }
}

class _IngredientEditPageForm extends StatefulWidget {
  final AppDataController<Ingredient?> controller;
  final Ingredient? ingredient;

  const _IngredientEditPageForm({
    required this.controller,
    this.ingredient,
    Key? key,
  }) : super(key: key);

  @override
  State<_IngredientEditPageForm> createState() => _IngredientEditPageFormState();
}

class _IngredientEditPageFormState extends State<_IngredientEditPageForm> {
  final _formKey = GlobalKey<FormState>();
  late Ingredient _ingredient;

  @override
  void initState() {
    super.initState();
    _ingredient = widget.ingredient ?? Ingredient();
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    widget.controller.onGetData(() {
      if (!_formKey.currentState!.validate()) return null;
      _formKey.currentState!.save();
      return _ingredient;
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSectionHeader(
            title: appI10N.ingredientFormPrimaryDetails,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: _ingredient.name,
            label: appI10N.ingredientFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N.ingredientFormNameInvalid : null,
            onSaved: (value) => _ingredient.name = value,
            paddingBottom: 16,
          ),
          AppServingInput(
            initialValue: _ingredient.serving,
            label: appI10N.ingredientFormServing,
            validator: (serving) => serving.value > 0 ? null : appI10N.ingredientFormServingInvalid,
            onSaved: (value) => _ingredient.servings = [value],
            units: Ingredient.primaryServingUnits,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_ingredient.calories, exact: true),
            label: appI10N.ingredientFormCalories,
            onSaved: (value) => _ingredient.calories = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppSectionHeader(
            title: appI10N.ingredientFormNutrients,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_ingredient.nutrients.carbs, exact: true),
            label: appI10N.ingredientFormCarbs,
            onSaved: (value) => _ingredient.nutrients.carbs = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_ingredient.nutrients.protein, exact: true),
            label: appI10N.ingredientFormProtein,
            onSaved: (value) => _ingredient.nutrients.protein = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_ingredient.nutrients.fat, exact: true),
            label: appI10N.ingredientFormFat,
            onSaved: (value) => _ingredient.nutrients.fat = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppNutrientsChart(nutrients: _ingredient.nutrients),
        ],
      ),
    );
  }
}

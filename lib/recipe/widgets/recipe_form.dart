import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_item_form_controller.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:aniry/app/widgets/app_serving_input.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeForm extends StatefulWidget {
  final AppItemFormController controller;
  final Recipe? recipe;

  const RecipeForm({
    required this.controller,
    this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe ?? Recipe();
  }

  void _openIngredientSelector() {}

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    widget.controller.onGetItem(() {
      if (!_formKey.currentState!.validate()) return null;
      _formKey.currentState!.save();
      return _recipe;
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSectionHeader(
            title: appI10N.recipeFormPrimaryDetails,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: _recipe.name,
            label: appI10N.recipeFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N.recipeFormNameInvalid : null,
            onSaved: (value) => _recipe.name = value,
            paddingBottom: 16,
          ),
          AppServingInput(
            initialValue: _recipe.serving,
            label: appI10N.recipeFormServing,
            validator: (serving) => serving.value > 0 ? null : appI10N.recipeFormServingInvalid,
            onSaved: (value) => _recipe.servings = [value],
            units: Recipe.primaryServingUnits,
            paddingBottom: 16,
          ),
          AppSectionHeader(
            title: appI10N.recipeFormIngredients,
            paddingBottom: 8,
            actions: [
              AppHeaderAction(
                icon: Icons.add,
                tooltip: appI10N.recipeFormIngredientsAddTooltip,
                onPressed: _openIngredientSelector,
              )
            ],
          )
        ],
      ),
    );
  }
}

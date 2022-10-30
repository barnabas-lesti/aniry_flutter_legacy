import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_serving_input.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/models/ingredient_served.dart';
import 'package:aniry/ingredient/widgets/ingredient_selector_dialog.dart';
import 'package:aniry/ingredient/widgets/ingredient_serving_editor_dialog.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RecipeForm extends StatefulWidget {
  final AppDataController<Recipe?> controller;
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

  void Function() _buildOnEditIngredientsPress(BuildContext context) {
    return () {
      showIngredientSelectorDialog(
        context: context,
        initialSelectedIDs: _recipe.ingredientsServed.map((ingredientServed) => ingredientServed.id).toList(),
        onSave: (ids) {
          setState(() {
            _recipe.ingredientsServed = ids.map((id) {
              final ingredient = IngredientProvider.of(context).getIngredient(id);
              final existingIngredientServed = _recipe.ingredientsServed.where((served) => served.id == id).firstOrNull;
              final serving = existingIngredientServed != null ? existingIngredientServed.serving : ingredient.serving;
              return IngredientServed(ingredient: ingredient, serving: serving);
            }).toList();
          });
        },
      );
    };
  }

  void Function(String) _buildOnListTileTap(BuildContext context) {
    return (id) {
      showIngredientServingEditorDialog(
        context: context,
        initialServing: _recipe.ingredientsServed.firstWhere((served) => served.id == id).serving,
        onSave: (serving) {
          setState(() {
            _recipe.ingredientsServed.firstWhere((served) => served.id == id).serving.value = serving.value;
          });
        },
      );
    };
  }

  void _onListReorder(List<String> ids) {
    setState(() {
      _recipe.ingredientsServed =
          ids.map((id) => _recipe.ingredientsServed.where((proxy) => proxy.id == id).first).toList();
    });
  }

  void _onDelete(String id) {
    setState(() {
      _recipe.ingredientsServed = _recipe.ingredientsServed.where((proxy) => proxy.id != id).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe ?? Recipe();
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    widget.controller.onGetData(() {
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
                onPressed: _buildOnEditIngredientsPress(context),
              )
            ],
          ),
          AppList(
            items: _recipe.ingredientsServed.map((servedItem) => servedItem.toListItem()).toList(),
            noItemsText: appI10N.recipeFormIngredientsNoItems,
            showIcon: true,
            showTextRightPrimary: true,
            showTextRightSecondary: true,
            numberOfVisibleItems: 5,
            onTap: _buildOnListTileTap(context),
            onReorder: _onListReorder,
            onDelete: _onDelete,
          ),
        ],
      ),
    );
  }
}

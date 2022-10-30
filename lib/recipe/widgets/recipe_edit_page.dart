import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/app/widgets/app_header_action.dart';
import 'package:aniry/app/widgets/app_confirmation_dialog.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:aniry/app/widgets/app_list.dart';
import 'package:aniry/app/widgets/app_notification.dart';
import 'package:aniry/app/widgets/app_page_scaffold.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/app/widgets/app_serving_input.dart';
import 'package:aniry/ingredient/Ingredient_provider.dart';
import 'package:aniry/ingredient/models/ingredient_proxy.dart';
import 'package:aniry/ingredient/widgets/ingredient_selector_dialog.dart';
import 'package:aniry/ingredient/widgets/ingredient_serving_editor_dialog.dart';
import 'package:aniry/recipe/models/recipe.dart';
import 'package:aniry/recipe/recipe_provider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RecipeEditPage extends StatelessWidget {
  final String title;
  final String? id;

  RecipeEditPage({
    required this.title,
    this.id,
    super.key,
  });

  final _formController = AppDataController<Recipe?>();

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
      final recipe = _formController.getData();
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
        child: _RecipeEditPageForm(
          controller: _formController,
          recipe: (id != null) ? recipeProvider.getRecipe(id!) : null,
        ),
      ),
    );
  }
}

class _RecipeEditPageForm extends StatefulWidget {
  final AppDataController<Recipe?> controller;
  final Recipe? recipe;

  const _RecipeEditPageForm({
    required this.controller,
    this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  State<_RecipeEditPageForm> createState() => _RecipeEditPageFormState();
}

class _RecipeEditPageFormState extends State<_RecipeEditPageForm> {
  final _formKey = GlobalKey<FormState>();
  late Recipe _recipe;

  void Function() _buildOnEditIngredientsPress(BuildContext context) {
    return () {
      showIngredientSelectorDialog(
        context: context,
        initialSelectedIDs: _recipe.ingredientProxies.map((proxy) => proxy.id).toList(),
        onSave: (ids) {
          setState(() {
            _recipe.ingredientProxies = ids.map((id) {
              final ingredient = IngredientProvider.of(context).getIngredient(id);
              final existingProxy = _recipe.ingredientProxies.where((proxy) => proxy.id == id).firstOrNull;
              final serving = existingProxy != null ? existingProxy.serving : ingredient.serving.clone();
              return IngredientProxy(ingredient: ingredient, serving: serving);
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
        initialServing: _recipe.ingredientProxies.firstWhere((proxy) => proxy.id == id).serving,
        onSave: (serving) {
          setState(() {
            _recipe.ingredientProxies.firstWhere((proxy) => proxy.id == id).serving.value = serving.value;
          });
        },
      );
    };
  }

  void _onListReorder(List<String> ids) {
    setState(() {
      _recipe.ingredientProxies =
          ids.map((id) => _recipe.ingredientProxies.where((proxy) => proxy.id == id).first).toList();
    });
  }

  void _onDelete(String id) {
    setState(() {
      _recipe.ingredientProxies = _recipe.ingredientProxies.where((proxy) => proxy.id != id).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe != null ? widget.recipe!.clone() : Recipe();
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
            items: _recipe.ingredientProxies.map((proxy) => proxy.toListItem()).toList(),
            noItemsText: appI10N.recipeFormIngredientsNoItems,
            showIcon: true,
            showTextRightPrimary: true,
            showTextRightSecondary: true,
            numberOfVisibleItems: 5,
            onTap: _buildOnListTileTap(context),
            onReorder: _onListReorder,
            onDelete: _onDelete,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appI10N.recipeFormTotalCalories,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_recipe.calories.toStringAsFixed(0)}${AppUnit.kcal}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

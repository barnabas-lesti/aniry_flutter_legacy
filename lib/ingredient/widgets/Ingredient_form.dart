import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_data_controller.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:aniry/app/widgets/app_serving_input.dart';
import 'package:aniry/app/widgets/app_section_header.dart';
import 'package:aniry/ingredient/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatefulWidget {
  final AppDataController<Ingredient?> controller;
  final Ingredient? ingredient;

  const IngredientForm({
    required this.controller,
    this.ingredient,
    Key? key,
  }) : super(key: key);

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
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
        ],
      ),
    );
  }
}

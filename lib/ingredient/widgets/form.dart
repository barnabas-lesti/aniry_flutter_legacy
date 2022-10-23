import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/app/widgets/input.dart';
import 'package:aniry/app/widgets/serving_input.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatefulWidget {
  final AppItemFormController controller;

  const IngredientForm({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _calories = 0;
  double _carbs = 0;
  double _protein = 0;
  double _fat = 0;
  AppServing _serving = AppServing(
    unit: IngredientItem.defaultServingUnit,
    value: IngredientItem.defaultServingValue,
  );

  @override
  Widget build(BuildContext context) {
    widget.controller.onGetItem(() {
      if (!_formKey.currentState!.validate()) return null;

      _formKey.currentState!.save();
      return IngredientItem(
        id: IngredientItem.createId(),
        name: _name,
        calories: _calories,
        nutrients: AppNutrients(
          carbs: _carbs,
          protein: _protein,
          fat: _fat,
        ),
        servings: [_serving],
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppInput(
            initialValue: _name,
            label: appI10N(context).ingredientFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N(context).ingredientFormNameInvalid : null,
            onSaved: (value) => _name = value,
            paddingBottom: 16,
          ),
          AppServingInput(
            initialValue: _serving,
            label: appI10N(context).ingredientFormServing,
            validator: (value) => _serving.value > 0 ? null : appI10N(context).ingredientFormServingInvalid,
            onSaved: (value) => _serving = value,
            units: IngredientItem.primaryServingUnits,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_calories, exact: true),
            label: appI10N(context).ingredientFormCalories,
            onSaved: (value) => _calories = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_carbs, exact: true),
            label: appI10N(context).ingredientFormCarbs,
            onSaved: (value) => _carbs = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_protein, exact: true),
            label: appI10N(context).ingredientFormProtein,
            onSaved: (value) => _protein = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_fat, exact: true),
            label: appI10N(context).ingredientFormFat,
            onSaved: (value) => _fat = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
        ],
      ),
    );
  }
}

import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/app/widgets/input.dart';
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
  String name = '';
  double calories = 0;
  double carbs = 0;
  double protein = 0;
  double fat = 0;

  @override
  Widget build(BuildContext context) {
    widget.controller.onGetItem(() {
      if (!_formKey.currentState!.validate()) return null;

      _formKey.currentState!.save();
      return IngredientItem(
        id: IngredientItem.createId(),
        name: name,
        calories: calories,
        nutrients: AppNutrients(
          carbs: carbs,
          protein: protein,
          fat: fat,
        ),
        servings: [AppServing()],
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppInput(
            initialValue: name,
            label: appI10N(context).ingredientFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N(context).ingredientFormNameInvalid : null,
            onSaved: (value) => name = value!,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(calories, exact: true),
            label: appI10N(context).ingredientFormCalories,
            onSaved: (value) => calories = double.parse(value!),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(carbs, exact: true),
            label: appI10N(context).ingredientFormCarbs,
            onSaved: (value) => carbs = double.parse(value!),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(protein, exact: true),
            label: appI10N(context).ingredientFormProtein,
            onSaved: (value) => protein = double.parse(value!),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(fat, exact: true),
            label: appI10N(context).ingredientFormFat,
            onSaved: (value) => fat = double.parse(value!),
            number: true,
          ),
        ],
      ),
    );
  }
}

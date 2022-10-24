import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/app/widgets/input.dart';
import 'package:aniry/app/widgets/serving_input.dart';
import 'package:aniry/app/widgets/title.dart';
import 'package:aniry/ingredient/models/item.dart';
import 'package:flutter/material.dart';

class IngredientForm extends StatefulWidget {
  final AppItemFormController controller;
  final IngredientItem? item;

  const IngredientForm({
    required this.controller,
    this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<IngredientForm> createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  final _formKey = GlobalKey<FormState>();
  late IngredientItem _item;
  final _paddingBottom = const EdgeInsets.only(bottom: 16);

  @override
  void initState() {
    super.initState();
    _item = widget.item ?? IngredientItem();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.onGetItem(() {
      if (!_formKey.currentState!.validate()) return null;
      _formKey.currentState!.save();
      return _item;
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _paddingBottom,
            child: AppSectionTitle(AppI10N.of(context).ingredientFormPrimaryDetails),
          ),
          AppInput(
            initialValue: _item.name,
            label: AppI10N.of(context).ingredientFormName,
            validator: (value) =>
                (value == null || value.isEmpty) ? AppI10N.of(context).ingredientFormNameInvalid : null,
            onSaved: (value) => _item.name = value,
            paddingBottom: 16,
          ),
          AppServingInput(
            initialValue: _item.serving,
            label: AppI10N.of(context).ingredientFormServing,
            validator: (serving) => serving.value > 0 ? null : AppI10N.of(context).ingredientFormServingInvalid,
            onSaved: (value) => _item.servings = [value],
            units: IngredientItem.primaryServingUnits,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_item.calories, exact: true),
            label: AppI10N.of(context).ingredientFormCalories,
            onSaved: (value) => _item.calories = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          Padding(
            padding: _paddingBottom,
            child: AppSectionTitle(AppI10N.of(context).ingredientFormNutrients),
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_item.nutrients.carbs, exact: true),
            label: AppI10N.of(context).ingredientFormCarbs,
            onSaved: (value) => _item.nutrients.carbs = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_item.nutrients.protein, exact: true),
            label: AppI10N.of(context).ingredientFormProtein,
            onSaved: (value) => _item.nutrients.protein = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
          AppInput(
            initialValue: AppUtils.doubleToString(_item.nutrients.fat, exact: true),
            label: AppI10N.of(context).ingredientFormFat,
            onSaved: (value) => _item.nutrients.fat = AppUtils.stringToDouble(value),
            number: true,
            paddingBottom: 16,
          ),
        ],
      ),
    );
  }
}

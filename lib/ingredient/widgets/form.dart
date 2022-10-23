import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/models/nutrients.dart';
import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/widgets/text_input.dart';
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

  @override
  Widget build(BuildContext context) {
    widget.controller.onGetItem(() {
      if (!_formKey.currentState!.validate()) return null;

      _formKey.currentState!.save();
      return IngredientItem(
        id: IngredientItem.createId(),
        name: name,
        calories: 0,
        nutrients: AppNutrients(),
        servings: [AppServing()],
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextInput(
            label: appI10N(context).ingredientFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N(context).ingredientFormNameInvalid : null,
            onSaved: (value) => name = value!,
          ),
        ],
      ),
    );
  }
}

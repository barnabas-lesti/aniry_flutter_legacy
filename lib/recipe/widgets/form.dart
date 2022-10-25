import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/item_form_controller.dart';
import 'package:aniry/app/widgets/input.dart';
import 'package:aniry/app/widgets/serving_input.dart';
import 'package:aniry/app/widgets/title.dart';
import 'package:aniry/recipe/models/item.dart';
import 'package:flutter/material.dart';

class RecipeForm extends StatefulWidget {
  final AppItemFormController controller;
  final RecipeItem? item;

  const RecipeForm({
    required this.controller,
    this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _space = 16.0;
  final _paddingBottom = const EdgeInsets.only(bottom: 16);
  late RecipeItem _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item ?? RecipeItem();
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

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
            child: AppSectionTitle(appI10N.recipeFormPrimaryDetails),
          ),
          AppInput(
            initialValue: _item.name,
            label: appI10N.recipeFormName,
            validator: (value) => (value == null || value.isEmpty) ? appI10N.recipeFormNameInvalid : null,
            onSaved: (value) => _item.name = value,
            paddingBottom: _space,
          ),
          AppServingInput(
            initialValue: _item.serving,
            label: appI10N.recipeFormServing,
            validator: (serving) => serving.value > 0 ? null : appI10N.recipeFormServingInvalid,
            onSaved: (value) => _item.servings = [value],
            units: RecipeItem.primaryServingUnits,
            paddingBottom: _space,
          ),
        ],
      ),
    );
  }
}

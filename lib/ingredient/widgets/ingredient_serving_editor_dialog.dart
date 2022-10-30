import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/widgets/app_button_group.dart';
import 'package:aniry/app/widgets/app_input.dart';
import 'package:flutter/material.dart';

void showIngredientServingEditorDialog({
  required BuildContext context,
  required AppServing initialServing,
  required void Function(AppServing) onSave,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return IngredientServingEditorDialog(
        initialServing: initialServing,
        onSave: onSave,
      );
    },
  );
}

class IngredientServingEditorDialog extends StatefulWidget {
  final AppServing initialServing;
  final void Function(AppServing) onSave;

  const IngredientServingEditorDialog({
    required this.initialServing,
    required this.onSave,
    super.key,
  });

  @override
  State<IngredientServingEditorDialog> createState() => _IngredientServingEditorDialogState();
}

class _IngredientServingEditorDialogState extends State<IngredientServingEditorDialog> {
  late AppServing _serving;

  void Function() _buildOnSave(BuildContext context) {
    return () {
      widget.onSave(_serving);
      Navigator.pop(context);
    };
  }

  @override
  void initState() {
    super.initState();
    _serving = widget.initialServing;
  }

  @override
  Widget build(BuildContext context) {
    final appI10N = AppI10N.of(context);

    return SimpleDialog(
      title: Text(appI10N.ingredientServingEditorDialogTitle),
      titlePadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
      children: [
        AppInput(
          number: true,
          initialValue: AppUtils.doubleToString(_serving.value, exact: true),
          label: appI10N.ingredientServingEditorDialogServingLabel,
          onChanged: (value) => _serving.value = AppUtils.stringToDouble(value),
          paddingBottom: 16,
          suffix: _serving.unit,
        ),
        AppButtonGroup(actions: [
          AppButtonGroupAction(
            label: appI10N.ingredientServingEditorDialogCancel,
            onPressed: () => Navigator.pop(context),
          ),
          AppButtonGroupAction(
            label: appI10N.ingredientServingEditorDialogSave,
            onPressed: _buildOnSave(context),
          ),
        ]),
      ],
    );
  }
}

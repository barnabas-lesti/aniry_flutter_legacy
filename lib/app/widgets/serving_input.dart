import 'package:aniry/app/models/serving.dart';
import 'package:aniry/app/utils.dart';
import 'package:aniry/app/widgets/input.dart';
import 'package:aniry/app/widgets/select_input.dart';
import 'package:flutter/material.dart';

class AppServingInput extends StatefulWidget {
  final AppServing initialValue;
  final String label;
  final List<String> units;
  final String? Function(AppServing) validator;
  final void Function(AppServing) onSaved;
  final double? paddingBottom;

  const AppServingInput({
    required this.initialValue,
    required this.label,
    required this.units,
    required this.validator,
    required this.onSaved,
    this.paddingBottom,
    super.key,
  });

  @override
  State<AppServingInput> createState() => _AppServingInputState();
}

class _AppServingInputState extends State<AppServingInput> {
  @override
  Widget build(context) {
    AppServing serving = widget.initialValue;
    final input = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: AppInput(
            number: true,
            initialValue: AppUtils.doubleToString(widget.initialValue.value, exact: true),
            label: widget.label,
            validator: (_) => widget.validator(serving),
            onChanged: (value) => serving.value = AppUtils.stringToDouble(value),
            onSaved: (_) => widget.onSaved(serving),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AppSelectInput(
              initialValue: widget.initialValue.unit,
              onChanged: (value) => serving.unit = value,
              options: widget.units
                  .map((unit) => AppSelectInputOption(
                        label: unit,
                        value: unit,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );

    return (widget.paddingBottom != null && widget.paddingBottom! > 0)
        ? Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBottom!),
            child: input,
          )
        : input;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final void Function(String?)? onSaved;
  final double? paddingBottom;
  final bool? number;

  const AppInput({
    this.validator,
    this.initialValue,
    this.label,
    this.onSaved,
    this.paddingBottom,
    this.number,
    super.key,
  });

  @override
  Widget build(context) {
    final input = TextFormField(
      validator: validator,
      initialValue: initialValue,
      onSaved: onSaved,
      keyboardType: number ?? false ? const TextInputType.numberWithOptions(decimal: true) : null,
      inputFormatters: number ?? false
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
              TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.replaceAll(',', '.'),
                ),
              ),
            ]
          : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );

    return paddingBottom != null && paddingBottom! > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: input,
          )
        : input;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final void Function(String)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool? number;
  final bool? readonly;
  final TextAlign? textAlign;
  final double? paddingBottom;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const AppInput({
    this.validator,
    this.initialValue,
    this.label,
    this.onSaved,
    this.number,
    this.readonly,
    this.onTap,
    this.textAlign,
    this.paddingBottom,
    this.onChanged,
    this.controller,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(context) {
    final input = TextFormField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      textAlign: textAlign ?? TextAlign.start,
      onTap: onTap,
      readOnly: (readonly ?? false) ? readonly! : false,
      validator: validator,
      initialValue: initialValue,
      onSaved: (value) => onSaved?.call(value ?? ''),
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

    return (paddingBottom != null && paddingBottom! > 0)
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: input,
          )
        : input;
  }
}

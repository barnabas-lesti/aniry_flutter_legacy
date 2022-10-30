import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final bool? number;
  final bool? readonly;
  final TextAlign? textAlign;
  final double? paddingBottom;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? suffix;
  final void Function(String)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const AppInput({
    this.validator,
    this.initialValue,
    this.label,
    this.number,
    this.readonly,
    this.textAlign,
    this.paddingBottom,
    this.controller,
    this.focusNode,
    this.suffix,
    this.onSaved,
    this.onChanged,
    this.onTap,
    super.key,
  });

  @override
  Widget build(context) {
    final input = TextFormField(
      focusNode: focusNode,
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      readOnly: (readonly ?? false) ? readonly! : false,
      validator: validator,
      initialValue: initialValue,
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
        suffix: (suffix ?? '').isNotEmpty ? Text(suffix!) : null,
      ),
      onChanged: onChanged,
      onTap: onTap,
      onSaved: (value) => onSaved?.call(value ?? ''),
    );

    return (paddingBottom ?? 0) > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: input,
          )
        : input;
  }
}

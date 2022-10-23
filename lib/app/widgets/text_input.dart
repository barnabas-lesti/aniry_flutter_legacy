import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final void Function(String?)? onSaved;

  const AppTextInput({
    this.validator,
    this.initialValue,
    this.label,
    this.onSaved,
    super.key,
  });

  @override
  Widget build(context) {
    return TextFormField(
      validator: validator,
      initialValue: initialValue,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}

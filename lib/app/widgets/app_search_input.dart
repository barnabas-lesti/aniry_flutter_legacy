import 'package:aniry/app/widgets/app_input.dart';
import 'package:flutter/material.dart';

class AppSearchInput extends StatelessWidget {
  final String label;
  final void Function(String) onSearch;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const AppSearchInput({
    required this.label,
    required this.onSearch,
    this.controller,
    this.initialValue,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(context) {
    return AppInput(
      focusNode: focusNode,
      label: label,
      onChanged: onSearch,
      initialValue: initialValue,
      controller: controller,
    );
  }
}

import 'package:aniry/app/widgets/app_input.dart';
import 'package:flutter/material.dart';

class AppSearchInput extends StatelessWidget {
  final String label;
  final void Function(String) onSearch;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? paddingBottom;

  const AppSearchInput({
    required this.label,
    required this.onSearch,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.paddingBottom,
    super.key,
  });

  @override
  Widget build(context) {
    final input = AppInput(
      focusNode: focusNode,
      label: label,
      onChanged: onSearch,
      initialValue: initialValue,
      controller: controller,
    );

    return (paddingBottom ?? 0) > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: input,
          )
        : input;
  }
}

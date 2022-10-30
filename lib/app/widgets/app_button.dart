import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final int? flex;

  const AppButton({
    required this.label,
    required this.onPressed,
    this.flex,
    super.key,
  });

  @override
  Widget build(context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );

    return flex != null && flex! > 0 ? Expanded(flex: flex!, child: button) : button;
  }
}

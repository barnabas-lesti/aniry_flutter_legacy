import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

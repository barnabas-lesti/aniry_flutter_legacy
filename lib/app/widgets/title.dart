import 'package:flutter/material.dart';

class AppSectionTitle extends StatelessWidget {
  final String text;

  const AppSectionTitle(
    this.text, {
    super.key,
  });

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

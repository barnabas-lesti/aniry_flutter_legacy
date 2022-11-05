import 'package:flutter/material.dart';

class AppGap extends StatelessWidget {
  final double? vertical;
  final double? horizontal;

  const AppGap({
    this.vertical,
    this.horizontal,
    super.key,
  });

  @override
  Widget build(context) {
    return SizedBox(
      width: horizontal,
      height: vertical,
    );
  }
}

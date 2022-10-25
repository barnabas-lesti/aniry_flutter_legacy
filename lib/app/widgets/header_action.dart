import 'package:flutter/material.dart';

class AppHeaderAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final void Function()? onPressed;

  const AppHeaderAction({
    required this.icon,
    required this.tooltip,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}

import 'package:flutter/material.dart';

class AppFab extends StatelessWidget {
  const AppFab({
    required this.icon,
    required this.onPressed,
    this.color = Colors.indigo,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final Color? color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      child: icon,
    );
  }
}

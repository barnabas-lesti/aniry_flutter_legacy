import 'package:flutter/material.dart';

class AppPageScaffold extends StatelessWidget {
  static const double gap = 16;

  final String title;
  final Widget child;
  final List<Widget> actions;

  const AppPageScaffold({
    required this.title,
    required this.child,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: gap, right: gap, top: gap),
        child: child,
      ),
    );
  }
}

class AppPageAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final void Function()? onPressed;

  const AppPageAction({
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

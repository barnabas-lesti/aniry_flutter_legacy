import 'package:flutter/material.dart';

class AppPageScaffold extends StatelessWidget {
  static const double gutter = 16;

  final String title;
  final List<Widget> children;
  final List<Widget> actions;

  const AppPageScaffold({
    required this.title,
    required this.children,
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
        padding: const EdgeInsets.only(left: gutter, right: gutter, top: gutter),
        child: Column(children: children),
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

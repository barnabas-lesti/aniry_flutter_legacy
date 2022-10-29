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

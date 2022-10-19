import 'package:flutter/material.dart';

IconButton buildAppScreenAction(IconData icon, String tooltip, {void Function()? onPressed}) => IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );

class AppScreen extends StatelessWidget {
  static const double gutter = 16;

  final String title;
  final List<Widget> children;
  final List<Widget> actions;

  const AppScreen({
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

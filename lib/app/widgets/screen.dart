import 'package:flutter/material.dart';

class AppScreenWidget extends StatelessWidget {
  static const double gutter = 16;

  final String title;
  final List<Widget> children;
  final List<AppScreenAction> actions;

  const AppScreenWidget({
    required this.title,
    required this.children,
    this.actions = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          for (int i = 0; i < actions.length; i++)
            IconButton(
              icon: Icon(actions[i].icon),
              tooltip: actions[i].tooltip,
              onPressed: actions[i].onPressed,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: gutter, right: gutter, top: gutter),
        child: Column(children: children),
      ),
    );
  }
}

class AppScreenAction {
  final IconData icon;
  final String tooltip;
  final void Function()? onPressed;

  const AppScreenAction({
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });
}

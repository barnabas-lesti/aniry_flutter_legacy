import 'package:flutter/material.dart';

PreferredSizeWidget showAppHeaderWidget({
  required String title,
  List<AppHeaderWidgetAction> actions = const [],
}) =>
    AppBar(
      title: Text(title),
      actions: [
        for (int i = 0; i < actions.length; i++)
          IconButton(
            icon: Icon(actions[i].icon),
            tooltip: actions[i].tooltip,
            onPressed: actions[i].onPressed,
          ),
      ],
    );

class AppHeaderWidgetAction {
  late IconData icon;
  late String tooltip;
  late void Function()? onPressed;

  AppHeaderWidgetAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });
}

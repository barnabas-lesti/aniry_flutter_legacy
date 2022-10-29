import 'package:aniry/app/widgets/app_button.dart';
import 'package:flutter/material.dart';

class AppButtonGroup extends StatelessWidget {
  final List<AppButtonGroupAction> actions;
  final double? gap;
  final double? paddingBottom;

  const AppButtonGroup({
    required this.actions,
    this.gap,
    this.paddingBottom,
    super.key,
  });

  @override
  Widget build(context) {
    final List<Widget> children = [];
    for (int index = 0; index < actions.length; index++) {
      children.add(AppButton(
        label: actions[index].label,
        onPressed: actions[index].onPressed,
        flex: 1,
      ));
      if (index + 1 < actions.length) {
        children.add(SizedBox(width: gap ?? 16));
      }
    }

    final row = Row(children: children);

    return (paddingBottom ?? 0) > 0
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: row,
          )
        : row;
  }
}

class AppButtonGroupAction {
  final String label;
  final void Function() onPressed;

  AppButtonGroupAction({
    required this.label,
    required this.onPressed,
  });
}

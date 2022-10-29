import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final double? paddingBottom;
  final List<Widget> actions;

  const AppSectionHeader({
    required this.title,
    this.paddingBottom,
    this.actions = const [],
    super.key,
  });

  @override
  Widget build(context) {
    final text = Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
    final row = actions.isNotEmpty
        ? Row(
            children: [
              Expanded(child: text),
              const SizedBox(width: 8),
              Expanded(
                flex: 0,
                child: Row(children: actions),
              ),
            ],
          )
        : text;
    final content = paddingBottom != null
        ? Padding(
            padding: EdgeInsets.only(bottom: paddingBottom!),
            child: row,
          )
        : row;

    return content;
  }
}

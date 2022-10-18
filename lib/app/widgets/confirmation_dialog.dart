import 'package:flutter/material.dart';

Future<String?> showAppConfirmationDialogWidget({
  required BuildContext context,
  required String text,
  required List<AppConfirmationDialogAction> actions,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => _AppConfirmationDialogWidget(
        text: text,
        actions: actions,
      ),
    );

class _AppConfirmationDialogWidget extends StatelessWidget {
  const _AppConfirmationDialogWidget({
    required this.text,
    required this.actions,
    Key? key,
  }) : super(key: key);

  final String text;
  final List<AppConfirmationDialogAction> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        for (int i = 0; i < actions.length; i++)
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(actions[i].color ?? Theme.of(context).primaryColor),
            ),
            onPressed: () {
              actions[i].onPressed();
              Navigator.pop(context);
            },
            child: Text(actions[i].label),
          ),
      ],
    );
  }
}

class AppConfirmationDialogAction {
  final String label;
  final void Function() onPressed;
  final Color? color;

  const AppConfirmationDialogAction({
    required this.label,
    required this.onPressed,
    this.color,
  });
}

import 'package:flutter/material.dart';

Future<String?> showCommonConfirmationDialog({
  required BuildContext context,
  required String text,
  required List<CommonConfirmationDialogAction> actions,
}) =>
    showDialog<String>(
      context: context,
      builder: (context) => _CommonConfirmationDialog(
        text: text,
        actions: actions,
      ),
    );

class CommonConfirmationDialogAction {
  final String label;
  final void Function() onPressed;
  final Color? color;

  const CommonConfirmationDialogAction({
    required this.label,
    required this.onPressed,
    this.color,
  });
}

class _CommonConfirmationDialog extends StatelessWidget {
  const _CommonConfirmationDialog({
    required this.text,
    required this.actions,
    Key? key,
  }) : super(key: key);

  final String text;
  final List<CommonConfirmationDialogAction> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
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

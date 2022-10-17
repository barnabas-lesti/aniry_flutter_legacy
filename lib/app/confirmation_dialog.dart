import 'package:flutter/material.dart';

Future<String?> showAppConfirmationDialog({
  required BuildContext context,
  required String text,
  required void Function() onConfirm,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => _AppConfirmationDialog(
        text: text,
        onConfirm: onConfirm,
      ),
    );

class _AppConfirmationDialog extends StatelessWidget {
  const _AppConfirmationDialog({
    required this.text,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function() onConfirm;

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
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

Future<String?> showAppConfirmationDialog({
  required BuildContext context,
  required String text,
  required void Function() onConfirm,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AppConfirmationDialog(
        text: text,
        onConfirm: onConfirm,
      ),
    );

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    required this.text,
    required this.onConfirm,
    this.onCancel,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            onCancel?.call();
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

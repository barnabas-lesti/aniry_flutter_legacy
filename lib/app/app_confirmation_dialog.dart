import 'package:flutter/material.dart';

Future<String?> showAppConfirmationDialog({
  required BuildContext context,
  required String text,
  required void Function() onConfirm,
}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AppConfirmationDialog(
      text: text,
      onConfirm: onConfirm,
    ),
  );
}

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    required this.text,
    required this.onConfirm,
    Key? key,
    this.onCancel,
  }) : super(key: key);

  final String text;
  final void Function()? onCancel;
  final void Function() onConfirm;

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

import 'package:flutter/material.dart';

Future<String?> showAppConfirmationDialogWidget({
  required BuildContext context,
  required String text,
  required void Function() onConfirm,
}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => _AppConfirmationDialogWidget(
        text: text,
        onConfirm: onConfirm,
      ),
    );

class _AppConfirmationDialogWidget extends StatelessWidget {
  const _AppConfirmationDialogWidget({
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

import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsHome extends StatefulWidget {
  final String title;

  const SettingsHome({
    required this.title,
    super.key,
  });

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  final FocusNode inputFocusNode = FocusNode();

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: widget.title,
      child: Column(
        children: const [
          Text('Hello settings page!'),
        ],
      ),
    );
  }
}

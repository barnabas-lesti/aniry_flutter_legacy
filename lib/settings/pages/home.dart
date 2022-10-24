import 'package:aniry/app/i10n.dart';
import 'package:aniry/app/widgets/button.dart';
import 'package:aniry/app/widgets/page_scaffold.dart';
import 'package:aniry/app/widgets/title.dart';
import 'package:flutter/material.dart';

class SettingsHome extends StatelessWidget {
  final String title;

  const SettingsHome({
    required this.title,
    super.key,
  });

  final _space = AppPageScaffold.gap / 2;
  final _spacePadding = const EdgeInsets.only(bottom: AppPageScaffold.gap / 2);

  void _onDataExportPress() {}

  void _onDataImportPress() {}

  @override
  Widget build(context) {
    return AppPageScaffold(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _spacePadding,
            child: AppSectionTitle(AppI10N.of(context).settingsHomeDataTitle),
          ),
          Padding(
            padding: _spacePadding,
            child: Text(AppI10N.of(context).settingsHomeDataText),
          ),
          Padding(
            padding: _spacePadding,
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: AppI10N.of(context).settingsHomeDataExportButton,
                    onPressed: _onDataExportPress,
                  ),
                ),
                SizedBox(width: _space),
                Expanded(
                  child: AppButton(
                    label: AppI10N.of(context).settingsHomeDataImportButton,
                    onPressed: _onDataImportPress,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}

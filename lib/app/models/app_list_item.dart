import 'package:flutter/material.dart';

class AppListItem {
  final String id;
  final Type source;
  final String textLeftPrimary;
  final String textLeftSecondary;
  final String textRightPrimary;
  final String textRightSecondary;
  final IconData? icon;
  final Color? color;

  const AppListItem({
    required this.id,
    required this.source,
    required this.textLeftPrimary,
    this.textLeftSecondary = '',
    this.textRightPrimary = '',
    this.textRightSecondary = '',
    this.icon,
    this.color,
  });
}

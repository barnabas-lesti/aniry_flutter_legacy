import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AppFeatureRouter {
  final IconData icon;
  final BeamerDelegate routerDelegate;
  final String Function(BuildContext) label;

  const AppFeatureRouter({
    required this.icon,
    required this.routerDelegate,
    required this.label,
  });
}

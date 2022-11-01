import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';

class AppTotalCalories extends StatelessWidget {
  final double calories;
  final double? paddingBottom;

  const AppTotalCalories({
    required this.calories,
    this.paddingBottom,
    super.key,
  });

  @override
  Widget build(context) {
    final appI10N = AppI10N.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16 + (paddingBottom ?? 0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appI10N.appTotalCalories,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

import 'package:aniry/app/app_i10n.dart';
import 'package:aniry/app/app_utils.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_unit.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AppNutrientsChart extends StatelessWidget {
  final AppNutrients nutrients;

  const AppNutrientsChart({
    required this.nutrients,
    super.key,
  });

  Widget _buildLegendItem(String label, double value, Color color) {
    return Wrap(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          '$label (${AppUtils.doubleToString(value)}${AppUnit.g})',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  PieChartSectionData _buildSectionData(double value, Color color) {
    return PieChartSectionData(
      value: value,
      color: color,
      showTitle: false,
      radius: 150.0,
    );
  }

  @override
  Widget build(context) {
    final appI10N = AppI10N.of(context);
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            if (nutrients.carbs != 0)
              _buildLegendItem(
                appI10N.appNutrientsChartCarbs,
                nutrients.carbs,
                AppNutrients.carbsColor,
              ),
            if (nutrients.protein != 0)
              _buildLegendItem(
                appI10N.appNutrientsChartProtein,
                nutrients.protein,
                AppNutrients.proteinColor,
              ),
            if (nutrients.fat != 0)
              _buildLegendItem(
                appI10N.appNutrientsChartFat,
                nutrients.fat,
                AppNutrients.fatColor,
              ),
          ],
        ),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: [
                _buildSectionData(nutrients.carbs, AppNutrients.carbsColor),
                _buildSectionData(nutrients.protein, AppNutrients.proteinColor),
                _buildSectionData(nutrients.fat, AppNutrients.fatColor),
              ],
              centerSpaceRadius: 0,
              sectionsSpace: 0,
              startDegreeOffset: 180,
            ),
            swapAnimationDuration: const Duration(milliseconds: 300),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ],
    );
  }
}

import 'package:aniry/app/app_utils.dart';

class AppNutrients {
  late double carbs;
  late double protein;
  late double fat;

  AppNutrients({
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
  });

  static AppNutrients fromJson(Map<String, dynamic>? json) {
    return json != null
        ? AppNutrients(
            carbs: (json['carbs'] as num? ?? 0).toDouble(),
            protein: (json['protein'] as num? ?? 0).toDouble(),
            fat: (json['fat'] as num? ?? 0).toDouble(),
          )
        : AppNutrients();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (carbs != 0) json['carbs'] = carbs;
    if (protein != 0) json['protein'] = protein;
    if (fat != 0) json['fat'] = fat;
    return json;
  }

  @override
  String toString() {
    return '${AppUtils.doubleToString(carbs)}g carbs, ${AppUtils.doubleToString(protein)}g protein, ${AppUtils.doubleToString(fat)}g fat';
  }
}

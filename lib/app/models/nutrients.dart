import 'package:aniry/app/utils.dart';

class AppNutrients {
  late double carbs;
  late double protein;
  late double fat;

  AppNutrients({
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
  });

  static AppNutrients fromJson(Map<String, dynamic> json) {
    return AppNutrients(
      carbs: (json['carbs'] as num? ?? 0).toDouble(),
      protein: (json['protein'] as num? ?? 0).toDouble(),
      fat: (json['fat'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
    };
  }

  @override
  String toString() {
    return '${AppUtils.doubleToString(carbs)}g carbs, ${AppUtils.doubleToString(protein)}g protein, ${AppUtils.doubleToString(fat)}g fat';
  }
}

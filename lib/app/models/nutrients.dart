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
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0,
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

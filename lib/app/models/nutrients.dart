import 'package:json_annotation/json_annotation.dart';

part 'nutrients.g.dart';

@JsonSerializable()
class AppNutrients {
  double carbs;
  double protein;
  double fat;

  AppNutrients({
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
  });

  @override
  toString() =>
      '${carbs.toStringAsFixed(0)}g carbs, ${protein.toStringAsFixed(0)}g protein, ${fat.toStringAsFixed(0)}g fat';

  factory AppNutrients.fromJson(Map<String, dynamic> json) => _$AppNutrientsFromJson(json);

  Map<String, dynamic> toJson() => _$AppNutrientsToJson(this);
}

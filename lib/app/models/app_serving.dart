import 'package:aniry/app/models/app_unit.dart';
import 'package:aniry/app/app_utils.dart';

class AppServing {
  late String unit;
  late double value;

  AppServing({
    this.unit = AppUnit.g,
    this.value = 0,
  });

  static AppServing fromJson(Map<String, dynamic> json) {
    return AppServing(
      unit: json['unit'] as String? ?? AppUnit.g,
      value: (json['value'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'unit': unit,
      'value': value,
    };
  }

  @override
  String toString() {
    return '${AppUtils.doubleToString(value)}$unit';
  }
}

import 'package:aniry/app/models/serving_unit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serving.g.dart';

@JsonSerializable()
class AppServing {
  AppServingUnit unit;
  double value;

  AppServing({
    this.unit = AppServingUnit.g,
    this.value = 0,
  });

  @override
  toString() => '${value.toStringAsFixed(0)}${unit.name}';

  factory AppServing.fromJson(Map<String, dynamic> json) => _$AppServingFromJson(json);

  Map<String, dynamic> toJson() => _$AppServingToJson(this);
}

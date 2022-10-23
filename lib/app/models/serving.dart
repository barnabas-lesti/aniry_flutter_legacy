import 'package:aniry/app/models/unit.dart';
import 'package:aniry/app/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serving.g.dart';

@JsonSerializable()
class AppServing {
  String unit;
  double value;

  AppServing({
    this.unit = AppUnit.g,
    this.value = 0,
  });

  @override
  toString() => '${AppUtils.doubleToString(value)}$unit';

  factory AppServing.fromJson(Map<String, dynamic> json) => _$AppServingFromJson(json);

  Map<String, dynamic> toJson() => _$AppServingToJson(this);
}

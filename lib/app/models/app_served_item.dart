import 'package:aniry/app/models/app_list_item.dart';
import 'package:aniry/app/models/app_nutrients.dart';
import 'package:aniry/app/models/app_servable_item.dart';
import 'package:aniry/app/models/app_serving.dart';
import 'package:aniry/app/models/app_unit.dart';

class AppServedItem {
  late AppServing serving;
  late AppServableItem item;

  AppServedItem({
    required this.item,
    AppServing? serving,
  }) {
    this.serving = serving != null ? serving.clone() : AppServing();
  }

  static double reduceCalories(Iterable<double> calories) {
    return calories.fold(0, (value, element) => value + element);
  }

  static AppNutrients reduceNutrients(Iterable<AppNutrients> nutrients) {
    return nutrients.fold(AppNutrients(), (value, element) {
      value.carbs += element.carbs;
      value.protein += element.protein;
      value.fat += element.fat;
      return value;
    });
  }

  String get id => item.id;

  double get calories {
    return (item.calories / item.serving.value) * serving.value;
  }

  AppNutrients get nutrients {
    return AppNutrients(
      carbs: (item.nutrients.carbs / item.serving.value) * serving.value,
      protein: (item.nutrients.protein / item.serving.value) * serving.value,
      fat: (item.nutrients.fat / item.serving.value) * serving.value,
    );
  }

  AppListItem toListItem() {
    return AppListItem(
      id: item.id,
      textLeftPrimary: item.name,
      textLeftSecondary: nutrients.toString(),
      textRightPrimary: serving.toString(),
      textRightSecondary: '${calories.toStringAsFixed(0)}${AppUnit.kcal}',
      icon: item.icon,
      color: item.color,
    );
  }
}

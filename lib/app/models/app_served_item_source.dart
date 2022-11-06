import 'package:aniry/app/models/app_served_item.dart';
import 'package:aniry/app/models/app_serving.dart';

class AppServedItemSource {
  late AppServing serving;
  late String itemID;

  AppServedItemSource({
    required this.itemID,
    required this.serving,
  });

  static AppServedItemSource fromJson(Map<String, dynamic> json) {
    return AppServedItemSource(
      serving: AppServing.fromJson(json['serving'] as Map<String, dynamic>),
      itemID: json['itemID'] as String,
    );
  }

  static AppServedItemSource fromServedItem(AppServedItem servedItem) {
    return AppServedItemSource(itemID: servedItem.id, serving: servedItem.serving);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'itemID': itemID,
      'serving': serving,
    };
  }
}

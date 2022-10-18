import 'package:realm/realm.dart';

part 'item.g.dart';

@RealmModel()
class _ShoppingItemModel {
  @PrimaryKey()
  late final String id;
  late final String text;
  late int order;
  late bool checked = false;
}

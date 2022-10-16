import 'package:realm/realm.dart';

part 'item.g.dart';

@RealmModel()
class _ShoppingListItem {
  @PrimaryKey()
  late final Uuid id;
  late String text;
  late int order;
  late bool checked = false;
}

import 'package:aniry_shopping_list/shopping_list/shopping_list_item.dart';
import 'package:realm/realm.dart';

final realm = Realm(Configuration.local([
  ShoppingListItem.schema,
]));

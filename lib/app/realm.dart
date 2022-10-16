import 'package:aniry_shopping_list/shopping_list/item.dart';
import 'package:realm/realm.dart';

final appRealm = Realm(Configuration.local([
  ShoppingListItem.schema,
]));

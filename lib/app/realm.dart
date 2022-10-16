import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:realm/realm.dart';

final appRealm = Realm(Configuration.local([
  ShoppingItem.schema,
]));

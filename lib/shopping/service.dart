import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:realm/realm.dart';

typedef ShoppingServiceResult<T extends RealmObject> = RealmResults<T>;

class _ShoppingService {
  late final Realm _realm;

  _ShoppingService() {
    _realm = Realm(Configuration.local([ShoppingItem.schema]));
  }

  ShoppingItem createItem(String text, int order) => ShoppingItem(Uuid.v4(), text, order);

  ShoppingServiceResult<ShoppingItem> getAllItems() => _realm.all<ShoppingItem>();

  List<ShoppingItem> sortItemsByOrder(List<ShoppingItem> items) => items..sort((a, b) => a.order.compareTo(b.order));

  void addItem(String text, int order) => _realm.write(() => _realm.add(createItem(text, order)));

  void checkItem(ShoppingItem item, bool checked) => _realm.write(() => item.checked = checked);

  void deleteItem(ShoppingItem item) => _realm.write(() => _realm.delete(item));

  void deleteAllItems() => _realm.write(() => _realm.deleteAll<ShoppingItem>());

  void reorderItems(ShoppingServiceResult<ShoppingItem> existingItems, List<ShoppingItem> updatedItems) {
    _realm.write(() {
      for (int i = 0; i < updatedItems.length; i++) {
        final item = existingItems.singleWhere((element) => element.id == updatedItems[i].id);
        if (item.order != i) {
          item.order = i;
        }
      }
    });
  }
}

final shoppingService = _ShoppingService();

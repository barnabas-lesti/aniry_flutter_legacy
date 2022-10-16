import 'package:aniry_shopping_list/app/realm.dart';
import 'package:aniry_shopping_list/shopping/item.dart';
import 'package:realm/realm.dart';

typedef ShoppingServiceResult<T extends RealmObject> = RealmResults<T>;

class _ShoppingService {
  ShoppingItem createItem(String text, int order) => ShoppingItem(Uuid.v4(), text, order);

  ShoppingServiceResult<ShoppingItem> getAllItems() => appRealm.all<ShoppingItem>();

  List<ShoppingItem> sortItemsByOrder(List<ShoppingItem> items) => items..sort((a, b) => a.order.compareTo(b.order));

  void addItem(String text, int order) => appRealm.write(() => appRealm.add(createItem(text, order)));

  void checkItem(ShoppingItem item, bool checked) => appRealm.write(() => item.checked = checked);

  void deleteItem(ShoppingItem item) => appRealm.write(() => appRealm.delete(item));

  void deleteAllItems() => appRealm.write(() => appRealm.deleteAll<ShoppingItem>());

  void reorderItems(ShoppingServiceResult<ShoppingItem> existingItems, List<ShoppingItem> updatedItems) {
    appRealm.write(() {
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

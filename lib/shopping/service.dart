import 'package:aniry/shopping/models/item.dart';
import 'package:realm/realm.dart';

typedef ShoppingServiceResult<T extends RealmObject> = RealmResults<T>;

class _Service {
  late final Realm _realm;

  _Service() {
    _realm = Realm(Configuration.local([ShoppingItemModel.schema]));
  }

  ShoppingItemModel createItem(String text, int order) => ShoppingItemModel(Uuid.v4().toString(), text, order);

  ShoppingServiceResult<ShoppingItemModel> getAllItems() => _realm.all<ShoppingItemModel>();

  List<ShoppingItemModel> sortItemsByOrder(List<ShoppingItemModel> items) =>
      items..sort((a, b) => a.order.compareTo(b.order));

  void addItem(String text, int order) => _realm.write(() => _realm.add(createItem(text, order)));

  void checkItem(ShoppingItemModel item, bool checked) => _realm.write(() => item.checked = checked);

  void deleteItem(ShoppingItemModel item) => _realm.write(() => _realm.delete(item));

  void deleteItems(List<ShoppingItemModel> items) => _realm.write(() => _realm.deleteMany(items));

  void reorderItems(ShoppingServiceResult<ShoppingItemModel> existingItems, List<ShoppingItemModel> updatedItems) {
    _realm.write(() {
      for (int i = 0; i < updatedItems.length; i++) {
        final item = existingItems.singleWhere((existingItem) => existingItem.id == updatedItems[i].id);
        if (item.order != i) {
          item.order = i;
        }
      }
    });
  }
}

final shoppingService = _Service();

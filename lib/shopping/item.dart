import 'package:aniry/app/item.dart';

class ShoppingItem extends AppItem {
  ShoppingItem({
    required String id,
    required String text,
    bool checked = false,
  }) : super(
          id: id,
          text: text,
          checked: checked,
        );
}

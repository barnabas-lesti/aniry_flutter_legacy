// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ShoppingListItem extends _ShoppingListItem with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  ShoppingListItem(
    Uuid id,
    String text,
    int order, {
    bool checked = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<ShoppingListItem>({
        'checked': false,
      });
    }
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'text', text);
    RealmObject.set(this, 'order', order);
    RealmObject.set(this, 'checked', checked);
  }

  ShoppingListItem._();

  @override
  Uuid get id => RealmObject.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => throw RealmUnsupportedSetError();

  @override
  String get text => RealmObject.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObject.set(this, 'text', value);

  @override
  int get order => RealmObject.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObject.set(this, 'order', value);

  @override
  bool get checked => RealmObject.get<bool>(this, 'checked') as bool;
  @override
  set checked(bool value) => RealmObject.set(this, 'checked', value);

  @override
  Stream<RealmObjectChanges<ShoppingListItem>> get changes =>
      RealmObject.getChanges<ShoppingListItem>(this);

  @override
  ShoppingListItem freeze() => RealmObject.freezeObject<ShoppingListItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(ShoppingListItem._);
    return const SchemaObject(ShoppingListItem, 'ShoppingListItem', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('text', RealmPropertyType.string),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('checked', RealmPropertyType.bool),
    ]);
  }
}

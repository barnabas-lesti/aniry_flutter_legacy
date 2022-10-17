// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ShoppingItem extends _ShoppingItem with RealmEntity, RealmObject {
  static var _defaultsSet = false;

  ShoppingItem(
    Uuid id,
    String text,
    int order, {
    bool checked = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<ShoppingItem>({
        'checked': false,
      });
    }
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'text', text);
    RealmObject.set(this, 'order', order);
    RealmObject.set(this, 'checked', checked);
  }

  ShoppingItem._();

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
  Stream<RealmObjectChanges<ShoppingItem>> get changes =>
      RealmObject.getChanges<ShoppingItem>(this);

  @override
  ShoppingItem freeze() => RealmObject.freezeObject<ShoppingItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(ShoppingItem._);
    return const SchemaObject(ShoppingItem, 'ShoppingItem', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('text', RealmPropertyType.string),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('checked', RealmPropertyType.bool),
    ]);
  }
}

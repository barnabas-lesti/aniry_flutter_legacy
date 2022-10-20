import 'dart:convert';
import 'dart:io';

import 'package:aniry/common/item.dart';
import 'package:path_provider/path_provider.dart';

enum CommonCollection {
  shopping;
}

class CommonStorage<T extends CommonItem> {
  final CommonCollection collection;
  final T Function(Map<String, dynamic>) fromJson;

  CommonStorage({
    required this.collection,
    required this.fromJson,
  });

  Future<File> get _storageFile async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/${collection.name}.ani');
  }

  Future<List<T>> fetchItems() async {
    final file = await _storageFile;
    if (!await file.exists()) return [];

    final dataString = await file.readAsString();
    final data = json.decode(dataString) as List<dynamic>;
    return data.map((raw) => fromJson(raw)).toList();
  }

  void storeItems(List<T> items) async {
    final file = await _storageFile;
    await file.writeAsString(json.encode(items));
  }
}

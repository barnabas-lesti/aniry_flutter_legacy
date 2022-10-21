import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum AppPartition {
  shopping;
}

final appStorage = _AppStorage();

class _AppStorage {
  Future<File> _storageFile(AppPartition partition) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/${partition.name}.ani');
  }

  Future<dynamic> fetchData(AppPartition partition) async {
    final file = await _storageFile(partition);
    if (!await file.exists()) return [];

    final dataString = await file.readAsString();
    return json.decode(dataString);
  }

  void storeData(AppPartition partition, dynamic data) async {
    final file = await _storageFile(partition);
    await file.writeAsString(json.encode(data));
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum AppPartition {
  shopping;
}

class AppStorage {
  final AppPartition partition;

  AppStorage({required this.partition});

  Future<File> get _storageFile async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/${partition.name}.ani');
  }

  Future<dynamic> fetchData() async {
    final file = await _storageFile;
    if (!await file.exists()) return [];

    final dataString = await file.readAsString();
    return json.decode(dataString);
  }

  void storeData(dynamic data) async {
    final file = await _storageFile;
    await file.writeAsString(json.encode(data));
  }
}

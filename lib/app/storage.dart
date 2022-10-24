import 'dart:convert';
import 'dart:io';

import 'package:aniry/app/models/export_data.dart';
import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

enum AppPartition {
  shopping,
  ingredient,
}

final appStorage = _AppStorage();

class _AppStorage {
  Future<File> _getFile(String name) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/$name.ani');
  }

  Future<dynamic> fetchPartitionData(AppPartition partition) async {
    final file = await _getFile(partition.name);
    if (!await file.exists()) return [];

    final dataString = await file.readAsString();
    return json.decode(dataString);
  }

  void storePartitionData(AppPartition partition, dynamic data) async {
    final file = await _getFile(partition.name);
    await file.writeAsString(json.encode(data));
  }

  Future<void> exportData(String fileName, dynamic data) async {
    final file = await _getFile(fileName);
    await file.writeAsString(json.encode(data));
    await Share.shareXFiles([XFile(file.path)]);
  }
}

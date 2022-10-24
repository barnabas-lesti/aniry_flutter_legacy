import 'dart:convert';
import 'dart:io';

import 'package:aniry/app/models/exported_data.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

enum AppPartition {
  shopping,
  ingredient,
}

class AppStorage {
  static Future<File> _loadFile(String name) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;
    return File('$path/$name.ani');
  }

  static Future<dynamic> loadPartitionData(AppPartition partition) async {
    final file = await _loadFile(partition.name);
    if (!await file.exists()) return [];

    final dataString = await file.readAsString();
    return json.decode(dataString);
  }

  static void storePartitionData(AppPartition partition, dynamic data) async {
    final file = await _loadFile(partition.name);
    await file.writeAsString(json.encode(data));
  }

  static Future<bool> exportData(String fileName, AppExportedData data) async {
    final file = await _loadFile(fileName);
    await file.writeAsString(json.encode(data));
    final result = await Share.shareXFiles([XFile(file.path)]);
    return result.status == ShareResultStatus.success;
  }

  static Future<AppExportedData?> importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return AppExportedData.fromJson(json.decode(await file.readAsString()));
    }
    return null;
  }
}

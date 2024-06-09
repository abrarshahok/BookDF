import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> saveBase64Pdf(String base64Pdf, String fileName) async {
  try {
    Uint8List bytes = base64Decode(base64Pdf);
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/$fileName';
    File file = File(path);
    if (file.existsSync()) {
      return path;
    } else {
      await file.writeAsBytes(bytes);
      return path;
    }
  } catch (e) {
    throw Exception("Error saving PDF: $e");
  }
}

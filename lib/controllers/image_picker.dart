import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:mysql1/mysql1.dart';

Future<Map<String, dynamic>?> openImagePicker() async {
  final typeGroup = XTypeGroup(
    label: 'images',
    extensions: const ['jpg', 'jpeg', 'png', 'heic'],
  );

  final xFile = await openFile(acceptedTypeGroups: [typeGroup]);
  if (xFile != null) {
    File file = File(xFile.path);
    Blob blob = Blob.fromBytes(await file.readAsBytes());

    return {
      'file': file,
      'blob': Blob.fromBytes(await file.readAsBytes()),
      'name': xFile.name,
    };
  }
}

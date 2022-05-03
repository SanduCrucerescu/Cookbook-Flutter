import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Uint8List getImageDataFromBlob(Blob img) {
  if (!img.toString().startsWith('/')) {
    var blob = const Base64Codec().encode(img.toBytes());

    return const Base64Codec().decode(blob);
  } else {
    var blob = img.toString();

    return const Base64Codec().decode(blob);
  }
}

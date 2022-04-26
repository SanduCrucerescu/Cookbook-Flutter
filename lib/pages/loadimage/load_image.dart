import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:convert';
import 'dart:typed_data';

class LoadImagePage extends StatefulWidget {
  static const String id = '/img';

  LoadImagePage({Key? key}) : super(key: key);

  @override
  State<LoadImagePage> createState() => _LoadImagePageState();
}

class _LoadImagePageState extends State<LoadImagePage> {
  Image? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          color: kcMedBeige,
          child: Column(
            children: [
              CustomButton(
                duration: const Duration(milliseconds: 200),
                onTap: () async {
                  img = await onTap();
                  setState(() {});
                },
              ),
              img ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Image> onTap() async {
  final DatabaseManager dbm = await DatabaseManager.init();

  Results? res = await dbm.select(
    table: 'recipes',
    fields: ['picture'],
    where: {'title': 't'},
  );

  var blob = res!.first['picture'].toString();

  Uint8List image = const Base64Codec().decode(blob);

  return Image.memory(image);
}

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

class LoadImagePage extends HookConsumerWidget {
  static const String id = '/img';

  LoadImagePage({Key? key}) : super(key: key);

  Image? img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onTap: () {
                  onTap(img);
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

void onTap(Image? img) async {
  final DatabaseManager dbm = await DatabaseManager.init();

  Results? res = await dbm.select(
    table: 'members',
    fields: ['profile_picture'],
    where: {'username': 'photo'},
  );

  var blob = res!.first['profile_picture'];

  // print(blob.runtimeType);

  // var temp = base64.decode(blob.join(""));

  // print(temp);

  Uint8List image = Base64Codec().decode(blob);

  img = Image.memory(image);
}

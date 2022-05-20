import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookbook/controllers/image_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

import '../../components/components.dart';
import '../../db/database_manager.dart';
import '../../models/member/member.dart';
import '../../theme/colors.dart';
import 'admin_page.dart';

class UserInfo extends HookConsumerWidget {
  final String text;
  final Alignment position;
  final SelectedUserChangeNotifier state;
  late String img64;

  UserInfo({
    required this.text,
    required this.position,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();

    double xSize = 600;
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 20, top: 20, left: 20),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          height: 278,
          width: 600,
          child: Column(
            children: [
              Container(
                height: 40,
                width: xSize,
                alignment: Alignment.topCenter,
                child: Text(
                  state.userName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Container(
                  // color: Color.fromARGB(255, 245, 245, 220),
                  alignment: Alignment.topLeft,
                  child: state.currMember == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            UserInfoField(
                              title: 'Name: ',
                              content: state.userName,
                              controller: nameController,
                              onTap: () {
                                state.currMember?.name = nameController.text;
                              },
                            ),
                            UserInfoField(
                              title: 'Email: ',
                              content: state.email,
                              controller: emailController,
                              onTap: () {
                                state.currMember?.email = emailController.text;
                              },
                            ),
                            CustomButton(
                              showShadow: true,
                              width: 550,
                              child: const Text("Change Image"),
                              duration: const Duration(days: 0),
                              // onTap: () async {
                              //   DatabaseManager dbManager =
                              //       await DatabaseManager.init();
                              //   Member member = state.currMember!;
                              //   print(member.name);
                              //   dbManager.update(
                              //     table: 'members',
                              //     set: {
                              //       'name': member.name,
                              //       'emai': member.email,
                              //       'password': member.password,
                              //       'profile_pic': img64
                              //     },
                              //     where: {'email': state.currMember!.email},
                              //   );
                              // },

                              onTap: () async {
                                _openImagePicker(state);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                              child: CustomButton(
                                color: kcMedBeige,
                                duration: const Duration(milliseconds: 100),
                                onTap: () async {
                                  if (state.file == null) {
                                    ByteData bytes = await rootBundle
                                        .load('assets/images/ph.png');
                                    Uint8List photobytes = bytes.buffer
                                        .asUint8List(bytes.offsetInBytes,
                                            bytes.lengthInBytes);

                                    img64 = base64Encode(photobytes);
                                  } else {
                                    final bytes = state.file?.readAsBytesSync();
                                    img64 = base64Encode(bytes!);
                                  }
                                  DatabaseManager dbManager =
                                      await DatabaseManager.init();
                                  Member member = state.currMember!;
                                  print(member.name);
                                  if (state.file != null) {
                                    dbManager.update(
                                      table: 'members',
                                      set: {
                                        'username': member.name,
                                        'email': member.email,
                                        'password': member.password,
                                        'profile_pic': img64,
                                      },
                                      where: {'email': state.currMember!.email},
                                    );
                                  } else {
                                    dbManager.update(
                                      table: 'members',
                                      set: {
                                        'username': member.name,
                                        'email': member.email,
                                        'password': member.password,
                                      },
                                      where: {'email': state.currMember!.email},
                                    );
                                  }
                                },
                                child: const Text(
                                  'Apply',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoField extends HookConsumerWidget {
  final String title, content;
  final VoidCallback onTap;
  final DatabaseManager dbManager = DatabaseManager();
  final TextEditingController controller;

  UserInfoField({
    required this.title,
    required this.content,
    required this.onTap,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 40,
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 5),
              color: kcMedBeige,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Expanded(
                    child: CustomTextField(
                      controller: controller,
                      height: 15,
                      width: 230,
                      isShadow: false,
                      backgroundColor: Colors.transparent,
                      hintText: content,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              color: kcMedBeige,
              width: 100,
              height: 40,
              child: InkWell(
                onTap: () => onTap(),
                child: const Center(
                  child: Text('Save'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _openImagePicker(SelectedUserChangeNotifier state) async {
  final typeGroup = XTypeGroup(
    label: 'images',
    extensions: const ['jpg', 'jpeg', 'png', 'heic'],
  );

  final xFile = await openFile(acceptedTypeGroups: [typeGroup]);
  state.text = xFile?.name;

  File file = File(xFile!.path); //TODO add null check
  state.path = file;
  Blob blob = Blob.fromBytes(await file.readAsBytes());
  state.photo = blob;
}

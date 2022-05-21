import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/messages/inbox_widget.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import 'admin_page.dart';

class UserInfo extends HookConsumerWidget {
  final String text;
  final SelectedUserChangeNotifier state;
  late String img64;

  UserInfo({
    required this.text,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            state.currMember != null
                ? ProfilePic(
                    height: 100,
                    member: state.currMember!,
                  )
                : const SizedBox(),
            SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  state.userName,
                  style: ksFormHeadlineStyle,
                ),
              ),
            ),
            Container(
              child: state.currMember == null
                  ? const Center(
                      child: Text(
                      'No User Selected',
                      style: ksFormHeadlineStyle,
                    ))
                  : Column(
                      children: [
                        UserInfoField(
                          title: 'Name',
                          content: state.userName,
                          controller: nameController,
                          onTap: () {
                            state.currMember?.name = nameController.text;
                          },
                        ),
                        UserInfoField(
                          title: 'Email',
                          content: state.email,
                          controller: emailController,
                          onTap: () {
                            state.currMember?.email = emailController.text;
                          },
                        ),
                        CustomButton(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: size.width,
                          color: Colors.transparent,
                          showShadow: true,
                          border: Border.all(
                            width: .5,
                            color: Colors.black,
                          ),
                          child: const Text("Change Image"),
                          duration: const Duration(days: 0),
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
                                Uint8List photobytes = bytes.buffer.asUint8List(
                                    bytes.offsetInBytes, bytes.lengthInBytes);

                                img64 = base64Encode(photobytes);
                              } else {
                                final bytes = state.file?.readAsBytesSync();
                                img64 = base64Encode(bytes!);
                              }
                              DatabaseManager dbManager =
                                  await DatabaseManager.init();
                              Member member = state.currMember!;

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
            )
          ],
        ),
      ),
    );
  }
}

class EditingNotifier extends ChangeNotifier {
  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool val) {
    _isEditing = val;
    notifyListeners();
  }
}

// final isEditingProvider = StateProvider((ref) => false);

class UserInfoField extends HookConsumerWidget {
  final String title, content;
  final VoidCallback onTap;
  // final DatabaseManager dbManager = DatabaseManager();
  final TextEditingController controller;

  final isEditingProvider = ChangeNotifierProvider<EditingNotifier>(
    (ref) => EditingNotifier(),
  );

  UserInfoField({
    required this.title,
    required this.content,
    required this.onTap,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                // color: kcMedBeige,
                // borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: .5,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
              margin: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(title, style: ksTitleButtonStyle),
                    ),
                  ),
                  Expanded(
                    child: ref.watch(isEditingProvider).isEditing
                        ? CustomTextField(
                            backgroundColor: Colors.transparent,
                            margin: const EdgeInsets.only(right: 5),
                            isShadow: false,
                            hintText: 'email',
                            focusNode: focusNode,
                            // border: Border.all(
                            //   width: .5,
                            //   color: Colors.black,
                            //   style: BorderStyle.solid,
                            // ),
                            onChanged: (value) {
                              // state.filteringString = value;
                            },
                            onClickSuffix: () {
                              // tec.clear();
                              // state.filteringString = ''; //  Fix (x) Button
                            },
                            // controller: tec,
                            width: 300,
                            height: 200,
                            // borderRadius: const BorderRadius.all(Radius.circular(5)),
                          )
                        : SelectableText(content),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 70,
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              // color: kcMedBeige,
              border: Border.all(
                width: .5,
                color: Colors.black,
              ),
            ),
            child: ref.watch(isEditingProvider).isEditing
                ? InkWell(
                    onTap: () => onTap(),
                    child: const Center(
                      child: Text('Save'),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      focusNode.requestFocus();
                      ref.watch(isEditingProvider).isEditing = true;
                    },
                    child: const Center(
                      child: Text('Edit'),
                    ),
                  ),
          ),
          ref.watch(isEditingProvider).isEditing
              ? Container(
                  width: 70,
                  height: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    // color: kcMedBeige,
                    border: Border.all(
                      width: .5,
                      color: Colors.black,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => ref.watch(isEditingProvider).isEditing = false,
                    child: const Center(
                      child: Text('Cancel'),
                    ),
                  ))
              : const SizedBox(),
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

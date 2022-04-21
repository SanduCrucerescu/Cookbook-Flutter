import 'dart:io';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/userPage/profile_widget.dart';
import 'package:cookbook/pages/userPage/user_preferences.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import 'package:mysql1/mysql1.dart';
import '../register/register.dart';

class UserPage extends StatefulWidget {
  static const String id = '/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const user = UserPreferences.myUser;

    return CustomPage(
      child: Container(
        color: kcLightBeige,
        width: size.width - 200,
        height: size.height - 100,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {},
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 250, vertical: 35),
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: user.name,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 250, vertical: 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: user.email,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 250, vertical: 35),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'click to change password',
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _openImagePicker(VerificationChangeNotifier state) async {
  final typeGroup = XTypeGroup(
    label: 'images',
    extensions: const ['jpg', 'jpeg', 'png', 'heic'],
  );

  final xFile = await openFile(acceptedTypeGroups: [typeGroup]);
  if (xFile != null) {
    state.photoSuccessful = true;
    state.text = xFile.name;

    File file = File(xFile.path);
    state.path = file;
    Blob blob = Blob.fromBytes(await file.readAsBytes());
    state.photo = blob;
  }
}

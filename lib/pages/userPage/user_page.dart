import 'dart:io';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/userPage/profile_widget.dart';
import 'package:cookbook/pages/userPage/user.dart';
import 'package:cookbook/pages/userPage/user_preferences.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
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
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {},
              ),
            ),
            const UserPageForm(user: user)
          ],
        ),
      ),
    );
  }
}

class UserPageForm extends StatelessWidget {
  const UserPageForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserPageTextField(
          size: size,
          user: user,
          hintText: user.name,
          label: "Name",
        ),
        UserPageTextField(
          size: size,
          user: user,
          hintText: user.email,
          label: "Email",
        ),
        UserPageTextField(
          size: size,
          user: user,
          hintText: '**************',
          label: "Password",
        ),
      ],
    );
  }
}

class UserPageTextField extends StatelessWidget {
  final String hintText, label;

  const UserPageTextField({
    Key? key,
    required this.hintText,
    required this.size,
    required this.user,
    this.label = '',
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SelectableText(
              label,
              style: ksLabelTextStyle,
            ),
          ),
          CustomTextField(
            backgroundColor: Colors.transparent,
            isShadow: false,
            width: size.width,
            inputDecoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
          const SizedBox(height: 20),
        ],
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

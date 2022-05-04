import 'dart:io';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/register/register.dart';
import 'package:cookbook/pages/userPage/profile_widget.dart';
import 'package:cookbook/pages/userPage/user.dart';
import 'package:cookbook/pages/userPage/user_preferences.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:mysql1/mysql1.dart';

class UserPage extends ConsumerWidget {
  static const String id = '/user';
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserPageState();
  }
}

class UserPageState extends HookConsumerWidget {
  final photoProvider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  late String img64;

  UserPageState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(photoProvider);
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
                onClicked: () async {
                  _openImagePicker(state);
                },
              ),
            ),
            const UserPageForm(user: user),
          ],
        ),
      ),
    );
  }

//todo: The photo picker and changer are yet to be implemented
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
}

//todo: The photo picker and changer are yet to be implemented
class VerificationChangeNotifier extends ChangeNotifier {
  bool _photoSuccessful = false;
  bool _wrongData = false;
  String _wrongDataText = "";
  String _text = "";
  late Blob _photo;
  File? _xFile;

  bool get photoSuccessful => _photoSuccessful;

  bool get wrongData => _wrongData;

  String get wrongDataText => _wrongDataText;

  String get text => _text;

  File? get file => _xFile;

  Blob get photo => _photo;

  set photoSuccessful(bool val) {
    _photoSuccessful = val;
    notifyListeners();
  }

  set wrongData(bool val) {
    _wrongData = val;
    notifyListeners();
  }

  set wrongDataText(String txt) {
    _wrongDataText = txt;
    notifyListeners();
  }

  set text(String val) {
    _text = val;
    notifyListeners();
  }

  set photo(Blob file) {
    _photo = file;
    notifyListeners();
  }

  set path(File? path) {
    _xFile = path;
    notifyListeners();
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
        Center(child: buildSaveButton())
      ],
    );
  }

  Widget buildSaveButton() => SaveButton(
        text: 'Save Changes',
        onClicked: () {},
      );
}

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const SaveButton({Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.black,
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class UserPageTextField extends StatelessWidget {
  final String hintText, label;
  final Size size;
  final User user;

  const UserPageTextField({
    Key? key,
    required this.hintText,
    required this.size,
    required this.user,
    this.label = '',
  }) : super(key: key);

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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            backgroundColor: Colors.transparent,
            isShadow: false,
            width: size.width,
            onChanged: (user) {},
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

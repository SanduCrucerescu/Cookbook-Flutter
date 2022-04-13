import 'dart:io';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/addUser.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'package:mysql1/mysql1.dart';

class RegisterPage extends ConsumerWidget {
  static const String id = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            addBackgroundImage(size),
            RegisterForm(),
          ],
        ),
      ),
    );
  }

  SizedBox addBackgroundImage(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Image.asset(
        "assets/images/bg1.png",
        fit: BoxFit.fill,
      ),
    );
  }
}

class RegisterForm extends HookConsumerWidget {
  RegisterForm({Key? key}) : super(key: key);

  final photoProvider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(photoProvider);
    final List<Map<String, dynamic>> fields = [
      {"text": "Name", "password": false},
      {"text": "Email", "password": false},
      {"text": "Password", "password": true},
      {"text": "Confirm password", "password": true},
    ];

    return Center(
      child: Container(
        height: 600,
        width: 500,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: .5, style: BorderStyle.solid),
            boxShadow: ksStandardBoxShadow,
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              "R E G I S T E R",
              style: GoogleFonts.montserrat(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(fields.length, (int idx) {
              final Map<String, dynamic> field = fields[idx];

              field["controller"] = useTextEditingController();

              return CustomTextField(
                width: 350,
                height: 60,
                margin: const EdgeInsets.all(10),
                hintText: field["text"],
                controller: field["controller"],
                obscureText: field["password"],
              );
            }),
            const SizedBox(height: 20),
            state.photoSuccessful
                ? Center(
                    child: SelectableText(
                      "Photo added: " + state.text,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
            const SizedBox(height: 10),
            FormButton(
                color: kcMedBeige,
                onTap: () {
                  _openImagePicker(state);
                },
                text: "A d d  P h o t o"),
            const SizedBox(height: 10),
            FormButton(
              color: kcMedBeige,
              onTap: () async {
                //Navigator.of(context).pushNamed(RegisterPage.id);

                TextEditingController email = fields[1]['controller'];
                TextEditingController pass = fields[2]['controller'];
                TextEditingController username = fields[0]['controller'];

                String photo = "LOAD_FILE('${state.path}')";

                bool register = await AddUser.adding(userInfo: {
                  "email": email.text,
                  "password": pass.text,
                  "username": username.text,
                  "profile_picture": photo
                });

                if (register) {
                  print("object");
                } else {
                  print("no");
                }
              },
              text: "R e g i s t e r",
            ),
            const SizedBox(height: 10),
            FormButton(
              showShadow: false,
              color: Colors.white,
              onTap: () {
                Navigator.of(context).pop();
              },
              text: "C a n c e l",
            ),
          ],
        ),
      ),
    );
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
      state.path = xFile.path;
      Blob blob = Blob.fromBytes(await xFile.readAsBytes());
      state.photo = blob;
    }
  }
}

class VerificationChangeNotifier extends ChangeNotifier {
  bool _photoSuccessful = false;
  String _text = "";
  late Blob _photo;
  late String _xFile;

  bool get photoSuccessful => _photoSuccessful;

  String get text => _text;

  Blob get photo => _photo;

  String get path => _xFile;

  set photoSuccessful(bool val) {
    _photoSuccessful = val;
    notifyListeners();
  }

  set text(String val) {
    _text = val;
    notifyListeners();
  }

  set photo(Blob file) {
    _photo = file;
  }

  set path(String path) {
    _xFile = path;
  }
}

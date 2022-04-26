import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/add_user.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_selector/file_selector.dart';
import 'package:mysql1/mysql1.dart';
import 'package:email_validator/email_validator.dart';

import '../home/home_page.dart';

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
  final bool showShadow;

  RegisterForm({this.showShadow = true, Key? key}) : super(key: key);

  final photoProvider = ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );
  bool _isValid = false;
  late String img64;

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
        height: 650,
        width: 500,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: .5, style: BorderStyle.solid),
            boxShadow: showShadow ? ksStandardBoxShadow : null,
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SelectableText(
              "R E G I S T E R",
              style: ksFormHeadlineStyle,
            ),
            const SizedBox(height: 20),
            ...List.generate(fields.length, (int idx) {
              final Map<String, dynamic> field = fields[idx];

              field["controller"] = useTextEditingController();

              return CustomTextField(
                maxLines: 1,
                width: 350,
                height: 60,
                margin: const EdgeInsets.all(10),
                hintText: field["text"],
                controller: field["controller"],
                obscureText: field["password"],
              );
            }),
            const SizedBox(height: 20),
            state.wrongData
                ? Center(
                    child: SelectableText(
                      state.wrongDataText,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),
            const SizedBox(height: 10),
            state.photoSuccessful
                ? Center(
                    child: SelectableText(
                      "Photo added: " + state.text,
                      style: ksFormButtonStyle,
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
                TextEditingController email = fields[1]['controller'];
                TextEditingController pass = fields[2]['controller'];
                TextEditingController passConf = fields[3]['controller'];
                TextEditingController username = fields[0]['controller'];

                _isValid = EmailValidator.validate(email.text);
                if (_isValid) {
                  if (pass.text != passConf.text) {
                    state.wrongData = true;
                    state.wrongDataText = "Passwords do not mach";
                    log(state.wrongDataText);
                  } else {
                    if (state.file == null) {
                      ByteData bytes =
                          await rootBundle.load('assets/images/ph.png');
                      Uint8List photobytes = bytes.buffer.asUint8List(
                          bytes.offsetInBytes, bytes.lengthInBytes);

                      img64 = base64Encode(photobytes);
                    } else {
                      final bytes = state.file?.readAsBytesSync();
                      img64 = base64Encode(bytes!);
                    }
                    bool register = await AddUser.adding(
                      userInfo: {
                        "email": email.text,
                        "password": pass.text,
                        "username": username.text,
                        "profile_pic": img64,
                      },
                    );
                    if (register) {
                      Navigator.of(context).pushNamed(HomePage.id);
                    } else {
                      print("registring unsucessful");
                    }
                  }
                } else {
                  state.wrongData = true;
                  state.wrongDataText =
                      "Passwords dont mach or insert a valid email";
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

      File file = File(xFile.path);
      state.path = file;
      Blob blob = Blob.fromBytes(await file.readAsBytes());
      state.photo = blob;
    }
  }
}

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

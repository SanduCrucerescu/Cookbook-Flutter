import 'dart:developer';
import 'dart:math' as math;
import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/admin/user_info.dart';
import 'package:cookbook/pages/home/home_page.dart';
import 'package:cookbook/pages/register/register.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
  static const String id = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildBackgroundImage(size),
            LoginForm(),
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage(Size size) {
    return RotatedBox(
      quarterTurns: 0,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.asset(
          "assets/images/bg1.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class LoginForm extends HookConsumerWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final verificationProvider =
      ChangeNotifierProvider<VerificationChangeNotifier>(
    (ref) => VerificationChangeNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationProvider);

    final TextEditingController tec1 = useTextEditingController();
    tec1.text = "abolandr@gnu.org";
    final TextEditingController tec2 = useTextEditingController();
    tec2.text = "xbsxysKe53";
    return Center(
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: .5,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
          boxShadow: ksStandardBoxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: SelectableText(
                  "C o o k b o o k",
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 350,
              child: CustomTextField(
                margin: const EdgeInsets.only(bottom: 10),
                controller: tec1,
              ),
            ),
            SizedBox(
              width: 350,
              height: 70,
              child: CustomTextField(
                margin: const EdgeInsets.only(top: 10),
                controller: tec2,
                obscureText: true,
              ),
            ),
            state.loginUnSuccessful
                ? Center(
                    child: SelectableText(
                      state.text,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  FormButton(
                    color: kcMedBeige,
                    text: "L o g i n",
                    onTap: () async {
                      bool isValid = await Validator().validate(
                        userInfo: {"email": tec1.text, "password": tec2.text},
                      );

                      if (isValid == true) {
                        Navigator.of(context).pushNamed(HomePage.id);
                      } else {
                        state.loginUnSuccessful = true;
                        state.text = "* login unsuccessfull";
                        log("Login unsuccessfull");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FormButton(
                    showShadow: false,
                    color: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushNamed(RegisterPage.id);
                    },
                    text: "R e g i s t e r",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationChangeNotifier extends ChangeNotifier {
  bool _loginUnSuccessful = false;
  String _text = "";

  bool get loginUnSuccessful => _loginUnSuccessful;

  String get text => _text;

  set loginUnSuccessful(bool val) {
    _loginUnSuccessful = val;
    notifyListeners();
  }

  set text(String val) {
    _text = val;
    notifyListeners();
  }
}

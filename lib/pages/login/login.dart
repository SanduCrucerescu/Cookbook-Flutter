import 'dart:developer';
import 'package:cookbook/components/ui_components.dart';
import 'package:cookbook/controllers/verification.dart';
import 'package:cookbook/pages/home/home_page.dart';
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
            const LoginForm(),
          ],
        ),
      ),
    );
  }

  SizedBox buildBackgroundImage(Size size) {
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

class LoginForm extends HookConsumerWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController tec1 = useTextEditingController();
    final TextEditingController tec2 = useTextEditingController();

    return Center(
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, width: .5, style: BorderStyle.solid),
          color: Colors.white,
          boxShadow: ksStandardBoxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: SelectableText(
                  "C o o k b o o k",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
                  controller: tec1,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(top: 10),
                  controller: tec2,
                  obscureText: true,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: LoginButton(
                tec1: tec1,
                tec2: tec2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.tec1,
    required this.tec2,
  }) : super(key: key);

  final TextEditingController tec1;
  final TextEditingController tec2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 200,
        child: CustomButton(
          duration: const Duration(milliseconds: 200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 0,
              spreadRadius: .5,
              offset: const Offset(3, 3),
            ),
          ],
          onTap: () {
            Future<bool> isValid = Validator.validate(
              userInfo: {"email": tec1.text, "password": tec2.text},
            );

            if (isValid == true) {
              Navigator.of(context).pushNamed(HomePage.id);
            } else {
              log("Login unsuccessfull");
            }
          },
          child: const Text(
            "L O G I N",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/components.dart';

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
            const RegisterForm(),
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
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> fields = [
      {
        "text": "Name",
        "password": false,
      },
      {
        "text": "Email",
        "password": false,
      },
      {
        "text": "Password",
        "password": true,
      },
      {
        "text": "Confirm password",
        "password": true,
      },
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
            FormButton(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterPage.id);
              },
              text: "R e g i s t e r",
            ),
            const SizedBox(height: 10),
            FormButton(
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
}

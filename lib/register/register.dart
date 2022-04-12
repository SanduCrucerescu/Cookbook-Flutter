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
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController name = useTextEditingController();
    final TextEditingController email = useTextEditingController();
    final TextEditingController password = useTextEditingController();
    final TextEditingController confirmPassword = useTextEditingController();

    return Center(
      child: Container(
        height: 600,
        width: 500,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: .5, style: BorderStyle.solid),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SelectableText(
                "R E G I S T E R",
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
                  hintText: "Name",
                  controller: name,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
                  hintText: "Email",
                  controller: email,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
                  hintText: "Password",
                  controller: password,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
                  hintText: "Confirm Password",
                  controller: confirmPassword,
                ),
              ),
            ),
            const Expanded(
              child: RegisterButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 140,
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
            Navigator.of(context).pushNamed(RegisterPage.id);
          },
          child: const Text(
            "R E G I S T E R",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
      ),
    );
  }
}

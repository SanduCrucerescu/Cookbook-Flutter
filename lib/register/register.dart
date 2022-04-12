import 'package:cookbook/components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController name = useTextEditingController();
    final TextEditingController email = useTextEditingController();
    final TextEditingController password = useTextEditingController();
    final TextEditingController confirmPassword = useTextEditingController();

    return Center(
      child: Container(
        height: 500,
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
              child: SizedBox(
                width: 350,
                child: CustomTextField(
                  margin: const EdgeInsets.only(bottom: 10),
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
                  controller: confirmPassword,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

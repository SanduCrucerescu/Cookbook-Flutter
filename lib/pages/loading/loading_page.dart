import 'dart:async';
import 'dart:developer';
import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "/loading";
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchRecipes();
      InheritedLoginProvider.of(context).setDisplayedRecipes(
        filteringStrings: [''],
        filterOption: 'title',
      );
      Navigator.of(context).pushNamed(LoginPage.id);
    });
    super.initState();
  }

  Future<void> fetchRecipes() async {
    GetRecepies getrecepies = GetRecepies();
    final loginProvider = InheritedLoginProvider.of(context);
    await getrecepies.getrecep(limit: [loginProvider.currOffset, 9]);
    loginProvider.currOffset += 9;
    loginProvider.recipes = getrecepies.recepieList;
    loginProvider.resetDisplayedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/bg4.png",
            fit: BoxFit.fill,
          ),
          const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: progressIndicator,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Maybe text?
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      height: 45,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      width: size.width,
                      child: Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Welcome to our shit cookbook app',
                              speed: const Duration(milliseconds: 100),
                              textStyle: const TextStyle(
                                fontFamily: "Elianto",
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

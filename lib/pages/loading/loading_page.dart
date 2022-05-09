import 'dart:async';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "/loading";

  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushNamed(LoginPage.id),
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await fetchRecipes();
      InheritedLoginProvider.of(context).setDisplayedRecipes('');
    });
  }

  Future<void> fetchRecipes() async {
    GetRecepies getrecepies = GetRecepies();
    await getrecepies.getrecep();
    InheritedLoginProvider.of(context).recipes = getrecepies.recepieList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/bg1.png",
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: size.height / 8,
            child: SizedBox(
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
                  children: const <Widget>[
                    RefreshProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                    // Some space so it is not crowded
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    // Placeholder
                    Text(
                      "hallo",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black),
                    )
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

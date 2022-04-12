import 'dart:async';

import 'package:flutter/material.dart';
import '../login/login.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "/loading";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.of(context).pushNamed(LoginPage.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/images/bg1.png", fit: BoxFit.fill),
          Center(
          child: Padding(
            padding: EdgeInsets.only(top:200.0),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Welcome to our shit cookbook app',speed: Duration(milliseconds: 0100),
                    textStyle: const TextStyle(fontFamily: "Elianto", fontSize: 40)),
              ],
            ),
          ),),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Maybe text?
                    Image.asset("assets/images/LogoLogin.png")
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

import 'dart:async';
import 'package:cookbook/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "/loading";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            () => Navigator.of(context).pushNamed(HomePage.id)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}


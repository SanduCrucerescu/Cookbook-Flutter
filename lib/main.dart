import 'package:cookbook/controllers/routes.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cookbook',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: kcPrimaryGreen,
      ),
      initialRoute: LoginPage.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

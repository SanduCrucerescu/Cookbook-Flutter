<<<<<<< HEAD
part of controllers;
=======
import 'package:cookbook/pages/adminPage/adminpage.dart';
import 'package:cookbook/pages/home/home_page.dart';
import 'package:cookbook/pages/loadimage/load_image.dart';
import 'package:cookbook/pages/loading/loading_page.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:cookbook/pages/recipeadd/recipe_add.dart';
import 'package:cookbook/pages/register/register.dart';
import 'package:flutter/material.dart';
>>>>>>> 02a8a94 (Add recipe UI ~80% done)

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => ResponsiveHomePageBuilder(),
        );
      case '/login':
        // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/loading':
        return MaterialPageRoute(
          builder: (_) => const LoadingScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      case '/admin':
        return MaterialPageRoute(
          builder: (_) => Admin(),
        );
      case '/messages':
        return MaterialPageRoute(
          builder: (_) => MessagePage(),
        );
      case '/img':
        return MaterialPageRoute(
          builder: (_) => LoadImagePage(),
        );
      case '/addrecipe':
        return MaterialPageRoute(
          builder: (_) => Recipe_Add(),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

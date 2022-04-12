import 'package:cookbook/pages/adminPage/adminpage.dart';
import 'package:cookbook/pages/home/home_page.dart';
import 'package:cookbook/pages/loading/loading_page.dart';
import 'package:cookbook/pages/login/login.dart';
import 'package:cookbook/main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case '/admin':
        return MaterialPageRoute(
          builder: (_) => const Admin(),
        );
      case '/loading':
        return MaterialPageRoute(
          builder: (_) => LoadingScreen(),
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

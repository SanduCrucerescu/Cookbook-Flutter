part of controllers;

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
          builder: (_) => const LoginPage(),
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
          builder: (_) => const MessagePage(),
        );
      case '/img':
        return MaterialPageRoute(
          builder: (_) => LoadImagePage(),
        );
      case '/addrecipe':
        return MaterialPageRoute(
          builder: (_) => AddRecipePage(),
        );
      case '/faq':
        return MaterialPageRoute(
          builder: (_) => FAQPage(),
        );
      case '/weeklypage':
        return MaterialPageRoute(
          builder: (_) => ResponsiveWeeklyPageBuilder(),
        );
      case '/user':
        return MaterialPageRoute(
          builder: (_) => const UserPage(),
        );
      case '/cart':
        return MaterialPageRoute(
          builder: (_) => ShoppingPage(),
        );
      case '/favorites':
        return MaterialPageRoute(
          builder: (_) => ResponsiveFavoritesPage(),
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

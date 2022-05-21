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
          builder: (_) => const LoadingScreenWrapper(),
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
      case '/comments':
        return MaterialPageRoute(
          builder: (_) => CommentsPage(
            recipe: Recipe(
                id: 2,
                ownerEmail: 'mchildrens3@blogtalkradio.com',
                title: 'Quick & easy tiramisu',
                longDescription:
                    'Condensed milk is the secret to this super snappy Italian dessert. Coffee and chocolate are a classic combo, simply layer them up and enjoy',
                shortDescription:
                    'Condensed milk is the secret to this super snappy Italian dessert. Coffee and chocolate are a classic combo, simply layer them up and enjoy',
                instructions:
                    'STEP 1: Mix the coffee granules with 2 tbsp boiling water in a large jug and stir to combine. Add the coffee liqueur and 75ml cold water. Pour into a shallow dish and set aside. STEP 2: Make the cream layer by beating the mascarpone, condensed milk and vanilla extract with an electric whisk until thick and smooth. STEP 3: Break the sponge fingers into two or three pieces and soak in the coffee mixture for a few secs. Put a few bits of the sponge in the bottom of two wine or sundae glasses and top with the cream. Sift over the cocoa and chill for at least 1 hr before serving.',
                quantity: 1,
                ingredients: [],
                picture: Blob.fromBytes([]),
                tags: []),
          ),
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

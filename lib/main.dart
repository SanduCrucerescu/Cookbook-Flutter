import 'dart:developer';
import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'pages/loading/loading_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class InheritedLoginProviderWrapper extends StatefulWidget {
  final Widget child;
  const InheritedLoginProviderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<InheritedLoginProviderWrapper> createState() =>
      _InheritedLoginProviderWrapperState();
}

class _InheritedLoginProviderWrapperState
    extends State<InheritedLoginProviderWrapper> {
  Map<String?, dynamic>? userData;
  bool isLoggedIn = false;
  int _pageId = 0;
  List<Recipe> _recipes = [];
  List<Recipe> _displayedRecipes = [];

  int get pageId => _pageId;
  List<Recipe> get recipes => _recipes;

  List<Recipe> get displayedRecipes {
    log('getting displayed recipes');
    return _displayedRecipes;
  }

  set pageId(int val) {
    setState(() {
      _pageId = val;
    });
  }

  void setDisplayedRecipes(String filterinString) {
    log('setting displayed recipes with: "$filterinString"');
    _displayedRecipes = [];
    for (Recipe r in recipes) {
      if (r.title.toUpperCase().startsWith(filterinString.toUpperCase())) {
        log(r.title);
        _displayedRecipes.add(r);
      }
    }
    setState(() {});
  }

  set recipes(List<Recipe> newRecipes) {
    setState(() {
      _recipes = newRecipes;
    });
  }

  set displayedRecipes(List<Recipe> newRecipes) {
    setState(() {
      _displayedRecipes = newRecipes;
    });
  }

  void setIsLoggedIn(bool val, Map<String?, dynamic> newUserData) {
    setState(() {
      isLoggedIn = val;
      userData = newUserData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedLoginProvider(
      child: widget.child,
      data: this,
      isLoggedIn: isLoggedIn,
      recipes: recipes,
      displayedRecipes: displayedRecipes,
    );
  }
}

class InheritedLoginProvider extends InheritedWidget {
  final bool isLoggedIn;
  final Widget child;
  final _InheritedLoginProviderWrapperState data;
  final List<Recipe> recipes, displayedRecipes;

  const InheritedLoginProvider({
    required this.recipes,
    required this.displayedRecipes,
    required this.data,
    required this.isLoggedIn,
    required this.child,
    Key? key,
  }) : super(key: key, child: child);

  static _InheritedLoginProviderWrapperState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedLoginProvider>()!
        .data;
  }

  @override
  bool updateShouldNotify(covariant InheritedLoginProvider oldWidget) {
    return isLoggedIn != oldWidget.isLoggedIn ||
        displayedRecipes != oldWidget.displayedRecipes;
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedLoginProviderWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'cookbook',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kcLightBeige,
            surface: kcMedBeige,
            brightness: Brightness.light,
          ),
          fontFamily: 'Montserrat',
          primaryColor: kcMedBeige,
        ),
        initialRoute: UserPage.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

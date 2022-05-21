import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/home/home_page.dart';
import 'package:cookbook/pages/loading/loading_page.dart';
import 'package:cookbook/pages/shoppingCart/shopping_page.dart';
import 'package:cookbook/pages/weeklyPage/weeklyPage.dart';
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

final pageIdProvider = StateProvider<int>((ref) => 0);

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
  List<Recipe> _recipes = [];
  List<Recipe> _displayedRecipes = [];

  List<Recipe> get recipes => _recipes;

  List<Recipe> get displayedRecipes {
    return _displayedRecipes;
  }

  void setDisplayedRecipes(String filterinString) {
    _displayedRecipes = [];
    for (Recipe r in recipes) {
      if (r.title.toUpperCase().startsWith(filterinString.toUpperCase())) {
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

  @override
  Widget build(BuildContext context) {
    return InheritedLoginProvider(
      data: this,
      child: widget.child,
      userData: userData,
      recipes: recipes,
      displayedRecipes: displayedRecipes,
    );
  }
}

class InheritedLoginProvider extends InheritedWidget {
  final Widget child;
  final _InheritedLoginProviderWrapperState data;
  final Map<String?, dynamic>? userData;
  final List<Recipe> recipes, displayedRecipes;

  const InheritedLoginProvider({
    required this.userData,
    required this.recipes,
    required this.displayedRecipes,
    required this.data,
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
    return displayedRecipes != oldWidget.displayedRecipes ||
        userData != oldWidget.userData ||
        recipes != oldWidget.recipes;
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
        initialRoute: LoadingScreenWrapper.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

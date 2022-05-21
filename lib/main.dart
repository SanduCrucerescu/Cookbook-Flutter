import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/models/tag/tag.dart';
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
  Member? member;
  List<Recipe> _recipes = [];
  List<Recipe> _displayedRecipes = [];
  List<Recipe> _favorites = [];
  List<Recipe> get recipes => _recipes;
  List<Recipe> get favorites => _favorites;
  List<Recipe> get displayedRecipes => _displayedRecipes;

  void setDisplayedRecipes({
    required String filteringString,
    required String filterOption,
  }) {
    _displayedRecipes = [];

    switch (filterOption.toUpperCase()) {
      case 'TITLE':
        if (filteringString == '') {
          _displayedRecipes = recipes;
          break;
        }
        for (Recipe r in recipes) {
          if (r.title.toUpperCase().startsWith(filteringString.toUpperCase())) {
            _displayedRecipes.add(r);
          }
        }
        break;
      case 'INGREDIENTS':
        if (filteringString == '') {
          _displayedRecipes = recipes;
          break;
        }
        for (Recipe r in recipes) {
          for (Ingredient ingr in r.ingredients) {
            if (ingr.name
                .toUpperCase()
                .startsWith(filteringString.toUpperCase())) {
              _displayedRecipes.add(r);
            }
          }
        }
        break;
      case 'TAGS':
        if (filteringString == '') {
          _displayedRecipes = recipes;
          break;
        }
        for (Recipe r in recipes) {
          for (Tag tag in r.tags) {
            if (tag.name
                .toUpperCase()
                .startsWith(filteringString.toUpperCase())) {
              _displayedRecipes.add(r);
            }
          }
        }
        break;
    }

    setState(() {});
  }

  set recipes(List<Recipe> newRecipes) {
    setState(() {
      _recipes = newRecipes;
    });
  }

  set favorites(List<Recipe> newRecipes) {
    setState(() {
      _favorites = newRecipes;
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
      member: member,
      child: widget.child,
      userData: userData,
      favorites: favorites,
      recipes: recipes,
      displayedRecipes: displayedRecipes,
    );
  }
}

class InheritedLoginProvider extends InheritedWidget {
  final Widget child;
  final Member? member;
  final _InheritedLoginProviderWrapperState data;
  final Map<String?, dynamic>? userData;
  final List<Recipe> recipes, displayedRecipes, favorites;

  const InheritedLoginProvider({
    required this.member,
    required this.userData,
    required this.recipes,
    required this.displayedRecipes,
    required this.data,
    required this.child,
    required this.favorites,
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
        recipes != oldWidget.recipes ||
        favorites != oldWidget.favorites;
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
        initialRoute: LoadingScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

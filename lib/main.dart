import 'package:cookbook/controllers/controllers.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:cookbook/pages/loading/loading_page.dart';
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
  int currOffset = 0;
  Map<String?, dynamic>? userData;
  Member? member;
  List<Recipe> _recipes = [];
  List<Recipe> _displayedRecipes = [];
  List<Recipe> _favorites = [];
  List<Recipe> get recipes => _recipes;
  List<Recipe> get favorites => _favorites;
  List<Recipe> get displayedRecipes => _displayedRecipes;

  void resetDisplayedRecipes() {
    setState(() {
      _displayedRecipes = _recipes;
    });
  }

  void setDisplayedRecipes({
    required List<String> filteringStrings,
    required String filterOption,
  }) {
    _displayedRecipes = [];

    switch (filterOption.toUpperCase()) {
      case 'TITLE':
        if (filteringStrings.isEmpty || filteringStrings[0] == '') {
          for (Recipe r in recipes) {
            _displayedRecipes.add(r);
          }
          break;
        }
        for (Recipe r in recipes) {
          if (r.title
              .toUpperCase()
              .startsWith(filteringStrings[0].toUpperCase())) {
            _displayedRecipes.add(r);
          }
        }
        break;
      case 'INGREDIENTS':
        print('setting ingredients');
        print(filteringStrings);
        if (filteringStrings.isEmpty ||
            (filteringStrings.length == 1 && filteringStrings[0] == '')) {
          for (Recipe r in recipes) {
            _displayedRecipes.add(r);
          }
          break;
        }
        print(displayedRecipes);
        for (Recipe r in recipes) {
          if (filteringStrings.sublist(1).every((e) => r.ingredients
              .map((ingr) => ingr.name.toUpperCase())
              .contains(e.toUpperCase()))) {
            _displayedRecipes.add(r);
          }
        }
        print(_displayedRecipes);
        break;
      case 'TAGS':
        if (filteringStrings.isEmpty ||
            (filteringStrings.length == 1 && filteringStrings[0] == '')) {
          for (Recipe r in recipes) {
            _displayedRecipes.add(r);
          }
          break;
        }
        for (Recipe r in recipes) {
          if (filteringStrings.sublist(1).every((e) => r.tags
              .map((tag) => tag.name.toUpperCase())
              .contains(e.toUpperCase()))) {
            _displayedRecipes.add(r);
          }
        }
        break;
    }

    setState(() {});
  }

  void addRecipes(List<Recipe> newRecipes) {
    setState(() {
      for (Recipe r in newRecipes) {
        _recipes.add(r);
      }
    });
  }

  void addRecipe(Recipe newRecipe) {
    setState(() {
      _recipes.add(newRecipe);
    });
  }

  void removeRecipe(Recipe newRecipe) {
    setState(() {
      _recipes.remove(newRecipe);
    });
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
      currOffset: currOffset,
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
  final int currOffset;

  const InheritedLoginProvider({
    required this.currOffset,
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

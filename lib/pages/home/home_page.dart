import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/get_favorites.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatefulHookConsumerWidget {
  static const String id = "/";
  final int cols;
  final double searchBarWidth;

  const HomePage.desktop({Key? key})
      : cols = 3,
        searchBarWidth = 800,
        super(key: key);

  const HomePage.tablet({Key? key})
      : cols = 2,
        searchBarWidth = 800,
        super(key: key);

  const HomePage.mobile({Key? key})
      : cols = 1,
        searchBarWidth = 300,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final responsiveProvider = ChangeNotifierProvider<ResponsiveNotifier>(
    (ref) => ResponsiveNotifier(),
  );

  final GetFavorites getFavorites = GetFavorites();
<<<<<<< HEAD
<<<<<<< HEAD
  Future<List<Recipe>?>? items;
=======
  Future<List<Recipe>?>? items;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      items = getFavorites.getfav(
        InheritedLoginProvider.of(context).userData?['email'],
      );
    });

    super.initState();
  }
>>>>>>> 85ac6f9 (commi)

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      items = getFavorites.getfav(
        InheritedLoginProvider.of(context).userData?['email'],
      );
    });

    super.initState();
  }

  @override
=======

  @override
>>>>>>> a9cc257 (commi)
  Widget build(BuildContext context) {
    final state = ref.watch(responsiveProvider);
    final tec = useTextEditingController();
    final searchBarWidth = widget.searchBarWidth;

    return CustomPage(
      showSearchBar: true,
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: FutureBuilder(
<<<<<<< HEAD
<<<<<<< HEAD
        future: items,
        builder: (context, snapshot) {
          if (snapshot.hasData || state.recipes == null) {
            state.setRecipeBoxes(
              favorites: snapshot.data as List<Recipe>?,
=======
        future: getFavorites.getfav(
          InheritedLoginProvider.of(context).userData?['email'],
        ),
=======
        future: items,
>>>>>>> 85ac6f9 (commi)
        builder: (context, snapshot) {
          if (snapshot.hasData || state.recipes == null) {
            state.setRecipeBoxes(
<<<<<<< HEAD
              favorites: snapshot.data as List<Recipe>,
>>>>>>> a9cc257 (commi)
=======
              favorites: snapshot.data as List<Recipe>?,
>>>>>>> 85ac6f9 (commi)
              ctx: context,
              displayedRecipes:
                  InheritedLoginProvider.of(context).displayedRecipes,
              cols: widget.cols,
            );
            return SizedBox(
              child: ListView.builder(
                cacheExtent: 50,
                itemCount: state.recipes!.length,
                itemBuilder: (ctx, i) => Container(
                  child: state.recipes![i],
                ),
              ),
            );
          } else {
<<<<<<< HEAD
<<<<<<< HEAD
=======
            getFavorites.getfav(
              InheritedLoginProvider.of(context).userData?['email'],
            );
>>>>>>> a9cc257 (commi)
=======
>>>>>>> 85ac6f9 (commi)
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class ResponsiveNotifier extends ChangeNotifier {
  String _filteringString = '';
  List<Widget>? _recipes;
  int rows = 10;
  int _internalCols = 0;

  int get internalCols => _internalCols;

  String get filteringString => _filteringString;

  set filteringString(String val) {
    _filteringString = val;
    notifyListeners();
  }

  void setRecipeBoxes({
    required List<Recipe>? favorites,
    required BuildContext ctx,
    required List<Recipe> displayedRecipes,
    required int cols,
  }) {
    final List<Widget> _newRecipes = [];
    _internalCols = cols;

    for (int i = 0; i < displayedRecipes.length; i += cols) {
      _newRecipes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            i > displayedRecipes.length ? displayedRecipes.length % cols : cols,
            (idx) => Center(
              child: i + idx < displayedRecipes.length
                  ? RecipeBox(
                      recipe: displayedRecipes[i + idx],
                      isLiked: favorites == null
                          ? true
                          : favorites
                              .map((e) => e.ownerEmail)
                              .contains(displayedRecipes[i + idx].ownerEmail),
                    )
                  : const SizedBox(
                      width: 450,
                    ),
            ),
          ),
        ),
      );
    }
    _recipes = _newRecipes;
  }

  List<Widget>? get recipes {
    log('get _recipes');
    return _recipes;
  }
}

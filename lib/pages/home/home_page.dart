import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/get_favorites.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
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

  GetFavorites getFavorites = GetFavorites();
  Future<List<Recipe>?>? _items;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
  //     _items = getFavorites
  //         .getfav(InheritedLoginProvider.of(context).userData?['email']);
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _items = getFavorites.getfav(
        InheritedLoginProvider.of(context).userData?['email'],
      );
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext contextref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(responsiveProvider);
    final tec = useTextEditingController();
    final searchBarWidth = widget.searchBarWidth;

    return CustomPage(
      showSearchBar: true,
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: FutureBuilder(
        future: getFavorites
            .getfav(InheritedLoginProvider.of(context).userData?['email']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            state.setRecipeBoxes(
              favorites: snapshot.data as List<Recipe>?,
              ctx: context,
              displayedRecipes:
                  InheritedLoginProvider.of(context).displayedRecipes,
              cols: widget.cols,
            );
            return SizedBox(
              width: size.width - 220,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                cacheExtent: 50,
                itemCount: state.recipes.length,
                shrinkWrap: true,
                itemBuilder: (ctx, i) => Container(
                  child: state.recipes[i],
                ),
              ),
            );
          } else {
            getFavorites
                .getfav(InheritedLoginProvider.of(context).userData?['email']);
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
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
  List<Widget> _recipes = [];
  int rows = 10;

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
    _recipes = [];

    for (int i = 0; i < displayedRecipes.length; i += cols) {
      _recipes.add(
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
  }

  List<Widget> get recipes {
    log('get _recipes');
    return _recipes;
  }
}

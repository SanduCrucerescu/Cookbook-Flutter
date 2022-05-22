import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/db/queries/get_favorites.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../main.dart';

class FavoritesPage extends HookConsumerWidget {
  static const String id = '/favorites';
  final int cols;
  final double searchBarWidth;

  FavoritesPage(this.cols, this.searchBarWidth, {Key? key}) : super(key: key);

  FavoritesPage.desktop({Key? key})
      : cols = 3,
        searchBarWidth = 800,
        super(key: key);

  FavoritesPage.tablet({Key? key})
      : cols = 2,
        searchBarWidth = 800,
        super(key: key);

  FavoritesPage.mobile({Key? key})
      : cols = 1,
        searchBarWidth = 300,
        super(key: key);

  final responsivePorvider = ChangeNotifierProvider<ResponsiveNotifier>(
    (ref) => ResponsiveNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(responsivePorvider);
    final tec = useTextEditingController();

    state.setRecipeBoxes(
      ctx: context,
      displayedRecipes: InheritedLoginProvider.of(context).favorites,
      cols: cols,
    );

    return CustomPage(
      showSearchBar: false,
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: SizedBox(
        width: size.width - 220,
        child: state.recipes.isEmpty == false
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                cacheExtent: 50,
                itemCount: state.recipes.length,
                shrinkWrap: true,
                itemBuilder: (ctx, i) => Container(
                  child: state.recipes[i],
                ),
              )
            : const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: progressIndicator,
                ),
              ),
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
    required BuildContext ctx,
    required List<Recipe> displayedRecipes,
    required int cols,
  }) async {
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
                      isLiked: true,
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

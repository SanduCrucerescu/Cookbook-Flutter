import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_favorites.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../main.dart';

class FavoritesPage extends StatefulHookConsumerWidget {
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
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  GetFavorites getFavorites = GetFavorites();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await getFavorites
          .getfav(InheritedLoginProvider.of(context).userData?['email']);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(widget.responsivePorvider);
    final tec = useTextEditingController();

    state.setRecipeBoxes(
      ctx: context,
      displayedRecipes: getFavorites.recepieList ?? [],
      cols: widget.cols,
    );

    return CustomPage(
      showSearchBar: true,
      controller: tec,
      searchBarWidth: widget.searchBarWidth,
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
            : const SizedBox(),
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
            i + cols > displayedRecipes.length
                ? cols - (displayedRecipes.length % cols + 1)
                : cols,
            (idx) => Center(
              child: RecipeBox(
                recipe: displayedRecipes[i + idx],
                isLiked: true,
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

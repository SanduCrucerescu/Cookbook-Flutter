import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  static const String id = "/";
  final int cols;

  HomePage.desktop({Key? key})
      : cols = 3,
        super(key: key);

  HomePage.tablet({Key? key})
      : cols = 2,
        super(key: key);

  HomePage.mobile({Key? key})
      : cols = 1,
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
      displayedRecipes: InheritedLoginProvider.of(context).displayedRecipes,
      cols: cols,
    );

    return CustomPage(
      showSearchBar: true,
      controller: tec,
      child: Container(
        color: kcLightBeige,
        height: size.height - 100,
        width: size.width - 200,
        padding: const EdgeInsets.all(10),
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
      log(i.toString());
      _recipes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            i + cols > displayedRecipes.length
                ? cols - displayedRecipes.length % cols
                : cols,
            (idx) => Center(
              child: RecipeBox(
                recipe: displayedRecipes[i + idx],
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

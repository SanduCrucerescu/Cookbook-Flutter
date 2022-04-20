import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String id = "/";
  final int rows;

  HomePage.desktop({Key? key})
      : rows = 3,
        super(key: key);

  HomePage.tablet({Key? key})
      : rows = 2,
        super(key: key);

  HomePage.mobile({Key? key})
      : rows = 1,
        super(key: key);

  final responsivePorvider = ChangeNotifierProvider<ResponsiveNotifier>(
    (ref) => ResponsiveNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(responsivePorvider);

    if (state.recipes.isEmpty) {
      log('recipes is empty');
      // final recipes = InheritedLoginProvider.of(context).getRecipes();
      state.getRecipesFromInheritedLoginProvider(
        ctx: context,
        allRecipes: InheritedLoginProvider.of(context).recipes,
      );
      log('got recipes');
    }

    // state.checkWidth(size.width);

    log('rebuilding');
    log('${state.recipes}');
    log('${state.recipes.isEmpty}');

    return CustomPage(
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
  int _cols = 3;
  List<Widget> _recipes = [];
  int rows = 10;

  int get cols => _cols;

  void getRecipesFromInheritedLoginProvider({
    required BuildContext ctx,
    required List<Recipe> allRecipes,
  }) async {
    log('getting recipes from inherited login provider');

    // final allRecipes = await InheritedLoginProvider.of(ctx).getRecipes();

    _recipes = [];

    for (int i = 0; i < allRecipes.length; i += cols) {
      log(i.toString());
      _recipes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            i + cols > allRecipes.length
                ? cols - allRecipes.length % cols
                : cols,
            (idx) => Center(
              child: RecipeBox(
                recipe: allRecipes[i + idx],
              ),
            ),
          ),
        ),
      );
      log('$recipes');
    }
  }

  List<Widget> get recipes {
    log('get _recipes');
    return _recipes;
  }

  set cols(int val) {
    _cols = val;
    log('$val');
    notifyListeners();
  }

  void checkWidth(double width) {
    if (width < 1200) {
      cols = 1;
    } else if (width < 1600) {
      cols = 2;
    } else {
      cols = 3;
    }
  }

  // void genRecipes() {
  //   log('generating recipes');
  //   _recipes = List.generate(
  //     rows,
  //     (int idx) => Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: List.generate(
  //         cols,
  //         (int jdx) => const Center(
  //           child: RecipeBox(),
  //         ),
  //       ),
  //     ),
  //   );
  //   // notifyListeners();
  // }
}

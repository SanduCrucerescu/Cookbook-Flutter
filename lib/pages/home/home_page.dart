import 'dart:developer';

import 'package:cookbook/components/components.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String id = "/";

  HomePage({Key? key}) : super(key: key);

  final responsivePorvider = ChangeNotifierProvider<ResponsiveNotifier>(
    (ref) => ResponsiveNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(responsivePorvider);

    if (state.recipes == null) {
      state.genRecipes();
    }

    state.checkWidth(size.width);

    log('rebuilding');

    return CustomPage(
      child: Container(
        color: kcLightBeige,
        height: size.height - 100,
        width: size.width - 200,
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: size.width - 220,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            cacheExtent: 50,
            itemCount: state.rows,
            shrinkWrap: true,
            itemBuilder: (ctx, i) => Container(
              child: state.recipes![i],
            ),
          ),
        ),
      ),
    );
  }
}

class ResponsiveNotifier extends ChangeNotifier {
  int _cols = 3;
  List<Widget>? _recipes;
  final int rows = 10;

  int get cols => _cols;
  List<Widget>? get recipes {
    log('get _recipes');
    return _recipes;
  }

  set cols(int val) {
    _cols = val;
    genRecipes();
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

  void genRecipes() {
    log('generating recipes');
    _recipes = List.generate(
      rows,
      (int idx) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          cols,
          (int jdx) => const Center(
            child: RecipeBox(),
          ),
        ),
      ),
    );
    // notifyListeners();
  }
}

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeeklyPage extends HookConsumerWidget {
  static const String id = "/weeklypage";
  final int cols;
  final double searchBarWidth;

  WeeklyPage.desktop({Key? key})
      : cols = 3,
        searchBarWidth = 800,
        super(key: key);

  WeeklyPage.tablet({Key? key})
      : cols = 2,
        searchBarWidth = 800,
        super(key: key);

  WeeklyPage.mobile({Key? key})
      : cols = 1,
        searchBarWidth = 300,
        super(key: key);

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thurday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    return CustomPage(
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, idx) {
          return Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text('Week X')),
              Container(
                height: 500,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: kcLightBeige,
                  border: Border.all(
                    width: .5,
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, jdx) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kcMedBeige,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 10),
                        child: SelectableText(
                          days[jdx],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
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
                isLiked: false,
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

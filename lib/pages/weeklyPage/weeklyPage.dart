// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiver/collection.dart';

import '../../models/tag/tag.dart';

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
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final tec = useTextEditingController();
    const int idx = 0;

    return CustomPage(
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              'Week ${idx + 1}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Container(
            height: size.height - 150,
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
            child: RecipeList(
              days: days,
              size: size,
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeList extends StatefulWidget {
  const RecipeList({
    Key? key,
    required this.days,
    required this.size,
  }) : super(key: key);

  final List<String> days;
  final Size size;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (BuildContext contexts, jdx) {
        return Container(
          margin: const EdgeInsets.all(10),
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kcMedBeige,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Column(
              children: [
                SelectableText(
                  widget.days[jdx],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 350,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        return RecipeTile(
                          idx: i,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RecipeTile extends StatefulWidget {
  final int idx;
  const RecipeTile({
    Key? key,
    required this.idx,
  }) : super(key: key);

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width / 4,
      padding: const EdgeInsets.only(top: 15),
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // state.toggle = true;
          // state.idx = idx;
        },
        //todo Perhaps add a hover function to show recipes.
        // onHover: () {

        // },
        //todo add a listview.builder to display 3 recipes in one day.
        child: ListTile(
          title: SelectableText("Name"),
          subtitle: SelectableText("Tags"),
          // onTap: ,
        ),
      ),
      // ),
    );
  }
}

class RecipeTileController extends ChangeNotifier {
  List<Recipe> recipes = [];
  List<Tag> tags = [];
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

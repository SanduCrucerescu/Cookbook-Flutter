// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_week.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:cookbook/models/weekly_recipe/weekly_recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final tec = useTextEditingController();

    final PageController pgc =
        usePageController(initialPage: weekNumber(DateTime.now()) - 1);

    return CustomPage(
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: PageView.builder(
        controller: pgc,
        scrollDirection: Axis.vertical,
        itemCount: 52,
        itemBuilder: (context, idx) {
          return Column(
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
                  email: InheritedLoginProvider.of(context)
                      .userData!['email']
                      .toString(),
                  week: idx + 1,
                  size: size,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final weeklyRecipesProvider = StateProvider(
  (ref) => [],
);

class RecipeList extends StatefulHookConsumerWidget {
  const RecipeList({
    Key? key,
    required this.size,
    required this.week,
    required this.email,
  }) : super(key: key);

  final int week;
  final Size size;
  final String email;

  @override
  ConsumerState<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<RecipeList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final dbManager = await DatabaseManager.init();

      final _weekleRecipes = await dbManager
          .select(
            table: 'weekly_recipe',
            fields: ['*'],
            where: {
              'email': widget.email,
              'week': widget.week,
            },
            and: true,
          )
          .then(
            (val) => val!.map(
              (e) => WeeklyRecipe(
                day: e.fields['day'],
                week: e.fields['week'],
                daytime: e.fields['meal_type'],
                recipeId: e.fields['recipe_id'],
                email: e.fields['email'].toString(),
              ),
            ),
          );

      ref.read(weeklyRecipesProvider.notifier).state = _weekleRecipes.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (BuildContext contexts, day) {
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
                  days[day],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 350,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, daytime) {
                        return RecipeTile(
                          recipes: InheritedLoginProvider.of(context).recipes,
                          week: widget.week,
                          day: day,
                          daytime: daytime,
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

class RecipeTile extends StatefulHookConsumerWidget {
  final int week, day, daytime;
  final List<Recipe> recipes;
  const RecipeTile({
    required this.week,
    required this.day,
    required this.daytime,
    required this.recipes,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends ConsumerState<RecipeTile> {
  Recipe? recipe;

  @override
  void initState() {
    final weeklyRecipes =
        ref.read(weeklyRecipesProvider.notifier).state.map((wr) {
      if (wr.day == widget.day &&
          wr.week == widget.week &&
          wr.daytime == widget.daytime) return wr;
    }).toList();
    final WeeklyRecipe? weeklyRecipe =
        weeklyRecipes.isNotEmpty ? weeklyRecipes[0] : null;

    for (Recipe r in widget.recipes) {
      if (weeklyRecipe != null && weeklyRecipe.recipeId == r.id) {
        recipe = r;
        break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(weeklyRecipesProvider);

    return recipe == null
        ? const SizedBox()
        : Container(
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
                title: SelectableText(recipe != null ? recipe!.title : ''),
                subtitle:
                    SelectableText(recipe != null ? recipe!.ownerEmail : ''),
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

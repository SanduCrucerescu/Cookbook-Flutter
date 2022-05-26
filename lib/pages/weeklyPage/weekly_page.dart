import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/controllers/get_image_from_blob.dart';
import 'package:cookbook/controllers/get_week.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/get_ingredients_from_id.dart';
import 'package:cookbook/db/queries/get_ingridients.dart';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/db/queries/get_tags_from_id.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:cookbook/models/weekly_recipe/weekly_recipe.dart';
import 'package:cookbook/pages/faq/helpData.dart';
import 'package:cookbook/pages/recipe/recipe.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

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
    final email = InheritedLoginProvider.of(context).member!.email;

    final PageController pgc = usePageController(
      initialPage: weekNumber(DateTime.now()) - 1,
    );

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
                  email: InheritedLoginProvider.of(context).member!.email,
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

class WeeklyPageController extends ChangeNotifier {
  List<WeeklyRecipe> _weeklyRecipes = [];

  List<WeeklyRecipe> get weeklyRecipes => _weeklyRecipes;

  set weeklyRecipes(List<WeeklyRecipe> newRecipes) {
    _weeklyRecipes = newRecipes;
    notifyListeners();
  }

  void addRecipe(WeeklyRecipe recipe) {
    _weeklyRecipes.add(recipe);
    notifyListeners();
  }

  void removeRecipe(WeeklyRecipe recipe) {
    _weeklyRecipes.remove(recipe);
    notifyListeners();
  }
}

final weeklyPageController = ChangeNotifierProvider(
  (ref) => WeeklyPageController(),
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
  List<WeeklyRecipe>? _weeklyRecipes;

  Future<List<WeeklyRecipe>?> fetchWeeklyRecipes() async {
    final dbManager = await DatabaseManager.init();

    _weeklyRecipes = await dbManager
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
          (val) => val!
              .map(
                (e) => WeeklyRecipe(
                  day: e.fields['day'],
                  week: e.fields['week'],
                  daytime: e.fields['meal_type'],
                  recipeId: e.fields['recipe_id'],
                  email: e.fields['email'].toString(),
                ),
              )
              .toList(),
        );
    return _weeklyRecipes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchWeeklyRecipes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            // physics: BouncingScrollPhysics(),
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (BuildContext contexts, day) {
              List<WeeklyRecipe> recipesForDay = [];

              for (WeeklyRecipe wr in _weeklyRecipes!) {
                if (wr.day - 1 == day) {
                  recipesForDay.add(wr);
                }
              }

              return WeekDayColumn(
                recipes: recipesForDay,
                day: day,
                week: widget.week,
              );
            },
          );
        } else {
          return Center(
            child: progressIndicator,
          );
        }
      },
    );
  }
}

class WeekDayColumn extends StatelessWidget {
  const WeekDayColumn({
    Key? key,
    required this.day,
    required this.week,
    required this.recipes,
  }) : super(key: key);

  final int day, week;
  final List<WeeklyRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kcMedBeige,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10),
        child: Column(
          children: [
            SelectableText(
              days[day],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: size.height - 216,
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: recipes.length,
                  itemBuilder: (context, idx) {
                    return RecipeTile(
                      weeklyRecipes: recipes,
                      week: week,
                      day: day,
                      idx: idx,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeTile extends StatefulHookConsumerWidget {
  final int week, day, idx;
  final List<WeeklyRecipe> weeklyRecipes;

  const RecipeTile({
    required this.week,
    required this.day,
    required this.idx,
    required this.weeklyRecipes,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends ConsumerState<RecipeTile> {
  Recipe? recipe;

  Future<Recipe?> fetchRecipe() async {
    WeeklyRecipe? weeklyRecipe = widget.weeklyRecipes[widget.idx];

    final dbManager = await DatabaseManager.init();
    final Results? rs = await dbManager.select(
        table: 'recipes', fields: ['*'], where: {'id': weeklyRecipe.recipeId});

    final fields = rs!.first.fields;

    recipe = Recipe(
      id: fields['id'],
      ownerEmail: fields['member_email'],
      title: fields['title'],
      longDescription: fields['description'].toString(),
      shortDescription: fields['description'].toString(),
      instructions: fields['instructions'].toString(),
      picture: fields['picture'],
      ingredients: await getIngredientsFromId(fields['id']),
      tags: await getTagsFromId(fields['id']),
    );
    await dbManager.close();

    return recipe;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: fetchRecipe(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 100,
            width: size.width / 4,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(
                      recipe: recipe!,
                    ),
                  ),
                );
              },
              onHover: (val) {},
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      height: 70,
                      child: ClipOval(
                        child: Image.memory(
                          getImageDataFromBlob(recipe!.picture),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(recipe!.title),
                          Text(recipe!.ownerEmail),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
            width: 200,
            child: Center(child: Text('No Recipe')),
          );
        }
      }),
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

import 'dart:developer';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/components/refresh_progress_indicator.dart';
import 'package:cookbook/db/queries/get_members.dart';
import 'package:cookbook/db/queries/get_recipes.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final membersState = ref.watch(membersProvider);
      final loginProvider = InheritedLoginProvider.of(context);
      if (loginProvider.member != null) {
        membersState.members = await getMembers(
          context,
          // InheritedLoginProvider.of(context).member!.email,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext contextref) {
    final state = ref.watch(responsiveProvider);
    final tec = useTextEditingController();
    final searchBarWidth = widget.searchBarWidth;
    final homeSc = useScrollController();
    final Size size = MediaQuery.of(context).size;
    final loginProvider = InheritedLoginProvider.of(context);

    homeSc.addListener(() async {
      print(loginProvider.currOffset);
      if (homeSc.position.atEdge && !state.refreshing && homeSc.offset != 0) {
        state.refreshing = true;
        final refetchedRecipes = GetRecepies();
        await refetchedRecipes.getrecep(limit: [loginProvider.currOffset, 9]);
        loginProvider.currOffset += refetchedRecipes.recepieList.length < 9
            ? refetchedRecipes.recepieList.length
            : 9;
        loginProvider.addRecipes(refetchedRecipes.recepieList);
        loginProvider.resetDisplayedRecipes();
        state.refreshing = false;
      }
    });

    return CustomPage(
      showSearchBar: true,
      controller: tec,
      searchBarWidth: searchBarWidth,
      child: loginProvider.displayedRecipes.isNotEmpty
          ? Builder(builder: ((context) {
              state.setRecipeBoxes(
                favorites: loginProvider.favorites,
                ctx: context,
                displayedRecipes: loginProvider.displayedRecipes,
                cols: widget.cols,
              );
              return Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height - 110,
                      child: ListView.builder(
                        controller: homeSc,
                        cacheExtent: 20,
                        itemCount: state.recipes.length,
                        itemBuilder: (ctx, i) => Container(
                          child: state.recipes[i],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: -100,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        height: state.refreshing ? 40 : 0,
                        width: size.width,
                        child: const SizedBox(
                          height: 150,
                          width: 200,
                          child: progressIndicator,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }))
          : const Center(
              child: SizedBox(
                child: Text(
                  'No Recipes',
                  style: ksLabelTextStyle,
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
  bool _refreshing = false;

  bool get refreshing => _refreshing;

  set refreshing(bool val) {
    _refreshing = val;
    notifyListeners();
  }

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

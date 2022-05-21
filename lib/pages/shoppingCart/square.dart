import 'package:cookbook/db/queries/get_ingridients.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shopping_page.dart';
import 'package:cookbook/pages/shoppingCart/search.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_list.dart';
import 'package:flutter/material.dart';

class Sqaure extends StatelessWidget {
  final SelectedIngridientChangeNotifier state;

  const Sqaure({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            SearchIngridient(state: state),
            IngridientColumn(state: state),
          ],
        ),
      ),
    );
  }
}

class IngridientColumn extends StatefulWidget {
  const IngridientColumn({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SelectedIngridientChangeNotifier state;

  @override
  State<IngridientColumn> createState() => _IngridientColumnState();
}

class _IngridientColumnState extends State<IngridientColumn> {
  DatabaseManager? dbManager;
  List<Ingredient> ingredients = [];
  List<Ingredient> displayedIngridients = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // TODO this.
      ingredients = await getIngridients();
      displayedIngridients = ingredients;
      widget.state.currIngridient = displayedIngridients[0];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    displayedIngridients = [];
    final Size size = MediaQuery.of(context).size;

    for (Ingredient ingridient in ingredients) {
      if (ingridient.name.startsWith(widget.state.filteringString)) {
        displayedIngridients.add(ingridient);
      }
    }

    if (ingredients.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: const CircularProgressIndicator(),
      );
    } else {
      return Container(
        height: size.height - 200,
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          controller: ScrollController(),
          itemCount: displayedIngridients.length,
          itemBuilder: (BuildContext context, int idx) {
            return IngridientTile(
              pricePerUnit: ingredients[idx].pricePerUnit,
              id: ingredients[idx].id,
              ingredient: displayedIngridients[idx],
              idx: idx,
              name: displayedIngridients[idx].name,
            );
          },
        ),
      );
    }
  }
}

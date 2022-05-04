import 'package:cookbook/controllers/get_ingridients.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:cookbook/pages/shoppingCart/search.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_list.dart';
import 'package:flutter/material.dart';

class Sqaure extends StatelessWidget {
  final SelectedUserChangeNotifier2 state;
  final position;

  const Sqaure({
    required this.state,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, bottom: 20, top: 20, left: 40),
      child: Align(
        alignment: position,
        // rectangle itself
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          // Height and width of the boxes
          height: 850,
          width: 600,
          //Title of the rectangle
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SearchIngridient(state: state),
                IngridientColumn(state: state),
              ],
            ),
          ),
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

  final SelectedUserChangeNotifier2 state;

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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
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

    for (Ingredient ingridient in ingredients) {
      if (ingridient.name.startsWith(widget.state.filteringString)) {
        displayedIngridients.add(ingridient);
      }
    }
    // print(displayedIngridients);

    if (ingredients.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(children: const [CircularProgressIndicator()]),
      );
    } else {
      return Container(
        height: 698,
        width: 1000,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: ListView.builder(
          controller: ScrollController(),
          itemCount: displayedIngridients.length,
          itemBuilder: (BuildContext context, int idx) {
            return IngridientTile(
              pricePerUnit: ingredients[idx].pricePerUnit,
              id: ingredients[idx].id,
              ingridient: ingredients[idx],
              state: widget.state,
              idx: idx,
              name: displayedIngridients[idx].name,
            );
          },
        ),
      );
    }
  }
}

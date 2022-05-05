import 'package:cookbook/components/components.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_to_buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'square.dart';

class ShoppingPage extends HookConsumerWidget {
  static const String id = "/cart";

  ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectIngredientProvider);
    final tec = useTextEditingController();
    Size size = MediaQuery.of(context).size;

    return CustomPage(
      child: Row(
        children: [
          Expanded(
            child: Sqaure(
              state: state,
              position: Alignment.topLeft,
            ),
          ),
          Expanded(
            child: IngridientsToBuy(
              position: Alignment.topRight,
              idx: state._idx,
            ),
          ),
        ],
      ),
    );
  }
}

final selectIngredientProvider =
    ChangeNotifierProvider<SelectedIngridientChangeNotifier>(
  (ref) => SelectedIngridientChangeNotifier(),
);

class SelectedIngridientChangeNotifier extends ChangeNotifier {
  int _idx = 0;
  Ingredient? _currIngredient;
  String _name = "";
  String _filteringString = '';
  List<Ingredient> _ingredientList = [];

  String get filteringString => _filteringString; // notify

  int get idx => _idx;

  Ingredient? get currIngridient => _currIngredient;

  List<Ingredient> get ingredientList => _ingredientList;

  set currIngridient(Ingredient? ingredient) {
    _currIngredient = ingredient;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    _ingredientList.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    _ingredientList.remove(ingredient);
    notifyListeners();
  }

  void removeIngredientAt(int idx) {
    _ingredientList.removeAt(idx);
    notifyListeners();
  }

  set ingredientList(List<Ingredient> list) {
    ingredientList = list;
    notifyListeners();
  }

  set filteringString(String val) {
    _filteringString = val;
    notifyListeners();
  }

  set idx(int val) {
    _idx = val;
    notifyListeners();
  }
}

import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/queries/get_cart_ingridients.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_to_buy.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'square.dart';

class ShoppingPage extends StatefulHookConsumerWidget {
  static const String id = "/cart";

  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends ConsumerState<ShoppingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(selectIngredientProvider).ingredientList =
          (await getCartIngridients(context))!;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectIngredientProvider);

    return CustomPage(
      child: Row(
        children: [
          Expanded(
            child: Sqaure(
              state: state,
            ),
          ),
          Expanded(
            child: IngridientsToBuy(
              idx: state.idx,
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

  void addAdditionalIngredients(Ingredient a, double amountToAdd) {
    a.amount = a.amount! + amountToAdd;
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
    _ingredientList = list;
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

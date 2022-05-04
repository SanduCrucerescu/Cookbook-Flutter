import 'dart:io';

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

  final selectUserProvider2 =
      ChangeNotifierProvider<SelectedIngridientChangeNotifier2>(
    (ref) => SelectedIngridientChangeNotifier2(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectUserProvider2);
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
              state: state,
              text: state._name,
              ingredientList: [],
              position: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedIngridientChangeNotifier2 extends ChangeNotifier {
  int _idx = -1;
  Ingredient? _currIngredient;
  String _name = "";
  String _filteringString = '';

  String get filteringString => _filteringString;

  int get idx => _idx;

  String get userName => _name;

  Ingredient? get currIngridient => _currIngredient;
  set currIngridient(Ingredient? member) {
    _currIngredient = member;
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

  set userName(String val) {
    _name = val;
    notifyListeners();
  }
}

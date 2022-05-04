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
      ChangeNotifierProvider<SelectedUserChangeNotifier2>(
    (ref) => SelectedUserChangeNotifier2(),
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
              text: "Current User",
              position: Alignment.topRight,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedUserChangeNotifier2 extends ChangeNotifier {
  int _idx = -1;
  Ingredient? _currMember;
  String _userName = "";
  String _email = "";
  Image image = Image.asset("assets/images/ph.png"); // doesnt count
  String _filteringString = '';
  File? _xFile;

  String get filteringString => _filteringString;

  int get idx => _idx;

  String get email => _email;

  String get userName => _userName;

  Ingredient? get currIngridient => _currMember;
  File? get file => _xFile;

  set currIngridient(Ingredient? member) {
    _currMember = member;
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

  set email(String val) {
    _email = val;
    notifyListeners();
  }

  set userName(String val) {
    _userName = val;
    notifyListeners();
  }

  set path(File? path) {
    _xFile = path;
    notifyListeners();
  }
}

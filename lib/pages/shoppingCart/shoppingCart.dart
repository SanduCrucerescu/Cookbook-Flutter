import 'package:cookbook/components/components.dart';
import 'package:cookbook/pages/messages/message_screen.dart';
import 'package:cookbook/pages/messages/search_bar.dart';
import 'package:cookbook/pages/recipeadd/ui_components.dart';
import 'package:cookbook/pages/shoppingCart/test.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingPage extends HookConsumerWidget {
  static const String id = "/cart";

  ShoppingPage({Key? key}) : super(key: key);

  final shoppingPageController = ChangeNotifierProvider<ShoppingPageController>(
    (ref) => ShoppingPageController(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    //final state = ref.wa
    const double xWidth = 1000;
    return CustomPage(
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: const Center(
                child: Text(
                  "Shopping Page",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            Center(
              child: Container(
                  color: Colors.grey,
                  height: 50,
                  width: xWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Search for an item"),
                      CustomButton(
                          duration: const Duration(milliseconds: 200),
                          onTap: () {})
                    ],
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Scrollbar(
                    isAlwaysShown: true,
                    child: Scrollbar(
                      child: Text("xd"),
                    )),
                Container(
                  height: 500,
                  width: xWidth,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.red,
                  height: 100,
                  width: xWidth,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CustomButton(
                      child: Text("Save"),
                      duration: Duration(days: 0),
                      onTap: () {},
                    )
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShoppingPageController extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  set items(List<String> newItems) {
    _items = newItems;
    notifyListeners();
  }

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }
}

class SelectedUserChangeNotifier extends ChangeNotifier {
  int _idx = -1;
  String _userName = "";
  String _email = "";
  Image image = Image.asset("assets/images/ph.png"); // doesnt count
  String _filteringString = '';

  String get filteringString => _filteringString;

  int get idx => _idx;

  String get email => _email;

  String get userName => _userName;

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
}

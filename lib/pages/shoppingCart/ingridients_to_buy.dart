import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends HookConsumerWidget {
  final String text;
  final Alignment position;
  final SelectedIngridientChangeNotifier2 state;
  final List<Ingredient> ingredientList; // To here

  IngridientsToBuy({
    required this.text,
    required this.position,
    required this.state,
    required this.ingredientList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double xSize = 600;
    return Container(
      padding: const EdgeInsets.only(right: 40, bottom: 20, top: 20, left: 20),
      child: Align(
        alignment: position,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 500,
              width: xSize,
              child: SizedBox(
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: null,
                  child: ListView.builder(
                      controller: null,
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            TextButton(
                                onPressed: () {/* Remove */},
                                child: const Text("X")),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("ingredientList[1].name"),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 100,
                width: xSize,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {}, child: Text("Save Shopping Cart")),
                      // TextButton(
                      //     onPressed: () {}, child: Text("Another Button")),
                      // TextButton(
                      //     onPressed: () {},
                      //     child: Text("And another one Button"))
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Text("Total Cost: 40€")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

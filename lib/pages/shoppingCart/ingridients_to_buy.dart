import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends HookConsumerWidget {
  final String text;
  final Alignment position;
  final SelectedIngridientChangeNotifier2 state; // To here
  final int idx;

  const IngridientsToBuy({
    required this.text,
    required this.position,
    required this.state,
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getIngredientPrice() {
      double total = 0;
      for (Ingredient e in state.ingredientList) {
        total += e.pricePerUnit;
      }
      return total;
    }

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
                  controller: ScrollController(),
                  child: ListView.builder(
                      controller: ScrollController(), // null?
                      itemCount: state.ingredientList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    // TODO: remove from the list
                                  },
                                  child: const Text("X")),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(state.ingredientList[index].name),
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
                          onPressed: () {/* Commit to Database */},
                          child: const Text("Save Shopping Cart")),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: Text("Me and Lui",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      width: 200.00,
                      height: 140.00,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: ExactAssetImage('assets/images/IMG_5407.JPG'),
                          fit: BoxFit.fitHeight,
                        ),
                      )),
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
                      child: Text(
                          "Total Cost: " + getIngredientPrice().toString())),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

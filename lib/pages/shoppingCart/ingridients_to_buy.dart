import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends StatefulHookConsumerWidget {
  final Alignment position;
  final int idx;

  const IngridientsToBuy({
    required this.position,
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  _IngridientsToBuyState createState() => _IngridientsToBuyState();
}

class _IngridientsToBuyState extends ConsumerState<IngridientsToBuy> {
  @override
  Widget build(BuildContext context) {
    final position = widget.position;
    final state = ref.watch(selectIngredientProvider);
    final idx = widget.idx;

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
                child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: state.ingredientList.length, // NULL???????
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                state.removeIngredientAt(idx);
                                print("removed: " +
                                    state.ingredientList[idx].name);
                              },
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('assets/images/remove1.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                capitalize(state.ingredientList[index].name),
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
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
                child: TextButton(
                    style: ButtonStyle(
                        animationDuration: Duration(microseconds: 10)),
                    onPressed: () {/* Commit to Database */},
                    child: const Text("Save Shopping Cart",
                        style: TextStyle(fontSize: 25))),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: const Text("Me and Lui",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      width: 200.00,
                      height: 140.00,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
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
                      child: Center(
                        child: Text(
                            "Total Cost: " +
                                getIngredientPrice().toString() +
                                "€",
                            style: TextStyle(fontSize: 15)),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

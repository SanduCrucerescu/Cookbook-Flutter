import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_to_buy.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientTile extends HookConsumerWidget {
  final Ingredient ingridient;
  final int idx;
  final String name;
  final int id;
  final double? pricePerUnit;

  const IngridientTile({
    required this.ingridient,
    required this.idx,
    required this.id,
    required this.name,
    required this.pricePerUnit,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectIngredientProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        decoration: BoxDecoration(
            color: kcLightBeige,
            border: Border.all(
              color: kcMedGrey,
              width: .5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  state.addIngredient(ingridient);
                  // print("added " + ingridient.name);
                  // print(
                  //     "list size: " + (state.ingredientList.length).toString());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/add.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: ListTile(
                  title: Text(
                    capitalize(ingridient.name +
                        "   " +
                        (ingridient.pricePerUnit).toString() +
                        "€   " +
                        ingridient.unit),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

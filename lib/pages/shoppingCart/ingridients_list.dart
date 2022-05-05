import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/shoppingPage.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/src/blob.dart';

class IngridientTile extends HookConsumerWidget {
  final Ingredient ingridient;
  final int idx;
  final SelectedIngridientChangeNotifier2 state;
  final String name;
  final int id;
  final double? pricePerUnit;

  const IngridientTile({
    required this.ingridient,
    required this.idx,
    required this.state,
    required this.id,
    required this.name,
    required this.pricePerUnit,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  state.ingredientList.add(ingridient);
                  print("added " + ingridient.name);
                  print(
                      "list size: " + (state.ingredientList.length).toString());
                },
                child: const Text("Add")),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: ListTile(
                  title: Text(
                    ingridient.name +
                        " " +
                        (ingridient.pricePerUnit).toString() +
                        " " +
                        ingridient.unit,
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

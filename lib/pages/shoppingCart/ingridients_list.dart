import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_to_buy.dart';
import 'package:cookbook/pages/shoppingCart/shopping_page.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HoveringNotifier extends ChangeNotifier {
  bool _hovering = false;
  bool get hovering => _hovering;
  set hovering(bool val) {
    _hovering = val;
    notifyListeners();
  }

  void toggle() {
    _hovering = !_hovering;
    notifyListeners();
  }
}

class IngridientTile extends HookConsumerWidget {
  final Ingredient ingredient;
  final int idx;
  final String name;
  final int id;
  final double? pricePerUnit;

  final hoveringProvider = ChangeNotifierProvider<HoveringNotifier>(
    (ref) => HoveringNotifier(),
  );

  IngridientTile({
    required this.ingredient,
    required this.idx,
    required this.id,
    required this.name,
    required this.pricePerUnit,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectIngredientProvider);
    final Size size = MediaQuery.of(context).size;

    final hoveringState = ref.watch(hoveringProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 70,
      decoration: BoxDecoration(
        color: kcLightBeige,
        border: Border.all(
          color: Colors.black,
          width: .5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: size.width < 1000
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ShoppinCartIngredientInformation(
                        ingredient: ingredient,
                        title: 'Ingredient',
                        content: ingredient.name,
                      ),
                      ShoppinCartIngredientInformation(
                        title: 'Price',
                        content:
                            '${ingredient.pricePerUnit.toString()}€ per ${ingredient.unit}',
                        ingredient: ingredient,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        ingridientAmountBox(context: context, state: state);
                        state.addIngredient(ingredient);
                      },
                      child: const Icon(
                        Icons.add_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ShoppinCartIngredientInformation(
                      ingredient: ingredient,
                      title: 'Ingredient',
                      content: ingredient.name,
                    ),
                    ShoppinCartIngredientInformation(
                      title: 'Price',
                      content:
                          '${ingredient.pricePerUnit.toString()}€ per ${ingredient.unit}',
                      ingredient: ingredient,
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  margin: const EdgeInsets.only(right: 10),
                  height: 30,
                  width: 30,
                  decoration: hoveringState.hovering
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: .5, color: kcMedGrey))
                      : null,
                  child: InkWell(
                    onHover: (val) => hoveringState.hovering = val,
                    onTap: () async {
                      await ingridientAmountBox(context: context, state: state);
                      state.addIngredient(ingredient);
                    },
                    child: const Icon(
                      Icons.add_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  TextEditingController ingridientController = TextEditingController();
  Future<dynamic> ingridientAmountBox({
    required BuildContext context,
    required SelectedIngridientChangeNotifier state,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Add Ingredient")),
          content: TextField(
            controller: ingridientController,
            decoration: const InputDecoration(labelText: "Enter amount"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Abort'),
              child: const Text(
                'Abort',
                style: TextStyle(
                    color: Color.fromARGB(255, 250, 111, 5),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                int amountToAdd = int.parse(ingridientController.text);
                // for (Ingredient ingInList in state.ingredientList) {
                //   if (ingridient.id == ingInList.id) {
                //     state.addAdditionalIngredients(ingInList, amountToAdd);
                //   } else {
                //     state.addIngredient(ingridient);
                //   }
                // }

                if (state.ingredientList.contains(ingredient)) {
                  state.addAdditionalIngredients(ingredient, amountToAdd);
                } else {
                  state.addIngredient(ingredient);
                  ingredient.setAmount(amountToAdd);
                }
                Navigator.pop(context);
                for (int i = 0; i < state.ingredientList.length; i++) {
                  for (int j = i + 1; j < state.ingredientList.length; j++) {
                    if (state.ingredientList[i].name ==
                        (state.ingredientList[j].name)) {
                      state.ingredientList[i].amount =
                          state.ingredientList[i].amount =
                              (state.ingredientList[i].amount! +
                                  state.ingredientList[j].amount!);
                      state.ingredientList.remove(
                        state.ingredientList[j],
                      );
                    }
                  }
                }
                print(state.ingredientList);
              },
              child: const Text(
                "Add",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
}

class ShoppinCartIngredientInformation extends StatelessWidget {
  final Ingredient ingredient;
  final String title, content;

  const ShoppinCartIngredientInformation({
    Key? key,
    required this.ingredient,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            title,
            style: ksTitleButtonStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            content,
            style: ksFormButtonStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

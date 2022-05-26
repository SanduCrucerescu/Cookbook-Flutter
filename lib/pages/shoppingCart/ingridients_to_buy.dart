import 'package:cookbook/components/components.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/db/queries/add_cart_ingidients.dart';
import 'package:cookbook/db/queries/get_cart_ingridients.dart';
import 'package:cookbook/main.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/pages/shoppingCart/ingridients_list.dart';
import 'package:cookbook/pages/shoppingCart/shopping_page.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngridientsToBuy extends StatefulHookConsumerWidget {
  final int idx;

  const IngridientsToBuy({
    required this.idx,
    Key? key,
  }) : super(key: key);

  @override
  _IngridientsToBuyState createState() => _IngridientsToBuyState();
}

class _IngridientsToBuyState extends ConsumerState<IngridientsToBuy> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectIngredientProvider);

    double getIngredientPrice() {
      double total = 0;
      if (state.ingredientList.isNotEmpty) {
        for (Ingredient e in state.ingredientList) {
          total += e.pricePerUnit * e.amount!;
        }
      }
      return total;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(width: .5, color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            height: 500,
            child: SizedBox(
              child: state.ingredientList.isEmpty
                  ? Container(
                      height: 500,
                      width: 500,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: Text('Nothing Selected'),
                      ),
                    )
                  : CartBox(),
            ),
          ),
          SizedBox(
            // height: 50, width: 150,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'TOTAL   ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    TextSpan(
                      text: "${getIngredientPrice()}€",
                      style: ksLabelTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                border: Border.all(width: .4, color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomButton(
                height: 50,
                width: 200,
                color: kcLightBeige,
                // border: Border.all(width: 2, color: Colors.black),
                onTap: () async {
                  print(getCurrentCart(context));
                  await DeleteCart.Delete(
                      table: "cartingredients",
                      where: {"cart_id": getCurrentCart(context).toString()});

                  for (Ingredient ing in state.ingredientList) {
                    await AddCartIngridients.addToCart(cartInfo: {
                      "cart_id": getCurrentCart(context).toString(),
                      "ingredient_id": ing.id,
                      "amount": ing.amount
                    });
                  }
                },

                // Yep it works

                child: Text(
                  "Save",
                  style: ksFormButtonStyle.copyWith(fontSize: 20),
                ),
                //TODO: On update
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          // Container(
          //   child: const Text(
          //     // "Me and Lui",
          //     "",
          //     style: TextStyle(
          //       color: Colors.black,
          //     ),
          //   ),
          //   width: 200.00,
          //   height: 140.00,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: ExactAssetImage('assets/images/IMG_5407.JPG'),
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),
          //       ],
          //     ),
          //   )
        ],
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class CartBox extends ConsumerWidget {
  CartBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectIngredientProvider);

    /**
     * This function is very important 
     * if you remove it app will break
     */
    state.recheck(state.ingredientList);

    return Column(
      children: [
        SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 60,
                ),
                Expanded(flex: 5, child: Text('Ingredient')),
                Expanded(flex: 1, child: Text('Amount')),
                Expanded(flex: 1, child: Text('Price')),
              ],
            )),
        SizedBox(
          height: 449,
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: state.ingredientList.length,
            itemBuilder: (
              BuildContext context,
              int idx,
            ) {
              return Row(
                children: [
                  CartItem(idx: idx, state: state),
                  Expanded(
                    flex: 5,
                    child: Text(state.ingredientList[idx].name),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      state.ingredientList[idx].amount.toString(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      (state.ingredientList[idx].amount! *
                              state.ingredientList[idx].pricePerUnit)
                          .toString(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CartItem extends ConsumerWidget {
  final SelectedIngridientChangeNotifier state;
  final int idx;

  CartItem({
    Key? key,
    required this.state,
    required this.idx,
  }) : super(key: key);

  final hoveringProvider = ChangeNotifierProvider<HoveringNotifier>(
    (ref) => HoveringNotifier(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoveringState = ref.watch(hoveringProvider);
    return Container(
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
        width: 40,
        height: 30,
        duration: const Duration(milliseconds: 250),
        decoration: hoveringState.hovering
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: .5, color: kcMedGrey))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
        child: InkWell(
          onHover: (val) => hoveringState.hovering = val,
          onTap: () {
            state.removeIngredientAt(idx);
          },
          child: const Icon(
            Icons.remove_outlined,
            // size: 30,
          ),
        ),
      ),
    );
  }
}

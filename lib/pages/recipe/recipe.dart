import 'dart:ui';

import 'package:cookbook/components/drop_down.dart';
import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/get_image_from_blob.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/pages/recipeadd/dropdown_checkbox.dart';
import 'package:cookbook/theme/colors.dart';
import 'package:cookbook/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipePage extends HookConsumerWidget {
  String id = '/recipe';
  final Recipe recipe;

  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splitedInstructions = recipe.instructions.split("STEP");
    splitedInstructions.removeAt(0);

    List<CustDropdownMenuItem<String>> portionsPerRecipe = [
      const CustDropdownMenuItem(
        child: Text("2"),
        value: "2",
      ),
      const CustDropdownMenuItem(
        child: Text("4"),
        value: "4",
      ),
      const CustDropdownMenuItem(
        child: Text("6"),
        value: "6",
      )
    ];

    return CustomPage(
      child: Container(
        decoration: const BoxDecoration(
            // color: Colors.white,
            ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        child: Center(
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              Center(
                child: SelectableText(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Wrap(
                  children: recipe.tags
                      .toList()
                      .map((e) => Chip(
                            side: BorderSide(color: Colors.black, width: .3),
                            label: Text(
                              e.name,
                              style: const TextStyle(),
                            ),
                            backgroundColor: kcMedBeige,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: .5),
                  ),
                  child: Image.memory(
                    getImageDataFromBlob(recipe.picture),
                    fit: BoxFit.cover,
                    height: 600,
                    width: 700,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    SelectableText(
                      'Description',
                      style: ksLabelTextStyle,
                    ),
                    SelectableText(
                      recipe.longDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Row(children: [
                  const SelectableText(
                    "Portions for: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 50,
                    child: CustDropDown(
                      defaultSelectedIndex: 0,
                      items: portionsPerRecipe,
                      onChanged: (val) => {
                        for (int i = 0; i < recipe.ingredients.length; i++)
                          {recipe.ingredients[i].changeAmount(int.parse(val))}
                      },
                    ),
                  )
                ]),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          const Text(
                            "Ingredients",
                            style: ksFormHeadlineStyle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListTile(
                            onTap: null,
                            leading: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Expanded(
                                  child: Text(
                                    "Name",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "   Amount",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "           Unit",
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "    Price",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: recipe.ingredients.toList().length,
                            itemBuilder: (context, index) {
                              final ingredient = recipe.ingredients[index];
                              ingredient.addListener((() {}));

                              final ingredientProvider =
                                  ChangeNotifierProvider<Ingredient>(
                                (ref) => ingredient,
                              );

                              final state = ref.watch(ingredientProvider);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    //padding: const EdgeInsets.only(left: 30),
                                    child: Center(
                                      child: SelectableText(
                                        state.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      state.changedAmount.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      state.unit,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      state.changedAmount.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(left: 0, top: 500, child: VericalLine()),
                  Expanded(
                    // height: 500,
                    // width: 500,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: kcMedBeige,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Instructions",
                            style: ksFormHeadlineStyle,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            physics: ClampingScrollPhysics(),
                            itemCount: splitedInstructions.length,
                            itemBuilder: ((context, index) {
                              return SelectableText(
                                "\n" + splitedInstructions[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VericalLine extends StatelessWidget {
  final double? length;
  final double? width;
  final EdgeInsets? paddingHorizontal, margin;

  const VericalLine({
    this.paddingHorizontal,
    this.margin,
    this.length,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingHorizontal ?? const EdgeInsets.symmetric(vertical: 0),
      margin: margin ?? const EdgeInsets.all(10),
      width: width ?? .7,
      height: length ?? 410,
      color: kcMedGrey,
    );
  }
}

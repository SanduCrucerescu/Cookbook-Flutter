import 'package:cookbook/components/components.dart';
import 'package:cookbook/controllers/loadimage.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipePage extends HookConsumerWidget {
  String id = '/recipe';
  final Recipe recipe;

  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slitterd = recipe.instructions.split("STEP");
    print(slitterd);
    return CustomPage(
      child: Container(
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
                height: 10,
              ),
              Center(
                child: Image.memory(
                  getImageDataFromBlob(recipe.picture),
                  fit: BoxFit.cover,
                  height: 600,
                  width: 700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SelectableText(
                  recipe.longDescription,
                  style: const TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    // height: 500,
                    // width: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: recipe.ingredients.toList().length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SelectableText(
                              recipe.ingredients[index].getName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SelectableText(
                              recipe.ingredients[index].getAmount.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SelectableText(
                              recipe.ingredients[index].getUnit,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SelectableText(
                              recipe.ingredients[index].getAmount.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    // height: 500,
                    // width: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: slitterd.length,
                      itemBuilder: ((context, index) {
                        return SelectableText("\n" + slitterd[index]);
                      }),
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

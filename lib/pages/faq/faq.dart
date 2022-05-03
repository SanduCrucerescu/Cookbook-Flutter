import 'package:cookbook/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FAQPage extends HookConsumerWidget {
  static const String id = '/faq';
  FAQPage({Key? key}) : super(key: key);

  static const userAbility =
      'As a user you can see recipes and interact with them, '
      'create your own recipes, favorite recipes, see weekly suggestions, '
      'add recipes to cart and interact with other users. Enjoy!';

  static const addRecipe =
      'In order to add a recipe, simply click the "Add recipe" '
      'button on the left hand side navigation column. Then fill in the '
      'information for your recipe.';

  static const favoriteRecipe = 'If you as a user want to add a recipe '
      'to your favorites section; all you need to do is click the star shaped icon '
      'icon in the individual recipe tile then head to "My Page" section to see '
      'the "favorites" section button below the once previous "My Page" button.';
  static const addRcptCart =
      'To add a recipe to your cart, you will need to click '
      'the " + " button. After that your cart should now hold the recipe you wish to purchase.';

  final List<Item> items = [
    Item(header: 'What can I do as a user?', body: userAbility),
    Item(header: 'How do I add a recipe?', body: addRecipe),
    Item(header: 'How to favorite a recipe?', body: favoriteRecipe),
    Item(header: 'How to add a recipe to your cart?', body: addRcptCart),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tec = useTextEditingController();

    Size size = MediaQuery.of(context).size;
    // TODO: FAQ Help page, drop down panel of each question
    return CustomPage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              height: 50,
              width: size.width,
              controller: tec,
              margin: const EdgeInsets.all(12),
              onChanged: (val) {
                // do something
              },
            ),
            ExpansionPanelList.radio(
              animationDuration: Duration(milliseconds: 75),
              dividerColor: Colors.brown[100],
              elevation: 8,
              expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
              children: items
                  .map(
                    (item) => ExpansionPanelRadio(
                      canTapOnHeader: true,
                      value: item.header,
                      headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(
                          item.header,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      body: Container(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          subtitle: Text(
                            item.body,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final String header;
  final String body;

  Item({
    required this.header,
    required this.body,
  });
}

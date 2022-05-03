import 'faq.dart';

const userAbility = 'As a user you can see recipes and interact with them, '
    'create your own recipes, favorite recipes, see weekly suggestions, '
    'add recipes to cart and interact with other users. Enjoy!';

const addRecipe = 'In order to add a recipe, simply click the "Add recipe" '
    'button on the left hand side navigation column. Then fill in the '
    'information for your recipe.';

const favoriteRecipe = 'If you as a user want to add a recipe '
    'to your favorites section; all you need to do is click the star shaped icon '
    'icon in the individual recipe tile then head to "My Page" section to see '
    'the "favorites" section button below the once previous "My Page" button.';
const addRcptCart = 'To add a recipe to your cart, you will need to click '
    'the " + " button. After that your cart should now hold the recipe you wish to purchase.';

final List<Item> kFaqItems = [
  Item(header: 'What can I do as a user?', body: userAbility),
  Item(header: 'How do I add a recipe?', body: addRecipe),
  Item(header: 'How to favorite a recipe?', body: favoriteRecipe),
  Item(header: 'How to add a recipe to your cart?', body: addRcptCart),
];

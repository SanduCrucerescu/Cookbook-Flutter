import 'faq.dart';

const userAbility = 'As a user you can see recipes and interact with them, '
    'create your own recipes, favorite recipes, create/plan weekly recipes, '
    'add recipes to cart and interact with other users via messages. Enjoy!';

const addRecipe =
    'In order to add a recipe, You will have to click the "Add recipe" '
    'button on the left hand side navigation column. Once you do that you will be able '
    'to fill in the information for your new recipe. Information fields such as name, '
    'ingredients, descriptions, etc. Just remember to write "STEP" at the beginning of '
    'your recipe instructions. In this section you can even select specific ingredient '
    'amounts for your recipe needs.';

const favoriteRecipe = 'If you as a user want to add a recipe '
    'to your favorites section; all you need to do is click the star shaped icon '
    'icon in the individual recipe tile then head over to the "My Page" section '
    'to see the "favorites" section button below the once previous "My Page" button.'
    'Once there you can completely view all of your favorite recipe tiles and view all '
    'of your favorites in one place.';

const addRcptCart = 'To add a recipe to your cart, you will need to click '
    'the " + " button. After that your cart should now hold the recipe you wish to purchase.'
    'Enjoy your newly made purchase!';

const weeklyRecipes =
    'As a user, you have the ability to add individual recipes to the weekly page section.'
    'The weekly page section allows you to plan your meals ahead by specific days and weeks. '
    'Simply click the "+" button found within each recipe tile. A window should open and allow '
    'you to select the specific days and weeks you wish to add it to. This compared with the ability '
    'to purchase recipes makes for a perfect meal planner and diet organizer that fits whatever your '
    'nutritional needs are, from the athletic gym person to the at-home chef perfecting their craft.';

const commentsExplained =
    'Every recipe tile has the functionality for users to leave comments and view alongside other user comments.'
    'This allows for a space where socializing in relation to specific recipes can occur and you can see other users '
    'with similar culinary likes.';

const likesExplained =
    'Every recipe tile has the functionality for users to "like" their favorite recipes.';

const messagingExplained =
    'In this cookbook social platform all users have the ability to reach out and message '
    'fellow users in order to form social relations and even share their favorite recipes directly with their respective '
    'person they are chatting with. This allows for a great social and community experience to be formed within this platform. '
    'Within the messages tab found on the left hand side navigation column users can find their conversations and even search for '
    'specific conversations they have already had with other users.';

final List<Item> kFaqItems = [
  Item(header: 'What can I do as a user?', body: userAbility),
  Item(header: 'How do I add a recipe?', body: addRecipe),
  Item(header: 'How to favorite a recipe?', body: favoriteRecipe),
  Item(header: 'How to add a recipe to your cart?', body: addRcptCart),
  Item(header: 'How weekly recipes work.', body: weeklyRecipes),
  Item(header: 'Comments on recipe tiles.', body: commentsExplained),
  Item(header: 'Likes on recipe tiles.', body: likesExplained),
  Item(header: '', body: messagingExplained),
];

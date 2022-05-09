//TODO this
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>> getCartIngridients() async {
  final dbManager = await DatabaseManager.init();
  List<Ingredient> ingridients = [];

  Results? res = await dbManager.query(
      query:
          '''SELECT ingredients.id,name,unit,pricePerUnit FROM cartingredients 
JOIN ingredients_for_recipe 
ON ingredients_for_recipe.id =cartingredients.ingredients_for_recipe_id
JOIN ingredients ON ingredients.id=ingredients_for_recipe.ingredient_id
JOIN members ON members.cart_id=cartingredients.cart_id
WHERE members.username="Queenie Bogace";'''); // TODO:Change Queenie to current user
//TODO this
  for (var r in res!) {
    final curr = Ingredient(
      id: r['id'],
      name: r['name'],
      unit: r['unit'],
      // amount: r['amount'],
      pricePerUnit: r['pricePerUnit'],
    );
    ingridients.add(curr);
  }
  return ingridients;
}

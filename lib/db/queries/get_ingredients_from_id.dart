import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:mysql1/mysql1.dart';

Future<List<Ingredient>> getIngredientsFromId(int id) async {
  final DatabaseManager dbManager = await DatabaseManager.init();
  List<Ingredient> ingredients = [];

  Results? rs = await dbManager.query(
      query:
          "select * from ingredients_for_recipe INNER JOIN ingredients on ingredients_for_recipe.ingredient_id = ingredients.id where recipe_id = $id;");
  for (var ing in rs!) {
    final ingr = Ingredient(
      id: ing.fields['id'],
      name: ing.fields['name'],
      unit: ing.fields['unit'],
      amount: ing.fields['amount'],
      pricePerUnit: ing.fields['pricePerUnit'],
    );
    ingredients.add(ingr);
  }

  dbManager.close();
  return ingredients;
}

import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';

class AddRecipe {
  static Future<bool> adding(
      {Map<String, dynamic>? recipeInfo,
      Map<String, int>? ingredients,
      List<String>? tags}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    List<int> ingredientID = [];
    List<int> amount = [];

    ingredients!.keys.forEach((key) {
      ingredientID.add(int.parse(key));
    });

    ingredients.values.forEach((value) {
      amount.add(value);
    });

    Future? res = dbManager.insert(table: "recipes", fields: [
      "title",
      "description",
      "instructions",
      "member_email",
      "picture"
    ], data: {
      "title": recipeInfo?["title"],
      "description": recipeInfo?["description"],
      "instructions": recipeInfo?["instructions"],
      "member_email": recipeInfo?["member_email"],
      "picture": recipeInfo?["picture"]
    });

    Future? id = dbManager.query(query: "SELECT MAX(id) FROM recipes;");

    int idVal = 0;

    for (var rs in await id) {
      idVal = rs[0];
    }

    for (int i = 0; i < ingredients.length; i++) {
      Future? ingredients = dbManager.insert(
          table: "ingredients_for_recipe",
          fields: [
            "recipe_id",
            "ingredient_id",
            "amount"
          ],
          data: {
            "recipe_id": idVal,
            "ingredient_id": ingredientID[i],
            "amount": amount[i]
          });
    }

    for (int i = 0; i < tags!.length; i++) {
      Future? id = dbManager.select(table: "tags", fields: [
        "id"
      ], where: {
        "name": tags[i],
      });

      int idTag = 0;

      for (var rs in await id) {
        idTag = rs[0];
      }

      Future? ingredients =
          dbManager.insert(table: "recipes_has_tags", fields: [
        "recipes_id",
        "tags_id"
      ], data: {
        "recipes_id": idVal,
        "tags_id": idTag,
      });
    }
    dbManager.close();
    return true;
  }
}

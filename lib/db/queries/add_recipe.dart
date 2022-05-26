import 'package:cookbook/db/database_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql1/mysql1.dart';

class AddRecipe {
  static Future<bool> adding(
      {Map<String, dynamic>? recipeInfo,
      Map<String, double>? ingredients,
      List<String>? tags}) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    List<int> ingredientID = [];
    List<double> amount = [];

    ingredients!.keys.forEach((key) {
      ingredientID.add(int.parse(key));
    });

    ingredients.values.forEach((value) {
      amount.add(value);
    });

    Results? res = await dbManager.insert(table: "recipes", fields: [
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

    Results? id = await dbManager.query(query: "SELECT MAX(id) FROM recipes;");

    int idVal = 0;

    for (var rs in id!) {
      idVal = rs[0];
    }
    for (int i = 0; i < ingredients.length; i++) {
      Results? ingredients = await dbManager.insert(
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
      Results? id = await dbManager.select(table: "tags", fields: [
        "id"
      ], where: {
        "name": tags[i],
      });

      late int idTag;

      for (var rs in id!) {
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

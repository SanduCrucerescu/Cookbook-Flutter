import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:mysql1/mysql1.dart';

class GetRecepies {
  late List<Recipe> _recepieList;
  late Recipe recipeClass;
  late Ingredient ingredientClass;
  late Tag tagClass;

  List<Recipe> get recepieList => _recepieList;

  void setRecipie(Recipe rec) {
    _recepieList.add(rec);
  }

  Future<void> getrecep() async {
    _recepieList = [];
    final DatabaseManager databaseManager = await DatabaseManager.init();

    Results? res =
        await databaseManager.select(table: "recipes", fields: ["*"]);

    for (var rs in res!) {
      recipeClass = Recipe(
          id: rs[0],
          ownerEmail: rs[4],
          title: rs[1],
          longDescription: rs[2].toString(),
          shortDescription: rs[2].toString(),
          instructions: rs[3].toString(),
          quantity: rs[6],
          picture: rs[7],
          ingredients: await getIngredients(rs[0]),
          tags: await getTags(rs[0]));
      setRecipie(recipeClass);
    }
  }

  Future<List<Ingredient>> getIngredients(int id) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();
    List<Ingredient> ingredient = [];

    Results? ingredients = await databaseManager.query(
        query:
            "select * from ingredients_for_recipe INNER JOIN ingredients on ingredients_for_recipe.ingredient_id = ingredients.id where recipe_id = $id;");
    for (var ing in ingredients!) {
      ingredientClass = Ingredient(
          ing[4], ing[5].toString(), ing[3], ing[6].toString(), ing[7]);
      ingredient.add(ingredientClass);
    }
    return ingredient;
  }

  Future<List<Tag>> getTags(int id) async {
    final DatabaseManager databaseManager = await DatabaseManager.init();
    List<Tag> tagsList = [];

    Results? tags = await databaseManager.query(
        query:
            "select * from ingredients_for_recipe INNER JOIN ingredients on ingredients_for_recipe.ingredient_id = ingredients.id where recipe_id = $id;");

    for (var tag in tags!) {
      tagClass = Tag(id: tag[1], name: tag[4].toString());
      tagsList.add(tagClass);
    }
    return tagsList;
  }

  @override
  String toString() {
    return " " + recipeClass.instructions;
  }
}

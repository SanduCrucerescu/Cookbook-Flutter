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
    final DatabaseManager dbManager = await DatabaseManager.init();

    Results? recipes = await dbManager.select(table: "recipes", fields: ["*"]);

    for (var rs in recipes!) {
      recipeClass = Recipe(
          id: rs.fields['id'],
          ownerEmail: rs.fields['member_email'],
          title: rs.fields['title'],
          longDescription: rs.fields['description'].toString(),
          shortDescription: rs.fields['description'].toString(),
          instructions: rs.fields['instructions'].toString(),
          quantity: 1,
          picture: rs.fields['picture'],
          ingredients: await getIngredients(rs.fields['id']) ?? [],
          tags: await getTags(rs.fields['id']));
      setRecipie(recipeClass);
    }
    dbManager.close();
  }

  Future<List<Ingredient>?> getIngredients(int id) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    List<Ingredient> ingredient = [];

    Results? ingredients = await dbManager.query(
        query:
            "select * from ingredients_for_recipe INNER JOIN ingredients on ingredients_for_recipe.ingredient_id = ingredients.id where recipe_id = $id;");
    for (var ing in ingredients!) {
      ingredientClass = Ingredient(
        id: ing.fields['id'],
        name: ing.fields['name'],
        unit: ing.fields['unit'],
        amount: ing.fields['amount'],
        pricePerUnit: ing.fields['pricePerUnit'],
      );
      ingredient.add(ingredientClass);
    }
    dbManager.close();
    return ingredient;
  }

  Future<List<Tag>> getTags(int id) async {
    final DatabaseManager dbManager = await DatabaseManager.init();
    List<Tag> tagsList = [];

    Results? tags = await dbManager.query(query: """
SELECT tags.id, tags.name
FROM recipes_has_tags as recipe_tags
INNER JOIN recipes 
ON recipe_tags.recipes_id = recipes.id 
INNER JOIN tags
ON recipe_tags.tags_id = tags.id
WHERE recipe_tags.recipes_id = $id;""");

    for (var tag in tags!) {
      tagClass = Tag(id: tag.fields['id'], name: tag.fields['name']);
      tagsList.add(tagClass);
    }
    dbManager.close();
    return tagsList;
  }

  @override
  String toString() {
    return " ${recipeClass.instructions}";
  }
}

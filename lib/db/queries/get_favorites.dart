import 'package:cookbook/db/database_manager.dart';
import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:cookbook/models/tag/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class GetFavorites {
  List<Recipe>? recepieList;
  late Recipe recipeClass;
  late Ingredient ingredientClass;
  late Tag tagClass;

  void setRecipie(Recipe rec) {
    if (recepieList != null) {
      recepieList!.add(rec);
    }
  }

  Future<List<Recipe>?> getfav(
    String? email,
  ) async {
    recepieList = [];
    final DatabaseManager dbManager = await DatabaseManager.init();

    Results? fav = await dbManager.query(
        query:
            "select recipes.id, title, description, instructions, member_email, picture from favorites inner join recipes on favorites.id = recipes.id where email = '$email';");

    for (var rs in fav!) {
      recipeClass = Recipe(
          id: rs.fields['id'],
          ownerEmail: rs.fields['member_email'],
          title: rs.fields['title'],
          longDescription: rs.fields['description'].toString(),
          shortDescription: rs.fields['description'].toString(),
          instructions: rs.fields['instructions'].toString(),
          quantity: 1,
          picture: rs.fields['picture'],
          ingredients: await getIngredients(rs.fields['id']),
          tags: await getTags(rs.fields['id']));
      setRecipie(recipeClass);
    }
    dbManager.close();
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    return recepieList;
=======
    return _recepieList;
>>>>>>> a9cc257 (commi)
=======
    return recepieList;
>>>>>>> 85ac6f9 (commi)
=======
    return recepieList;
=======
    print(_recepieList);
    return _recepieList;
    // print(recepieList);
>>>>>>> 8e6b174 (merge)
>>>>>>> 7ef59b4 (merge)
=======
    return recepieList;
>>>>>>> c09583a (commi)
  }

  Future<List<Ingredient>> getIngredients(int id) async {
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

    Results? tags = await dbManager.query(
        query:
            "select * from ingredients_for_recipe INNER JOIN ingredients on ingredients_for_recipe.ingredient_id = ingredients.id where recipe_id = $id;");

    for (var tag in tags!) {
      tagClass = Tag(id: tag.fields['id'], name: tag.fields['name']);
      tagsList.add(tagClass);
    }
    dbManager.close();
    return tagsList;
  }

  @override
  String toString() {
    return " " + recipeClass.instructions;
  }
}

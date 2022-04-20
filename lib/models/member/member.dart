import 'dart:convert';
import 'package:cookbook/models/recipe/recipe.dart';
import 'package:mysql1/mysql1.dart';

class Member {
  final String name;
  final String email;
  final String password;
  final List<Recipe> favorites;
  final List<Recipe> recipes;
  final Blob profilePicture;

  Member(this.name, this.email, this.password, this.favorites, this.recipes,
      this.profilePicture);

  void addFavorite(Recipe recipe) {
    favorites.add(recipe);
  }

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  void removeFavorite(Recipe favoriteRecipe) {
    int favoriteID = favoriteRecipe.id;
    for (Recipe recipe in favorites) {
      int recipeId = recipe.id;
      if (recipeId == favoriteID) {
        favorites.remove(recipe);
      }
    }
  }

  void removeRecipe(Recipe removeRecipe) {
    int removeRecipeID = removeRecipe.id;
    for (Recipe recipe in recipes) {
      int recipeId = recipe.id;
      if (recipeId == removeRecipeID) {
        recipes.remove(recipe);
      }
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'favorites': favorites.map((x) => x.toMap()).toList(),
      'recipes': recipes.map((x) => x.toMap()).toList(),
      'profilePicture': profilePicture.toBytes(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      map['name'] ?? '',
      map['email'] ?? '',
      map['password'] ?? '',
      List<Recipe>.from(map['favorites']?.map((x) => Recipe.fromMap(x))),
      List<Recipe>.from(map['recipes']?.map((x) => Recipe.fromMap(x))),
      Blob.fromBytes(map['profilePicture']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));
}

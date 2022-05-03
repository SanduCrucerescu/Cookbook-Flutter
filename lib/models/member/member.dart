import 'dart:convert';

import 'package:mysql1/mysql1.dart';

import 'package:cookbook/models/recipe/recipe.dart';

class Member {
  String name;
  String email;
  String password;
  List<Recipe>? favorites;
  List<Recipe>? recipes;
  Blob? profilePicture;

  Member({
    required this.name,
    required this.email,
    required this.password,
    this.favorites,
    this.profilePicture,
    this.recipes,
  });

  void addFavorite(Recipe recipe) {
    if (favorites != null) {
      favorites!.add(recipe);
    }
  }

  void addRecipe(Recipe recipe) {
    if (recipes != null) {
      recipes!.add(recipe);
    }
  }

  void removeFavorite(Recipe favoriteRecipe) {
    if (favorites != null) {
      int favoriteID = favoriteRecipe.id;
      for (Recipe recipe in favorites!) {
        int recipeId = recipe.id;
        if (recipeId == favoriteID) {
          favorites!.remove(recipe);
        }
      }
    }
  }

  void removeRecipe(Recipe removeRecipe) {
    if (recipes != null) {
      int removeRecipeID = removeRecipe.id;
      for (Recipe recipe in recipes!) {
        int recipeId = recipe.id;
        if (recipeId == removeRecipeID) {
          recipes!.remove(recipe);
        }
      }
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'favorites': favorites?.map((x) => x.toMap()).toList(),
      'recipes': recipes?.map((x) => x.toMap()).toList(),
      'profilePicture': profilePicture?.toBytes(),
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      favorites: map['favorites'] != null
          ? List<Recipe>.from(map['favorites']?.map((x) => Recipe.fromMap(x)))
          : null,
      recipes: map['recipes'] != null
          ? List<Recipe>.from(map['recipes']?.map((x) => Recipe.fromMap(x)))
          : null,
      profilePicture: map['profilePicture'] != null
          ? Blob.fromBytes(map['profilePicture'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));
}

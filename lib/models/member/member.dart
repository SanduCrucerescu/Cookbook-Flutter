import 'package:mysql1/mysql1.dart';

import '../recipe/recipe.dart';

class Member {
  final String name;
  final String email;
  final String password;
  final List<Recipe> favorites;
  final List<Recipe> recipes;
  final Blob profilePicture;

  Member(this.name, this.email, this.password, this.favorites, this.recipes,
      this.profilePicture);

  String get getName => name;

  String get getEmail => email;

  String get getPassword => password;

  List<Recipe> get getFavorites => favorites;

  List<Recipe> get getRecipes => recipes;

  Blob get getProfilePicture => profilePicture;

  void set name(String name) {
    this.name = name;
  }

  void set email(String email) {
    this.email = email;
  }

  void set password(String password) {
    this.password = password;
  }

  void set favorites(List<Recipe> favorites) {
    this.favorites = favorites;
  }

  void set recipes(List<Recipe> recipes) {
    this.recipes = recipes;
  }

  void set profilePicture(Blob profilePicture) {
    this.profilePicture = profilePicture;
  }

  void addFavorite(Recipe recipe) {
    favorites.add(recipe);
  }

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  void removeFavorite(Recipe favoriteRecipe) {
    int favoriteID = favoriteRecipe.getId;
    for (Recipe recipe in favorites) {
      int recipeId = recipe.getId;
      if (recipeId == favoriteID) {
        favorites.remove(recipe);
      }
    }
  }

  void removeRecipe(Recipe removeRecipe) {
    int removeRecipeID = removeRecipe.getId;
    for (Recipe recipe in recipes) {
      int recipeId = recipe.getId;
      if (recipeId == removeRecipeID) {
        recipes.remove(recipe);
      }
    }
  }
}
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
// class Member {
//   final String name;
//   final String email;
//   final String password;
//   final List<Recipe> favorites;
//   final List<Recipe> recipes;
//   final Blob profilePicture;

//   Member(this.name, this.email, this.password, this.favorites, this.recipes,
//       this.profilePicture);

//   String get getName => name;

//   String get getEmail => email;

//   String get getPassword => password;

//   List<Recipe> get getFavorites => favorites;

//   List<Recipe> get getRecipes => recipes;

//   Blob get getProfilePicture => profilePicture;

//   void set name(String name) {
//     this.name = name;
//   }

//   void set email(String email) {
//     this.email = email;
//   }

//   void set password(String password) {
//     this.password = password;
//   }

//   void set favorites(List<Recipe> favorites) {
//     this.favorites = favorites;
//   }

//   void set recipes(List<Recipe> recipes) {
//     this.recipes = recipes;
//   }

//   void set profilePicture(Blob profilePicture) {
//     this.profilePicture = profilePicture;
//   }

//   void addFavorite(Recipe recipe) {
//     favorites.add(recipe);
//   }

//   void addRecipe(Recipe recipe) {
//     recipes.add(recipe);
//   }

//   void removeFavorite(Recipe recipe) {}

//   void removeRecipe(Recipe recipe) {}

//   String convertToString() {
//     return getName + getEmail;
//   }
// }
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

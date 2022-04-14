import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';

class ShoppingCart {
  List<Ingredient> ingredients;
  final Member member;

  ShoppingCart({required this.ingredients, required this.member});

  List<Ingredient> get getIngredients => ingredients;

  Member get getMember => member;

  void set setIngredients(List<Ingredient> ingredients) {
    this.ingredients = ingredients;
  }

  void set member(Member member) {
    this.member = member;
  }

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
  }

  void removeIngredient(Ingredient removeIngredient) {
    int removeId = removeIngredient.getId;
    for (Ingredient ingredient in ingredients) {
      int ingredientId = ingredient.getId;
      if (ingredientId == removeId) {
        ingredients.remove(ingredient);
      }
    }
  }

  void getTotal() {
    double total = 0;
    for (Ingredient ingredient in ingredients) {
      total += ingredient.getPricePerUnit;
    }
  }
}

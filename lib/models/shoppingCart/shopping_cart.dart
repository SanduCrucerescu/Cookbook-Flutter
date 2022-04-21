import 'dart:convert';

import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/member/member.dart';

class ShoppingCart {
  List<Ingredient> ingredients;
  final Member member;

  ShoppingCart({required this.ingredients, required this.member});

  void removeIngredient(Ingredient removeIngredient) {
    int removeId = removeIngredient.id;
    for (Ingredient ingredient in ingredients) {
      int ingredientId = ingredient.id;
      if (ingredientId == removeId) {
        ingredients.remove(ingredient);
      }
    }
  }

  void getTotal() {
    double total = 0;
    for (Ingredient ingredient in ingredients) {
      total += ingredient.pricePerUnit;
    }
  }

  @override
  String toString() =>
      'ShoppingCart(ingredients: $ingredients, member: $member)';

  Map<String, dynamic> toMap() {
    return {
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'member': member.toMap(),
    };
  }

  factory ShoppingCart.fromMap(Map<String, dynamic> map) {
    return ShoppingCart(
      ingredients: List<Ingredient>.from(
          map['ingredients']?.map((x) => Ingredient.fromMap(x))),
      member: Member.fromMap(map['member']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCart.fromJson(String source) =>
      ShoppingCart.fromMap(json.decode(source));
}

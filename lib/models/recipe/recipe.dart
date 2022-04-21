import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mysql1/mysql1.dart';

import 'package:cookbook/models/ingredient/ingredient.dart';
import 'package:cookbook/models/tag/tag.dart';

class Recipe {
  final int id;
  final String ownerEmail;
  String title;
  String longDescription;
  String shortDescription;
  String instructions;
  double quantity;
  Blob picture;
  List<Ingredient> ingredients;
  List<Tag> tags;

  Recipe({
    required this.id,
    required this.ownerEmail,
    required this.title,
    required this.longDescription,
    required this.shortDescription,
    required this.instructions,
    required this.quantity,
    required this.picture,
    required this.ingredients,
    required this.tags,
  });

  @override
  String toString() {
    String ing = "";
    String recipe = "$id " +
        title +
        " " +
        instructions +
        " " +
        longDescription +
        " " +
        ownerEmail +
        " ";
    for (Ingredient ingredient in ingredients) {
      ing += ingredient.toString() + " ";
    }
    return recipe + ing;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerEmail': ownerEmail,
      'title': title,
      'longDescription': longDescription,
      'shortDescription': shortDescription,
      'instructions': instructions,
      'quantity': quantity,
      'picture': picture.toBytes(),
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id']?.toInt() ?? 0,
      ownerEmail: map['ownerEmail'] ?? '',
      title: map['title'] ?? '',
      longDescription: map['longDescription'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      instructions: map['instructions'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      picture: Blob.fromBytes(map['picture']),
      ingredients: List<Ingredient>.from(
          map['ingredients']?.map((x) => Ingredient.fromMap(x))),
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));
}

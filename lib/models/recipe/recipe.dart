import 'package:mysql1/mysql1.dart';

import '../ingredient/ingredient.dart';
import '../tag/tag.dart';

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

  int get getId => id;

  String get getOwnerEmail => ownerEmail;

  String get getTitle => title;

  String get getLongDescription => longDescription;

  String get getShortDescription => shortDescription;

  String get getInstructions => instructions;

  double get getQuantity => quantity;

  Blob get getPicture => picture;

  List<Ingredient> get getIngredients => ingredients;

  List<Tag> get getTags => tags;

  void set id(int id) {
    this.id = id;
  }

  void set ownerEmail(String ownerEmail) {
    this.ownerEmail = ownerEmail;
  }

  void set setTitle(String title) {
    this.title = title;
  }

  void set setLongDescription(String longDescription) {
    this.longDescription = longDescription;
  }

  void setShortDescription(String shortDescription) {
    this.shortDescription = shortDescription;
  }

  void set setQuantity(double quantity) {
    this.quantity = quantity;
  }

  void set setPicture(Blob picture) {
    this.picture = picture;
  }

  void set setIngredients(List<Ingredient> ingredients) {
    this.ingredients = ingredients;
  }

  void set setTags(List<Tag> tags) {
    this.tags = tags;
  }
}

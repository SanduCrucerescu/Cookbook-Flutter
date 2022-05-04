import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ingredient {
  final int id;
  String name;
  final int amount;
  final String unit;
  final double pricePerUnit;
  //final double amountFactor;

  Ingredient(
    this.id,
    this.name,
    this.amount,
    this.unit,
    this.pricePerUnit,
    //this.amountFactor
  );

  @override
  String toString() {
    return name +
        ":" +
        amount.toString() +
        ":" +
        unit +
        ":" +
        pricePerUnit.toString();
    // ":" +
    // getAmountFactor.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'unit': unit,
      'pricePerUnit': pricePerUnit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['amount']?.toInt() ?? 0,
      map['unit'] ?? '',
      map['pricePerUnit']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}

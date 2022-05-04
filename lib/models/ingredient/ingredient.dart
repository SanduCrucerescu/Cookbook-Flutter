import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ingredient {
  int id;
  String name;
  double pricePerUnit;
  String unit;
  // int amount;
  //final double amountFactor;

  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.pricePerUnit,
    // this.amount = 1,
    //this.amountFactor
  });

  @override
  String toString() {
    return name +
        ":" +
        // amount.toString() +
        // ":" +
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
      // 'amount': amount,
      'unit': unit,
      'pricePerUnit': pricePerUnit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      // amount: map['amount']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
      pricePerUnit: map['pricePerUnit']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}

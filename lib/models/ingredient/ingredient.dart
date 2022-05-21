import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ingredient with ChangeNotifier {
  int id;
  String name;
  double pricePerUnit;
  String unit;
  int? amount;
  double? changedPrice;
  int? changedAmount;
  //final double amountFactor;

  Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.pricePerUnit,
    this.amount,
    //this.amountFactor
  });

  @override
  String toString() {
    return "$name:$amount:$unit:$pricePerUnit";
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
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
      pricePerUnit: map['pricePerUnit']?.toDouble() ?? 0.0,
    );
  }

  void setAmount(int amountToAdd) {
    amount = amountToAdd;
    notifyListeners();
  }

  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));

  void changeAmount(int portion) {
    switch (portion) {
      case 2:
        changedAmount = amount;
        changedPrice = pricePerUnit;
        break;
      case 4:
        changedAmount = amount! * 2;
        changedPrice = pricePerUnit * 2;
        break;
      case 6:
        changedAmount = amount! * 4;
        changedPrice = pricePerUnit * 4;
        break;
    }
    notifyListeners();
  }
}

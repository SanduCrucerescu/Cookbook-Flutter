import 'package:hooks_riverpod/hooks_riverpod.dart';

class Ingredient {
  final int id;
  final String name;
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

  int get getId => id;

  String get getName => name;

  int get getAmount => amount;

  String get getUnit => unit;

  double get getPricePerUnit => pricePerUnit;

  //double get getAmountFactor => amountFactor;

  void set id(int id) {
    this.id = id;
  }

  void set name(String name) {
    this.name = name;
  }

  void set amount(int amount) {
    if (amount >= 0) {
      this.amount = amount;
    } else {
      this.amount = 0;
    }
  }

  void set unit(String unit) {
    this.unit = unit;
  }

  void set pricePerUnit(double pricePerUnit) {
    if (pricePerUnit >= 0) {
      this.pricePerUnit = pricePerUnit;
    } else {
      this.pricePerUnit = 0;
    }
  }

  void set amountFactor(int amountFactor) {
    if (amountFactor >= 0) {
      this.amountFactor = amountFactor;
    } else {
      this.amountFactor = 0;
    }
  }

  @override
  String toString() {
    return getName +
        ":" +
        getAmount.toString() +
        ":" +
        getUnit +
        ":" +
        getPricePerUnit.toString();
    // ":" +
    // getAmountFactor.toString();
  }
}

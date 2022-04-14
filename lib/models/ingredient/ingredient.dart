class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final double pricePerUnit;
  final double amountFactor;

  Ingredient(
      this.name, this.amount, this.unit, this.pricePerUnit, this.amountFactor);

  String get getName => name;

  double get getAmount => amount;

  String get getUnit => unit;

  double get getPricePerUnit => pricePerUnit;

  double get getAmountFactor => amountFactor;

  void set name(String name) {
    this.name = name;
  }

  void set amount(double amount) {
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

  void set amountFactor(double amountFactor) {
    if (amountFactor >= 0) {
      this.amountFactor = amountFactor;
    } else {
      this.amountFactor = 0;
    }
  }

  String convertToString() {
    return getName +
        ":" +
        getAmount.toString() +
        ":" +
        getUnit +
        ":" +
        getPricePerUnit.toString() +
        ":" +
        getAmountFactor.toString();
  }
}

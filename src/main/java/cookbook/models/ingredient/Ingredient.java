package cookbook.models.ingredient;

public class Ingredient {
  private String name;
  private double amount;
  private String unit;
  private double pricePerUnit;
  private double amountFactor;

  public Ingredient(String name, double amount, String unit, double price, double amountFactor) {
    this.setAmountFactor(amountFactor);
    this.setName(name);
    this.setAmount(amount);
    this.setUnit(unit);
    this.setPricePerUnit(price);
  }

  public String toJson() {
    return String.format("""
        {
            "name": "%s",
            "amount": "%s",
            "unit": "%s",
            "price": "%s",
            "amount": "%s"
        }
        """,
        getName(),
        getAmount(),
        getUnit(),
        getPricePerUnit(),
        getAmount());
  }

  public String toString() {
    return getName() + ":" + getAmount() + ":" + getUnit() + ":" + getPricePerUnit() + ":" + getAmountFactor() + ",";
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public double getAmount() {
    return amount;
  }

  public void setAmount(double amount) {
    this.amount = amount;
  }

  public String getUnit() {
    return unit;
  }

  public void setUnit(String unit) {
    this.unit = unit;
  }

  public double getPricePerUnit() {
    return pricePerUnit;
  }

  public void setPricePerUnit(double pricePerUnit) {
    this.pricePerUnit = pricePerUnit;
  }

  public double getAmountFactor() {
    return this.amountFactor;
  }

  public void setAmountFactor(double factor) {
    this.amountFactor = factor;
  }
}

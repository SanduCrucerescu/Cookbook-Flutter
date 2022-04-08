package cookbook.models.shoppingCart;

import cookbook.models.ingredient.Ingredient;
import cookbook.models.member.Member;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Shopping Cart.
 */
public class ShoppingCart {

  private ArrayList<Ingredient> ingredients;
  private Member member;

  /**
   * Shopping Cart Constructor.
   *
   * @param ingredients
   *
   * @param member
   *
   */
  public ShoppingCart(ArrayList<Ingredient> ingredients, Member member) {
    this.setIngredients(ingredients);
    this.setMember(member);
  }

  public ArrayList<Ingredient> getIngredients() {
    return ingredients;
  }

  public void setIngredients(ArrayList<Ingredient> ingredients) {
    this.ingredients = ingredients;
  }

  /**
   * Gets the total.

   * @return double total
   *
   */
  public double getTotal() {
    double total = 0;
    for (Ingredient i : ingredients) {
      total += i.getPricePerUnit();
    }
    return total;
  }

  public Member getMember() {
    return member;
  }

  public void setMember(Member member) {
    this.member = member;
  }

  public void checkOut() {}
}

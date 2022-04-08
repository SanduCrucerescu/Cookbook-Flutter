
package cookbook.ingredient_test;

import cookbook.models.ingredient.Ingredient;
import org.junit.jupiter.api.Test;


public class IngredientTest {
  @Test
  void testToJson() {
    Ingredient ingredient = new Ingredient("Salt", 2, "Tea Spoons", 0.5, 1);
    String expected = """
        {
            "name": "Salt",
            "amount": "2.0",
            "unit": "Tea Spoons",
            "price": "0.5",
            "amount": "1"
        }
        """;
    assert ingredient.toJson().equals(expected);
  }

}


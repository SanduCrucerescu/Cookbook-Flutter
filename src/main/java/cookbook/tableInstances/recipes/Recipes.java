package cookbook.tableInstances.recipes;

import cookbook.database.databaseManager.DatabaseManager;
import cookbook.models.recipe.Recipe;
import cookbook.tableInstances.TableInstance;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This class represents the table recipes, it fetches all recipes from
 * the database and stores them in a List.
 */
public class Recipes extends TableInstance {
  private List<Recipe> recipes = new ArrayList<>();
  private final DatabaseManager dbManager = new DatabaseManager();

  public Recipes() {
    super();
    initRecipes();
  }

  /**
   * Initializes the recipes by fetching all recipes from the database.
   */
  public void initRecipes() {
    fetch("SELECT * FROM recipes;");
    Connection con = dbManager.openConnection();
    for (Map<String, Object> m : getQueryResult()) {
      try {
        Blob blob = con.createBlob();
        blob.setBytes(1, (byte[]) m.get("recipe_pic"));
        recipes.add(new Recipe(
            m.get("id").toString(),
            m.get("title").toString(),
            m.get("description").toString(),
            m.get("instructions").toString(),
            m.get("member_email").toString(),
            blob
        ));
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }


  public List<Recipe> getRecipes() {
    return recipes;
  }

  public void setRecipes(List<Recipe> recipes) {
    this.recipes = recipes;
  }
}

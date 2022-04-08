package cookbook.databaseManagerTest;

import cookbook.database.databaseManager.DatabaseManager;
import cookbook.database.databaseManager.QueryType;
import java.sql.ResultSetMetaData;

import cookbook.models.recipe.Recipe;
import cookbook.tableInstances.recipes.Recipes;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;

public class DatabaseManagerTest {
  @Test
  void testOpenConnection() {
    DatabaseManager dbManager = new DatabaseManager();
    dbManager.openConnection();
    assert dbManager.getCon() != null;
  }

  @Test
  void testCloseConnection() throws SQLException {
    DatabaseManager dbManager = new DatabaseManager();
    dbManager.openConnection();
    assert dbManager.getCon() != null;
    dbManager.closeConnection();
    assert dbManager.getCon().isClosed();
  }

  @Test
  void testImprovedQueryResult() {
    DatabaseManager dbManager = new DatabaseManager();
    dbManager.openConnection();
    assert dbManager.getCon() != null;
    dbManager.query("SELECT * FROM members WHERE email = 'abolandr@gnu.org'", QueryType.execute);
    System.out.println(dbManager.getQueryResult().get(0).get("password"));
  }

  @Test
  void testGetMemberFromDatabase() throws SQLException {
    DatabaseManager dbManager = new DatabaseManager();
    dbManager.openConnection();
    assert dbManager.getCon() != null;
    dbManager.query("select profile_picture from members where email = 'ymcjarrowj@yandex.ru';", QueryType.execute);
    ResultSetMetaData rsmd = dbManager.getResultSet().getMetaData();
    int columnsNumber = rsmd.getColumnCount();
    while (dbManager.getResultSet().next()){
      for (int i = 1; i <= columnsNumber; i++) {
        if (i > 1) System.out.print(",  ");
        String columnValue = dbManager.getResultSet().getString(i);
        System.out.print(rsmd.getColumnName(i) + ": " + columnValue );
      }
      System.out.println();
    }
  }

  @Test
  void testInitRecipe() throws SQLException {
    Recipes recipes = new Recipes();
    assert recipes.getRecipes().get(0).getTitle().equals("Crock Pot Italian Zucchini");
  }
}

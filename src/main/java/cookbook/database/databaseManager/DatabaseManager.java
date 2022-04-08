package cookbook.database.databaseManager;

// TODO : Fix Checkstyle
import cookbook.database.databaseManagerInterface.DatabaseManagerInterface;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cookbook.database.databaseManager.QueryType.update;

/**
 * This class automatically connects to the database and keeps the connection stable.
 * It also allows querying from the database.
 */
public class DatabaseManager implements DatabaseManagerInterface {
  final String connectionUrl = "jdbc:mysql://beryllium.mysql.database.azure.com:3306/cookbook?useSSL=true";
  final String usr = "beryllium";
  final String password = "1dv508project!";
  private List<Map<String, Object>> queryResult = new ArrayList<>();
  private ResultSet resultSet;
  private Connection con = null;

  public Connection getCon() {
    return con;
  }

  public List<Map<String, Object>> getQueryResult() {
    return queryResult;
  }

  public ResultSet getResultSet(){
    return resultSet;
  }

  public void setQueryResult(List<Map<String, Object>> queryResult) {
    this.queryResult = queryResult;
  }

  /**
   *  Automatically tries to connect to database on initialization.
   */
  public DatabaseManager() {
  }

  /**
   * Establishes connection to database.
   * @return con
   */
  public Connection openConnection() {
    try {
//      Class.forName(driver);
      con = DriverManager.getConnection(connectionUrl, usr, password);
      System.out.println("Test Database Manager.openConnection()");
    } catch (SQLException e) {
      e.printStackTrace();
    } return con;
  }

  /**
   * Closing the connection.
   */
  public void closeConnection() {
    try {
      this.con.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  @Override
  public void query(String query, QueryType type) {
    try {
      queryResult = new ArrayList<>();
      var rs = new Object();
      openConnection();
      PreparedStatement preparedStatement = con.prepareStatement(query,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
      resultSet = preparedStatement.executeQuery();

      ResultSetMetaData rsmd = resultSet.getMetaData();
      int cols = rsmd.getColumnCount();
      while (resultSet.next()){
        Map<String, Object> rows = new HashMap<>(cols);
        for (int i = 1; i <= cols; i++) {
          rows.put(rsmd.getColumnName(i), resultSet.getObject(i));
        }
        queryResult.add(rows);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  @Override
  public void createDatabase() {

  }

  @Override
  public void createTable() {

  }

  @Override
  public void createUser() {

  }

  @Override
  public void createView() {

  }

  @Override
  public void updateTable() {

  }

  @Override
  public void updateView() {

  }

  @Override
  public void dropDatabase() {

  }

  @Override
  public void dropTable() {

  }

  @Override
  public void dropUser() {

  }

  @Override
  public void dropView() {

  }

  @Override
  public void alterTable() {

  }

  @Override
  public void alterUser() {

  }

  @Override
  public void alterView() {

  }

  @Override
  public void insertIntoTable(String tableName, List<String> params) {
    openConnection();
    System.out.println("INSERT INTO " + tableName + " VALUES('" + String.join("', '", params) + "');");
    query("INSERT INTO " + tableName + " VALUES('" + String.join("', '", params + "');"), QueryType.update);
    closeConnection();
  }

  @Override
  public void deleteFromTable() {

  }


  @Override
  public void useDatabase() {

  }
}

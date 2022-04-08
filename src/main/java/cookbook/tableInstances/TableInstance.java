package cookbook.tableInstances;

import cookbook.database.databaseManager.DatabaseManager;

import cookbook.database.databaseManager.QueryType;
import java.util.List;
import java.util.Map;

public abstract class TableInstance {
  private final DatabaseManager session;

  public TableInstance() {
    this.session = new DatabaseManager();
  }

  public void fetch(String query) {
    session.query(query, QueryType.execute);
  }

  public void filter(String category, String parameter) {}

  public DatabaseManager getSession() {
    return session;
  }

  public List<Map<String, Object>> getQueryResult() {
    return session.getQueryResult();
  }
}

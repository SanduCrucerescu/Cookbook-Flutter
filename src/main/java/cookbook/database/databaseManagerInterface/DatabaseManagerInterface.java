package cookbook.database.databaseManagerInterface;

import cookbook.database.databaseManager.QueryType;

import java.util.List;

public interface DatabaseManagerInterface {
    void createDatabase();

    void createTable();

    void createUser();

    void createView();

    void updateTable();

    void updateView();

    void dropDatabase();

    void dropTable();

    void dropUser();

    void dropView();

    void alterTable();

    void alterUser();

    void alterView();

    void insertIntoTable(String tableName, List<String> params);

    void deleteFromTable();

    void query(String query, QueryType type);

    void useDatabase();
}

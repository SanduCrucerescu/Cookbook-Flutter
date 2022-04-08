package cookbook.Login;

import cookbook.Main.MenuUI;
import cookbook.database.databaseManager.DatabaseManager;
import cookbook.database.databaseManager.QueryType;
import cookbook.models.member.Member;
import java.io.FileNotFoundException;
import java.sql.Blob;
import java.sql.SQLException;
import javafx.stage.Stage;

public class LoginActions {
  protected static Member member;

  public static void setMember(String email, String password) throws SQLException {
    DatabaseManager databaseManager = new DatabaseManager();
    String createMember = String.format("SELECT * FROM members where email = '%s' and password = '%s';", email, password);
    member = new Member();
    databaseManager.query(createMember, QueryType.execute);
    member.setEmail((String) databaseManager.getQueryResult().get(0).get("email"));
    member.setPassword((String) databaseManager.getQueryResult().get(0).get("password"));
    member.setUsername((String) databaseManager.getQueryResult().get(0).get("username"));
    Blob blob = databaseManager.openConnection().createBlob();
    blob.setBytes(1, (byte[]) databaseManager.getQueryResult().get(0).get("profile_picture"));
    member.setProfile_picture(blob);
  }

  public static Member getMember(){
    return member;
  }

  public static boolean onClick(String email, String password) {
    DatabaseManager databaseManager = new DatabaseManager();
    Stage menu = new Stage();
    MenuUI menuUI = new MenuUI();

    String querry = String.format("SELECT EXISTS(SELECT email, password FROM members where email = '%s' and password = '%s');", email, password);
    databaseManager.query(querry, QueryType.execute);

    try {
      if (databaseManager.getResultSet().first()) {
        if (databaseManager.getResultSet().getInt(1) == 1){
          try {
            LoginActions.setMember(email, password);
            menuUI.start(menu);
            menu.show();
            return true;
          } catch (FileNotFoundException e) {
            e.printStackTrace();
          }
        }
      }
    } catch (SQLException e){
      e.printStackTrace();
    }
    return false;
  }
}

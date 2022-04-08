package cookbook.Main;

import cookbook.tableInstances.recipes.Recipes;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javafx.geometry.Insets;
import javafx.geometry.Rectangle2D;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.Priority;
import javafx.scene.layout.VBox;
import javafx.scene.paint.ImagePattern;
import javafx.scene.shape.Rectangle;
import javafx.stage.Screen;

public class AllRepies {
  private ScrollPane sp;

  public ScrollPane getSp() {
    return sp;
  }

  public void setSp(ScrollPane sp) {
    this.sp = sp;
  }

  public void makeScrollPane(){
    Recipes recipes = new Recipes();
    FlowPane fp = new FlowPane(); fp.setStyle("-fx-background-color: yellow");
    Rectangle2D sb = Screen.getPrimary().getBounds();

    for (int i = 0; i < recipes.getRecipes().size(); i++) {
      VBox vBox = new VBox(); vBox.setStyle("-fx-background-color: red");
      vBox.setMaxWidth(sb.getWidth() / 3.84);
      vBox.setMinWidth(sb.getHeight() / 3);

      Rectangle rectangle = new Rectangle( sb.getWidth() / 3.84, sb.getHeight() / 3);
      VBox.setVgrow(rectangle, Priority.ALWAYS);

      try {
        Blob blob = recipes.getRecipes().get(i).getRecipe_pic();
        InputStream inputStream = blob.getBinaryStream();
        Image image = new Image(inputStream);
        rectangle.setFill(new ImagePattern(image));
      } catch (SQLException e) {
        e.printStackTrace();
      }
      Button btn = new Button("View recipe");
      Label lbl = new Label();
      lbl.setStyle("-fx-background-color: black");
      vBox.getChildren().addAll(rectangle, btn, lbl);
      fp.setHgap(20);
      fp.setVgap(20);
      fp.getChildren().addAll(vBox);
    }

    sp = new ScrollPane();
    sp.setContent(fp);
//    sp.fitToHeightProperty().set(true);
    sp.fitToWidthProperty().set(true);
    setSp(sp);
  }
}

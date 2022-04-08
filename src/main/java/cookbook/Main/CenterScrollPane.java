package cookbook.Main;

import javafx.application.Application;
import javafx.beans.binding.Bindings;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.image.Image;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.ImagePattern;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;


public class CenterScrollPane extends Application {
  @Override
  public void init() throws Exception {
    super.init();
  }

  @Override
  public void stop() throws Exception {
    super.stop();
  }

  public static void main(String[] args) { launch(); }

  @Override
  public void start(Stage stage) {
    FlowPane fp = new FlowPane();

    for (int i = 0; i < 100; i++) {
      VBox vBox = new VBox(); vBox.setStyle("-fx-background-color: #f79421");
      Button btn = new Button("View recipe");
      Label lbl = new Label("Mix together all ingredients in your crockpot.' 'Cook 4 hours on high.' 'Enjoy.");
      Rectangle rectangle = new Rectangle( 546, 336); //haha

      Image image = new Image("profile.png");
      rectangle.setFill(new ImagePattern(image));

      vBox.getChildren().addAll(rectangle, btn, lbl);
      fp.setHgap(50);
      fp.setVgap(50);
      fp.getChildren().add(vBox);
      }
    ScrollPane sp = new ScrollPane();
      sp.setContent(fp);
      sp.fitToHeightProperty().set(true);
      sp.fitToWidthProperty().set(true);
    Scene scene = new Scene(sp);

    stage.setTitle("Scroll Pane Example");
    stage.setFullScreen(true);
    stage.setScene(scene);
    stage.show();
  }
}

package cookbook.Main;

import cookbook.AddingRecipie.AddingUI;
import cookbook.Login.LoginActions;
import cookbook.database.databaseManager.DatabaseManager;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import javafx.geometry.Insets;
import javafx.geometry.Rectangle2D;
import javafx.scene.control.Button;
import java.io.FileNotFoundException;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.scene.paint.ImagePattern;
import javafx.scene.shape.Circle;
import javafx.stage.Screen;
import javafx.stage.Stage;

public class MenuUI extends Application {
  public static void main(String[] args) {
    launch(args);
  }

  @Override
  public void start(Stage primaryStage) throws FileNotFoundException {
    double padding = 0;
    Rectangle2D sb = Screen.getPrimary().getBounds();
    BorderPane borderPane = new BorderPane(); borderPane.getStyleClass().add("firstBorderPane");
    borderPane.setMinHeight(Region.USE_COMPUTED_SIZE);
    borderPane.setMinWidth(Region.USE_COMPUTED_SIZE);
    BorderPane centerPane = new BorderPane();
    centerPane.setMinHeight(Region.USE_COMPUTED_SIZE);
    centerPane.setMinWidth(Region.USE_COMPUTED_SIZE);

    if(sb.getWidth() >= 2000){
      padding = 42.5;
    } else if (sb.getWidth() <= 2000){
      padding = 28;
    }

    // controls for the borderpane
    VBox leftMenu = new VBox(); leftMenu.getStyleClass().add("vbox");
    Button logoBtn = new Button(); logoBtn.getStyleClass().add("logo");
    Button cart = new Button(); cart.getStyleClass().add("cart");
    Button favorites = new Button(); favorites.getStyleClass().add("favorites");
    Button addRecepies = new Button(); addRecepies.getStyleClass().add("add");

    double finalPadding = padding;
    addRecepies.setOnAction(event -> {
      AddingUI addingUI = new AddingUI();
      addingUI.makeGridPane();
      GridPane gridPane = addingUI.getGridPane(); gridPane.getStyleClass().add("gridPane");
      BorderPane.setMargin(gridPane, new Insets(sb.getWidth() / finalPadding, sb.getHeight() / finalPadding, 0 , sb.getHeight() /
          finalPadding));
      centerPane.setCenter(gridPane);
    });

    // controls for the centerPane
    HBox topPart = new HBox(); topPart.getStyleClass().add("topPart");
    TextField search = new TextField(); search.getStyleClass().add("search"); search.setPromptText("Search Recipes");
    Circle photo = new Circle(100,100, 30);
    Label userName = new Label(); userName.setText(LoginActions.getMember().getUsername()); userName.getStyleClass().add("name");

    Image def = new Image("profile.png");
    photo.setFill(new ImagePattern(def));

    try {
      if (LoginActions.getMember().getProfile_picture() != null) {
        Blob blob = LoginActions.getMember().getProfile_picture();
        InputStream inputStream = blob.getBinaryStream();
        Image image = new Image(inputStream);
        photo.setFill(new ImagePattern(image));
      }
    } catch (SQLException e){
      e.printStackTrace();
    }


    //BorderPane.setMargin(topPart, new Insets(0, sb.getHeight() / padding, 0 , sb.getHeight() / padding));
    HBox.setHgrow(search, Priority.ALWAYS);
    topPart.getChildren().addAll(search, userName, photo);

    centerPane.setTop(topPart);

    AllRepies allRepies = new AllRepies();
    allRepies.makeScrollPane();
    ScrollPane centerScrollPane = allRepies.getSp(); centerScrollPane.getStyleClass().add("scrollPane");


    leftMenu.getChildren().addAll(logoBtn, cart, favorites, addRecepies);
    leftMenu.setPadding(new Insets(25, 25, 0, 25));
    VBox.setVgrow(leftMenu, Priority.ALWAYS);
    borderPane.setLeft(leftMenu);
    borderPane.setCenter(centerPane);
    BorderPane.setMargin(centerScrollPane, new Insets(25, 25, 0 , 25));
    centerPane.setCenter(centerScrollPane);
    Scene scene = new Scene(borderPane, 1400, 800);
    scene.getStylesheets().add("designMenu.css");

    primaryStage.setScene(scene);
    primaryStage.show();
  }
}

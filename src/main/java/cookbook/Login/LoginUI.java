package cookbook.Login;

import javafx.animation.PauseTransition;
import javafx.application.Application;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.scene.control.TextField;
import javafx.scene.effect.DropShadow;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.stage.Screen;
import javafx.stage.Stage;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import javafx.util.Duration;


public class LoginUI extends Application {

  public static void main(String[] args) {
    launch(args);
  }

  @Override
  public void start(Stage primaryStage) throws FileNotFoundException {
    Image background = new Image(new FileInputStream("src/main/resources/Background-Login-100.jpg"));
    Image logo = new Image(new FileInputStream("src/main/resources/LogoLogin.png"));
    ImageView selectedImage = new ImageView(background);
    DropShadow shadow = new DropShadow();

    selectedImage.fitHeightProperty().bind(primaryStage.heightProperty());
    selectedImage.fitWidthProperty().bind(primaryStage.widthProperty());
    selectedImage.setPreserveRatio(false);

    ImageView selectedImage1 = new ImageView(logo);
    BorderPane border = new BorderPane();


    VBox vBox = new VBox(selectedImage1);
    vBox.getStyleClass().add("vbox");

    TextField email = new TextField("abolandr@gnu.org");
    email.getStyleClass().add("text");
    email.setPromptText("Email");

    TextField password = new TextField("xbsxysKe53");
    password.getStyleClass().add("text");
    password.setPromptText("Password");

    Label warning = new Label();
    warning.getStyleClass().add("warning");

    Button logIn = new Button("Log In");
    logIn.getStyleClass().add("buttons");

    // drop shadow on login button
    logIn.setOnMouseEntered(e -> {
      logIn.setEffect(shadow);
    });
    logIn.setOnMouseExited(r -> {
      logIn.setEffect(null);
    });

    // drop shadow on login button
    logIn.setOnMouseEntered(e -> {
      logIn.setEffect(shadow);
    });
    logIn.setOnMouseExited(r -> {
      logIn.setEffect(null);
    });

    // button to log in and to check is the fields are empty or not.
    logIn.setOnAction(event -> {
      if (!email.getText().trim().isEmpty() || !password.getText().trim().isEmpty()) {
        if (LoginActions.onClick(email.getText(), password.getText())) {
          primaryStage.close();
        } else {
          warning.setText("*wrong email or password");
        }
      } else {
        warning.setText("*please fill all the fields");
      }
    });

    vBox.setFillWidth(false);

    vBox.getChildren().addAll(warning, email, password, logIn);
    selectedImage.setImage(background);
    border.getChildren().addAll(selectedImage);
    border.setCenter(vBox);


    Scene scene = new Scene(border, 768, 620);
    Splash splash = new Splash();
    splash.show();

    primaryStage.setScene(splash.getSplashScene());
    primaryStage.show();
    PauseTransition delay = new PauseTransition(Duration.seconds(2));
    delay.setOnFinished(event -> primaryStage.setScene(scene) );
    delay.play();
    scene.getStylesheets().add("designLoginUI.css");

    primaryStage.setScene(splash.getSplashScene());
    primaryStage.show();
    scene.getStylesheets().add("designLoginUI.css");

  }


  public void close(Stage primaryStage) {
    primaryStage.close();
  }
}

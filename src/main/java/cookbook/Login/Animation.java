package cookbook.Login;

import javafx.application.Application;
import javafx.stage.Stage;

/**
 * Main class for testing the Welcome Screen
 */
public class Animation extends Application {

  @Override
  public void start(Stage stage) {

    Splash splash = new Splash();
    splash.show();
    stage.setScene(splash.getSplashScene());
    splash.getSequentialTransition().setOnFinished(e -> {
    });
    stage.show();

  }

  // Run just the animation
  public static void main(String[] args) {
    launch(args);
  }

}

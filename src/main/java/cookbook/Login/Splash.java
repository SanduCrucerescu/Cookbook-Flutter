package cookbook.Login;

import javafx.animation.*;

import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.util.Duration;


/**
 * This is my own splash screen, that I made myself.
 */
public class Splash {

    static Scene splash;
    // Moving rectangle why not
    static Rectangle rect = new Rectangle();
    final private Pane pane;
    final private SequentialTransition seqT;

    public Splash() {
        pane = new Pane();
        Image imggg = new Image("file:src/main/resources/Background-Login-100.jpg");
        BackgroundImage bImg = new BackgroundImage(imggg,
                BackgroundRepeat.REPEAT,
                BackgroundRepeat.REPEAT,
                BackgroundPosition.CENTER,
                BackgroundSize.DEFAULT);
        Background bGround = new Background(bImg);
        pane.setBackground(bGround);

        splash = new Scene(pane, 768, 620);
        seqT = new SequentialTransition();
    }

    // Rectangle
    public void show() {
        //Size
        int scale = 40;
        //Speed
        int dur = 500;
        rect = new Rectangle(100 - 2 * scale, 20, scale, scale);
        rect.setFill(Color.BEIGE);

        // Rolls
        int[] rotins = {2 * scale, 3 * scale, 4 * scale, 5 * scale, 6 * scale, 7 * scale, 8 * scale, 9 * scale};
        int x, y;
        for (int i : rotins) {
            //rotating the square
            RotateTransition rt = new RotateTransition(Duration.millis(dur), rect);
            rt.setByAngle(i / Math.abs(i) * 90);
            rt.setCycleCount(1);
            //moving the square horizontally
            TranslateTransition pt = new TranslateTransition(Duration.millis(dur), rect);
            x = (int) (rect.getX() + Math.abs(i));
            y = (int) (rect.getX() + Math.abs(i) + (Math.abs(i) / i) * scale);
            pt.setFromX(x);
            pt.setToX(y);

            ParallelTransition pat = new ParallelTransition();
            pat.getChildren().addAll(pt, rt);
            pat.setCycleCount(1);
            seqT.getChildren().add(pat);
        }
        //playing the animation
        seqT.play();
        seqT.setNode(rect);
        //The text part may replace with images
        Label lab = new Label("Welcome\nLoading...");
        lab.setFont(new Font("Calibri", 40));
        lab.setStyle("-fx-text-fill:black");
        lab.setLayoutX(300);
        lab.setLayoutY(500);
        rect.setLayoutX(350);
        rect.setLayoutY(400);

        Image logo = new Image("file:src/main/resources/LogoLogin.png");
        // Create an image view that uses the image.
        ImageView iv = new ImageView(logo);
        iv.fitHeightProperty();
        iv.fitWidthProperty();
        iv.setLayoutY(100);
        iv.setLayoutX(280);

        // Loading cogwheel
        ProgressIndicator progressIndicator = new ProgressIndicator();
        progressIndicator.setLayoutX(350);
        progressIndicator.setLayoutY(400);
        progressIndicator.setStyle("-fx-accent: #0c0c0c;");
        progressIndicator.setPrefSize(6000, 6000);
        // Fade in transitions for image and text
        //Image
        FadeTransition fade = new FadeTransition(Duration.seconds(2), iv);
        fade.setFromValue(0.0);
        fade.setToValue(1.0);
        fade.play();
        // Text
        FadeTransition loading = new FadeTransition(Duration.seconds(1), lab);
        loading.setFromValue(0.0);
        loading.setToValue(1.0);
        loading.play();
        pane.getChildren().addAll(lab, iv, progressIndicator);

        seqT.play();
    }

    public Scene getSplashScene() {
        return splash;
    }

    public SequentialTransition getSequentialTransition() {
        return seqT;
    }
}
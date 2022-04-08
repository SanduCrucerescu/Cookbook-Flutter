package cookbook.AddingRecipie;


import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;

public class AddingUI {
  private GridPane gridPane;

  public GridPane getGridPane() {
    return gridPane;
  }

  public void setGridPane(GridPane gridPane) {
    this.gridPane = gridPane;
  }

  public void makeGridPane(){
    gridPane = new GridPane();
    Button button1 = new Button("Button 1");

    TextField recipeName = new TextField();

    gridPane.add(recipeName, 0,0);


  }
}

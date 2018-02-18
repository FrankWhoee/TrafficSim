import java.util.ArrayList;

public class Car extends Entity {
  
  public boolean collidingWithRoads;
  public Position objective;
  public ArrayList<Position> path;
  
    public Car(final int id, final float xPos, final float yPos, final int health, final Position objective) {
        super(id, xPos, yPos, health, Constants.CAR_RADIUS);
        this.objective = objective;
    }
    
    

}
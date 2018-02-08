import java.util.ArrayList;

public class Car extends Entity {
    
  public boolean collidingWithRoads;
  
    public Car(final int id, final float xPos, final float yPos,
                final int health) {

        super(id, xPos, yPos, health, Constants.CAR_RADIUS);
    }
    
    

}
public class Car extends Entity {
  
  
    public Car(final int id, final double xPos, final double yPos,
                final int health) {

        super(id, xPos, yPos, health, Constants.CAR_RADIUS);
    }

}
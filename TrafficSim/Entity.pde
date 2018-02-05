public class Entity extends Position {

    private final int id;
    private final int health;
    private final double radius;

    public Entity(final int id, final double xPos, final double yPos, final int health, final double radius) {
        super(xPos, yPos);
        this.id = id;
        this.health = health;
        this.radius = radius;
    }


    public int getId() {
        return id;
    }

    public int getHealth() {
        return health;
    }

    public double getRadius() {
        return radius;
    }

}
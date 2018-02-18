public class Entity extends Position {

    private final int id;
    private final int health;
    private final float diameter;

    public Entity(final int id, final float xPos, final float yPos, final int health, final float diameter) {
        super(xPos, yPos);
        this.id = id;
        this.health = health;
        this.diameter = diameter;
    }


    public int getId() {
        return id;
    }

    public int getHealth() {
        return health;
    }

    public float getRadius() {
        return diameter/2;
    }

}
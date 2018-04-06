public class Entity extends Position {

    private final int id;
    private final int health;
    private final float radius;

    public Entity(final int id, final float xPos, final float yPos, final int health, final float radius) {
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

    public float getRadius() {
        return radius;
    }

}
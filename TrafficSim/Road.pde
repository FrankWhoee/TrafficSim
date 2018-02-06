public class Road extends Position {
 
    private final int id;
    private final float width;
    private final float height;
    public Road(final int id, final float xPos, final float yPos, float width, float height) {
        super(xPos, yPos);
        this.id = id; 
        this.width = width;
        this.height = height;
      }


    public int getId() {
        return id;
    }
    
    public float getWidth(){
      return width;
    }
    
    public float getHeight(){
      return height;
    }
    
    


  
}
import java.util.ArrayList;

public class Road extends Position {
 
    public int id;
    public float width;
    public float height;

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
    
    
    
    public ArrayList<Car> getCarList(){
      ArrayList<Car> carsOnRoad = new ArrayList<Car>();
      for(Car car: TrafficSim.Cars){
        if(width > height){
           if(car.getYPos() > super.yPos && car.getYPos() < (super.yPos + height)){
             carsOnRoad.add(car);
           }
        }else{
          if(car.getXPos() > super.xPos && car.getXPos() < (super.xPos + width)){
             carsOnRoad.add(car);
           }
        }
      }
      return carsOnRoad;
    }


  
}
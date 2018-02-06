import java.util.*;

ArrayList<Car> Cars = new ArrayList<Car>();
private static int nextCarId = 0;
private int screenWidth = 1280;
private int screenHeight = 720;

void generateCars(int amount, float screenWidth, float screenHeight){
      for(int i =0; i < amount; i++){
        Car newCar = createNewCar(screenWidth,screenHeight);
        Cars.add(newCar);
      }
}

Car createNewCar(float screenWidth, float screenHeight){
    float x = (float)(Math.random() * screenWidth);
    float y = (float)(Math.random() * screenHeight);
    Car newCar = new Car(nextCarId,x,y, Constants.MAX_HEALTH);
    return newCar;
}


void setup() {
  size(1280, 720);
   generateCars(10,1280,720);
}

void draw() {
  background(0);
  runCars();
  renderCars();
}

public ArrayList<Car> getSortedCars(Car car){
        ArrayList<Car> sortedCars = new ArrayList<Car>();
        Car removed;
        sortedCars = new ArrayList<Car>();
        for(Car cars: Cars){
          if(cars != car){
            sortedCars.add(cars);
          }
            
        }
        int index;
        for(int k = 0; k < sortedCars.size() - 1; k++){
            index = k;
            for(int i = k + 1; i < sortedCars.size(); i++){
                if(sortedCars.get(index).getDistanceTo(car) > sortedCars.get(i).getDistanceTo(car)){
                    index = i;
                }else if(sortedCars.get(index).getDistanceTo(car) == sortedCars.get(i).getDistanceTo(car)){
                    if(sortedCars.get(index).getHealth() > sortedCars.get(i).getHealth()){
                      index = i;
                    }
                }
            }
            removed = sortedCars.get(k);
            sortedCars.set(k, sortedCars.get(index));
            sortedCars.set(index, removed);
        }
      return sortedCars;  
}

void runCars(){
  //TODO: Add sentience to cars.
  for(int i = 0; i < Cars.size(); i++){
    ArrayList<Car> sortedCars = getSortedCars(Cars.get(i));
    
    if(sortedCars.get(0).getDistanceTo(Cars.get(i)) > 5){
      float angleRad = Cars.get(i).orientTowardsInRad(sortedCars.get(0));
      float thrust = 5;
      Cars.get(i).move(angleRad, thrust);
    }else{
      float angleRad = Cars.get(i).orientTowardsInRad(sortedCars.get(1)) + 180;
      float thrust = 5;
      Cars.get(i).move(angleRad, thrust);
    }
    
  }
  
}

void renderCars(){
  fill(255);
  noStroke();
  for(Car car : Cars){
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
  }
  
}
  
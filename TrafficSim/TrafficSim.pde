import java.util.*;

ArrayList<Car> Cars = new ArrayList<Car>();
ArrayList<Road> Roads = new ArrayList<Road>();
private static int nextCarId = 0;
public int displayWidth = 1280;
public int displayHeight = 720;

void generateCars(int amount, float screenWidth, float screenHeight){
      for(int i =0; i < amount; i++){
        Car newCar = createNewCar(screenWidth,screenHeight);
        Cars.add(newCar);
        nextCarId++;
      }
}

Car createNewCar(float screenWidth, float screenHeight){
    float x = (float)(Math.random() * screenWidth);
    float y = (float)(Math.random() * screenHeight);
    Car newCar = new Car(nextCarId,x,y, Constants.MAX_HEALTH);
    return newCar;
}


void setup() {
  size(displayWidth, displayHeight);
   generateCars(100,1280,720);
}

void draw() {
  background(0);
  runCars();
  render();
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
  for(int i = 1; i < Cars.size() - 1; i++){
    //ArrayList<Car> sortedCars = getSortedCars(Cars.get(i));
  }
  
}

void render(){
  fill(255);
  noStroke();
  
  
  for(Road road: Roads){
    rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  }
  
  
  for(Car car : Cars){
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
  }
  
  
}
  
import java.util.*;

ArrayList<Car> Cars = new ArrayList<Car>();
private static int nextCarId = 0;

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
  size(640, 360);
   generateCars(10,640,360);
}

void draw() {
  background(0);
  runCars();
  renderCars();
}

void runCars(){
  //TODO: Add sentience to cars.
  for(int i = 0; i < Cars.size(); i++){
    float randomAngleRad = (float)(Math.random() * Math.PI * 2);
    float randomThrust = (float)Math.random() * 5;
     Cars.get(i).move(randomAngleRad, randomThrust);
  }
  
}

void renderCars(){
  fill(255);
  noStroke();
  for(Car car : Cars){
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
  }
  
}
  
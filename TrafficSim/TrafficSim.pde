import java.util.*;

public ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
private static int nextCarId = 0;
private static int nextRoadId = 0;
public int displayWidth = 1280;
public int displayHeight = 720;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;

Road roadH = new Road(0,0, centerY - 20, displayWidth, 40);
Road roadV = new Road(1,centerX - 20,0, 40, displayHeight);
Road roadV2 = new Road(1,500,0, 40, displayHeight);



void generateCars(int amount, float screenWidth, float screenHeight){
      for(Road road: Roads){
        for(int i = 0; i < amount/Roads.size(); i++){
          
          if(road.getWidth() > road.getHeight()){
            if(Math.random() > 0.5){
              Car newCar = createNewCar(road.getWidth(), road.getYPos() + road.getHeight()/2);
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car");
            }else{
              Car newCar = createNewCar(road.getXPos(), road.getYPos() + road.getHeight()/2);
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car");
            }
            
          }else{
            if(Math.random() > 0.5){
              Car newCar = createNewCar(road.getXPos() + road.getWidth()/2, road.getHeight());
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car");
            }else{
              Car newCar = createNewCar(road.getXPos() + road.getWidth()/2, road.getYPos());
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car");              
            }
            
          }
        }
      }
      System.out.println("Cars generated.");
}

Car createNewCar(float x, float y){
    Car newCar = new Car(nextCarId,x,y, Constants.MAX_HEALTH);
    return newCar;
}


void setup() {
  size(displayWidth, displayHeight);
   
   System.out.println("roadH width:  " + roadH.getWidth());
   System.out.println("roadH width:  " + roadV.getHeight());
   Roads.add(roadH);
   Roads.add(roadV);
   Roads.add(roadV2);
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
    float angleRad = Cars.get(i).orientTowardsInRad(new Position(centerX, centerY));
    Cars.get(i).move(angleRad, 5);
  }
  
}

void render(){
  fill(100);
  noStroke();
  
  
  for(Road road: Roads){
    rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  }
  
  fill(255);
  noStroke();
  for(Car car : Cars){
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
  }
  
  
}
  
import java.util.*;

public ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
private static int nextCarId = 0;
private static int nextRoadId = 0;
public int displayWidth = 1280;
public int displayHeight = 720;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;

Road roadH = new Road(0,0, centerY - 20, displayWidth, 100);
Road roadV = new Road(1,centerX - 20,0, 100, displayHeight);
Road roadV2 = new Road(1,500,0, 100, displayHeight);



void generateCars(int amount, float screenWidth, float screenHeight){
      for(Road road: Roads){
        for(int i = 0; i < amount/Roads.size(); i++){
          
          if(road.getWidth() > road.getHeight()){
            if(nextCarId % amount/Roads.size() == 1){
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
            if(nextCarId % amount/Roads.size() == 1){
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
   generateCars(20,1280,720);
}

void draw() {
  background(0);
  runCars();
  render();
  renderLine();
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
    Cars.get(i).move(angleRad, 1);
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
    if(car.collidingWithRoads){
      fill(255,0,0);
    }else{
      fill(255);
    }
    
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
  }
  
  
}

void renderLine(){
  int chosenRoad = 2;
  int chosenCar = 6;
  float carX = Cars.get(chosenCar).getXPos() + 16;
  float carY = Cars.get(chosenCar).getYPos() + 16;

  float roadX = Roads.get(chosenRoad).getXPos();
  float roadY = Roads.get(chosenRoad).getYPos();
  float roadWidth = Roads.get(chosenRoad).getWidth();
  float roadHeight = Roads.get(chosenRoad).getHeight();
  
  float closestX = Math.max(roadX, Math.min(carX, roadX + roadWidth));
  float closestY = Math.max(roadY, Math.min(carY, roadY + roadHeight));
  //System.out.println("closestY: " + closestY + " car y: " + carY);
  //System.out.println("roadY: " + roadY + " roadHeight: " + roadHeight);
  float dx = carX - closestX;
  float dy = carY - closestY;
  if(((dx * dx) + (dy * dy)) < 64){
    stroke(255,0,0);
  }else{
    stroke(0,255,0);
  } 
  line(Cars.get(chosenCar).getXPos(),Cars.get(chosenCar).getYPos(),closestX, closestY);
 }
  
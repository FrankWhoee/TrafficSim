import java.util.*;

public ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
private static int nextCarId = 0;
private static int nextRoadId = 0;
public int displayWidth = 1280;
public int displayHeight = 720;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;
public int turn = 0;


Road roadH = new Road(0,0, centerY - 20, displayWidth, 100);
Road roadV = new Road(1,centerX - 20,0, 100, displayHeight);
Road roadV2 = new Road(2,500,0, 100, displayHeight);
Road roadV3 = new Road(3,100,0, 100, displayHeight);
Road roadH2 = new Road(4,0, centerY - 200, displayWidth, 100);
Road roadH3 = new Road(4,0, centerY + 200, displayWidth, 100);

void generateCars(int amount){
      for(Road road: Roads){
        for(int i = 0; i < Math.min(amount, 1); i++){
          
          if(road.getWidth() > road.getHeight()){
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(road.getWidth(), road.getYPos() + road.getHeight()/2);
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car Location: Right Side");
            }else{
              Car newCar = createNewCar(road.getXPos(), road.getYPos() + road.getHeight()/2);
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car Location: Left Side");
            }
            
          }else{
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(road.getXPos() + road.getWidth()/2, road.getHeight());
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car Location: Lower Side");
            }else{
              Car newCar = createNewCar(road.getXPos() + road.getWidth()/2, road.getYPos());
              Cars.add(newCar);
              nextCarId++;
              System.out.println(newCar.getId() + " spawned. Type: Car Location: Upper Side");              
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
   Roads.add(roadV3);
   Roads.add(roadH2);
   Roads.add(roadH3);
    generateCars(12);
  
}

void draw() {
  background(0);
  
  render();
  runCars();
  renderLine();
  
  turn++;
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
    Car car = Cars.get(i);
    if(car.getXPos() > centerX - 10 && car.getXPos() < centerX + 10 && car.getYPos() > centerY - 10 && car.getYPos() < centerY + 10){
      //Cars.remove(i);
    }
  }
  
  for(Car car: Cars){
    //ArrayList<Car> sortedCars = getSortedCars(Cars.get(i));
    
    
    
    float angleRad = car.orientTowardsInRad(new Position(centerX, centerY));
    car.move(angleRad, 1);
    //System.out.println(car.getId() + " completed calculations. Next Position: x: " + car.getXPos() + " y: " + car.getYPos());
  }
  
}

void render(){
  fill(100);
  noStroke();
  
  
  for(Road road: Roads){
    rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  }
  
  noStroke();
  for(Car car : Cars){
    if(car.collidingWithRoads){
      fill(0,255,0);
    }else{
      fill(255,0,0);
    }
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
    textSize(10);
    //String coordinates = "x: " + (int)car.getXPos() + " y: " + (int)car.getYPos();
    //String id = ("id: " + car.getId());
    //text(coordinates, car.getXPos() + 15, car.getYPos() + 15);
    //text(id, car.getXPos() + 15, car.getYPos() + 25);
  }
  
  
}

void renderLine(){
  for(int k = 0; k < Cars.size(); k++){
  int chosenCar = k;
  for(int i =0; i < Roads.size(); i ++){
        int chosenRoad = i;
        float carX = Cars.get(chosenCar).getXPos();
        float carY = Cars.get(chosenCar).getYPos();
      
        float roadX = Roads.get(chosenRoad).getXPos();
        float roadY = Roads.get(chosenRoad).getYPos();
        float roadWidth = Roads.get(chosenRoad).getWidth();
        float roadHeight = Roads.get(chosenRoad).getHeight();
        float offset = 0;
       if(roadWidth > roadHeight){
         roadHeight -= offset;
       }else{
         roadWidth -= offset;
       }
        float closestX = Math.max(roadX, Math.min(carX, roadX + roadWidth));
        float closestY = Math.max(roadY, Math.min(carY, roadY + roadHeight));
        float dx = carX - closestX;
        float dy = carY - closestY;
    if(((dx * dx) + (dy * dy)) < 64){
      stroke(255,0,0);
    }else{
      stroke(0,255,0);
    } 
    line(Cars.get(chosenCar).getXPos(),Cars.get(chosenCar).getYPos(),closestX, closestY);
    }
  }
 }
  
import java.util.*;
public static Map<Car,Velocity> carVectors = new HashMap<Car,Velocity>();

public static ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
public static ArrayList<Light> Lights = new ArrayList<Light>();

private static int nextCarId = 0;
private static int nextRoadId = 0;
private static int nextLightId = 0;
private static int lightsInterval = 199;

public int displayWidth = 1280;
public int displayHeight = 720;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;
public int turn = 0;
public float randomSpawnLocOffsetLength = 100;
public float randomSpawnLocOffsetWidth = 50;
public float defaultRoadWidth = 100;

char mode = 'v';
Road road = new Road(0,0,0,defaultRoadWidth,displayHeight);
boolean roadUIFinished = false;

void generateCars(int amount){
      for(Road road: Roads){
        for(int i = 0; i < Math.max(amount/Roads.size(), 1); i++){

          if(road.getWidth() > road.getHeight()){
            float newYPos = (road.getYPos() + 16) + (float)((road.getHeight() - 32) * Math.random());
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(road.getWidth() - (float)(Math.random() * randomSpawnLocOffsetLength), newYPos);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Right Side");
            }else{
              Car newCar = createNewCar(road.getXPos() + (float)(Math.random() * randomSpawnLocOffsetLength), newYPos);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Left Side");
            }
            
          }else{
            float newXPos = (road.getXPos() + 16) +  (float)((road.getWidth() - 32) * Math.random());
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(newXPos, road.getHeight() - (float)(Math.random() * randomSpawnLocOffsetLength));
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Lower Side");
            }else{
              Car newCar = createNewCar(newXPos, road.getYPos() + (float)(Math.random() * randomSpawnLocOffsetLength));
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Upper Side");              
            }
            
          }
        }
      }
      //System.out.println("Cars generated.");
}

void runCars(){
  //TODO: Add sentience to cars.
  for(Car car: Cars){
    ArrayList<Light> sortedLights = getSortedLights(car);
    float angleRad = car.orientTowardsInRad(car.objective);
    if(sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("yellow"))){
      car.move(angleRad, 1);
    }else if(sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("green"))){
      car.move(angleRad, 2);
    }else{
      car.move(angleRad, 2);
    }
    
    
  }
  
}

Car createNewCar(float x, float y){
    float randomX = (float)Math.random() * displayWidth;
    float randomY = (float)Math.random() * displayHeight;
    Position objective = new Position(randomX, randomY);
    Car newCar = new Car(nextCarId,x,y, Constants.MAX_HEALTH, objective);
    return newCar;
}

void roadUI(){
  
  if(keyPressed && (key == 'h' || key == 'v')){
    mode = key;
  }
  if(mode == 'h'){
    road.width = displayWidth;
    road.height = defaultRoadWidth;
    road.setPosition(new Position(0,road.getYPos()));
  }else if(mode == 'v'){
    road.width = defaultRoadWidth;
    road.height = displayWidth;
    road.setPosition(new Position(road.getXPos(),0));
  }
  
  if(keyPressed && keyCode == RIGHT && mode == 'v'){
    road.setPosition(new Position(road.getXPos() + 5, road.getYPos()));
  }else if(keyPressed && keyCode == LEFT && mode == 'v'){
    road.setPosition(new Position(road.getXPos() - 5, road.getYPos()));
  }else if(keyPressed && keyCode == UP && mode == 'h'){
    road.setPosition(new Position(road.getXPos(), road.getYPos() - 5));
  }else if(keyPressed && keyCode == DOWN && mode == 'h'){
    road.setPosition(new Position(road.getXPos(), road.getYPos() + 5));
  }
  
  if(keyPressed && key == ' '){
    Road newRoad = new Road(nextRoadId, road.getXPos(), road.getYPos(), road.width, road.height);
    Roads.add(newRoad);
    nextRoadId++;
    road.id = nextRoadId;
    System.out.println("road added");
    keyPressed = false;
  }
  
  if(keyPressed && (key == ENTER || key == RETURN)){
    System.out.println("Enter or Return pressed");
    roadUIFinished = true;
    generateCars(100);
    for(Road road: Roads){
     int intersections = 0;
     if(road.width > road.height){
       for(Road roads: Roads){
         if(roads.height > roads.width){
           intersections++;
           System.out.println("Horz-Vert Intersection detected. Total intersections: " + intersections);
         }
       }
     }else{
       for(Road roads: Roads){
         if(roads.width > roads.height){
           intersections++;
           System.out.println("Vert-Horz Intersection detected. Total intersections: " + intersections);
         }
       }
     }
     for(int i = 0; i < intersections * 2; i++){
       nextLightId++;
       Light newLight = new Light(nextLightId,road, "red");
       Lights.add(newLight);
       
     }
   }
  }
  
  
}

void setup() {
  int displayWidth = this.displayWidth + 100;
  int displayHeight = this.displayHeight + 100;
  size(displayWidth, displayHeight);
}

void draw() {
  if(roadUIFinished == false){
    background(0);
    roadUI();
    roadUIRender();
  }else{
     background(0);
    carVectors.clear();
    render();
    if(!keyPressed && key != 'l'){
      runCars();
    }
    //renderLine();
    runLights();
    turn++;
  }
 
}

void roadUIRender(){
  fill(75);
  noStroke();
  rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  
  for(Road roads: Roads){
    rect(roads.getXPos(),roads.getYPos(), roads.getWidth(), roads.getHeight());
    //System.out.println("road " + roads.getId() + " drawn at x: " + roads.getXPos() + " y: " + roads.getYPos());
  }
}

void render(){
  fill(100);
  noStroke();
  
  
  for(Road road: Roads){
    rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  }
  
  noFill();
  for(Car car : Cars){
    if(car.collidingWithRoads){
      stroke(0,255,0);
    }else{
      stroke(255,0,0);
    }
    noFill();
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
    fill(0,255,0);
    ellipse(car.objective.getXPos(), car.objective.getYPos(), 10, 10);
    //textSize(10);
    fill(0,255,0);
    //String coordinates = "x: " + (int)car.getXPos() + " y: " + (int)car.getYPos();
     String id = ("id: " + car.getId());
    //text(coordinates, car.getXPos() + 15, car.getYPos() + 15);
    text(id, car.getXPos() - 30, car.getYPos() + 25);
    text(id, car.objective.getXPos() - 30, car.objective.getYPos() + 25);
  }
  
  for(Light light: Lights){
    noFill();
    stroke(light.R,light.G,light.B);
    rect(light.getXPos(),light.getYPos(), light.width, light.height);
    
    noStroke();
    fill(light.R,light.G,light.B);
    
    //Debugging for Issue #3
    //String id = ("id: " + light.id);
    //String coordinates = "x: " + (int)light.getXPos() + " y: " + (int)light.getYPos();
    //text(id, light.getXPos() + 30, light.getYPos() + 25);
    //text(coordinates, light.getXPos() + 15, light.getYPos() + 15);
    
  }
  
  
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

public ArrayList<Light> getSortedLights(Car car){
        ArrayList<Light> sortedLights = new ArrayList<Light>();
        Light removed;
        sortedLights = new ArrayList<Light>();
        for(Light lights: Lights){
            if(lights.road.getCarList().contains(car)){
              sortedLights.add(lights);
            }
            
        }
        int index;
        for(int k = 0; k < sortedLights.size() - 1; k++){
            index = k;
            for(int i = k + 1; i < sortedLights.size(); i++){
                if(sortedLights.get(index).getDistanceTo(car) > sortedLights.get(i).getDistanceTo(car)){
                    index = i;
                }
            }
            removed = sortedLights.get(k);
            sortedLights.set(k, sortedLights.get(index));
            sortedLights.set(index, removed);
        }
      return sortedLights;  
}

void runLights(){
  for(Light light: Lights){
    if(light.width > light.height){
      if(turn % lightsInterval == 0){
        light.setColour("green");
      }else if(turn % lightsInterval == lightsInterval/2){
        light.setColour("yellow");
      }else if(turn % lightsInterval == (lightsInterval/2) + 23){
        light.setColour("red");
      }
    }else{
      if(turn % lightsInterval == (lightsInterval/2) + 23){
        light.setColour("green");
      }else if(turn % lightsInterval == lightsInterval/2){
        light.setColour("yellow");
      }else if(turn % lightsInterval == 0){
        light.setColour("red");
      }
    }
    
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
  
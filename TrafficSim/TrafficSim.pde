import java.util.*;
public static Map<Car,Velocity> carVectors = new HashMap<Car,Velocity>();

public static ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
public static ArrayList<Light> Lights = new ArrayList<Light>();

private static int nextCarId = 0;
private static int nextRoadId = 0;
private static int nextLightId = 0;
private static int lightsInterval = 199;

public int displayWidth = 1300;
public int displayHeight = 700;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;
public int turn = 0;
public float randomSpawnLocOffsetLength = 100;
public float randomSpawnLocOffsetWidth = 50;
public int defaultRoadWidth = 100;

public int[][] grid = new int[displayWidth/defaultRoadWidth][displayHeight/defaultRoadWidth];

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
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Right Side");
              
              
            }else{
              Car newCar = createNewCar(road.getXPos() + (float)(Math.random() * randomSpawnLocOffsetLength), newYPos);
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Left Side");
            }
            
          }else{
            float newXPos = (road.getXPos() + 16) +  (float)((road.getWidth() - 32) * Math.random());
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(newXPos, road.getHeight() - (float)(Math.random() * randomSpawnLocOffsetLength));
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Lower Side");
            }else{
              Car newCar = createNewCar(newXPos, road.getYPos() + (float)(Math.random() * randomSpawnLocOffsetLength));
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Upper Side");              
            }
            
          }
        }
      }
      //System.out.println("Cars generated.");
}

Car createNewCar(float x, float y){
    float randomX = (float)Math.random() * displayWidth;
    float randomY = (float)Math.random() * displayHeight;
    Position objective = new Position(randomX, randomY);
    while(!objective.isIntersectingRoad(randomX,randomY)){
      randomX = (float)Math.random() * displayWidth;
      randomY = (float)Math.random() * displayHeight;
    }
    objective = new Position(randomX,randomY);
    Car newCar = new Car(nextCarId,x,y, Constants.MAX_HEALTH, objective);
    return newCar;
}

void runCars(){
  //TODO: Add sentience to cars.
  for(Car car: Cars){
    
    
    
    ArrayList<Light> sortedLights = getSortedLights(car);
    Position nextObj = car.path.get(car.path.size() - 1);
    
    if(car.getDistanceTo(car.objective) < defaultRoadWidth/2){
      nextObj = car.objective;
    }
    
    if(car.getDistanceTo(nextObj) < 1){
      if(car.path.size() > 1){
        car.path.remove(car.path.size() - 1);
      }
      nextObj = car.path.get(car.path.size() - 1);
      
    }
    
    
    
    float angleRad = car.orientTowardsInRad(nextObj);
    if(sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("yellow"))){
      car.move(angleRad, 1);
    }else if(sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("green"))){
      car.move(angleRad, 2);
    }else{
      car.move(angleRad, 2);
    }
    
    
  }
  
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
    if(road.getXPos() + defaultRoadWidth < displayWidth){
      road.setPosition(new Position(road.getXPos() + defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
    
  }else if(keyPressed && keyCode == LEFT && mode == 'v'){
    if(road.getXPos() - defaultRoadWidth > -1){
      road.setPosition(new Position(road.getXPos() - defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
  }else if(keyPressed && keyCode == UP && mode == 'h'){
    if(road.getYPos() - defaultRoadWidth > -1){
      road.setPosition(new Position(road.getXPos(), road.getYPos() - defaultRoadWidth));
      keyPressed = false;
    }
  }else if(keyPressed && keyCode == DOWN && mode == 'h'){
    if(road.getYPos() + defaultRoadWidth < displayHeight){
      road.setPosition(new Position(road.getXPos(), road.getYPos() + defaultRoadWidth));
      keyPressed = false;
    }
  }
  
  if(keyPressed && key == ' '){
    Road newRoad = new Road(nextRoadId, road.getXPos(), road.getYPos(), road.width, road.height);
    Roads.add(newRoad);
    nextRoadId++;
    road.id = nextRoadId;
    if(newRoad.width > newRoad.height){
      fillRow((int)(road.getYPos()/defaultRoadWidth));
    }else{
      fillCol((int)(road.getXPos()/defaultRoadWidth));
    }
    System.out.println("road added (total roads: " + nextRoadId + ")");
    printGrid(grid);
    keyPressed = false;
  }
  
  if(keyPressed && (key == ENTER || key == RETURN)){
    System.out.println("Enter or Return pressed");
    roadUIFinished = true;
    generateCars(1);
    for(Road road: Roads){
     int intersections = 0;
     if(road.width > road.height){
       for(Road roads: Roads){
         if(roads.height > roads.width){
           intersections++;
           //System.out.println("Horz-Vert Intersection detected. Total intersections: " + intersections);
         }
       }
     }else{
       for(Road roads: Roads){
         if(roads.width > roads.height){
           intersections++;
           //System.out.println("Vert-Horz Intersection detected. Total intersections: " + intersections);
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
  size(displayWidth, displayHeight);
  clearGrid();
}

void clearGrid(){
  for(int row = 0; row < grid[0].length; row++){
    for(int column = 0; column < grid.length; column++){
      grid[column][row] = 0;
    }
  }
  System.out.println("Grid cleared.");
}

void printGrid(int[][] grid){
  for(int row = 0; row < grid[0].length; row++){
    String output = "";
    for(int column = 0; column < grid.length; column++){
      output = output + grid[column][row] + " ";
    }
    System.out.println(output);
  }
}

void fillRow(int rowNum){
    for(int column = 0; column < grid.length; column++){
      grid[column][rowNum] = 1;
    }
  
}

void fillCol(int colNum){
    for(int row = 0; row < grid[colNum].length; row++){
      grid[colNum][row] = 1;
    }
  
}

ArrayList<Position> breadthFirstSearch(Car car){
  //MAP KEY:
  //-1 = objective position
  //0 = inaccesible area
  //2 = car
  //1 = unvisited area
  //3 = frontier
  //4 = visited
  From[][] map = new From[grid.length][grid[0].length];
  int[][] temp = new int[grid.length][grid[0].length];
  System.out.println("Matrices \"map\" and \"temp\" initialised.");
  //xPos = Column, yPos = Row
  ArrayList<Position> frontier = new ArrayList<Position>();
  System.out.println("ArrayList \"frontier\" initialised.");
  //import grid -> temp
  for(int row = 0; row < grid[0].length; row++){
    for(int column = 0; column < grid.length; column++){
      temp[column][row] = grid[column][row];
    }
  }
  System.out.println("grid has been imported to temp");
  System.out.println("temp:");
  printGrid(temp);
  
  //plot objective on temp
  int objCol = ((int)car.objective.getXPos() - ((int)car.objective.getXPos() % 100))/100;
  int objRow = ((int)car.objective.getYPos() - ((int)car.objective.getYPos() % 100))/100;
  temp[objCol][objRow] = -1;
  System.out.println("objective plotted on temp");
  
  
   //plot car on temp and map
  int carCol = ((int)car.getXPos() - ((int)car.getXPos() % 100))/100;
  int carRow = ((int)car.getYPos() - ((int)car.getYPos() % 100))/100;
  temp[carCol][carRow] = 2;
  Position carPos = new Position(carCol, carRow);
  map[carCol][carRow] = new From(carPos,carPos);
  System.out.println("car plotted on temp");
  System.out.println("temp:");
  printGrid(temp);
  
  //add car to frontier
  frontier.add(new Position(carCol,carRow));
  System.out.println("car added to frontier.");
  
  //flag for early exit out of Breadth First Search
  boolean flagEarlyExit = false;
  System.out.println("Breadth First Search: Variables ready for car " + car.getId() + ". Proceeding with calculations.");
  //Calculate
  while(!flagEarlyExit){
    printGrid(temp);
    System.out.println("");
    for(int index = frontier.size() - 1; index >= 0; index--){
      
      
      
      int col = (int)frontier.get(index).getXPos();
      int row = (int)frontier.get(index).getYPos();
      if(temp[col][row] == 3 || temp[col][row] == 2){
          if(row < temp[col].length - 1 && (temp[col][row + 1] == 1 || temp[col][row + 1] == -1)){
            temp[col][row + 1] = 3;
            Position is = new Position(col,row  +1);
            Position from = new Position(col,row);
            map[col][row + 1] = new From(is, from);
            frontier.add(new Position(col,row + 1));
            
            if(col == objCol && (row + 1) == objRow){
              System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
          if(row > 0 && (temp[col][row - 1] == 1 || temp[col][row - 1] == -1)){ 
            temp[col][row - 1] = 3;
            Position is = new Position(col,row  - 1);
            Position from = new Position(col,row);
            map[col][row - 1] = new From(is, from);
            frontier.add(new Position(col,row - 1));
            
            if(col == objCol && (row - 1) == objRow){
              System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
          if(col < temp.length - 1 && (temp[col + 1][row] == 1 || temp[col + 1][row] == -1)){
            temp[col + 1][row] = 3;
            Position is = new Position(col + 1,row);
            Position from = new Position(col,row);
            map[col + 1][row] = new From(is, from);
            frontier.add(new Position(col + 1,row));
            
            if((col + 1) == objCol && (row) == objRow){
              System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
          if(col > 0 && (temp[col - 1][row] == 1 || temp[col - 1][row] == -1)){
            temp[col - 1][row] = 3;
            Position is = new Position(col - 1,row);
            Position from = new Position(col,row);
            map[col - 1][row] = new From(is, from);
            frontier.add(new Position(col - 1,row));
            
            if((col - 1) == objCol && (row) == objRow){
              System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
          if(temp[col][row] != 2){
            temp[col][row] = 4;
          }
          frontier.remove(index);
          
      }
    }
  }
  
  //List of positions that form the path
  ArrayList<Position> path = new ArrayList<Position>();
  
  From current = map[objCol][objRow];
  
  
  From start = map[carCol][carRow];
  
  while(!same(current,start)){
    float convertedX = ((float)current.is.getXPos() * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    float convertedY = ((float)current.is.getYPos() * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    
    Position convertedPosition = new Position(convertedX, convertedY);
    path.add(convertedPosition);
    current = map[(int)current.from.getXPos()][(int)current.from.getYPos()];
  }
  
  
  return path;
}

boolean same(From from1, From from2){
  if(from1.is.getXPos() == from2.is.getXPos() && from1.is.getYPos() == from2.is.getYPos()){ //ERROR ON THIS LINE NullPointerException
    if(from1.from.getXPos() == from2.from.getXPos() && from1.from.getYPos() == from2.from.getYPos()){
      return true;
    }
    return false;
  }
  return false;
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
    fill(100);
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
    noStroke();
    fill(255,0,0);
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
  
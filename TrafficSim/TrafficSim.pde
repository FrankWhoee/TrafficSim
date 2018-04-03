import java.util.*;
public static Map<Car,Velocity> carVectors = new HashMap<Car,Velocity>();

public static ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
public static ArrayList<Light> Lights = new ArrayList<Light>();

public static boolean pause = false;

private static int nextCarId = 0;
private static int nextRoadId = 0;
private static int nextLightId = 0;
private static int lightsInterval = 50;

public int displayWidth = 1600;
public int displayHeight = 900;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;
public int turn = 0;
public int amountOfCars = 75 ;
public int defaultRoadWidth = 100;
public float randomSpawnLocOffsetLength = 50;
public float randomSpawnLocOffsetWidth = 50;

//formationType can be:
//"grid"
//"orbital"
//"trib_tree"

//Here is the variable declared in all three ways since I know you're lazy:
public String formationType = "grid";
//public String formationType = "orbital";
//public String formationType = "trib_tree";

public int[][] grid = new int[displayWidth/defaultRoadWidth][displayHeight/defaultRoadWidth];

char mode = 'v';
Road road = new Road(0,0,0,defaultRoadWidth,displayHeight);
boolean roadUIFinished = false;

void setup() {
  size(displayWidth, displayHeight);
  clearGrid();
  disp_setup();
}

void draw() {
  disp_draw();
  //master_draw();
}

void disp_setup(){
  size(displayWidth, displayHeight);
  clearGrid();
  formation(formationType);
  
   generateCars(amountOfCars);
   generateLights();

}

void master_draw(){
  if(roadUIFinished == false){
    background(0);
    roadUI();
    roadUIRender();
  }else{
    background(0);
    carVectors.clear();
    render();
    if((!keyPressed && key != 'l') && !pause){
      runCars();
    }
    //renderLine();
    runLights();
    turn++;
  }
}

void formation(String formation){
  if(formation.equals("grid")){
    Road road0  = new Road(0,0.0,0.0,100.0,900.0);
    Road road1  = new Road(1,200.0,0.0,100.0,900.0);
    Road road2  = new Road(2,400.0,0.0,100.0,900.0);
    Road road3  = new Road(3,600.0,0.0,100.0,900.0);
    Road road4  = new Road(4,800.0,0.0,100.0,900.0);
    Road road5  = new Road(5,1000.0,0.0,100.0,900.0);
    Road road6  = new Road(6,1200.0,0.0,100.0,900.0);
    Road road7  = new Road(7,1400.0,0.0,100.0,900.0);
    Road road8  = new Road(8,0.0,0.0,1600.0,100.0);
    Road road9  = new Road(9,0.0,200.0,1600.0,100.0);
    Road road10  = new Road(10,0.0,400.0,1600.0,100.0);
    Road road11  = new Road(11,0.0,600.0,1600.0,100.0);
    Road road12  = new Road(12,0.0,800.0,1600.0,100.0);
    
    Roads.add(road0);
    Roads.add(road1);
    Roads.add(road2);
    Roads.add(road3);
    Roads.add(road4);
    Roads.add(road5);
    Roads.add(road6);
    Roads.add(road7);
    Roads.add(road8);
    Roads.add(road9);
    Roads.add(road10);
    Roads.add(road11);
    Roads.add(road12);

  }else if(formation.equals("orbital")){
    Road road0  = new Road(0,0.0,0.0,100.0,900.0);
    Road road1  = new Road(1,1500.0,0.0,100.0,900.0);
    Road road2  = new Road(2,0.0,0.0,1600.0,100.0);
    Road road3  = new Road(3,0.0,800.0,1600.0,100.0);
    Road road4  = new Road(4,200.0,600.0,1200.0,100.0);
    Road road5  = new Road(5,200.0,200.0,1200.0,100.0);
    Road road6  = new Road(6,200.0,200.0,100.0,500.0);
    Road road7  = new Road(7,1300.0,200.0,100.0,500.0);
    Road road8  = new Road(8,0.0,400.0,1600.0,100.0);
    Road road9  = new Road(9,800.0,0.0,100.0,900.0);
    
    Roads.add(road0);
    Roads.add(road1);
    Roads.add(road2);
    Roads.add(road3);
    Roads.add(road4);
    Roads.add(road5);
    Roads.add(road6);
    Roads.add(road7);
    Roads.add(road8);
    Roads.add(road9);
    
  }else if(formation.equals("trib_tree")){
    Road road0  = new Road(0,0,800.0,1600.0,100.0);
    Road road1  = new Road(1,700,0.0,100.0,900.0);
    Road road2  = new Road(2,700,100.0,800.0,100.0);
    Road road3  = new Road(3,100,300.0,700.0,100.0);
    Road road4  = new Road(4,700,500.0,700.0,100.0);
    Road road5  = new Road(5,100,300.0,100.0,400.0);
    Road road6  = new Road(6,1400,100.0,100.0,300.0);
    Road road7  = new Road(7,1200,300.0,100.0,300.0);
    Road road8  = new Road(8,900,300.0,400.0,100.0);
    Road road9  = new Road(9,100,500.0,400.0,100.0);
    Road road10  = new Road(10,500,100.0,100.0,300.0);
    Road road11  = new Road(11,200,100.0,400.0,100.0);
    Road road12  = new Road(12,1000,500.0,100.0,200.0);
    
    Roads.add(road0);
    Roads.add(road1);
    Roads.add(road2);
    Roads.add(road3);
    Roads.add(road4);
    Roads.add(road5);
    Roads.add(road6);
    Roads.add(road7);
    Roads.add(road8);
    Roads.add(road9);
    Roads.add(road10);
    Roads.add(road11);
    Roads.add(road12);
  }else{
    return;
  }
  affixRoadsToMatrix();
}

void translateToMatrix(Road newRoad){
  
  if(newRoad.width > newRoad.height){
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(newRoad.width); 
      fillRow(col,row,l);
    }else{
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(newRoad.height); 
      
      fillCol(col,row,l);
    }
  
}

void affixRoadsToMatrix(){
  
  for(Road road: Roads){
    translateToMatrix(road);
    //System.out.println("Road road" + road.getId() + " = new Road(" + road.getId() + "," + road.getXPos() + "," + road.getYPos() + "," + road.width + "," + road.height + ");");
  }
  //Confirming if grid has been correctly transformed (debugging)
  //printGrid(grid);
}

void generateCars(int amount){
      for(Road road: Roads){
        for(int i = 0; i < Math.max(amount/Roads.size(), 1); i++){

          if(road.getWidth() > road.getHeight()){
            float newYPos = (road.getYPos() + 17) + (float)((road.getHeight() - 33) * Math.random());
            System.out.println("newYPos: " + newYPos);
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(road.getWidth() - (float)(Math.random() * randomSpawnLocOffsetLength), newYPos);
              
              float randomX = newCar.getXPos();
              float randomY = newCar.getYPos();
              Position nextPos = new Position(randomX, randomY);
              while(!newCar.isIntersectingRoad(randomX,randomY)){
                  randomX = (float)Math.random() * displayWidth;
                  randomY = (float)Math.random() * displayHeight;
                  nextPos = new Position(randomX, randomY);
              }
              newCar.setPosition(nextPos);
              
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Right Side");
              
              
            }else{
              Car newCar = createNewCar(road.getXPos() + (float)(Math.random() * randomSpawnLocOffsetLength), newYPos);
              
              float randomX = newCar.getXPos();
              float randomY = newCar.getYPos();
              Position nextPos = new Position(randomX, randomY);
              while(!newCar.isIntersectingRoad(randomX,randomY)){
                  randomX = (float)Math.random() * displayWidth;
                  randomY = (float)Math.random() * displayHeight;
                  nextPos = new Position(randomX, randomY);
              }
              newCar.setPosition(nextPos);
              
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Left Side");
            }
            
          }else{
            float newXPos = (road.getXPos() + 17) +  (float)((road.getWidth() - 33) * Math.random());
            System.out.println("newXPos: " + newXPos);
            if(nextCarId % 2 == 1){
              Car newCar = createNewCar(newXPos, road.getHeight() - Constants.CAR_RADIUS - (float)(Math.random() * randomSpawnLocOffsetLength));
              //System.out.println("road height: " + road.getHeight());
              
              float randomX = newCar.getXPos();
              float randomY = newCar.getYPos();
              Position nextPos = new Position(randomX, randomY);
              while(!newCar.isIntersectingRoad(randomX,randomY)){
                  randomX = (float)Math.random() * displayWidth;
                  randomY = (float)Math.random() * displayHeight;
                  nextPos = new Position(randomX, randomY);
              }
              newCar.setPosition(nextPos);
              
              newCar.path = breadthFirstSearch(newCar);
              Cars.add(newCar);
              nextCarId++;
              //System.out.println(newCar.getId() + " spawned. Type: Car Location: Lower Side");
            }else{
              Car newCar = createNewCar(newXPos, road.getYPos() + Constants.CAR_RADIUS + (float)(Math.random() * randomSpawnLocOffsetLength));
               //System.out.println("road Y: " + road.getYPos());
               
               float randomX = newCar.getXPos();
              float randomY = newCar.getYPos();
              Position nextPos = new Position(randomX, randomY);
              while(!newCar.isIntersectingRoad(randomX,randomY)){
                  randomX = (float)Math.random() * displayWidth;
                  randomY = (float)Math.random() * displayHeight;
                  nextPos = new Position(randomX, randomY);
              }
              newCar.setPosition(nextPos);
               
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
  for(int i = (Cars.size() - 1); i >= 0; i--){
    Car car = Cars.get(i);
    ArrayList<Light> sortedLights = getSortedLights(car);
    Position nextObj = car.path.get(car.path.size() - 1);
    
    if(car.getDistanceTo(car.objective) < 25){
      Cars.remove(i);
    }
    
    if(car.getDistanceTo(car.objective) < (defaultRoadWidth/2) + 25){
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
      car.move(angleRad, 1);
    }else{
      car.move(angleRad, 1);
    }
    
    
  }
  
}

void roadUI(){
  if(mode == 'h'){
    if(keyPressed && key == 's'){
      if(road.width > defaultRoadWidth){
        road.width -= defaultRoadWidth;
        keyPressed = false;
      }
    }else if(keyPressed && key == 'w'){
      if(road.height < displayWidth){
        road.width += defaultRoadWidth;
        keyPressed = false;
      }
    }
  }else if(mode == 'v'){
    if(keyPressed && key == 's'){
      if(road.height > defaultRoadWidth){
        road.height -= defaultRoadWidth;
        keyPressed = false;
      }
    }else if(keyPressed && key == 'w'){
      if(road.height < displayHeight){
        road.height += defaultRoadWidth;
        keyPressed = false;
      }
    }
  }
  
  if(keyPressed && keyCode == RIGHT){
    if(road.getXPos() + defaultRoadWidth < displayWidth){
      road.setPosition(new Position(road.getXPos() + defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
    
  }else if(keyPressed && keyCode == LEFT){
    if(road.getXPos() - defaultRoadWidth > -1){
      road.setPosition(new Position(road.getXPos() - defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
  }else if(keyPressed && keyCode == UP){
    if(road.getYPos() - defaultRoadWidth > -1){
      road.setPosition(new Position(road.getXPos(), road.getYPos() - defaultRoadWidth));
      keyPressed = false;
    }
  }else if(keyPressed && keyCode == DOWN){
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
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(road.width); 
      
      fillRow(col,row,l);
    }else{
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(road.height); 
      
      fillCol(col,row,l);
    }
    System.out.println("road added (total roads: " + nextRoadId + ")");
    printGrid(grid);
    keyPressed = false;
  }
  
  if(keyPressed && (key == 'h' || key == 'v')){
    mode = key;
  }
  
  if(keyPressed){
    if(mode == 'h'){
      //road.width = displayWidth;
      road.height = defaultRoadWidth;
      road.setPosition(new Position(0,road.getYPos()));
    }else if(mode == 'v'){
      road.width = defaultRoadWidth;
      //road.height = displayHeight;
      road.setPosition(new Position(road.getXPos(),0));
    }
  }

  if(keyPressed && (key == ENTER || key == RETURN)){
    System.out.println("Enter or Return pressed");
    roadUIFinished = true;
    generateCars(amountOfCars);
    generateLights();
  }
  
  
}

void generateLights(){
  for(Road road: Roads){
       for(Road roads: Roads){
           nextLightId++;
           for(int i = 0; i < 2; i++){
             Light newLight;
             if(nextLightId % 2 == 0){
               newLight = new Light(nextLightId,roads, "red");
             }else{
               newLight = new Light(nextLightId,roads, "green");
             }
             if(!newLight.colour.equals("noRender")){
               Lights.add(newLight);
             }
           }
       }
   }
}



void runLights(){
  for(Light light: Lights){
    if(light.width > light.height){
      
      if(turn % lightsInterval == lightsInterval/2){
        if(light.id % 2 == 0){
           light.setColour("red");
        }else{
          light.setColour("green");
        }
      }else if(turn % lightsInterval == 0l){
        if(light.id % 2 == 0){
           light.setColour("green");
        }else{
          light.setColour("red");
        }
      }

    }else{
      if(turn % lightsInterval == lightsInterval/2){
        if(light.id % 2 == 0){
           light.setColour("green");
        }else{
          light.setColour("red");
        }
      }else if(turn % lightsInterval == 0){
        if(light.id % 2 == 0){
           light.setColour("red");
        }else{
          light.setColour("green");
        }
      }
    }



    
    
    /*
    if(light.width > light.height){
      if(turn % lightsInterval == 15){
        light.setColour("green");
      }else if(turn % lightsInterval == lightsInterval/2){
        light.setColour("yellow");
      }else if(turn % lightsInterval == (lightsInterval/2) + 30){
        light.setColour("red");
      }
    }else{
      if(turn % lightsInterval == 15){
        light.setColour("red");
      }else if(turn % lightsInterval == lightsInterval/2){
        light.setColour("green");
      }else if(turn % lightsInterval == (lightsInterval/2) + 30){
        light.setColour("yellow");
      }
    }
    */
  }
  
}

int convertToMatrix(double number){
  return (int)(number/defaultRoadWidth);
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

void fillRow(int colNum, int rowNum, int rowWidth){
    for(int column = colNum; column < colNum + rowWidth; column++){
      grid[column][rowNum] = 1;
    }
  
}

void fillCol(int colNum, int rowNum, int colHeight){
    for(int row = rowNum; row < rowNum + colHeight; row++){
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
  ArrayList<Position> path = new ArrayList<Position>();
  System.out.println("Matrices \"map\", \"path\", and \"temp\" initialised.");
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

  
  //plot objective on temp
  int objCol = ((int)car.objective.getXPos() - ((int)car.objective.getXPos() % 100))/100;
  int objRow = ((int)car.objective.getYPos() - ((int)car.objective.getYPos() % 100))/100;
  temp[objCol][objRow] = -1;
  System.out.println("objective plotted on temp");
  System.out.println("objCol: " + objCol + " objRow: " + objRow);
  System.out.println("obj x: " + car.objective.getXPos() + " obj y: " + car.objective.getYPos());
 
  
   //plot car on temp and map
  int carCol = ((int)car.getXPos() - ((int)car.getXPos() % 100))/100;
  int carRow = ((int)car.getYPos() - ((int)car.getYPos() % 100))/100;
  System.out.println("col: " + carCol + " carRow: " + carRow);
  System.out.println("temp row length: " + temp[0].length);
  System.out.println("temp col length: " + temp.length);
  System.out.println("car x: " + car.getXPos() + " car y: " + car.getYPos());
  System.out.println("car id: " + car.getId());
  temp[carCol][carRow] = 2;
  
  if(objCol == carCol && objRow == carRow){
    float convertedX = ((float)carCol * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    float convertedY = ((float)carRow * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    path.add( new Position(convertedX, convertedY));
    return path;
  }
  
  Position carPos = new Position(carCol, carRow);
  map[carCol][carRow] = new From(carPos,carPos);
  System.out.println("car plotted on temp");
  System.out.println("temp:");
  
  
  //add car to frontier
  frontier.add(new Position(carCol,carRow));
  System.out.println("car added to frontier.");
  
  //flag for early exit out of Breadth First Search
  boolean flagEarlyExit = false;
  System.out.println("Breadth First Search: Variables ready for car " + car.getId() + ". Proceeding with calculations.");
  //Calculate
  while(!flagEarlyExit){
    //printGrid(temp);
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
  
  //Which coordinate is being iterated currently.
  From current = map[objCol][objRow];
  //Where the car is right now
  From start = map[carCol][carRow];
  
  //While the current coordinates do not equal the start coordinates,
  while(!same(current,start)){
    
    //Convert the current position from matrix coordinates to real coordinates
    float convertedX = ((float)current.is.getXPos() * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    float convertedY = ((float)current.is.getYPos() * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    
    //Store newly converted position into a Position variable
    Position convertedPosition = new Position(convertedX, convertedY);
    //Add the new Position into the path
    path.add(convertedPosition);
    //Follow the "breadcrumbs" back to the start, so get where this current positions is "from".
    current = map[(int)current.from.getXPos()][(int)current.from.getYPos()];
  }
  return path;
}

//Checks if a From is the same as the other From.
boolean same(From from1, From from2){
  if(from1.is.getXPos() == from2.is.getXPos() && from1.is.getYPos() == from2.is.getYPos()){ //ERROR ON THIS LINE NullPointerException
    if(from1.from.getXPos() == from2.from.getXPos() && from1.from.getYPos() == from2.from.getYPos()){
      return true;
    }
    return false;
  }
  return false;
}

void disp_draw(){
  background(0);
    carVectors.clear();
    render();
    if((!keyPressed && key != 'l') && !pause){
      runCars();
    }
    //renderLine();
    runLights();
    turn++;
}

void roadUIRender(){
  for(Road roads: Roads){
    fill(150);
    rect(roads.getXPos(),roads.getYPos(), roads.getWidth(), roads.getHeight());
    //System.out.println("road " + roads.getId() + " drawn at x: " + roads.getXPos() + " y: " + roads.getYPos());
  }
  
  fill(75);
  noStroke();
  rect(road.getXPos(),road.getYPos(), road.getWidth(), road.getHeight());
  
  
}

void render(){
  fill(150);
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
    if(!light.colour.equals("noRender")){
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
      
      //Debugging for Issue #8
      //String id = ("id: " + light.id);
      //text(id, light.getXPos() - 30, light.getYPos() + 25);
    }
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

  

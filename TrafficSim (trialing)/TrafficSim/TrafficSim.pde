//***IMPORANT***
//THIS IS THE TRIALING VERSION
//THIS IS FOR CONDUCTING TESTS ON DIFFERENT ROAD FORMATIONS **ONLY**. USE MASTER BRANCH FOR GUI AND DISPLAYS.

import java.util.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

//formationType can be:
//"grid"
//"orbital"
//"trib_tree"
//"linear_tree"
//"radial_grid"
//"radial_tree"

//Here is the variable declared in all ways since I know you're lazy, uncomment it if you want to use it, comment it if you don't want to use it:
//public String formationType = "grid";
//public String formationType = "orbital";
//public String formationType = "radial_grid";
//public String formationType = "trib_tree";
//public String formationType = "linear_tree";
//public String formationType = "trib_grid";
public String formationType = "radial_tree";


//***IMPORTANT NOTE ABOUT ROAD FORMATION TYPES***
//TO CHANGE WHICH ONE YOU ARE TESTING, SIMPLY COMMENT THE CURRENT ONE BY ADDING // AT THE BEGINNING OF THE LINE, AND UNCOMMENT THE DESIRED ROAD FORMATION.

//**TRIAL VARIABLES** (VARIABLES ARE ADJUSTABLE):
//Amount of cars that will be spawned:
public int amountOfCars = 75;

//Total number of trials that will run
int numTrials = 25;

//Trial that program is on currently. Change this to resume from a previous run.
int currentTrial = 17;

//The total amount of ticks/turns that will run per trial.
int maxTicks = 30000;

//The amount of cars that remain.
int carsRemaining = 0;

//Used for keeping time. finalTime - initTime = elapsed time.
long initTime = 0;
long finalTime = 0;

//
String resultsFilePath = "/home/frank/Documents/TrafficSim_Data/" + formationType + ".txt";

// \/ \/ DO NOT MODIFY THESE VARIABLES UNLESS OTHERWISE MARKED \/ \/
//Results will be kept in the ArrayList.
public static ArrayList<Result> Results = new ArrayList<Result>();


public static Map<Car, Velocity> carVectors = new HashMap<Car, Velocity>();
public static ArrayList<Car> Cars = new ArrayList<Car>();
public static ArrayList<Road> Roads = new ArrayList<Road>();
public static ArrayList<Light> Lights = new ArrayList<Light>();

public static boolean pause = false;

private static int nextCarId = 0; //VALUE IS MODIFIABLE
private static int nextRoadId = 0; //VALUE IS MODIFIABLE
private static int nextLightId = 0;
private static int lightsInterval = 232; //VALUE IS MODIFIABLE

public int displayWidth = 1600;
public int displayHeight = 900;
public int centerX = displayWidth/2;
public int centerY = displayHeight/2;
public int turn = 0;

public int defaultRoadWidth = 100;
public float randomSpawnLocOffsetLength = 50;
public float randomSpawnLocOffsetWidth = 50;

public int[][] grid = new int[displayWidth/defaultRoadWidth][displayHeight/defaultRoadWidth];
public int[][] costMap = new int [displayWidth/defaultRoadWidth][displayHeight/defaultRoadWidth];

char mode = 'v';
Road road = new Road(0, 0, 0, defaultRoadWidth, displayHeight);
boolean roadUIFinished = false;

// /\ /\ DO NOT MODIFY THESE VARIABLES UNLESS OTHERWISE MARKED /\ /\

void draw() {
  //TO CREATE NEW ROAD FORMATIONS AND TEST THEM, COMMENT trialing_draw(); AND UNCOMMENT //master_draw();
  //ONE MUST BE COMMENTED, THE OTHER UNCOMMENTED FOR PROGRAM TO WORK.
  //AFTER UNCOMMENTING master_draw(); THE PROGRAM WILL GIVE A GUI WHERE YOU CAN MANIPULATE THE ROADS. AFTER YOU FINISH PLACING DOWN THE ROADS, THE CONSOLE PRINTS CODE THAT YOU CAN COPY AND PASTE INTO THE METHOD BELOW.
  //AFTER COPYING AND PASTING CODE, COMMENT master_draw(); AND UNCOMMENT trialing_draw();
  //WRITE public String formationType = "YOUR_FORMATION"; AND COMMENT THE CURRENT FORMATION TYPE.
  //RUN THE PROGRAM AND YOU WILL BE ABLE TO TEST YOUR CUSTOM FORMATION.
  
  //master_draw();
  trialing_draw();
}

void formation(String formation) {
  //FOLLOW THESE INSTRUCTIONS TO ADD YOUR OWN CUSTOM FORMATIONS:
  //SCROLL DOWN TO THE BOTTOM OF THIS METHOD AND THERE WILL BE MORE INSTRUCTIONS.
  
  if (formation.equals("grid")) {
    Road road0  = new Road(0, 0.0, 0.0, 100.0, 900.0);
    Road road1  = new Road(1, 200.0, 0.0, 100.0, 900.0);
    Road road2  = new Road(2, 400.0, 0.0, 100.0, 900.0);
    Road road3  = new Road(3, 600.0, 0.0, 100.0, 900.0);
    Road road4  = new Road(4, 800.0, 0.0, 100.0, 900.0);
    Road road5  = new Road(5, 1000.0, 0.0, 100.0, 900.0);
    Road road6  = new Road(6, 1200.0, 0.0, 100.0, 900.0);
    Road road7  = new Road(7, 1400.0, 0.0, 100.0, 900.0);
    Road road8  = new Road(8, 0.0, 0.0, 1600.0, 100.0);
    Road road9  = new Road(9, 0.0, 200.0, 1600.0, 100.0);
    Road road10  = new Road(10, 0.0, 400.0, 1600.0, 100.0);
    Road road11  = new Road(11, 0.0, 600.0, 1600.0, 100.0);
    Road road12  = new Road(12, 0.0, 800.0, 1600.0, 100.0);

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
  } else if (formation.equals("orbital")) {
    Road road0  = new Road(0, 0.0, 0.0, 100.0, 900.0);
    Road road1  = new Road(1, 1500.0, 0.0, 100.0, 900.0);
    Road road2  = new Road(2, 0.0, 0.0, 1600.0, 100.0);
    Road road3  = new Road(3, 0.0, 800.0, 1600.0, 100.0);
    Road road4  = new Road(4, 200.0, 600.0, 1200.0, 100.0);
    Road road5  = new Road(5, 200.0, 200.0, 1200.0, 100.0);
    Road road6  = new Road(6, 200.0, 200.0, 100.0, 500.0);
    Road road7  = new Road(7, 1300.0, 200.0, 100.0, 500.0);
    Road road8  = new Road(8, 0.0, 400.0, 1600.0, 100.0);
    Road road9  = new Road(9, 800.0, 0.0, 100.0, 900.0);

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
  } else if (formation.equals("trib_tree")) {
    Road road0  = new Road(0, 0, 800.0, 1600.0, 100.0);
    Road road1  = new Road(1, 700, 0.0, 100.0, 900.0);
    Road road2  = new Road(2, 700, 100.0, 800.0, 100.0);
    Road road3  = new Road(3, 100, 300.0, 700.0, 100.0);
    Road road4  = new Road(4, 700, 500.0, 700.0, 100.0);
    Road road5  = new Road(5, 100, 300.0, 100.0, 400.0);
    Road road6  = new Road(6, 1400, 100.0, 100.0, 300.0);
    Road road7  = new Road(7, 1200, 300.0, 100.0, 300.0);
    Road road8  = new Road(8, 900, 300.0, 400.0, 100.0);
    Road road9  = new Road(9, 100, 500.0, 400.0, 100.0);
    Road road10  = new Road(10, 500, 100.0, 100.0, 300.0);
    Road road11  = new Road(11, 200, 100.0, 400.0, 100.0);
    Road road12  = new Road(12, 1000, 500.0, 100.0, 200.0);

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
  }else if(formation.equals("linear_tree")){
    Road road0  = new Road(0,0.0,400.0,1600.0, 100.0);
    Roads.add(road0);
    Road road1  = new Road(1,100.0,400.0,100.0, 400.0);
    Roads.add(road1);
    Road road2  = new Road(2,500.0,400.0,100.0, 500.0);
    Roads.add(road2);
    Road road3  = new Road(3,900.0,400.0,100.0, 300.0);
    Roads.add(road3);
    Road road4  = new Road(4,1300.0,400.0,100.0, 400.0);
    Roads.add(road4);
    Road road5  = new Road(5,1100.0,100.0,100.0, 400.0);
    Roads.add(road5);
    Road road6  = new Road(6,700.0,0.0,100.0, 500.0);
    Roads.add(road6);
    Road road7  = new Road(7,300.0,0.0,100.0, 500.0);
    Roads.add(road7);
    Road road8  = new Road(8,0.0,0.0,100.0, 500.0);
    Roads.add(road8);
    Road road9  = new Road(9,1400.0,0.0,100.0, 500.0);
    Roads.add(road9);
    Road road10  = new Road(10,1500.0,400.0,100.0, 400.0);
    Roads.add(road10);
    Road road11  = new Road(11,0.0,0.0,200.0, 100.0);
    Roads.add(road11);
    Road road12  = new Road(12,0.0,200.0,200.0, 100.0);
    Roads.add(road12);
    Road road13  = new Road(13,100.0,600.0,200.0, 100.0);
    Roads.add(road13);
    Road road14  = new Road(14,0.0,700.0,200.0, 100.0);
    Roads.add(road14);
    Road road15  = new Road(15,700.0,600.0,500.0, 100.0);
    Roads.add(road15);
    Road road16  = new Road(16,500.0,800.0,600.0, 100.0);
    Roads.add(road16);
    Road road17  = new Road(17,400.0,700.0,200.0, 100.0);
    Roads.add(road17);
    Road road18  = new Road(18,500.0,200.0,300.0, 100.0);
    Roads.add(road18);
    Road road19  = new Road(19,700.0,0.0,300.0, 100.0);
    Roads.add(road19);
    Road road20  = new Road(20,900.0,200.0,300.0, 100.0);
    Roads.add(road20);
    Road road21  = new Road(21,1300.0,0.0,300.0, 100.0);
    Roads.add(road21);
    Road road22  = new Road(22,1400.0,200.0,200.0, 100.0);
    Roads.add(road22);
  }else if(formation.equals("trib_grid")){
    Road road0  = new Road(0,800.0,0.0,100.0, 900.0);
    Roads.add(road0);
    Road road1  = new Road(1,0.0,800.0,1600.0, 100.0);
    Roads.add(road1);
    Road road2  = new Road(2,100.0,200.0,800.0, 100.0);
    Roads.add(road2);
    Road road3  = new Road(3,100.0,0.0,100.0, 700.0);
    Roads.add(road3);
    Road road4  = new Road(4,300.0,0.0,100.0, 700.0);
    Roads.add(road4);
    Road road5  = new Road(5,500.0,0.0,100.0, 700.0);
    Roads.add(road5);
    Road road6  = new Road(6,100.0,0.0,500.0, 100.0);
    Roads.add(road6);
    Road road7  = new Road(7,100.0,400.0,500.0, 100.0);
    Roads.add(road7);
    Road road8  = new Road(8,100.0,600.0,500.0, 100.0);
    Roads.add(road8);
    Road road9  = new Road(9,800.0,400.0,500.0, 100.0);
    Roads.add(road9);
    Road road10  = new Road(10,1200.0,200.0,100.0, 500.0);
    Roads.add(road10);
    Road road11  = new Road(11,1000.0,200.0,100.0, 500.0);
    Roads.add(road11);
    Road road12  = new Road(12,1000.0,200.0,300.0, 100.0);
    Roads.add(road12);
    Road road13  = new Road(13,1000.0,600.0,300.0, 100.0);
    Roads.add(road13);
  }else if(formation.equals("radial_grid")){
    Road road0  = new Road(0,700.0,0.0,100.0, 900.0);
    Roads.add(road0);
    Road road1  = new Road(1,0.0,400.0,1600.0, 100.0);
    Roads.add(road1);
    Road road2  = new Road(2,900.0,600.0,700.0, 100.0);
    Roads.add(road2);
    Road road3  = new Road(3,900.0,200.0,700.0, 100.0);
    Roads.add(road3);
    Road road4  = new Road(4,900.0,200.0,100.0, 500.0);
    Roads.add(road4);
    Road road5  = new Road(5,1100.0,200.0,100.0, 500.0);
    Roads.add(road5);
    Road road6  = new Road(6,1300.0,200.0,100.0, 500.0);
    Roads.add(road6);
    Road road7  = new Road(7,1500.0,200.0,100.0, 500.0);
    Roads.add(road7);
    Road road8  = new Road(8,500.0,200.0,100.0, 500.0);
    Roads.add(road8);
    Road road9  = new Road(9,300.0,200.0,100.0, 500.0);
    Roads.add(road9);
    Road road10  = new Road(10,100.0,200.0,100.0, 500.0);
    Roads.add(road10);
    Road road11  = new Road(11,0.0,200.0,600.0, 100.0);
    Roads.add(road11);
    Road road12  = new Road(12,0.0,600.0,600.0, 100.0);
    Roads.add(road12);
    Road road13  = new Road(13,0.0,800.0,1600.0, 100.0);
    Roads.add(road13);
    Road road14  = new Road(14,0.0,0.0,1600.0, 100.0);
    Roads.add(road14);
  }else if(formation.equals("radial_tree")){
    Road road0  = new Road(0,700.0,0.0,100.0, 900.0);
    Roads.add(road0);
    Road road1  = new Road(1,0.0,400.0,1600.0, 100.0);
    Roads.add(road1);
    Road road2  = new Road(2,100.0,400.0,100.0, 500.0);
    Roads.add(road2);
    Road road3  = new Road(3,100.0,800.0,300.0, 100.0);
    Roads.add(road3);
    Road road4  = new Road(4,0.0,600.0,200.0, 100.0);
    Roads.add(road4);
    Road road5  = new Road(5,0.0,600.0,200.0, 100.0);
    Roads.add(road5);
    Road road6  = new Road(6,500.0,400.0,100.0, 400.0);
    Roads.add(road6);
    Road road7  = new Road(7,300.0,600.0,300.0, 100.0);
    Roads.add(road7);
    Road road8  = new Road(8,300.0,0.0,100.0, 500.0);
    Roads.add(road8);
    Road road9  = new Road(9,0.0,200.0,400.0, 100.0);
    Roads.add(road9);
    Road road10  = new Road(10,300.0,0.0,200.0, 100.0);
    Roads.add(road10);
    Road road11  = new Road(11,900.0,0.0,100.0, 500.0);
    Roads.add(road11);
    Road road12  = new Road(12,1200.0,100.0,100.0, 400.0);
    Roads.add(road12);
    Road road13  = new Road(13,1400.0,200.0,100.0, 600.0);
    Roads.add(road13);
    Road road14  = new Road(14,1100.0,400.0,100.0, 500.0);
    Roads.add(road14);
    Road road15  = new Road(15,900.0,100.0,200.0, 100.0);
    Roads.add(road15);
    Road road16  = new Road(16,900.0,600.0,300.0, 100.0);
    Roads.add(road16);
    Road road17  = new Road(17,1000.0,800.0,300.0, 100.0);
    Roads.add(road17);
    Road road18  = new Road(18,1300.0,600.0,300.0, 100.0);
    Roads.add(road18);
    Road road19  = new Road(19,1400.0,200.0,200.0, 100.0);
    Roads.add(road19);
  }else if(formation.equals("YOUR_FORMATION")){
    //PASTE CODE HERE. TO RENAME  THIS FORMATION CHANGE THE STRING ABOVE THIS LINE.
    //TO CREATE EVEN MORE FORMATIONS, ADD THIS TO THE END OF THE BRACKET BELOW AND PASTE CODE IN THERE: else if(formation.equals("YOUR_FORMATION")){}
  }
  affixRoadsToMatrix();
}

void writeResultsToFile(){
  try{
   String content = "This is the content to write into file\n";
    content +=("---------------PRINTING ALL RESULTS. COPY DATA FROM HERE---------------\n");
    content +=("\n");
    for(Result result : Results){
      content += ("---------------TRIAL " + result.trialNum + "---------------\n");
      content += ("TIMESTAMP: " + result.timestamp + "\n");
      content += ("FORMATION TYPE: " + result.formationType + "\n");
      content += ("CARS REMAINING: " + result.carsRemaining + "\n");
      content += ("TICK: " + result.tick + "\n");
      content += ("TIME ELAPSED: " + result.timeElapsed + "s" + "\n");
    }
    content +=(" " + "\n");
    content +=("---------------END PROGRAM. CLOSE OUT OF WINDOW.---------------" + "\n");
    
    FileWriter fw = new FileWriter(resultsFilePath );
    BufferedWriter bw = new BufferedWriter(fw);
    bw.write(content);
    
    bw.close();
    fw.close();
  }catch(Exception e){
    System.out.println(e);
  }
}

void setup() {
  size(displayWidth, displayHeight);
  clearGrid();
  //disp_setup();
  
  int messageTimingInS = 10;
  int messageTiming = messageTimingInS*1000;
  
  System.out.println("SYSTEM WILL PRINT STATUS FROM HERE. AFTER " + numTrials + " TRIALS, ALL RESULTS AND STATISTICS WILL BE PRINTED.");
  System.out.println("A LINE THAT SAYS \"PRINTING ALL RESULTS. COPY DATA FROM HERE\" WILL BE PRINTED ONTO THE CONSOLE. USE DATA FROM THERE.");
  System.out.println("THE FOLLOWING STATUS UPDATES ARE JUST TO INFORM YOU THAT THE PROGRAM IS RUNNING AND HAS NOT STOPPED. THEY WILL BE PRINTED EVERY 100 TICKS.");
  System.out.println("PROGRAM RUNS IN "+ (messageTiming/1000) +" SECONDS...");
  long init = System.currentTimeMillis();
  while(System.currentTimeMillis() - init < messageTiming - 3000){
  }
  String previousMessage = "";
  while(System.currentTimeMillis() - init < messageTiming){
    long deltaTime = System.currentTimeMillis() - init;
    int time = (messageTiming/1000) - (int)(deltaTime/1000);
    if(deltaTime % 1000 == 0 && !previousMessage.equals("PROGRAM RUNS IN " + time +  " SECONDS...")){
      System.out.println("PROGRAM RUNS IN " + time +  " SECONDS...");
      previousMessage = "PROGRAM RUNS IN " + time +  " SECONDS...";
    }
  }
}

void cullLights(){
  for(int i = Lights.size() - 1; i > 0; i--){
    Light light = Lights.get(i);
      if(!light.isIntersectingRoad() || (light.width < light.height && light.pairedLight == null)){
        Lights.remove(i);
      }
  }
}
    
void trialing_draw(){
  while(currentTrial < numTrials){
    Roads.clear();
    Cars.clear();
    Lights.clear();
    clearGrid();
    disp_setup();
    turn = 0;
    initTime = System.currentTimeMillis();
    currentTrial++;
    nextCarId = 0;
    nextRoadId = 0;
    nextLightId = 0;

    
    
    while(turn <= maxTicks && carsRemaining > 0){
      carsRemaining = Cars.size();
      costMap = createCostMap();
      trial_draw();
      if(turn % 100 == 0){
        
      }
    }
    carsRemaining = Cars.size();
    print_results();
  }
  print_compiledResults();
  writeResultsToFile();
}    


void print_compiledResults(){
  System.out.println(" ");
  System.out.println("---------------PRINTING ALL RESULTS. COPY DATA FROM HERE---------------");
  System.out.println(" ");
  System.out.println(" ");
  for(Result result : Results){
    System.out.println(" ");
    System.out.println("---------------TRIAL " + result.trialNum + "---------------");
    System.out.println("TIMESTAMP: " + result.timestamp);
    System.out.println("FORMATION TYPE: " + result.formationType);
    System.out.println("CARS REMAINING: " + result.carsRemaining);
    System.out.println("TICK: " + result.tick);
    System.out.println("TIME ELAPSED: " + result.timeElapsed + "s");
  }
  System.out.println(" ");
  System.out.println("---------------END PROGRAM. CLOSE OUT OF WINDOW.---------------");
  for(;;){}
}

void print_results(){
  DateFormat dateFormat = new SimpleDateFormat("yyy/MM/dd HH:mm:ss");
  Date currDate = new Date();
  String currentDate = dateFormat.format(currDate);
  finalTime = System.currentTimeMillis();
  System.out.println(" ");
  System.out.println("---------------STATISTICS---------------");
  System.out.println("TIMESTAMP: " + currentDate);
  System.out.println("FORMATION TYPE: " + formationType);
  System.out.println("TRIAL " + currentTrial + "/" + numTrials);
  System.out.println("CARS REMAINING: " + carsRemaining);
  System.out.println("TICK: " + turn);
  System.out.println("TIME ELAPSED: " + ((finalTime - initTime)/1000) + "s");
  
  Result newTrial = new Result(currentTrial,carsRemaining,turn,maxTicks,((finalTime - initTime)/1000),currentDate, formationType);
  Results.add(newTrial);
}

void print_status(){
  DateFormat dateFormat = new SimpleDateFormat("yyy/MM/dd HH:mm:ss");
  Date currDate = new Date();
  String currentDate = dateFormat.format(currDate);
  finalTime = System.currentTimeMillis();
  System.out.println(" ");
  System.out.println("---------------STATUS---------------");
  System.out.println("TIMESTAMP: " + currentDate);
  System.out.println("FORMATION TYPE: " + formationType);
  System.out.println("CURRENTLY RUNNING TRIAL " + currentTrial + "/" + numTrials);
  System.out.println("CARS REMAINING: " + carsRemaining);
  System.out.println("TICK: " + turn + "/" + maxTicks);
  System.out.println("TIME ELAPSED: " + ((finalTime - initTime)/1000) + "s");
}

void disp_setup() {
  size(displayWidth, displayHeight);
  clearGrid();
  formation(formationType);
  generateCars(amountOfCars);
  generateLights();
  pairLights();
  cullLights();
}

void master_draw() {
  if (roadUIFinished == false) {
    background(0);
    roadUI();
    roadUIRender();
    pairLights();
    cullLights();
  } else {
    background(0);
    costMap = createCostMap();
    carVectors.clear();
    render();
    if ((!keyPressed && key != 'l') && !pause) {
      runCars();
    }
    //renderLine();
    runLights();
    turn++;
  }
}



void translateRoadToMatrix(Road newRoad) {
  if (newRoad.width > newRoad.height) {
    int col = convertToMatrix(newRoad.getXPos());
    int row = convertToMatrix(newRoad.getYPos());
    int l = convertToMatrix(newRoad.width); 
    fillRow(col, row, l);
  } else {
    int col = convertToMatrix(newRoad.getXPos());
    int row = convertToMatrix(newRoad.getYPos());
    int l = convertToMatrix(newRoad.height); 

    fillCol(col, row, l);
  }
}

Position translateToMatrix(Position pos) {
  int col = convertToMatrix(pos.getXPos());
  int row = convertToMatrix(pos.getYPos());
  return new Position(col, row);
}

void affixRoadsToMatrix() {

  for (Road road : Roads) {
    translateRoadToMatrix(road);
    //System.out.println("Road road" + road.getId() + " = new Road(" + road.getId() + "," + road.getXPos() + "," + road.getYPos() + "," + road.width + "," + road.height + ");");
  }
  //Confirming if grid has been correctly transformed (debugging)
  //printGrid(grid);
}


void generateCars(int amount) {
    for (int i = 0; i < amount; i++) {
          float randomX = (float)Math.random() * displayWidth;
          float randomY = (float)Math.random() * displayHeight;
          Car newCar = createNewCar(randomX, randomY + (float)(Math.random() * randomSpawnLocOffsetLength));
          //System.out.println("road Y: " + road.getYPos());
          
          Position nextPos = new Position(randomX, randomY);
          while (!newCar.isIntersectingRoad(randomX, randomY)) {
            randomX = (float)Math.random() * displayWidth;
            randomY = (float)Math.random() * displayHeight;
            nextPos = new Position(randomX, randomY);
          }
          newCar.setPosition(nextPos);
          newCar.path = breadthFirstSearch(newCar);
          //newCar.path = dijksAlgo(newCar);
          Cars.add(newCar);
          nextCarId++;
      }
    
}


Car createNewCar(float x, float y) {
  float randomX = (float)Math.random() * displayWidth;
  float randomY = (float)Math.random() * displayHeight;
  Position objective = new Position(randomX, randomY);
  while (!objective.isIntersectingRoad(randomX, randomY)) {
    randomX = (float)Math.random() * displayWidth;
    randomY = (float)Math.random() * displayHeight;
  }
  objective = new Position(randomX, randomY);
  Car newCar = new Car(nextCarId, x, y, Constants.MAX_HEALTH, objective);
  return newCar;
}

void runCars() {
  //TODO: Add sentience to cars.
  for (int i = (Cars.size() - 1); i >= 0; i--) {
    Car car = Cars.get(i);
    ArrayList<Light> sortedLights = getSortedLights(car);
    Position nextObj = car.path.get(car.path.size() - 1);

    if (car.getDistanceTo(car.objective) < 25) {
      Cars.remove(i);
    }

    if (car.getDistanceTo(car.objective) < (defaultRoadWidth/2) + 25) {
      nextObj = car.objective;
    }

    if (car.getDistanceTo(nextObj) < 1) {
      if (car.path.size() > 1) {
        car.path.remove(car.path.size() - 1);
      }
      nextObj = car.path.get(car.path.size() - 1);
    }

    float angleRad = car.orientTowardsInRad(nextObj);
    if (sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("yellow"))) {
      car.move(angleRad, 1);
    } else if (sortedLights.size() > 0 && (sortedLights.get(0).colour.equals("green"))) {
      car.move(angleRad, 1);
    } else {
      car.move(angleRad, 1);
    }
  }
}

void roadUI() {
  if (mode == 'h') {
    if (keyPressed && key == 's') {
      if (road.width > defaultRoadWidth) {
        road.width -= defaultRoadWidth;
        keyPressed = false;
      }
    } else if (keyPressed && key == 'w') {
      if (road.height < displayWidth) {
        road.width += defaultRoadWidth;
        keyPressed = false;
      }
    }
  } else if (mode == 'v') {
    if (keyPressed && key == 's') {
      if (road.height > defaultRoadWidth) {
        road.height -= defaultRoadWidth;
        keyPressed = false;
      }
    } else if (keyPressed && key == 'w') {
      if (road.height < displayHeight) {
        road.height += defaultRoadWidth;
        keyPressed = false;
      }
    }
  }

  if (keyPressed && keyCode == RIGHT) {
    if (road.getXPos() + defaultRoadWidth < displayWidth) {
      road.setPosition(new Position(road.getXPos() + defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
  } else if (keyPressed && keyCode == LEFT) {
    if (road.getXPos() - defaultRoadWidth > -1) {
      road.setPosition(new Position(road.getXPos() - defaultRoadWidth, road.getYPos()));
      keyPressed = false;
    }
  } else if (keyPressed && keyCode == UP) {
    if (road.getYPos() - defaultRoadWidth > -1) {
      road.setPosition(new Position(road.getXPos(), road.getYPos() - defaultRoadWidth));
      keyPressed = false;
    }
  } else if (keyPressed && keyCode == DOWN) {
    if (road.getYPos() + defaultRoadWidth < displayHeight) {
      road.setPosition(new Position(road.getXPos(), road.getYPos() + defaultRoadWidth));
      keyPressed = false;
    }
  }

  if (keyPressed && key == ' ') {
    Road newRoad = new Road(nextRoadId, road.getXPos(), road.getYPos(), road.width, road.height);
    Roads.add(newRoad);
    System.out.println("Road road" + nextRoadId + "  = new Road(" + nextRoadId + ","+newRoad.getXPos()+","+newRoad.getYPos()+","+ newRoad.width + ", "+newRoad.height+");");
    System.out.println("Roads.add(road" + nextRoadId + ");");
    nextRoadId++;
    road.id = nextRoadId;
    if (newRoad.width > newRoad.height) {
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(road.width); 

      fillRow(col, row, l);
    } else {
      int col = convertToMatrix(newRoad.getXPos());
      int row = convertToMatrix(newRoad.getYPos());
      int l = convertToMatrix(road.height); 

      fillCol(col, row, l);
    }
    
    //printGrid(grid);
    keyPressed = false;
  }

  if (keyPressed && (key == 'h' || key == 'v')) {
    mode = key;
  }

  if (keyPressed) {
    if (mode == 'h') {
      //road.width = displayWidth;
      road.height = defaultRoadWidth;
      road.setPosition(new Position(0, road.getYPos()));
    } else if (mode == 'v') {
      road.width = defaultRoadWidth;
      //road.height = displayHeight;
      road.setPosition(new Position(road.getXPos(), 0));
    }
  }

  if (keyPressed && (key == ENTER || key == RETURN)) {
    //System.out.println("Enter or Return pressed");
    roadUIFinished = true;
    generateCars(amountOfCars);
    generateLights();
  }
}

void generateLights() {
  for (Road road : Roads) {
    for (Road roads : Roads) {
      nextLightId++;
      for (int i = 0; i < 2; i++) {
        Light newLight;
        if (nextLightId % 2 == 0) {
          newLight = new Light(nextLightId, roads, "red");
        } else {
          newLight = new Light(nextLightId, roads, "green");
        }
        if (!newLight.colour.equals("noRender")) {
          Lights.add(newLight);
        }
      }
    }
  }
}

ArrayList<Car> getCarsInGrid(int col, int row){
  ArrayList<Car> carsInGrid = new ArrayList<Car>();
  for(Car car : Cars){
    int carCol = convertToMatrix(car.getXPos());
    int carRow = convertToMatrix(car.getYPos());
    
    if(carCol == col && carRow == row){
      carsInGrid.add(car);
    }
  }
  return carsInGrid;
}

void pairLights(){
  for(Light light : Lights){
    if(light.width < light.height){
     for(Light compareLight: Lights){
      if(light.getYPos() == compareLight.getYPos() && light.getDistanceTo(compareLight) < 200){
          if(light.width != compareLight.width && light.height != compareLight.height && convertToMatrix(light.getXPos()) == convertToMatrix(compareLight.getXPos()) && convertToMatrix(light.getYPos()) == convertToMatrix(compareLight.getYPos())){
              light.pairedLight = compareLight;
              break;
          }
      }
     }
    }
  }
}

void runLights() {
  int localCooldownDefault = 0;
  for (Light light : Lights) {
      //ArrayList<Car> sortedCars = getSortedCars(light);
      int col = convertToMatrix(light.getXPos());
      int row = convertToMatrix(light.getYPos());
      
      ArrayList<Position> areasToCheck = new ArrayList<Position>();
      int nearCars = 0;
      areasToCheck.add(new Position(col,row + 1));
      areasToCheck.add(new Position(col,row - 1));
      areasToCheck.add(new Position(col + 1,row));
      areasToCheck.add(new Position(col - 1, row));
      
      for(Position gridSpaces : areasToCheck){
        if(gridSpaces.getXPos() >= 0 && gridSpaces.getXPos() <= displayWidth/defaultRoadWidth && gridSpaces.getYPos() >= 0 && gridSpaces.getYPos() < displayHeight/defaultRoadWidth){
          nearCars += costMap[(int)gridSpaces.getXPos()][(int)gridSpaces.getYPos()] - 1;
        }
      
      }
      
      if(nearCars > 0 && costMap[col][row] == 1){
        light.cooldown = localCooldownDefault;
        try{
          if(col != 0 && col != displayWidth/defaultRoadWidth && row > 0 && row  != displayHeight/defaultRoadWidth - 1){
            if((costMap[col + 1][row] + costMap[col - 1][row]) > (costMap[col][row + 1] + costMap[col][row - 1])){
              //let horz cars pass, since there are more horz cars 
              if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
            }else{
              if (light.width < light.height) {
                 light.setColour("red");
               } else {
                  light.setColour("green");
               } 
            }
            
            
          }else{
            if(col == displayWidth/defaultRoadWidth && row == displayHeight/defaultRoadWidth){
              //System.out.println("col: " + col + ", row: " + row); 
              if(costMap[col - 1][row] > (costMap[col][row - 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            if(col == 0 && row == displayHeight/defaultRoadWidth){
              //System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col + 1][row]) > (costMap[col][row - 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
            }else{
              if (light.width < light.height) {
                 light.setColour("red");
               } else {
                  light.setColour("green");
               } 
            }
            }
            
            if(col == 0 && row == 0){
                //System.out.println("col: " + col + ", row: " + row); 
                if((costMap[col + 1][row]) > (costMap[col][row + 1])){
                 if (light.width < light.height) {
                   light.setColour("green");
                 } else {
                    light.setColour("red");
                 } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            
            
            if(col == displayWidth/defaultRoadWidth && row == 0){
             // System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col - 1][row]) > (costMap[col][row + 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            if(col == displayWidth/defaultRoadWidth && row < displayHeight/defaultRoadWidth){
              //System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col - 1][row]) > (costMap[col][row + 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            if(col == 0 && row != displayHeight/defaultRoadWidth - 1 && row != 0){
             // System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col + 1][row] + 1) > (costMap[col][row + 1] + costMap[col][row - 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            if(row == 0 && col != displayWidth/defaultRoadWidth - 1 && col != 0){
             // System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col + 1][row] + costMap[col - 1][row]) > (costMap[col][row + 1] + 1)){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
            if(row == displayHeight/defaultRoadWidth - 1 && col != displayWidth/defaultRoadWidth && col != 0){
              //System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col + 1][row] + costMap[col - 1][row]) > (costMap[col][row - 1] + 1)){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }

            if(col == displayWidth/defaultRoadWidth && row != displayHeight/defaultRoadWidth - 1 && row != 0){
              //System.out.println("col: " + col + ", row: " + row); 
              if((costMap[col - 1][row] + 1) > (costMap[col][row + 1] + costMap[col][row - 1])){
               if (light.width < light.height) {
                 light.setColour("green");
               } else {
                  light.setColour("red");
               } 
              }else{
                if (light.width < light.height) {
                   light.setColour("red");
                 } else {
                    light.setColour("green");
                 } 
              }
            }
            
          }
          
        }catch(Exception e){
          //System.out.println("[" + e + "] row: " + row + ", col: " + col);
        }
        
        
      }else{
        if(light.width > light.height){
          if(turn % (lightsInterval)== lightsInterval/2){
            if(light.id % 2 == 0){
               light.setColour("red");
            }else{
              light.setColour("green");
            }
          }else if(turn % lightsInterval == 0){
            if(light.id % 2 == 0){
               light.setColour("green");
            }else{
              light.setColour("red");
            }
          }
        }else{
          Light verticalLight = light.pairedLight;
          try{
            if(verticalLight.colour.equals("red")){
              light.setColour("green");
            }else{
              light.setColour("red");
            }
          }catch(Exception e){
            
          }
        }
      
      }
  }
}

int convertToMatrix(double number) {
  return (int)(number/defaultRoadWidth);
}

void clearGrid() {
  for (int row = 0; row < grid[0].length; row++) {
    for (int column = 0; column < grid.length; column++) {
      grid[column][row] = 0;
    }
  }
  //System.out.println("Grid cleared.");
}

void printGrid(int[][] grid) {
  for (int row = 0; row < grid[0].length; row++) {
    String output = "";
    for (int column = 0; column < grid.length; column++) {
      output = output + grid[column][row] + " ";
    }
    //System.out.println(output);
  }
}

void fillRow(int colNum, int rowNum, int rowWidth) {
  for (int column = colNum; column < colNum + rowWidth; column++) {
    grid[column][rowNum] = 1;
  }
}

void fillCol(int colNum, int rowNum, int colHeight) {
  for (int row = rowNum; row < rowNum + colHeight; row++) {
    grid[colNum][row] = 1;
  }
}

int[][] createCostMap() {
  int[][] cost = new int [grid.length][grid[0].length];
  for (int row = 0; row < costMap[0].length; row++) {
    for (int column = 0; column < costMap.length; column++) {
      cost[column][row] = 1;
      //printGrid(cost);
    }
  }
  //printGrid(cost);
  for (Car car : Cars) {
    Position carPos = translateToMatrix(car);
    cost[(int)carPos.getXPos()][(int)carPos.getYPos()]++;
  }
  return cost;
}

ArrayList<Position> breadthFirstSearch(Car car) {
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
  //System.out.println("Matrices \"map\", \"path\", and \"temp\" initialised.");
  //xPos = Column, yPos = Row
  ArrayList<Position> frontier = new ArrayList<Position>();
  //System.out.println("ArrayList \"frontier\" initialised.");
  //import grid -> temp
  for (int row = 0; row < grid[0].length; row++) {
    for (int column = 0; column < grid.length; column++) {
      temp[column][row] = grid[column][row];
    }
  }
  //System.out.println("grid has been imported to temp");

  //plot objective on temp
  int objCol = ((int)car.objective.getXPos() - ((int)car.objective.getXPos() % 100))/100;
  int objRow = ((int)car.objective.getYPos() - ((int)car.objective.getYPos() % 100))/100;
  temp[objCol][objRow] = -1;
  //System.out.println("objective plotted on temp");
  //System.out.println("objCol: " + objCol + " objRow: " + objRow);
  //System.out.println("obj x: " + car.objective.getXPos() + " obj y: " + car.objective.getYPos());


  //plot car on temp and map
  int carCol = ((int)car.getXPos() - ((int)car.getXPos() % 100))/100;
  int carRow = ((int)car.getYPos() - ((int)car.getYPos() % 100))/100;
  //System.out.println("col: " + carCol + " carRow: " + carRow);
  //System.out.println("temp row length: " + temp[0].length);
  //System.out.println("temp col length: " + temp.length);
  //System.out.println("car x: " + car.getXPos() + " car y: " + car.getYPos());
  //System.out.println("car id: " + car.getId());
  temp[carCol][carRow] = 2;

  if (objCol == carCol && objRow == carRow) {
    float convertedX = ((float)carCol * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    float convertedY = ((float)carRow * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    path.add( new Position(convertedX, convertedY));
    return path;
  }

  Position carPos = new Position(carCol, carRow);
  map[carCol][carRow] = new From(carPos, carPos);
  //System.out.println("car plotted on temp");
  //System.out.println("temp:");


  //add car to frontier
  frontier.add(new Position(carCol, carRow));
  //System.out.println("car added to frontier.");

  //flag for early exit out of Breadth First Search
  boolean flagEarlyExit = false;
  //System.out.println("Breadth First Search: Variables ready for car " + car.getId() + ". Proceeding with calculations.");
  //Calculate
  while (!flagEarlyExit) {
    //printGrid(temp);
    for (int index = frontier.size() - 1; index >= 0; index--) {



      int col = (int)frontier.get(index).getXPos();
      int row = (int)frontier.get(index).getYPos();
      if (temp[col][row] == 3 || temp[col][row] == 2) {
        if (row < temp[col].length - 1 && (temp[col][row + 1] == 1 || temp[col][row + 1] == -1)) {
          temp[col][row + 1] = 3;
          Position is = new Position(col, row  +1);
          Position from = new Position(col, row);
          map[col][row + 1] = new From(is, from);
          frontier.add(new Position(col, row + 1));

          if (col == objCol && (row + 1) == objRow) {
            //System.out.println("Early exit flag triggered. Exiting calculation loop.");
            flagEarlyExit = true;
            break;
          }
        }
        if (row > 0 && (temp[col][row - 1] == 1 || temp[col][row - 1] == -1)) { 
          temp[col][row - 1] = 3;
          Position is = new Position(col, row  - 1);
          Position from = new Position(col, row);
          map[col][row - 1] = new From(is, from);
          frontier.add(new Position(col, row - 1));

          if (col == objCol && (row - 1) == objRow) {
            //System.out.println("Early exit flag triggered. Exiting calculation loop.");
            flagEarlyExit = true;
            break;
          }
        }
        if (col < temp.length - 1 && (temp[col + 1][row] == 1 || temp[col + 1][row] == -1)) {
          temp[col + 1][row] = 3;
          Position is = new Position(col + 1, row);
          Position from = new Position(col, row);
          map[col + 1][row] = new From(is, from);
          frontier.add(new Position(col + 1, row));

          if ((col + 1) == objCol && (row) == objRow) {
            //System.out.println("Early exit flag triggered. Exiting calculation loop.");
            flagEarlyExit = true;
            break;
          }
        }
        if (col > 0 && (temp[col - 1][row] == 1 || temp[col - 1][row] == -1)) {
          temp[col - 1][row] = 3;
          Position is = new Position(col - 1, row);
          Position from = new Position(col, row);
          map[col - 1][row] = new From(is, from);
          frontier.add(new Position(col - 1, row));

          if ((col - 1) == objCol && (row) == objRow) {
           // System.out.println("Early exit flag triggered. Exiting calculation loop.");
            flagEarlyExit = true;
            break;
          }
        }
        if (temp[col][row] != 2) {
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
  while (!same(current, start)) {

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

int getCost(ArrayList<Cost> costSoFar, Position p) {
  for (Cost cost : costSoFar) {
    if (cost.p.getXPos() == p.getXPos() && cost.p.getYPos() == p.getYPos()) {
      return cost.cost;
    }
  }
  return -1;
}

ArrayList<Position> dijksAlgo(Car car) {
  //MAP KEY:
  //0 = inaccesible area
  //2 = car
  //1 = unvisited area
  //3 = frontier
  //4 = visited
  //5 = objective position

  PriorityQueue<PriorityPosition> frontier = new PriorityQueue<PriorityPosition>();
  //System.out.println("ArrayList \"frontier\" initialised.");

  From[][] map = new From[grid.length][grid[0].length];
  int[][] temp = new int[grid.length][grid[0].length];

  //System.out.println("Matrices \"map\" and \"temp\" initialised.");

  //Path that car should take. To be filled with positions.
  ArrayList<Position> path = new ArrayList<Position>();

  ArrayList<Cost> costSoFar = new ArrayList<Cost>();

  //xPos = Column, yPos = Row
  //import grid -> temp
  for (int row = 0; row < grid[0].length; row++) {
    for (int column = 0; column < grid.length; column++) {
      temp[column][row] = grid[column][row];
    }
  }
  //System.out.println("grid has been imported to temp");

  //plot objective on temp
  int objCol = ((int)car.objective.getXPos() - ((int)car.objective.getXPos() % 100))/100;
  int objRow = ((int)car.objective.getYPos() - ((int)car.objective.getYPos() % 100))/100;
  temp[objCol][objRow] = 5;
  //System.out.println("objective plotted on temp");
  //System.out.println("objCol: " + objCol + " objRow: " + objRow);
  //System.out.println("obj x: " + car.objective.getXPos() + " obj y: " + car.objective.getYPos());


  //plot car on temp
  int carCol = ((int)car.getXPos() - ((int)car.getXPos() % 100))/100;
  int carRow = ((int)car.getYPos() - ((int)car.getYPos() % 100))/100;
  //System.out.println("col: " + carCol + " carRow: " + carRow);
  //System.out.println("temp row length: " + temp[0].length);
  //System.out.println("temp col length: " + temp.length);
  //System.out.println("car x: " + car.getXPos() + " car y: " + car.getYPos());
  //System.out.println("car id: " + car.getId());
  temp[carCol][carRow] = 2;

  //if car is already in the same square as the objective, just go to objective.
  if (objCol == carCol && objRow == carRow) {
    float convertedX = ((float)carCol * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    float convertedY = ((float)carRow * (float)defaultRoadWidth) + (float)defaultRoadWidth/2;
    path.add(new Position(convertedX, convertedY));
    return path;
  }

  Position carPos = new Position(carCol, carRow);
  map[carCol][carRow] = new From(carPos, carPos);
  //System.out.println("car plotted on temp");
  //System.out.println("temp:");


  //add car to frontier
  frontier.add(new PriorityPosition(new Position(carCol, carRow), 0));
  //System.out.println("car added to frontier.");

  //flag for early exit out of Breadth First Search
  boolean flagEarlyExit = false;
  //System.out.println("Breadth First Search: Variables ready for car " + car.getId() + ". Proceeding with calculations.");
  //Calculate
  while (!flagEarlyExit) {
    printGrid(temp);
    //System.out.println("----------------------------------------------");
    for (int index = frontier.size() - 1; index >= 0; index--) {
      int col = (int)frontier.peek().p.getXPos();
      int row = (int)frontier.peek().p.getYPos();


      if (temp[col][row] == 3 || temp[col][row] == 2) {
        if (row < temp[col].length - 1 && (temp[col][row + 1] == 1 || temp[col][row + 1] == 5)) {
          int newCost = getCost(costSoFar, new Position(col, row)) + costMap[col][row + 1];
          if (getCost(costSoFar, new Position(col, row + 1)) != -1 || newCost < getCost(costSoFar, new Position(col, row + 1))) {
            frontier.add(new PriorityPosition(new Position(col, row + 1), newCost));
            temp[col][row + 1] = 3;
            Position is = new Position(col, row  +1);
            Position from = new Position(col, row);
            map[col][row + 1] = new From(is, from);

            if (col == objCol && (row + 1) == objRow) {
              //System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
        }
        if (row > 0 && (temp[col][row - 1] == 1 || temp[col][row - 1] == 5)) { 
          int newCost = getCost(costSoFar, new Position(col, row)) + costMap[col][row - 1];
          if (getCost(costSoFar, new Position(col, row - 1)) != -1 || newCost < getCost(costSoFar, new Position(col, row - 1))) {
            frontier.add(new PriorityPosition(new Position(col, row - 1), newCost));
            temp[col][row - 1] = 3;
            Position is = new Position(col, row  - 1);
            Position from = new Position(col, row);
            map[col][row - 1] = new From(is, from);

            if (col == objCol && (row - 1) == objRow) {
              //System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
        }
        if (col < temp.length - 1 && (temp[col + 1][row] == 1 || temp[col + 1][row] == 5)) {
          int newCost = getCost(costSoFar, new Position(col, row)) + costMap[col + 1][row];
          if (getCost(costSoFar, new Position(col + 1, row)) != -1 || newCost < getCost(costSoFar, new Position(col + 1, row))) {
            frontier.add(new PriorityPosition(new Position(col + 1, row), newCost));
            temp[col + 1][row] = 3;
            Position is = new Position(col + 1, row);
            Position from = new Position(col, row);
            map[col + 1][row] = new From(is, from);

            if ((col + 1) == objCol && (row) == objRow) {
              //System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
        }
        if (col > 0 && (temp[col - 1][row] == 1 || temp[col - 1][row] == 5)) {
          int newCost = getCost(costSoFar, new Position(col, row)) + costMap[col - 1][row];
          if (getCost(costSoFar, new Position(col - 1, row)) != -1 || newCost < getCost(costSoFar, new Position(col - 1, row))) {
            frontier.add(new PriorityPosition(new Position(col - 1, row), newCost));
            temp[col - 1][row] = 3;
            Position is = new Position(col - 1, row);
            Position from = new Position(col, row);
            map[col - 1][row] = new From(is, from);

            if ((col - 1) == objCol && (row) == objRow) {
              System.out.println("Early exit flag triggered. Exiting calculation loop.");
              flagEarlyExit = true;
              break;
            }
          }
        }
        if (temp[col][row] != 2) {
          temp[col][row] = 4;
        }

        Position pos = new Position(-1, -1);
        PriorityPosition prioPos = new PriorityPosition(pos, -1);

        for (PriorityPosition priorityPos : frontier) {
          if (priorityPos.p.getXPos() == col && priorityPos.p.getYPos() == row) {
            prioPos = priorityPos;
          }
        }
        frontier.remove(prioPos);
      }
    }
  }

  //Which coordinate is being iterated currently.
  From current = map[objCol][objRow];
  //Where the car is right now
  From start = map[carCol][carRow];

  //While the current coordinates do not equal the start coordinates,
  while (!same(current, start)) {

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
boolean same(From from1, From from2) {
  if (from1.is.getXPos() == from2.is.getXPos() && from1.is.getYPos() == from2.is.getYPos()) { //ERROR ON THIS LINE NullPointerException
    if (from1.from.getXPos() == from2.from.getXPos() && from1.from.getYPos() == from2.from.getYPos()) {
      return true;
    }
    return false;
  }
  return false;
}

void disp_draw() {
  background(0);
  carVectors.clear();
  render();
  costMap = createCostMap();
  if ((!keyPressed && key != 'l') && !pause) {
    runCars();
  }
  runLights();
  turn++;
}

void trial_draw() {
  background(0);
  carVectors.clear();
  runCars();
  runLights();
  turn++;
  costMap = createCostMap();
  if(keyPressed && key == 'p') {
        print_status();
        keyPressed = false;
  }
}

void roadUIRender() {
  for (Road roads : Roads) {
    fill(150);
    rect(roads.getXPos(), roads.getYPos(), roads.getWidth(), roads.getHeight());
    //System.out.println("road " + roads.getId() + " drawn at x: " + roads.getXPos() + " y: " + roads.getYPos());
  }

  fill(75);
  noStroke();
  rect(road.getXPos(), road.getYPos(), road.getWidth(), road.getHeight());
}

void render() {
  fill(150);
  noStroke();


  for (Road road : Roads) {
    rect(road.getXPos(), road.getYPos(), road.getWidth(), road.getHeight());
  }

  noFill();
  for (Car car : Cars) {
    if (car.collidingWithRoads) {
      stroke(0, 255, 0);
    } else {
      stroke(255, 0, 0);
    }
    noFill();
    ellipse(car.getXPos(), car.getYPos(), Constants.CAR_RADIUS, Constants.CAR_RADIUS);
    noStroke();
    fill(255, 0, 0);
    ellipse(car.objective.getXPos(), car.objective.getYPos(), 10, 10);
    //textSize(10);
    fill(0, 255, 0);
    //String coordinates = "c: " + convertToMatrix(car.getXPos()) + " r: " + convertToMatrix(car.getYPos());
    //String PathCoordinates = "Pc: " + convertToMatrix(car.path.get(car.path.size() - 1).getXPos()) + " Pr: " + convertToMatrix(car.path.get(car.path.size() - 1).getYPos());
    String id = ("id: " + car.getId());
    //text(coordinates, car.getXPos() + 15, car.getYPos() + 15);
    //text(PathCoordinates, car.getXPos() + 15, car.getYPos() + 30);
    text(id, car.getXPos() - 30, car.getYPos() + 25);
    //text(id, car.objective.getXPos() - 30, car.objective.getYPos() + 25);
  }

  for (Light light : Lights) {
    if (!light.colour.equals("noRender")) {
      noFill();
      stroke(light.R, light.G, light.B);
      rect(light.getXPos(), light.getYPos(), light.width, light.height);

      noStroke();
      fill(light.R, light.G, light.B);

      //Debugging for Issue #3
      //String id = ("id: " + light.id);
      //String coordinates = "x: " + (int)light.getXPos() + " y: " + (int)light.getYPos();
      //text(id, light.getXPos() + 30, light.getYPos() + 25);
      //text(coordinates, light.getXPos() + 15, light.getYPos() + 15);

      //Debugging for Issue #8 & #9
      String lightId = ("id: " + light.id);
      text(lightId, light.getXPos() + 15, light.getYPos() + 25);
    }
  }
}

public ArrayList<Car> getSortedCars(Position car) {
  ArrayList<Car> sortedCars = new ArrayList<Car>();
  Car removed;
  sortedCars = new ArrayList<Car>();
  for (Car cars : Cars) {
    if (cars != car) {
      sortedCars.add(cars);
    }
  }
  int index;
  for (int k = 0; k < sortedCars.size() - 1; k++) {
    index = k;
    for (int i = k + 1; i < sortedCars.size(); i++) {
      if (sortedCars.get(index).getDistanceTo(car) > sortedCars.get(i).getDistanceTo(car)) {
        index = i;
      } else if (sortedCars.get(index).getDistanceTo(car) == sortedCars.get(i).getDistanceTo(car)) {
        if (sortedCars.get(index).getHealth() > sortedCars.get(i).getHealth()) {
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

public ArrayList<Light> getSortedLights(Car car) {
  ArrayList<Light> sortedLights = new ArrayList<Light>();
  Light removed;
  sortedLights = new ArrayList<Light>();
  for (Light lights : Lights) {
    if (lights.road.getCarList().contains(car)) {
      sortedLights.add(lights);
    }
  }
  int index;
  for (int k = 0; k < sortedLights.size() - 1; k++) {
    index = k;
    for (int i = k + 1; i < sortedLights.size(); i++) {
      if (sortedLights.get(index).getDistanceTo(car) > sortedLights.get(i).getDistanceTo(car)) {
        index = i;
      }
    }
    removed = sortedLights.get(k);
    sortedLights.set(k, sortedLights.get(index));
    sortedLights.set(index, removed);
  }
  return sortedLights;
}

void renderLine() {
  for (int k = 0; k < Cars.size(); k++) {
    int chosenCar = k;
    for (int i =0; i < Roads.size(); i ++) {
      int chosenRoad = i;
      float carX = Cars.get(chosenCar).getXPos();
      float carY = Cars.get(chosenCar).getYPos();

      float roadX = Roads.get(chosenRoad).getXPos();
      float roadY = Roads.get(chosenRoad).getYPos();
      float roadWidth = Roads.get(chosenRoad).getWidth();
      float roadHeight = Roads.get(chosenRoad).getHeight();
      float offset = 0;
      if (roadWidth > roadHeight) {
        roadHeight -= offset;
      } else {
        roadWidth -= offset;
      }
      float closestX = Math.max(roadX, Math.min(carX, roadX + roadWidth));
      float closestY = Math.max(roadY, Math.min(carY, roadY + roadHeight));
      float dx = carX - closestX;
      float dy = carY - closestY;
      if (((dx * dx) + (dy * dy)) < 64) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 255, 0);
      }
      line(Cars.get(chosenCar).getXPos(), Cars.get(chosenCar).getYPos(), closestX, closestY);
    }
  }
}

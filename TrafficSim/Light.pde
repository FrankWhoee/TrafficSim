public class Light extends Position{
 
  public int id;
  public Road road;
  public float width;
  public float height;
  public float R;
  public float G;
  public float B;
  public String colour;
  public Light(int id, Road road, String colour){
    super(0,0);
    this.road = road;
    this.id = id;
    this.colour = colour;
    if(road.getWidth() > road.getHeight()){
      width = 1;
      height = road.getHeight();
      super.yPos = road.getYPos();
      super.xPos = getSpotX();
    }else{
      width = road.getWidth();
      height = 1;
      super.xPos = road.getXPos();
      super.yPos = getSpotY();
    }
  }
  
  public float calculateIdUnrounded(){
    float output = 0;
    if(road.getWidth() > road.getHeight()){
      output = super.getXPos();
    }else{
      output = super.getYPos();
    }
    return output;
  }
  
  public void setColour(String colour){
    if(colour.equals("green")){
      R = 0;
      G = 255;
      B = 0;
      this.colour = colour;
    }else if(colour.equals("red")){
      R = 255;
      G = 0;
      B = 0;
      this.colour = colour;
    }else if(colour.equals("yellow")){
      R = 255;
      G = 255;
      B = 0;
      this.colour = colour;
    }else if(colour.equals("disabled")){
      R = 100;
      G = 100;
      B = 100;
      this.colour = colour;
    }
  }

  public float getSpotX(){
    ArrayList<Float> viableXPos = new ArrayList<Float>();
    for(Road road: TrafficSim.Roads){
      if(road.getWidth() < road.getHeight()){
        viableXPos.add(road.getXPos());
        viableXPos.add(road.getXPos() + road.getWidth() - width);
        //System.out.println("light " + this.id + ": " + road.getXPos() + " added new X viable position.");
        //System.out.println("light " + this.id + ": " + (road.getXPos() + road.getWidth() - width) + " added new X viable position.");
      }
    }
    
    for(Light light: TrafficSim.Lights){
      if(viableXPos.contains(light.getXPos()) && light.getYPos() == road.getYPos() && light.width < light.height){
        viableXPos.remove(light.getXPos());
        //System.out.println("light " + this.id + ": " + light.getXPos() + " removed X viable position, light id " + light.id + " already there");
      }
    }
    
    if(viableXPos.size() > 0){
      //System.out.println("Position set.");
      return viableXPos.get(0);
    }else{
      //System.out.println("No viable x positions");
      return -1;
    }
    
  }
    
  public float getSpotY(){
    ArrayList<Float> viableYPos = new ArrayList<Float>();
    for(Road road: TrafficSim.Roads){
      if(road.getWidth() > road.getHeight()){
        viableYPos.add(road.getYPos());
        viableYPos.add(road.getYPos() + road.getHeight() - height);
      }
    }
    
    for(Light light: TrafficSim.Lights){
      if(viableYPos.contains(light.getYPos()) && light.getXPos() == road.getXPos() && light.width > light.height){
        viableYPos.remove(light.getYPos());
      }
    }
    
    if(viableYPos.size() > 0){
      //System.out.println("No viable y positions");
      return viableYPos.get(0);
    }else{
      return -1;
    }
  }
  
}
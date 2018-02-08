public class Position{
  private float xPos;
  private float yPos;
  
  public Position(final float xPos, final float yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public float getXPos(){
    return xPos;
  }
  
  public float getYPos(){
    return yPos;
  }
  
  public float getDistanceTo(final Position target) {
        final double dx = xPos - target.getXPos();
        final double dy = yPos - target.getYPos();
        return (float)Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
    }
    
  public int orientTowardsInDeg(final Position target) {
    return Util.angleRadToDegClipped(orientTowardsInRad(target));
  }
    
  public float orientTowardsInRad(final Position target) {
    final double dx = target.getXPos() - xPos;
    final double dy = target.getYPos() - yPos;

    return (float)(Math.atan2(dy, dx) + 2 * Math.PI);
   }
   
   public void move(float angleRad, float thrust){
     float velX;
     float velY;
     final float xPos = this.xPos;
     final float yPos = this.yPos;
     Position newPosition = new Position(xPos,yPos);
     float radian = (float)(Math.PI * 2);
     
     for(float i = 0; i < radian; i += radian/10){
       
       velX = (float)(Math.cos(angleRad - i) * thrust);
       velY = (float)(Math.sin(angleRad - i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         if(courseOnRoad(angleRad - i, thrust)){
           this.xPos = newPosition.getXPos();
           this.yPos = newPosition.getYPos();
           break;
         }
         
       }
       
       velX = (float)(Math.cos(angleRad + i) * thrust);
       velY = (float)(Math.sin(angleRad + i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         if(courseOnRoad(angleRad + i, thrust)){
           this.xPos = newPosition.getXPos();
           this.yPos = newPosition.getYPos();
           break;           
         }

       }
     }
     
     
   }
   
   public boolean courseOnRoad(float angleRad, float thrust){
     float velx;
     float vely;
     float t;
     for(t = 0; t < thrust + 5; t += 0.1){
       float velX = (float)(Math.cos(angleRad) * t);
       float velY = (float)(Math.sin(angleRad) * t);
       float newX = xPos + velX;
       float newY = yPos + velY;
       
       if(!isIntersectingRoad(newX, newY)){
          return false;
       }
       
     }
     return true;
   }
   
   public boolean isIntersectingRoad(float xPos, float yPos){
     for(Road road: TrafficSim.Roads){
        //int chosenCar = 7;
        float carX = xPos;
        float carY = yPos;
      
        float roadX = road.getXPos();
        float roadY = road.getYPos();
        float roadWidth = road.getWidth();
        float roadHeight = road.getHeight();
       if(roadWidth > roadHeight){
         roadHeight -= 16;
       }else{
         roadWidth -= 16;
       }
        float closestX = Math.max(roadX, Math.min(carX, roadX + roadWidth));
        float closestY = Math.max(roadY, Math.min(carY, roadY + roadHeight));
        float dx = carX - closestX;
        float dy = carY - closestY;
        
        //float dx2 =  closestX - carX;
        //float dy2 =  closestY - carY;
        
       if((((dx * dx) + (dy * dy)) < 64)){
         if(this instanceof Car){
           Car car = (Car)this;
           car.collidingWithRoads = true;
          }
         return true;
       }
    }
    return false;
   }
   
   
}
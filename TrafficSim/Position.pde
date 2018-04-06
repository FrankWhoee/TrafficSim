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
  
  public void setPosition(Position position){
      xPos = position.getXPos();
      yPos = position.getYPos();
  }
  
  public float getYPos(){
    return yPos;
  }
  
  public void setXPos(float x){
    xPos = x;
  }
  
  public void setYPos(float y){
    yPos = y;
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
     
     
     for(float i = 0; i < radian; i += radian/120){
       
       velX = (float)(Math.cos(angleRad - i) * thrust);
       velY = (float)(Math.sin(angleRad - i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         if(courseOnRoad(angleRad - i, thrust)){
           if(collisionTime((angleRad - i), thrust)){
             if(objectsBetween(this,newPosition).isEmpty()){
               this.xPos = newPosition.getXPos();
               this.yPos = newPosition.getYPos();
               Velocity actualVel = new Velocity(velX,velY);
               carVectors.put((Car)this,actualVel);
               break;
             }
           }
           
         }
         
       }
       
       velX = (float)(Math.cos(angleRad + i) * thrust);
       velY = (float)(Math.sin(angleRad + i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         if(courseOnRoad((angleRad + i), thrust)){
           if(collisionTime((angleRad + i), thrust)){
             if(objectsBetween(this,newPosition).isEmpty()){
               this.xPos = newPosition.getXPos();
               this.yPos = newPosition.getYPos();
               Velocity actualVel = new Velocity(velX,velY);
               carVectors.put((Car)this,actualVel);
               break;
             }
             
           }         
         }

       }
     }
   }
   
   public boolean courseOnRoad(float angleRad, float thrust){
     float velx;
     float vely;
     float t;
     for(t = 0; t < thrust; t += 0.5){
       float velX = (float)(Math.cos(angleRad) * t);
       float velY = (float)(Math.sin(angleRad) * t);
       float newX = xPos + velX;
       float newY = yPos + velY;
       //stroke(255,0,0);
       //line(xPos,yPos,newX,newY);
       if(!isIntersectingRoad(newX, newY) || isIntersectingLight(newX,newY)){
          return false;
       }
       
     }
     return true;
   }
   
   public boolean isIntersectingRoad(float xPos, float yPos){
     for(Road road: TrafficSim.Roads){
        float carX = xPos;
        float carY = yPos;
      
        float roadX = road.getXPos();
        float roadY = road.getYPos();
        float roadWidth = road.getWidth();
        float roadHeight = road.getHeight();
        float offset = 32;
       if(roadWidth > roadHeight){
         roadHeight -= offset;
         roadY += 16;
       }else{
         roadWidth -= offset;
         roadX += 16;
       }
        float closestX = Math.max(roadX, Math.min(carX, roadX + roadWidth));
        float closestY = Math.max(roadY, Math.min(carY, roadY + roadHeight));
        float dx = carX - closestX;
        float dy = carY - closestY;
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
   
   public boolean isIntersectingLight(float xPos, float yPos){
     for(Light light: TrafficSim.Lights){
        float carX = xPos;
        float carY = yPos;
      
        float lightX = light.getXPos();
        float lightY = light.getYPos();
        float lightWidth = light.width;
        float lightHeight = light.height;
        
        float closestX = Math.max(lightX, Math.min(carX, lightX + lightWidth));
        float closestY = Math.max(lightY, Math.min(carY, lightY + lightHeight));
        float dx = carX - closestX;
        float dy = carY - closestY;
       if((((dx * dx) + (dy * dy)) < 64)){
         if(light.colour.equals("red")){
           if(this instanceof Car){
             Car car = (Car)this;
             car.collidingWithRoads = true;
            }
           return true;
         }
         
       }
    }
    return false;
   }
   
   public Light getIntersectingLight(float xPos, float yPos){
     for(Light light: TrafficSim.Lights){
        float carX = xPos;
        float carY = yPos;
      
        float lightX = light.getXPos();
        float lightY = light.getYPos();
        float lightWidth = light.width;
        float lightHeight = light.height;
        
        float closestX = Math.max(lightX, Math.min(carX, lightX + lightWidth));
        float closestY = Math.max(lightY, Math.min(carY, lightY + lightHeight));
        float dx = carX - closestX;
        float dy = carY - closestY;
       if((((dx * dx) + (dy * dy)) < 64)){
           return light;
       }
    }
    return new Light(-1,TrafficSim.Roads.get(0),"null");
   }
   
   public boolean collisionTime(float angleRad, float thrust){
     
     for(Car car : carVectors.keySet()){
       
       
       if(this.getDistanceTo(car) > 20){
         continue;
       }
       float velX = (float)(Math.cos(angleRad) * thrust);
       float velY = (float)(Math.sin(angleRad) * thrust);
       Velocity thisCarVel = new Velocity(velX,velY);
       float t = (float)Collision.collision_time(Constants.CAR_RADIUS,this, car, thisCarVel, carVectors.get(car));
       if(t >= 0 && t <= 1){
         //TrafficSim.pause = true;
         //Car thisCar = (Car)this;
         //System.out.println("collision detected. t = " + t + " between cars " + thisCar.getId() + " and " + car.getId());
         return false;
       }
     }
     return true;
     
   }
   
   public ArrayList<Entity> objectsBetween(Position start, Position target) {
        final ArrayList<Entity> entitiesFound = new ArrayList<Entity>();

        addEntitiesBetween(entitiesFound, start, target, Cars);

        return entitiesFound;
    }
    
    private void addEntitiesBetween(final List<Entity> entitiesFound,
                                           final Position start, final Position target,
                                           final Collection<? extends Entity> entitiesToCheck) {

        for (final Entity entity : entitiesToCheck) {
          if (entity.equals(start) || entity.equals(target) || TrafficSim.carVectors.containsKey(entity)) {
                continue;
            }
            if (Collision.segmentCircleIntersect(start, target, entity, Constants.FORECAST_FUDGE_FACTOR)) {
                entitiesFound.add(entity);
            }
        }
    }
    
   
}

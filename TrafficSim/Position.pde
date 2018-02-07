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
     
     for(float i = 0; i < radian; i += radian/360){
       
       velX = (float)(Math.cos(angleRad - i) * thrust);
       velY = (float)(Math.sin(angleRad - i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         this.xPos = newPosition.getXPos();
         this.yPos = newPosition.getYPos();
         break;
       }else{
         
       }
       
       velX = (float)(Math.cos(angleRad + i) * thrust);
       velY = (float)(Math.sin(angleRad + i) * thrust);
       newPosition = new Position(xPos + velX, yPos + velY);
       if(newPosition.getXPos() > 0 && newPosition.getXPos() < displayWidth && newPosition.getYPos() > 0 && newPosition.getYPos() < displayHeight){
         this.xPos = newPosition.getXPos();
         this.yPos = newPosition.getYPos();
         break;
       }else{
         
       }
     }
     
     
   }
   
   
}
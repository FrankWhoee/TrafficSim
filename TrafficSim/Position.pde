public class Position{
  private double xPos;
  private double yPos;
  
  public Position(final double xPos, final double yPos){
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  public double getXPos(){
    return xPos;
  }
  
  public double getYPos(){
    return yPos;
  }
  
  public double getDistanceTo(final Position target) {
        final double dx = xPos - target.getXPos();
        final double dy = yPos - target.getYPos();
        return Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
    }
    
     public int orientTowardsInDeg(final Position target) {
        return Util.angleRadToDegClipped(orientTowardsInRad(target));
    }
    
     public double orientTowardsInRad(final Position target) {
        final double dx = target.getXPos() - xPos;
        final double dy = target.getYPos() - yPos;

        return Math.atan2(dy, dx) + 2 * Math.PI;
    }

  
}
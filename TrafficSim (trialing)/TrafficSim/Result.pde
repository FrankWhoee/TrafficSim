class Result{
  public int trialNum;
  public int carsRemaining;
  public int tick;
  public int maxTick;
  public long timeElapsed;
  public String timestamp;
  public String formationType;
  
  public Result(int trialNum,
              int carsRemaining,
              int tick,
              int maxTick,
              long timeElapsed,
              String timestamp,
              String formationType){
                
              this.trialNum = trialNum;
              this.carsRemaining = carsRemaining;
              this.tick = tick;
              this.maxTick = maxTick;
              this.timeElapsed = timeElapsed;
              this.timestamp = timestamp;
              this.formationType = formationType;
              }

}

public static class Util {
  
    public static int angleRadToDegClipped(final double angleRad) {
        final long degUnclipped = Math.round(Math.toDegrees(angleRad));
        return (int) (((degUnclipped % 360L) + 360L) % 360L);
    }
    
}
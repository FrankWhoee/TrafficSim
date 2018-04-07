public static class Collision{
  
  public static boolean segmentCircleIntersect(final Position start, final Position end, final Entity circle, final double fudge) {
        // Parameterize the segment as start + t * (end - start),
        // and substitute into the equation of a circle
        // Solve for t
        final double circleRadius = circle.getRadius();
        final double startX = start.getXPos();
        final double startY = start.getYPos();
        final double endX = end.getXPos();
        final double endY = end.getYPos();
        final double centerX = circle.getXPos();
        final double centerY = circle.getYPos();
        final double dx = endX - startX;
        final double dy = endY - startY;
        
        final double a = square(dx) + square(dy);

        final double b = -2 * (square(startX) - (startX * endX)
                            - (startX * centerX) + (endX * centerX)
                            + square(startY) - (startY * endY)
                            - (startY * centerY) + (endY * centerY));

        if (a == 0.0) {
            // Start and end are the same point
            return start.getDistanceTo(circle) <= circleRadius + fudge;
        }

        // Time along segment when closest to the circle (vertex of the quadratic)
        final double t = Math.min(-b / (2 * a), 1.0);
        if (t < 0) {
            return false;
        }

        final double closestX = startX + dx * t;
        final double closestY = startY + dy * t;
        
        final double dx2= closestX - circle.getXPos();
        final double dy2 = closestY - circle.getYPos();
        final double closestDistance = (float)Math.sqrt(Math.pow(dx2, 2) + Math.pow(dy2, 2));

        return closestDistance <= circleRadius + fudge;
    }

    public static double square(final double num) {
        return num * num;
    }
  
  public static double collision_time(double r, final Position loc1, final Position loc2, final Velocity vel1, final Velocity vel2){
    
        // With credit to Ben Spector
        // Simplified derivation:
        // 1. Set up the distance between the two entities in terms of time,
        //    the difference between their velocities and the difference between
        //    their positions
        // 2. Equate the distance equal to the event radius (max possible distance
        //    they could be)
        // 3. Solve the resulting quadratic
        
        final double dx = loc1.getXPos() - loc2.getXPos();
        final double dy = loc1.getYPos() - loc2.getYPos();
        final double dvx = vel1.x - vel2.x;
        final double dvy = vel1.y - vel2.y;
        
        //Quadratic formula
        final double a = Math.pow(dvx, 2) + Math.pow(dvy, 2);
        final double b = 2 * (dx * dvx + dy * dvy);
        final double c = Math.pow(dx, 2) + Math.pow(dy, 2) - Math.pow(r, 2);
        
        final double disc = Math.pow(b, 2) - 4 * a * c;
        
        if(a == 0.0){
            if(b == 0.0){
                if(c <= 0.0){
                    // Implies r^2 >= dx^2 + dy^2 and the two are already colliding
                    return(0.0);
                }
                return(-1);
            }
            final double t = -c / b;
            if(t >= 0.0){
                return t;
            }
            return(-1);
        }else if(disc == 0.0){
            // One solution
            final double t = -b / (2 * a);
            return t;
        }else if(disc > 0){
           final double t1 = -b + Math.sqrt(disc);
           final double t2 = -b - Math.sqrt(disc);
           
           if(t1 >= 0.0 && t2 >= 0.0){
               return(Math.min(t1, t2) / (2 * a));
           } else if(t1 <= 0.0 && t2 <= 0.0){
               return (Math.max(t1, t2)/(2 * a));
           } else{
               return (0.0);
           }
        } else{
            return(-1);
           
        }
    }
}
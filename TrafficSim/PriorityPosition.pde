class PriorityPosition implements Comparable<PriorityPosition> {
   int priority;
   public Position p;
   public PriorityPosition(Position p, int priority) {
      this.priority = priority;
      this.p = p;
   }
   public int compareTo(PriorityPosition other) {
      return priority - other.priority;
   }
}

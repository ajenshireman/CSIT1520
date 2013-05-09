/**
 * Appendage Demo
 * 
 * Creature with a single appendage
 */

class Walker extends Thing {
  Appendage leg;
  
  /* Constructors */
  Walker ( PVector location, float mass, float size, float maxSpeed ) {
    super(location, mass, size);
    this.maxSpeed = maxSpeed;
    leg = new Appendage(50, 10, 0.05, 0.15);
  }
  
  /* return string containing class name */
  String type () { return "Walker"; }
  
  void update () {
    walkRandom();
    leg.calculate();
  }
  
  void checkEdge () {
    bounce4();
  }
  
  void display () {
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
      translate(location.x, location.y);
      float heading = velocity.heading2D();
      rotate(heading);
      rectMode(CENTER);
      rect(0, size / 2, size * 2, size);
      leg.display(- size, size / 2, Appendage.LEFT, 0);
    popMatrix();
  }
}

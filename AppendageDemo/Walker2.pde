/**
 * Appendage Demo
 * 
 * One appendage, drawn twice from the same origin
 * Looks like wings
 */

class Walker2 extends Thing {
  Appendage leg;
  
  /* Constructors */
  Walker2 ( PVector location, float mass, float size, float maxSpeed ) {
    super(location, mass, size);
    this.maxSpeed = maxSpeed;
    leg = new Appendage(25, 10, 0.1, 0.15);
  }
  
  /* return string containing class name */
  String type () { return "Walker"; }
  
  void update () {
    walkRandom();
    leg.calculate();
  }
  
  void checkEdge () {
    wrap();
  }
  
  void display () {
    leg.display(location.x, location.y, Appendage.LEFT, radians(10));
    leg.display(location.x, location.y, Appendage.RIGHT, radians(-10));
  }
}

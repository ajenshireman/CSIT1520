/**
 * Appendage Demo
 * 
 * 6-legged creature
 * 3 appendages, each drawn twice, once on each side of the body
 * The speed at which the appendages move is based on the creature's velocity
 */

class Walker6 extends Thing {
  Appendage legs[];
  
  /* Constructors */
  Walker6 ( PVector location, float mass, float size, float maxSpeed ) {
    super(location, mass, size);
    this.maxSpeed = maxSpeed;
    legs = new Appendage[3];
    for ( int i = 0; i < 3; i++ ) {
      legs[i] = new Appendage(10, 10, 0.2, 0.25);
    }
  }
  
  /* return string containing class name */
  String type () { return "Walker"; }
  
  void update () {
    walkRandom();
    for ( int i = 0; i < 3; i++ ) {
      // use velocity as the argument for calculate() so the legs go faster as the 
      //   creature speeds up and slower as it slows down
      legs[i].calculate(velocity.mag() / 10);
    }
  }
  
  void checkEdge () {
    bounceSides();
    wrapTB();
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
      rect(0, 0, size * 2, size);
      legs[0].display(0, size / 2, Appendage.RIGHT, radians(90));
      legs[0].display(0, -size / 2, Appendage.LEFT, radians(90));
      legs[1].display(-size / 2, size / 2, Appendage.RIGHT, radians(90));
      legs[1].display(-size / 2, -size / 2, Appendage.LEFT, radians(90));
      legs[2].display(size / 2, size / 2, Appendage.RIGHT, radians(90));
      legs[2].display(size / 2, -size / 2, Appendage.LEFT, radians(90));
    popMatrix();
  }
}

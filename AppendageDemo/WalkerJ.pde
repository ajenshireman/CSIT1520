/**
 * Appendage Demo
 * 
 * Creature with 4 "tentacles" dangling from its body. 
 * This creature has 3 appendages, but one is drawn twice.
 * This technique can be used to give the appearance of many different appendages
 *   while only needing to do the calculations for a few.
 */

class WalkerJ extends Thing {
  Appendage legs[];
  
  /* Constructors */
  WalkerJ ( PVector location, float mass, float size, float maxSpeed ) {
    super(location, mass, size);
    this.maxSpeed = maxSpeed;
    legs = new Appendage[3];
    for ( int i = 0; i < 3; i++ ) {
      legs[i] = new Appendage(100, 5, 0.05, 0.05);
    }
  }
  
  /* return string containing class name */
  String type () { return "Walker"; }
  
  void update () {
    walkRandom();
    for ( int i = 0; i < 3; i++ ) {
      legs[i].calculate();
    }
  }
  
  void checkEdge () {
    bounceTB();
    wrapSides();
  }
  
  void display () {
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
      translate(location.x, location.y);
      rectMode(CENTER);
      rect(0, 0, size * 2, size);
      legs[0].display(-size, size / 2, Appendage.RIGHT, radians(90));
      legs[2].display(- size / 2.5, size / 2, Appendage.RIGHT, radians(90));
      legs[0].display(size / 2.5, size / 2, Appendage.RIGHT, radians(90));
      legs[1].display(size, size / 2, Appendage.RIGHT, radians(90));
    popMatrix();
  }
}

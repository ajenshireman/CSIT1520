/**
 * Appendage
 * Author: Ajen Shieman
 * 
 * Draws a portion of a sine curve which always starts at the same point
 * This has the appearance of an undulating line
 * These can be used as various types of appenadages, such as legs, wings, flagella, 
 *   or anything that needs some flex in it.
 */

class Appendage {
  /* Appendage attributes */
  float length;    // length of curve segment. This is the number of pixels from the origin to perform
                   //   calculations over, not the length along the line connecting the points.
//int   segments;  // "resolution" of the curve, or how stretched out the sine curve is
                   //   lower values will result in a straight line, higher vakues more peaks
                   //   and valleys over the drawn length. no longer used
  float amplitude;      // maximum side-to-side motion of the curve. This is the maximum and minimum y-value
                        //   of the curve. If the curve does not reach its peak value within its length,
                        //   the amplitude will appear to be less.
//float step;           // amount to increment x for each y calculation. no longer used
  float startAngle;     // starting angle of the curve for each draw() cycle
  float angleVelocity;  // amount to increment the angle by for each y calculation. 
                        //   lower values will result in a straight line, higher vakues more peaks
                        //   and valleys over the drawn length.
  float angleChange;    // amount to increment startAngle by for each draw() cycle
                        //   affects how fast the wave oscillates
  float vals[];         // Array for storing y values of the curve
  
  // direction to draw the curve in, relative to the pivot point
  final static int RIGHT =  1;  // draw curve to the right of the origin (use positive x-values)
  final static int LEFT  = -1;  // draw curve to the left of the origin (use negative x-values)
  
  /* Constructors */
  // Minimunm info needed to create an appendage. choose a random starting angle by default
  Appendage ( float length, float amplitude, float angleVelocity, float angleChange ) {
    this.length = length;
    this.amplitude = amplitude;
    this.angleChange = angleChange;
    this.angleVelocity = angleVelocity;
    startAngle = random(360);
  }
  
  // Use a specific starting angle.
  Appendage ( float length, float amplitude, float angleVelocity, float angleChange, float startAngle ) {
    this(length, amplitude, angleVelocity, angleChange);
    this.startAngle = startAngle;
  }

  /* do the math for the curve
   * call this from the parent object once each cycle to update the curve 
   */
  // use the appendage's angleChange
  void calculate () {
    calculate(angleChange);
  }
  
  // increment the start angle by a specific amount. 
  // can be used to vary the appendage's speed with the parent's velocity
  void calculate ( float angleChange ) {
    startAngle -= angleChange;      // increment starting angle
    float angle = startAngle;       // copy starting angle for use in y calcs
    vals = new float[(int)length];  // create array for storing y values
    for ( int i = 0; i < vals.length; i++ ) {
      // calculate y value
      vals[i] = map( sin(angle), -1, 1, -amplitude, amplitude );
      // increment the angle
      angle += angleVelocity;
    }
  }
  
  /* display the curve
   * call from the parent object's display method
   * multiple calls can be made with different parameters to duplicate or mirror
   */
  void display ( float x,        // x posistion of the origin point
                 float y,        // y position of the origin point
                 int direction,  // LEFT or RIGHT. see var list
                 float rotation  // how to rotate the appendage
               ) {
    pushMatrix();
    // translate to the curve's orign and rotate
    translate(x, y);
    rotate(rotation);
    // translate the entire curve by the first y-value
    translate(0, -vals[0]);  // using the y-value instead of its opposite results in the curve
                             //   going even farther away from the pivot point
    // draw a line from each point to the next one
    for ( int i = 0; i < vals.length - 1; i++ ) {
      stroke(0);
      //strokeWeight(1.5);
      line(i * direction, vals[i], (i + 1) * direction, vals[i + 1]);
    }
    popMatrix();
  }
  
}

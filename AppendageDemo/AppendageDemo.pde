/**
 * Author: Ajen Shireman
 * 
 * Demonstrates use of the Appendage class and some of the things that can be done with it.
 * 
 */

Thing[] things;
PVector center;
boolean pause = false;

void setup () {
  size(400, 400, P3D);
  center = new PVector(width / 2, height / 2);
  things = new Thing[4];
  things[0] = new Walker(center, 1, 12, 1);
  things[1] = new Walker6(center, 1, 12, 2);
  things[2] = new WalkerJ(center, 1, 12, 0.65);
  things[3] = new Walker2(center, 1, 12, 1);
}

void draw () {
  if ( !pause ) {
    background(255);
    for ( int i = 0; i < things.length; i++ ) {
      if ( things[i] != null ) things[i].run();
    }
  }
}

void mousePressed () {
  if ( mouseButton == LEFT ) pause = !pause;
}

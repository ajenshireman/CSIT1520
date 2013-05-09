/**
 * primativeArray
 * Author: Ajen Shireman
 * 
 * Collection of dynamicaly-sized arrays for use with java primative types
 */

boolean paused;

void setup () {
  
}

void draw () {
  if ( paused ) return;
}

void mousePressed () {
  paused = !paused;
}

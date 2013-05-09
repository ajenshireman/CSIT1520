/**
 * cloudTest.pde
 * Author: Ajen Shireman
 * 
 * A number of large particles moving around and attracting a number of smaller particles.
 * Draws some pretty cool looking patterns.
 * This early version has some truly attrocious coding in it. I'll be working on a much 
 *   cleaner version in the near future.
 * 
 * Controls:
 * 1 - 4: Change render mode
 * r: reset
 * Space: Pause/Unpause
 */

int cloudSize = 500;  // total number of particles in the cloud
int nuclei = 3;       // total number of random walkers
int delay = 0;        // number of frames before particles or path are rendered
static int mode = 1;   /* controls render mode
                        *   1 - draw nuclei and particles, redraw background each frame
                        *   2 - as above, but do not render nuclei
                        *   3 - do not render nuclei or particles. draw particle paths in black on white background
                        *   4 - do not render nuclei or particles. draw particle colored particle paths on black background.
                        *         path color is determined by particle speed
                        */

boolean run = true;

Nucleus[] n = new Nucleus[nuclei];
Particle[] cloud = new Particle[cloudSize];

void setup () {
  size(600, 600);
  reset();
}

void draw () {
  if ( run ) {
    switch ( mode ) {
      case 1:
      case 2:
        background(255);
        break;
    }
    for ( int i = 0; i < n.length; i++ ) {
    n[i].run();
    }
    for ( int i = 0; i < cloud.length; i++ ) {
      cloud[i].run();
    }
  }
}

void mousePressed () {
  if ( mouseButton == LEFT ) run = !run;
  else if ( mouseButton == RIGHT ) reset();
}

void keyPressed () {
  switch ( key ) {
    case '1':
      mode = 1;
      break;
    case '2':
      mode = 2;
      break;
    case '3':
      mode = 3;
      background(255);
      break;
    case '4':
      mode = 4;
      background(0);
      break;
    case 'r':
      reset();
      break;
    case ' ':
      run = !run;
      break;
  }
}

void reset () {
  run = false;
  switch (mode) {
    case 1:
    case 2:
    case 3:
      background(255);
      break;
    case 4:
      background(0);
      break;
  }
  for ( int i = 0; i < n.length; i++ ) {
    float size = random(20, 40);
    n[i] = new Nucleus(random(width), random(height), size, size, cloud);
  }
  for ( int i = 0; i < cloud.length; i++ ) {
    cloud[i] = new Particle(random(width), random(height), 2, 5, n, delay);
  }
  run = true;
}

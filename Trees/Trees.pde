/*
 * Trees.pde
 * Original code by Daniel Shiffman
 * Additions and enhancements by Ajen Shireman
 *
 * Uses recursion to generate random tree-like structures
 * Left-Click: Generate a new tree
 * Right-Click: Take screenshot
 * Space: Take Screenshot
 */

import java.util.Date;

int   branchMin = 1;         // Minimum number of new branches to create
int   branchMax = 10;        // Maximum number of branches to create
float angleMin = -PI / 2.5;  // Mimimum angle for new branches
float angleMax = PI / 2.5;   // Maximum angle for new branches
int   trunkLength = 150;     // Length of the first segment - the trunk
int   trunkSize = 15;        // Thickness of trunk
int   lengthMin = 2;         // Minimum length of braches
int   sizeMin = 1;           // Minimum size of branches

int   branches = 0;          // Total number of branches in the tree

void setup () {
  size(1280, 800);
  background(255);
}

void draw () {
  
}

void branch ( float length, int size ) {
  //if ( length < 2 || size < 1 ) return;
  stroke(0);
  strokeWeight(size);
  line(0, 0 ,0 ,-length);
  translate(0, -length);
  branches++;
  if ( length < lengthMin || size < sizeMin ) return;
  /**/
  int b = (int)random(branchMin, branchMax);
  for ( int i = 0; i < b; i++ ) {
    float a = random(angleMin, angleMax);
    // pushMatrix() can only be used 32 times.
    try {
      //print("trying...");
      pushMatrix();
        rotate(a);
        branch(random(1, length), (int)random(size / 2, size - 1));
      popMatrix();
    } catch ( RuntimeException e ) {
      //print("caught...");
    }
  }
}

void newTree () {
  //print("doing stuff...");
  branches = 0;
  trunkSize = (int)random(15, 31);
  trunkLength = (int)random(10, 150);
  background(255);
  translate(width / 2, height);
  branch(trunkLength, trunkSize);
  //println("Done!");
  println("Trunk Length: " + trunkLength + " Trunk Size : " + trunkSize + " Branches : " + branches);
}

void screenshot () {
  save(date() + "-" + trunkLength + "-" + trunkSize + "-" + branchMax + ".png");
  println("Screenshot Saved");
}

String date () {
  Date d = new Date();
  return new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(d.getTime());
}

void mousePressed () {
  switch ( mouseButton ) {
    case LEFT:
      newTree();
      break;
    case RIGHT:
      screenshot();
      break;
    default:
      break;
  }
}

void keyPressed () {
  switch ( key ) {
    case ' ':
      screenshot();
      break;
    default:
      break;
  }
}

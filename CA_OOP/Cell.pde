/**
 * Cell.pde
 * Author: Ajen Shireman
 * 
 * A single cell for the Game of Life
 * 
 */

import java.lang.NullPointerException;

class Cell {
  final static int ALIVE = 1;
  final static int DEAD = 0;
  
  int size;          // Cells size in pixels
  int x, y;          // Cell's x and y co-ordinates
  PVector myColorAlive;  // Cell color when alive
  PVector myColorDead;   // Cell color when dead
  int lastState;     // Cell's state in the previous generation
  int state;         // Cell's current state
  int nextState;     // Cells's state in the next generation
  Cell[][] neighbors;  // Array containing the Cell's neighbors
  int n;  // number of living neighbors the cell has. used for debug only
  
  /* Constructors */
  // Constructs a new Cell with a randim initial state
  Cell ( int x, int y, int size ) {
    this.x = x;
    this.y = y;
    this.size = size;
    myColorAlive = new PVector(100, 100, 100);
    myColorDead = new PVector(255, 255, 255);
    state = (int)random(2);
    lastState = state;
  }
  
  // Constructs a new cell with a specific initial state
  Cell ( int x, int y, int size, int state ) {
    this(x, y, size);
    this.lastState = this.state = state;
  }
  
  // Constructs a new cell and sets the Alive and Dead colors
  Cell ( int x, int y, int size, PVector colorDead, PVector colorAlive ) {
    this(x, y, size);
    myColorAlive = colorAlive;
    myColorDead = colorDead;
  }
  
  /* Determine state for next generation */
  void update () {
    int condition = 0;
    // Count neighbors
    for ( int i = 0; i < 3; i++ ) {
      for ( int j = 0; j < 3; j++ ) {
        // Don't count yourself
        if ( neighbors[i][j] != this ) {
          // if there's no neighbor, count it as DEAD
          try {
            condition += neighbors[i][j].getLastState();
          } catch ( NullPointerException e ) {
            //ignore
          }
        }
      }
    }
    state = applyRules(condition);
    n = condition;
  }
  
  /* Rules for the Game */
  int applyRules( int neighbors ) {
    // Cell dies of loneliness if it has one or fewer neighbors
    if ( neighbors <= 1 ) {
      return DEAD;
    }
    // Cell dies from overcrowding if it has 4 or more neighbors
    else if ( neighbors >= 4 ) {
      return DEAD;
    }
    // Cell is "born" if it has exaclty 3 neighbors
    else if ( neighbors == 3 && state == DEAD ) {
      return ALIVE;
    }
    // Otherwise the Cell does not change
    else {
      return state;
    }
    
  } 
  
  /*  */
  void display () {
    if ( state == ALIVE ) {
      fill (myColorAlive.x, myColorAlive.y, myColorAlive.z);
    }
    else {
      fill(myColorDead.x, myColorDead.y, myColorDead.z);
    }
    noStroke();
    rect(x, y, size, size);
    
    /* debug 
    fill(255, 0, 0);
    //text(c + ", " + r, x + (size / 2.5), y + (size / 2));
    text(n, x + (size / 2), y + (size / 2));
    */
  }
  
  /* state operations */
  void setState ( int newState ) {
    state = newState;
  }
  
  int getState () {
    return state;
  }
  
  void saveState () {
    lastState = state;
  }
  
  int getLastState () {
    return lastState;
  }
  
  void swapState () {
    if ( state == DEAD ) state = ALIVE;
    else if ( state == ALIVE ) state = DEAD;
    lastState = state;
    display();
  }
  
  /* Set adjacent Cells */
  void setNeighbors ( Cell[][] neighbors ) {
    this.neighbors = new Cell[3][3];
    
    for ( int i = 0; i < 3; i++ ) {
      for ( int j = 0; j < 3; j++ ) {
        this.neighbors[i][j] = neighbors[i][j];
      }
    }
    
  }
  
}

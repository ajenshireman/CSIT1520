/**
 * Board.pde
 * Author: Ajen Shirman
 * 
 * Mangages an array of cells for the Game of Life
 * Rather than changing the cells directly,
 *   each cell is told which cells are adjacent to it.
 * Each cell then checks its nieghbors to determine
 *   whether it should live, die, or remain the same.
 */

import java.lang.ArrayIndexOutOfBoundsException;

class Board {
  int x, y;      // x and y co-orinates of the board
  int myWidth;   // width of the board in pixels
  int myHeight;  // height of the board in pixels
  int cellSize;  // size of each cell in pixels
  int columns;   // number of columns on the board
  int rows;      // number of rows on the board
  PVector boardColor;  // Background color of the board
  PVector cellColor;   // Color of alive cells
  
  Cell[][] cells;  // array containing the Cells
  
  boolean paused;  // is the simulation paused?
  
  /* Constructors */
  // Constructs a new Board at a specific location
  Board ( int x,  // horixontal position of the Board
          int y,  // vertical position of the Board
          int w,  // width of the Board
          int h,  // height of the board
          int cellSize, // size of each cell
          PVector boardColor,  // Background color of the board
          PVector cellColor    // Color of alive cells
        ) {
    this.cellSize = cellSize;
    this.x = x;
    this.y = y;
    myWidth = w;
    myHeight = h;
    columns = myWidth / cellSize;
    rows = myHeight / cellSize;
    this.boardColor = boardColor;
    this.cellColor = cellColor;
    paused = true;
    // Create Cells
    init();
  }
  
  // Creates the Cells for the Board
  void init () {
    cells = new Cell[columns][rows];
    // Create Cells
    int offset;
    if ( cellSize == 1 ) offset = 0;
    else offset = 1;
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        // move each Cell 1 pixels right and down, and reduce the size by 1 to avoid drawing over the grid lines
        cells[c][r] = new Cell(c * cellSize + offset + x, r * cellSize + offset + x, cellSize - offset, boardColor, cellColor);
      }
    }
    
    // tell the Cells which Cells are adjacent
    linkCells();
  }
  
  // Link the Cells together by telling them which Cells are adjacent
  void linkCells () {
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        Cell[][] neighbors = new Cell[3][3];  // array containing adjeacent Cells
        
        for ( int i = -1; i <= 1; i++ ) {
          for ( int j = -1; j <= 1; j++ ) {
            try {
              neighbors[i + 1][j + 1] = cells[(c + i)][(r + j)];
            } catch ( ArrayIndexOutOfBoundsException e ) {
              //ignore
            }
          }
        }
        cells[c][r].setNeighbors(neighbors);
      }
    }
  }
  
  /*  */
  void run () {
    display();
    if ( paused ) return;
    generate();
  }
  
  /* Draw all the things */
  void display () {
    drawCells();
    //drawGrid();
  }
  
  // Draw the Board
  void drawBoard () {
    noStroke();
    fill(boardColor.x, boardColor.y, boardColor.z);
    rect(x, y, boardSize, boardSize);
  }
  
  // Draw grid lines
  void drawGrid () {
    stroke(0);
    for ( int i = 0; i <= myWidth; i += cellSize ) {
      line(i + x, y, i + x, myHeight + y);
    }
    for ( int i = 0; i <= myWidth; i += cellSize ) {
      line(x, i + y, myWidth + x, i + y);
    }
  }
  
  // Draw the Cells
  void drawCells () {
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].display();
      }
    }
  }
  
  /* Run the Game of Life */
  void generate () {
    // set each Cell's previous state
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].saveState();
      }
    }
    
    // tell each Cell to determine its new state
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].update();
      }
    }
  }
  
  /* Save and load the state of all Cells */
  // Save current Cell states
  int[][] saveState () {
    int[][] boardState = new int[columns][rows];
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        boardState[c][r] = cells[c][r].getState();
      }
    }
    
    return boardState;
  }
  
  // Set all Cell states to a previous state
  void loadState ( int[][] boardState ) {
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].setState(boardState[c][r]);
      }
    }
  }
  
  // Clear the board
  void clear () {
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].setState(Cell.DEAD);
      }
    }
  }
  
  // Set all cells to a random state
  void reset () {
    for ( int c = 0; c < columns; c++ ) {
      for ( int r = 0; r < rows; r++ ) {
        cells[c][r].setState((int)random(2));
      }
    }
  }
  
  /* Toggle the Cell at the specified location */
  void turnCellOn ( int x, int y ) {
    // return if the given location is outside the Board
    if ( ( x < this.x ) || ( x > ( this.x + myWidth ) ) || ( y < this.y ) || ( y > ( this.y + myHeight ) ) ) {
      return;
    }
    // calculate column and row
    int c = (int)( ( x - this.x ) / cellSize);
    int r = (int)( ( y - this.y ) / cellSize);
    //println("mousex: " + x + " mouseY: " + y + " c: " + c + " r: " + r);
    cells[c][r].swapState();
  }
  
  void pause () {
    paused = !paused;
  }
  
  void pause ( boolean paused ) {
    this.paused = paused;
  }
  
}

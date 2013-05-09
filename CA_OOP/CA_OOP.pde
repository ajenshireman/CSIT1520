/**
 * CA_OOP.pde
 * Author: Ajen Shireman
 * 
 * Object-oriented implementation of Conway's Game of Life
 * 
 * Right-click to pause or unpause
 * Left-click on a cell to toggle it or off
 * Middle-click to advance to the next generation
 * Press C to clear the board
 * Press R to generate a new board with random initial states
 */

int cellSize = 10;      // width of each cell in pixels
int boardPadding = 10;  // number of pixels to move board from edges of window
int boardSize;          // size of the board in pixels
int bgColor = 255;      // Background color of the processing window
PVector boardColor = new PVector(204, 204, 204);  // Background color of the board
PVector cellColor = new PVector(255, 255, 100);   // Color of a living cell
boolean showGrid = true;

Board board;  // Board containing the cells

void setup () {
  size(500, 500);
  reset();
}

void draw () {
  board.run();
}

void mousePressed () {
  if ( mouseButton == LEFT ) {
    board.turnCellOn(mouseX, mouseY);
  }
  else if ( mouseButton == RIGHT ) {
    board.pause();
  }
  else if ( mouseButton == CENTER ) {
    if ( board.paused ) {
      board.generate();
    }
  }
}

void keyPressed () {
  if ( key == 'C' || key == 'c' ) {
    board.clear();
  }
  else if ( key == 'R' || key == 'r' ) {
    board.reset();
  }
}

/* Create a new Board */
void reset () {
  // for tall windows, additional space underneath the board
  if ( height > width ) {
    boardSize = width - ( boardPadding * 2 );
  }
  // for wide windows, additional space to the right of the board
  // also used for square windows
  else {
    boardSize = height - ( boardPadding * 2 );
  }
  // remove partial cells
  boardSize -= boardSize % cellSize;
  // create the Board
  board = new Board(boardPadding, boardPadding, boardSize , boardSize, cellSize, boardColor, cellColor);
  //  clear the background and draw the gridlines
  background(bgColor);
  board.drawBoard();
  if ( showGrid && cellSize > 1 ) board.drawGrid();
}

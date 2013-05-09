class Turtle {
  PVector location;
  float heading;
  float stepDelta;
  float angleDelta;
  ArrayList<PVector> myStack;
  
  Turtle(float x, float y, float h, float step, float angle) {
    location = new PVector(x, y);
    heading = h - 90;
    stepDelta = step;
    angleDelta = angle;
    myStack = new ArrayList<PVector>();
  }
   
  void run(String program) {
    for ( int i = 0; i < program.length(); i++ ) {
      step(program.charAt(i));
    }
    
  }
  
  void step(char letter) {
    float newx = location.x + (stepDelta * cos(radians(heading)));
    float newy = location.y + (stepDelta * sin(radians(heading)));
    
    switch ( letter ) {
      case 'F':
        line(location.x, location.y,newx, newy);
        location.x = newx;
        location.y = newy;
        break;
      case 'G':
      case 'f':
        location.x = newx;
        location.y = newy;
        break;
      case '+':
        heading += angleDelta;
        heading %= 360;
        break;
      case '-':
        heading -= angleDelta;
        heading %= 360;
        break;
      case '[':
        PVector p = new PVector(location.x, location.y, heading);
        myStack.add(p);
        break;
      case ']':
        int last = myStack.size() - 1;
        p = myStack.get(last);
        location.x = p.x;
        location.y = p.y;
        heading = p.z;
        myStack.remove(last);
        break;
      case '|':
        float step = stepDelta *0.5;
        newx = location.x + (step * cos(radians(heading)));
        newy = location.y + (step * sin(radians(heading)));
        line(location.x, location.y,newx, newy);
        location.x = newx;
        location.y = newy;
        break;
    }
  }
}
    



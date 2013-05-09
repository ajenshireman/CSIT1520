import java.util.HashMap;

class LSystem {
  String currentState;
  HashMap productionRules;
  Turtle myTurtle = null;
  float sizeDelta = 1.0;
  int stepNum = 1;
  
  LSystem(String initial, HashMap rules, Turtle t) {
    currentState = initial;
    productionRules = rules;
    myTurtle = t;
  }
  
  String getState() {
    return(currentState);
  }

 void render() {
   if (myTurtle != null) {
     PVector startLoc = myTurtle.location.get();
     float angle = myTurtle.heading;
     myTurtle.run(currentState);
     myTurtle.location = startLoc;
     myTurtle.heading = angle;
   }
 }
  
  void step() {
    String s = "";
    myTurtle.stepDelta *= sizeDelta;
    for(int i = 0; i < currentState.length(); i++) {
      String letter = "" + currentState.charAt(i);
      if (productionRules.containsKey(letter))
        s += productionRules.get(letter);
      else
        s += letter;
    }
    currentState = s;
  }
}



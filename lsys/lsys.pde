import java.util.Date;
import java.util.HashMap;

LSystem lsys;

void setup() {
  size(500,500);
  Tree();
  println("Rule: " + lsys.currentState);
  //background(255);
  background(255);
  int n = 3;
  for ( int i = 0; i < n; i++ ) {
    //lsys.step();
  }
  //lsys.render();
}

void draw() {
  background(255);
  lsys.render();
  //lsys.step();
}

void Tree() {
  String axiom = "";
  float angle = 90;
  float delt = 1;
  float step = 100;
  float rot = 0;
  float x = width / 2;
  float y = height / 2;
  HashMap rules = new HashMap();
  /*
  axiom = "";
  rules.put("", "");
  angle = 90;
  delt = 1;
  step = 50;
  x = 0;
  y = 0;
  rot = 0;
  */
  /**
  // Carpet
  axiom = "F-F-F-F";
  rules.put("F", "F[F]-F+F[--F]+F-F");
  angle = 90;
  delt = 1 / 3.0;
  step = 480;
  x = 490;
  y = 490;
  rot = 0;
  /*
  // Sierpinski Square
  axiom = "F-F-F-F";
  rules.put("F", "FF[-F-F-F]F");
  angle = 90;
  delt = 1 / 3.0;
  step = 480;
  x = 490;
  y = 490;
  rot = 0;
  /*
  // Rug
  axiom = "F-F-F-F";
  rules.put("F", "F[F-F]FF");
  angle = 90;
  delt = 1 / 3.0;
  step = 480;
  x = 490;
  y = 490;
  rot = 0;
  /*
  // Mosaics
  // Outer "twist"
  axiom = "F-F-F-F";
  rules.put("F", "FF[[+FF-F-F]-F+F-F]F");
  angle = 90;
  delt = 1 / 3.0;
  step = 150;
  x = 325;
  y = 325;
  rot = 0;
  /*/
  axiom = "F-F-F-F";
  rules.put("F", "FF[+FF-F-F]F");
  angle = 90;
  delt = 1 / 3.0;
  step = 150;
  x = 325;
  y = 325;
  rot = 0;
  /*
  axiom = "F-F-F-F";
  rules.put("F", "FF[+FF+F-F]F");
  angle = 90;
  delt = 1 / 3.0;
  step = 150;
  x = 325;
  y = 325;
  rot = 0;
  /*
  // Hexagons
  axiom = "F-F-F-F-F-F";
  rules.put("F", "FF[-F+F-F-F+F]F");
  angle = 60;
  delt = 1 / 3.0;
  step = 240;
  x = 130;
  y = 460;
  rot = 90;
  /*
  axiom = "F-F-F-F-F-F";
  rules.put("F", "FG[-F+F-GF--GF+F]F");
  rules.put("G", "GFG");
  angle = 60;
  delt = 1 / 3.0;
  step = 240;
  x = 130;
  y = 460;
  rot = 90;
  /*
  axiom = "F-F-F-F-F-F";
  rules.put("F", "FF[-FF-F-F-F-F]F");
  angle = 60;
  delt = 1 / 3.0;
  step = 240;
  x = 130;
  y = 460;
  rot = 90;
  /*
  // Pentagons
  axiom = "F-F-F-F-F";
  rules.put("F", "FF[-GG+F--G-F]F");
  rules.put("G", "GGG");
  angle = 72;
  delt = 1 / 3.0;
  step = 250;
  x = 125;
  y = 465;
  rot = 90;
  /*
  // triangles
  // Sierpinski-Gasket
  axiom = "F--F--F";
  rules.put("F", "F--F--F--GG");
  rules.put("G", "GG");
  angle = 60;
  delt = 1 / 2.0;
  step = 480;
  x = 10;
  y = 470;
  rot = 90;
  /*
  // Sierpinski-Arrowhead
  axiom = "F";
  rules.put("F", "[-G+++F][-G+F][GG--F]");
  rules.put("G", "GG");
  angle = 60;
  delt = 1 / 2.0;
  step = 480;
  x = 10;
  y = 470;
  rot = 90;
  /*
  axiom = "[F]--F";
  rules.put("F", "F[+F][-F]");
  angle = 90;
  delt = 1;
  /*
  axiom = "-L";
  rules.put("L", "LFRFL-F-RFLFR+F+LFRFL");
  rules.put("R", "RFLFR+F+LFRFL-F-RFLFR");
  delt = 0.33;
  rot = 90;
  /*
  axiom = "L";
  rules.put("L", "+RF-LFL-FR+");
  rules.put("R", "-LF+RFR+FL-");
  delt = 0.5;
  step = 500;
  x = 10;
  y = 490;
  rot = 0;
  /*
  axiom = "F+F+F+F";
  angle = 90;
  rules.put("F", "F+G-FF+F+FF+FG+FF-G+FF-F-FF-FG-FFF");
  rules.put("G", "GGGGGG");
  delt = 1/6.0;
  step = 250;
  x = 130;
  y = 380;
  /*
  //Bush 1
  axiom = "X";
  angle = 20;
  rules.put("X", "F-[[X]+X]+F[+FX]-X");
  rules.put("F", "FF");
  delt = 0.5;
  step = 190;
  y = height;
  x = width / 2;
  /*
  axiom = "X";
  angle = 22;
  rules.put("X", "F[+X][-X]FX");
  rules.put("F", "FF");
  delt = 0.5;
  step = 200;
  y = height;
  x = width / 2;
  /*
  // Bush 2
  axiom = "F";
  rules.put("F", "F[-F]F[+F][F]");
  angle = 20;
  delt = 0.5;
  step = 200;
  y = height;
  x = width / 2;
  /*
  axiom = "F-F-F-F";
  rules.put("F", "FF+F+F+F+F+F-F");
  angle = 90;
  delt = 0.25;
  step = 300;
  x = 100;
  y = 100;
  rot = 0;
  /*
  // Quadratic Koch
  axiom = "F-F-F-F";
  rules.put("F", "F+F-F-FF+F+F-F");
  angle = 90;
  delt = 0.25;
  step = 300;
  x = 400;
  y = 400;
  rot = 0;
  /*
  // Koch Snowflake
  axiom = "F++F++F";
  rules.put("F", "F-F++F-F");
  angle = 60;
  delt = 1 / 3.0;
  step = 425;
  x = 40;
  y = 127;
  rot = 90;
  /*
  // Dragon Spiral
  axiom = "X";
  rules.put("X", "X+YF");
  rules.put("Y", "FX-Y");
  angle = 90;
  delt = 0.8;
  step = 25;
  /*/
  /**/
  // define the L-system
  Turtle t = new Turtle(x, y, rot, step, angle);
  lsys = new LSystem(axiom, rules, t);
  lsys.sizeDelta = delt;
}

void screenshot () {
  save(date() + ".png");
  println("Screenshot Saved");
}

String date () {
  Date d = new Date();
  return new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(d.getTime());
}

void mousePressed () {
  lsys.step();
  println("Rule: " + lsys.currentState);
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

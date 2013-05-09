class Nucleus extends Thing {  

  
  Nucleus ( float x, float y, float mass, float size, Thing[] cloud ) {
    super(x, y, mass, size, cloud);
    
    tx = random(100000);
    ty = random(100000);
    xIncr = 0.01;
    yIncr = 0.01;
    
  }
  
  void run () {
    walkRandom();
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);
    checkEdge();
    acceleration.mult(0);
    pullCloud();
    if ( mode == 1 ) display();
  }
  
  void checkEdge () {
    bounce();
  }
  
  void display () {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, size, size);
  }
  
}

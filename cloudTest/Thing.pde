class Thing {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  float maxSpeed;
  
  float tx, ty;
  float xIncr, yIncr;
  
  Thing[] cloud;
  
  Thing () {
    
  }
  
  Thing ( PVector location, float mass, float size, Thing[] cloud ) {
    this.location = location.get();
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.mass = mass;
    this.size = size;
    this.cloud = cloud;
  }
  
  Thing ( float x, float y, float mass, float size, Thing[] cloud ) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.mass = mass;
    this.size = size;
    this.cloud = cloud;
  }
  
  void run () {
    
  }
  
  void pullCloud () {
    for ( int i = 0; i < cloud.length; i++) {
      PVector force = attract(cloud[i]);
      cloud[i].applyForce(force);
    }
  }
  
  PVector attract(Thing p) {
    PVector force = PVector.sub(location, p.location);
    float distance = force.mag();
    distance = constrain(distance, 10.0, 35.0);
    force.normalize();
    float strength = ( Constants.G * mass * p.mass ) / ( distance * distance );
    force.mult(strength);
    return force;
  }
  
  void walkRandom () {
    float dx = map(noise(tx), 0, 1, -1, 1);
    float dy = map(noise(ty), 0, 1, -1, 1);
    applyForce(new PVector(dx, dy));
    tx += xIncr;
    ty += yIncr;
  }
  
  void applyForce ( PVector force ) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void bounce () {
    if ( location.x > width - (size/2) ) {
      velocity.x *= -1;
      location.x = width - (size/2);
    }
    else if ( location.x < (size/2) ) {
      velocity.x *= -1;
      location.x = (size/2);
    }
    if ( location.y > height - (size/2) ) {
      velocity.y *= -1;
      location.y = height - (size/2);
    }  
    else if ( location.y < (size/2) ) {
      velocity.y *= -1;
      location.y = (size/2);
    } 
  }
  
}

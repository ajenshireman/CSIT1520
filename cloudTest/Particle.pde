class Particle extends Thing{
  int frames = 0;
  int lifetime;
  PVector lastloc;
  int delay;
  
  Particle ( float x, float y, float mass, float size, Thing[] cloud ) {
    super(x, y, mass, size, cloud);
  }
  
  Particle ( float x, float y, float mass, float size, Thing[] cloud, int delay ) {
    super(x, y, mass, size, cloud);
    maxSpeed = 3.1;
    lastloc = location.get();
    this.delay = delay;
  }
  
  void run () {
    update();
    display();
  }
  
  void update () {
    lastloc = location.get(); // copy current location
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display () {
      if ( frames > delay ) {
        switch ( mode ) {
          case 1:
          case 2:
            noStroke();
            fill(100, 100);
            ellipse(location.x, location.y, size, size);
            break;
          case 3:
            stroke(0, 5);
            line(lastloc.x, lastloc.y, location.x, location.y);
            break;
          case 4:
            stroke(map(velocity.mag(), 0, 5, 50, 150), map(velocity.x, -maxSpeed, maxSpeed, 50, 255), map(velocity.y, -maxSpeed, maxSpeed, 255, 50), 5);
            line(lastloc.x, lastloc.y, location.x, location.y);
            break;
        }
      }
      frames++;
  }
  
}

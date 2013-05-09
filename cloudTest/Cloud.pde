class Cloud {
  Particle[] cloud;
  
  Cloud ( int size ) {
    cloud = new Particle[size];
    for ( int i = 0; i < cloud.length; i++ ) {
      cloud[i] = new Particle(random(width), random(height), 1, 2, cloud);
    }
  }
  
  void run () {
    for ( int i = 0; i < cloud.length; i++ ) {
      cloud[i].run();
    }
  }
  
  int size () {
    return cloud.length;
  }
  
}
